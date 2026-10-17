"""Fit the X-Ray Room desk drawer to its steel plinth, and make the developer tank open as itself.

Run from the project folder:  python3 tools/sprite_fixes/xray_room_finish.py

Reads the v1 sprites and writes:
  - xray_room_desk_drawer_closed_v2.png / _open_v3.png: a steel drawer set into the front of the
    plinth under the control cabinet (world 822..928 x 476..503 at scale 0.25), in the plinth's
    blue-grey. The front is made from the plain parts of the v1 wooden front turned to steel;
    the handle and label plate are scaled evenly and turned to nickel.
  - xray_room_developer_tank_closed_v2.png: the v1 closed tank with the holes in its lid filled
    (pink rust had been keyed out with the pink sheet background).
  - xray_room_developer_tank_open_v2.png: the same tank, seen from the same angle, with its lid
    raised behind it and the developer (from the v1 open picture) showing in the opening.
"""
import random

from PIL import Image, ImageChops, ImageDraw, ImageFilter

DIR = "assets/objects/"
random.seed(3)


def edge_gap(size, width, alpha):
    mask = Image.new("L", size, 0)
    ImageDraw.Draw(mask).rectangle((0, 0, size[0] - 1, size[1] - 1), outline=alpha, width=width)
    shade = Image.new("RGBA", size, (4, 5, 6, 255))
    shade.putalpha(mask.filter(ImageFilter.GaussianBlur(width / 2)))
    return shade


def top_shadow(size, height, alpha):
    shade = Image.new("RGBA", size, (4, 5, 6, 0))
    draw = ImageDraw.Draw(shade)
    for y in range(min(height, size[1])):
        draw.line([(0, y), (size[0], y)], fill=(4, 5, 6, int(alpha * (1.0 - y / height) ** 1.5)))
    return shade


def to_steel(image, target, mean_lum, gain):
    """Grey the picture by its brightness, centred on `target`, with `gain` times its contrast."""
    r, g, b, a = image.split()
    lum = Image.merge("RGB", (r, g, b)).convert("L")
    bands = [lum.point(lambda v, t=t: max(0, min(255, int(t + (v - mean_lum) * gain)))) for t in target]
    return Image.merge("RGBA", bands + [a])


def fill_from_neighbours(image, mask):
    """Fill the masked pixels with the colour of the pixels around them (blur of the known
    pixels divided by the blur of where they are, widening until every hole is reached)."""
    alpha = image.getchannel("A").point(lambda v: 255 if v > 200 else 0)
    known = ImageChops.subtract(alpha, mask)
    rgb = image.convert("RGB")
    px_rgb, px_mask = rgb.load(), mask.load()
    todo = {(x, y) for y in range(mask.height) for x in range(mask.width) if px_mask[x, y]}
    for radius in (2, 4, 8, 16, 32):
        weight = known.filter(ImageFilter.GaussianBlur(radius)).load()
        spread = ImageChops.multiply(rgb, Image.merge("RGB", [known] * 3)).filter(ImageFilter.GaussianBlur(radius)).load()
        for x, y in list(todo):
            w = weight[x, y]
            if w > 6:
                px_rgb[x, y] = tuple(min(255, c * 255 // w) for c in spread[x, y])
                todo.discard((x, y))
    out = rgb.convert("RGBA")
    out.putalpha(ImageChops.lighter(image.getchannel("A"), mask))
    return out


# ---- Desk drawer -------------------------------------------------------------------------
FRONT_W, FRONT_H = 424, 108  # 106 x 27 world pixels at scale 0.25
PULL = 46
TOP = PULL + 12
PLINTH = (40.3, 42.8, 46.7)

closed = Image.open(DIR + "xray_room_desk_drawer_closed_v1.png").convert("RGBA")
opened = Image.open(DIR + "xray_room_desk_drawer_open_v1.png").convert("RGBA")

left = closed.crop((24, 152, 164, 266))
right = closed.crop((262, 152, 402, 266))
wood = Image.new("RGBA", (left.width + right.width, left.height))
wood.paste(left, (0, 0))
wood.paste(right, (left.width, 0))
front = to_steel(wood.resize((FRONT_W, FRONT_H), Image.LANCZOS), PLINTH, 42, 0.5)
# A pressed rim round the edge of the steel front.
draw = ImageDraw.Draw(front)
draw.line([(3, 3), (FRONT_W - 4, 3)], fill=(92, 96, 102, 255), width=2)
draw.line([(3, FRONT_H - 5), (FRONT_W - 4, FRONT_H - 5)], fill=(20, 22, 25, 255), width=2)

plate = closed.crop((170, 172, 256, 198))
plate = to_steel(plate.resize((int(plate.width * 0.62), int(plate.height * 0.62)), Image.LANCZOS), (78, 80, 84), 90, 0.9)
handle = closed.crop((184, 205, 244, 244))
handle = to_steel(handle.resize((int(handle.width * 0.95), int(handle.height * 0.95)), Image.LANCZOS), (92, 95, 100), 95, 1.0)
front.alpha_composite(plate, ((FRONT_W - plate.width) // 2, 14))
front.alpha_composite(handle, ((FRONT_W - handle.width) // 2, 14 + plate.height + 6))
front.alpha_composite(edge_gap(front.size, 6, 220))

canvas_size = (FRONT_W + 16, FRONT_H + 2 * TOP)
new_closed = Image.new("RGBA", canvas_size, (0, 0, 0, 0))
new_closed.alpha_composite(front, (8, TOP))
new_closed.save(DIR + "xray_room_desk_drawer_closed_v2.png")

inside = to_steel(opened.crop((80, 40, 350, 140)), (30, 32, 36), 40, 0.5).resize((FRONT_W, PULL), Image.LANCZOS)
inside.alpha_composite(top_shadow(inside.size, int(PULL * 0.6), 220))
backing = Image.new("RGBA", inside.size, (10, 11, 13, 255))
backing.alpha_composite(inside)
new_open = Image.new("RGBA", canvas_size, (0, 0, 0, 0))
new_open.alpha_composite(backing, (8, TOP))
shadow = Image.new("RGBA", canvas_size, (0, 0, 0, 0))
ImageDraw.Draw(shadow).rectangle((14, TOP + PULL + FRONT_H, FRONT_W + 2, TOP + PULL + FRONT_H + 8), fill=(0, 0, 0, 130))
new_open.alpha_composite(shadow.filter(ImageFilter.GaussianBlur(4)))
new_open.alpha_composite(front, (8, TOP + PULL))
new_open.save(DIR + "xray_room_desk_drawer_open_v3.png")

# ---- Developer tank: fill the lid --------------------------------------------------------
tank = Image.open(DIR + "xray_room_developer_tank_closed_v1.png").convert("RGBA")
# The top of the lid, as painted (the holes lie in it).
LID_TOP = [(30, 190), (398, 186), (410, 206), (410, 226), (22, 226), (20, 206)]
lid = Image.new("L", tank.size, 0)
ImageDraw.Draw(lid).polygon(LID_TOP, fill=255)
holes = ImageChops.multiply(lid, ImageChops.invert(tank.getchannel("A")))
holes = holes.point(lambda v: 255 if v > 20 else 0)
tank = fill_from_neighbours(tank, holes)
# Some grain over the filled part, so it is not smooth.
grain = Image.effect_noise(tank.size, 22).convert("L")
grainy = Image.merge("RGBA", [ImageChops.multiply(c, grain.point(lambda v: 200 + v // 5)) for c in tank.convert("RGB").split()] + [tank.getchannel("A")])
tank = Image.composite(grainy, tank, holes.filter(ImageFilter.GaussianBlur(1)))
tank.save(DIR + "xray_room_developer_tank_closed_v2.png")

# ---- Developer tank: open ----------------------------------------------------------------
old_open = Image.open(DIR + "xray_room_developer_tank_open_v1.png").convert("RGBA")
RIM_Y = 224  # the lid's lower edge: everything below it is the box
body = tank.crop((0, RIM_Y, tank.width, tank.height))
x0, _, x1, _ = body.getbbox()

result = Image.new("RGBA", tank.size, (0, 0, 0, 0))


def soft_rim(size, colour, width, radius):
    """A rounded steel edge round a panel, softened so it reads as a rolled lip."""
    mask = Image.new("L", size, 0)
    ImageDraw.Draw(mask).rounded_rectangle((0, 0, size[0] - 1, size[1] - 1), radius=radius, outline=255, width=width)
    rim = Image.new("RGBA", size, colour + (255,))
    rim.putalpha(mask.filter(ImageFilter.GaussianBlur(1.2)))
    return rim


# The lid, tipped back on its hinges: its inside face, standing up behind the box.
# Made of plain body steel (no catches), in shadow, leaning back a little.
lid_w = x1 - x0 - 12
lid_h = 124
face = tank.crop((92, 280, 332, 380)).resize((lid_w, lid_h), Image.LANCZOS)
face = Image.merge("RGBA", [c.point(lambda v: int(v * 0.58)) for c in face.convert("RGB").split()] + [Image.new("L", face.size, 255)])
shade = Image.new("RGBA", face.size, (0, 0, 0, 0))
d = ImageDraw.Draw(shade)
for y in range(lid_h):  # darker towards the hinge, where the box shades it
    d.line([(0, y), (lid_w, y)], fill=(5, 6, 7, int(170 * (y / lid_h) ** 2)))
face.alpha_composite(shade)
face.alpha_composite(soft_rim(face.size, (128, 130, 128), 5, 10))
corners = Image.new("L", face.size, 0)
ImageDraw.Draw(corners).rounded_rectangle((0, 0, lid_w - 1, lid_h - 1), radius=10, fill=255)
face.putalpha(corners)
lean = 9
face = face.transform(face.size, Image.QUAD, (-lean, 0, 0, lid_h, lid_w, lid_h, lid_w + lean, 0), Image.BICUBIC)
LID_FOOT = RIM_Y - 30  # the lid stands on the back edge of the opening
result.alpha_composite(face, (x0 + 6, LID_FOOT - lid_h + 4))

# The opening, the shape the closed lid's top had: the dark inside of the back wall,
# the developer below it, and the box's rolled rim round the edge.
opening = Image.new("L", tank.size, 0)
ImageDraw.Draw(opening).polygon([(x0 + 14, LID_FOOT), (x1 - 14, LID_FOOT), (x1 - 2, RIM_Y + 4), (x0 + 2, RIM_Y + 4)], fill=255)
well = Image.new("RGBA", tank.size, (14, 15, 16, 255))
wall = tank.crop((92, 290, 332, 330)).resize((x1 - x0, 16), Image.LANCZOS)
wall = Image.merge("RGBA", [c.point(lambda v: int(v * 0.3)) for c in wall.convert("RGB").split()] + [Image.new("L", wall.size, 255)])
well.alpha_composite(wall, (x0, LID_FOOT))
liquid = old_open.crop((100, 240, 360, 290)).resize((x1 - x0, 20), Image.LANCZOS)
liquid = Image.merge("RGBA", [c.point(lambda v: int(v * 0.95)) for c in liquid.convert("RGB").split()] + [Image.new("L", liquid.size, 255)])
liquid.alpha_composite(top_shadow(liquid.size, 8, 200))
well.alpha_composite(liquid, (x0, LID_FOOT + 13))
well.putalpha(opening)
result.alpha_composite(well)
back_rim = Image.new("RGBA", tank.size, (0, 0, 0, 0))
ImageDraw.Draw(back_rim).line([(x0 + 14, LID_FOOT + 1), (x1 - 14, LID_FOOT + 1)], fill=(160, 162, 158, 255), width=3)
for (ax, ay), (bx, by) in (((x0 + 14, LID_FOOT), (x0 + 2, RIM_Y + 4)), ((x1 - 14, LID_FOOT), (x1 - 2, RIM_Y + 4))):
    ImageDraw.Draw(back_rim).line([(ax, ay), (bx, by)], fill=(120, 122, 118, 255), width=4)
result.alpha_composite(back_rim.filter(ImageFilter.GaussianBlur(0.8)))

result.alpha_composite(body, (0, RIM_Y))
result.save(DIR + "xray_room_developer_tank_open_v2.png")
print("done: drawer", new_closed.size, "tank", result.getbbox())
