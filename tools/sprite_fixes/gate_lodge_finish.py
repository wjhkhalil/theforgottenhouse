"""Fit the Gate Lodge desk drawer to the painted desk, and keep the inner door its own size when open.

Run from the project folder:  python3 tools/sprite_fixes/gate_lodge_finish.py

Reads the v1 sprites and writes:
  - gate_lodge_desk_drawer_closed_v2.png / _open_v3.png: a long, low drawer front that fills
    the desk's top rail (world 577..681 x 368..389 at scale 0.25), recoloured to the desk wood.
    The wood is stretched from the v1 front; the brass plate and knob are scaled evenly so
    they stay round. Open: the same front pulled down, the drawer's inside showing above it.
  - gate_lodge_inner_door_open_v2.png: the closed door's frame with the corridor showing
    through its opening and the leaf swung inward along the left jamb. Same canvas and
    outline as the closed door, so it no longer grows when opened.
"""
from PIL import Image, ImageChops, ImageDraw, ImageFilter

DIR = "assets/objects/"


def recolour(image, gains):
    r, g, b, a = image.split()
    r = r.point(lambda v: min(255, int(v * gains[0])))
    g = g.point(lambda v: min(255, int(v * gains[1])))
    b = b.point(lambda v: min(255, int(v * gains[2])))
    return Image.merge("RGBA", (r, g, b, a))


def edge_gap(size, width, alpha):
    mask = Image.new("L", size, 0)
    ImageDraw.Draw(mask).rectangle((0, 0, size[0] - 1, size[1] - 1), outline=alpha, width=width)
    shade = Image.new("RGBA", size, (12, 6, 2, 255))
    shade.putalpha(mask.filter(ImageFilter.GaussianBlur(width / 2)))
    return shade


def top_shadow(size, height, alpha):
    shade = Image.new("RGBA", size, (8, 4, 2, 0))
    draw = ImageDraw.Draw(shade)
    for y in range(min(height, size[1])):
        draw.line([(0, y), (size[0], y)], fill=(8, 4, 2, int(alpha * (1.0 - y / height) ** 1.5)))
    return shade


# ---- Desk drawer -------------------------------------------------------------------------
FRONT_W, FRONT_H = 416, 84  # 104 x 21 world pixels at scale 0.25
PULL = 38
TOP = PULL + 12  # canvas padded equally top and bottom, so the centre stays on the rail
# Mean colour of the v1 front's wood, and of the painted rail it now sits in.
DRAWER_RGB = (72.4, 36.6, 16.8)
DESK_RGB = (39.8, 22.7, 12.8)
BRIGHTEN = 1.25  # the rail is in the shadow of the desk top; a little lighter reads as a drawer
BRASS_DIM = 0.72

closed = Image.open(DIR + "gate_lodge_desk_drawer_closed_v1.png").convert("RGBA")
opened = Image.open(DIR + "gate_lodge_desk_drawer_open_v1.png").convert("RGBA")
gains = [d / s * BRIGHTEN for d, s in zip(DESK_RGB, DRAWER_RGB)]

# Wood: the plain left and right parts of the v1 front, side by side, stretched to the rail.
left = closed.crop((24, 128, 164, 280))
right = closed.crop((264, 128, 404, 280))
wood = Image.new("RGBA", (left.width + right.width, left.height))
wood.paste(left, (0, 0))
wood.paste(right, (left.width, 0))
front = recolour(wood.resize((FRONT_W, FRONT_H), Image.LANCZOS), gains)

plate = closed.crop((170, 140, 258, 180))
plate = recolour(plate.resize((int(plate.width * 0.5), int(plate.height * 0.5)), Image.LANCZOS), [BRASS_DIM] * 3)
knob = closed.crop((186, 190, 242, 246))
knob = recolour(knob.resize((int(knob.width * 0.78), int(knob.height * 0.78)), Image.LANCZOS), [BRASS_DIM] * 3)
# Only the round knob, not the square of wood it was cut with.
round_mask = Image.new("L", knob.size, 0)
ImageDraw.Draw(round_mask).ellipse((1, 1, knob.width - 2, knob.height - 2), fill=255)
knob.putalpha(ImageChops.multiply(knob.getchannel("A"), round_mask.filter(ImageFilter.GaussianBlur(1))))
front.alpha_composite(plate, ((FRONT_W - plate.width) // 2, 7))
front.alpha_composite(knob, ((FRONT_W - knob.width) // 2, 7 + plate.height + 2))
front.alpha_composite(edge_gap(front.size, 6, 210))

canvas_size = (FRONT_W + 16, FRONT_H + 2 * TOP)
new_closed = Image.new("RGBA", canvas_size, (0, 0, 0, 0))
new_closed.alpha_composite(front, (8, TOP))
new_closed.save(DIR + "gate_lodge_desk_drawer_closed_v2.png")

inside = recolour(opened.crop((96, 40, 332, 150)), gains).resize((FRONT_W, PULL), Image.LANCZOS)
inside.alpha_composite(top_shadow(inside.size, int(PULL * 0.6), 215))
backing = Image.new("RGBA", inside.size, (20, 10, 4, 255))
backing.alpha_composite(inside)
new_open = Image.new("RGBA", canvas_size, (0, 0, 0, 0))
new_open.alpha_composite(backing, (8, TOP))
shadow = Image.new("RGBA", canvas_size, (0, 0, 0, 0))
ImageDraw.Draw(shadow).rectangle((14, TOP + PULL + FRONT_H, FRONT_W + 2, TOP + PULL + FRONT_H + 8), fill=(0, 0, 0, 120))
new_open.alpha_composite(shadow.filter(ImageFilter.GaussianBlur(4)))
new_open.alpha_composite(front, (8, TOP + PULL))
new_open.save(DIR + "gate_lodge_desk_drawer_open_v3.png")

# ---- Inner door --------------------------------------------------------------------------
FRAME = 24  # width of the studded frame round the closed door

door = Image.open(DIR + "gate_lodge_inner_door_closed_v1.png").convert("RGBA")
door_open = Image.open(DIR + "gate_lodge_inner_door_open_v1.png").convert("RGBA")
solid = door.getchannel("A").point(lambda v: 255 if v > 128 else 0)
opening = solid.filter(ImageFilter.MinFilter(2 * FRAME + 1))
ox0, oy0, ox1, oy1 = opening.getbbox()
ow, oh = ox1 - ox0, oy1 - oy0

# The corridor seen through the open sprite's doorway, fitted to the closed door's opening.
corridor = door_open.crop((124, 40, 262, 362)).resize((ow, oh), Image.LANCZOS)
view = Image.new("RGBA", door.size, (10, 8, 6, 255))
view.alpha_composite(corridor, (ox0, oy0))

# The leaf, swung inward: seen nearly edge-on along the left jamb, in shadow.
leaf = door_open.crop((14, 13, 120, 415))
leaf = recolour(leaf.resize((int(ow * 0.3), oh), Image.LANCZOS), (0.7, 0.7, 0.7))
view.alpha_composite(leaf, (ox0, oy0))
view.alpha_composite(top_shadow((ow, 30), 30, 160).rotate(-90, expand=True).resize((22, oh)), (ox0 + leaf.width, oy0))
view.putalpha(opening)

new_door = door.copy()
# Clear the closed leaf, keep the frame, then put the view in the opening.
frame_alpha = ImageChops.subtract(door.getchannel("A"), opening)
new_door.putalpha(frame_alpha)
result = Image.new("RGBA", door.size, (0, 0, 0, 0))
result.alpha_composite(view)
result.alpha_composite(new_door)
result.save(DIR + "gate_lodge_inner_door_open_v2.png")
print("drawer gains", [round(g, 2) for g in gains], "door opening", (ox0, oy0, ox1, oy1))
