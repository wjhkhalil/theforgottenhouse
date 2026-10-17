"""Fit the Matron's Office drawers to their furniture, and stand the filing cabinet against the wall.

Run from the project folder:  python3 tools/sprite_fixes/matrons_office_fit_drawers.py
Then run match_drawer_colours.py --apply to fine-tune the drawers' tint.

The v1 drawers are boxes seen from a little above, taller than the slots painted in the
desk and the sewing table. For each this writes, at scale 0.25 (4 picture pixels per room
pixel):
  - <name>_closed_v2.png: a flat front the size of its slot, the wood stretched from the
    plain parts of the v1 front and recoloured to the furniture round the slot; the
    handle (and keyhole) scaled evenly so they keep their shape;
  - <name>_open_v3.png: the same front pulled down, the drawer's inside above it.
The right-hand desk drawer's painted slot is under the "Objects to Find" panel, so it is
the desk's centre drawer, set into the plain band over the knee space.

The filing cabinet stood in front of the painted wall cabinet, its foot on the sewing
table's top, so it seemed to stand on the table. matrons_office_filing_cabinet_{closed,
open}_v2.png stand it inside the wall cabinet's open niche, on the niche floor, with the
sewing table's top and the pincushion (painted in front of the niche) cut out of it.
"""
from PIL import Image, ImageChops, ImageDraw, ImageFilter

DIR = "assets/objects/matrons_office_"
BG = "assets/backgrounds/matrons_office_background_v1.png"
K = 1.30625  # background pixels per room pixel
PX = 4
BRIGHTEN = 1.1
PULL_SHARE = 0.45

DRAWERS = {
    # name: (slot in room pixels, the furniture round it (room boxes) for the colour,
    #        the v1 front's plain wood, its hardware box, and "brass" or a knob ellipse)
    "desk_drawer_left": ((659.5, 465, 765, 493), [(648, 466, 657, 492), (767, 466, 776, 492)],
                         [(40, 150, 135, 240), (290, 150, 385, 240)], (135, 178, 288, 248), "brass"),
    "desk_drawer_right": ((839.5, 460, 945, 481), [(800, 462, 835, 479), (950, 462, 985, 479)],
                          [(40, 150, 140, 240), (300, 150, 400, 240)], (140, 148, 285, 248), "brass"),
    "sewing_drawer": ((377, 459.5, 439, 478.5), [(345, 459, 372, 479), (445, 459, 472, 479)],
                      [(45, 168, 160, 262), (262, 168, 385, 262)], (183, 188, 247, 245), "knob"),
}

# The filing cabinet: the niche's inside (room pixels) and what is painted in front of it.
NICHE = (307.5, 440)          # left edge and floor
NICHE_WIDTH = 68.5
TABLE_TOP = [(355, 433.5), (420, 433.5), (420, 470), (326.5, 470), (326.5, 447.5)]
PINCUSHION = (366.5, 416.5, 400.5, 443)


def recolour(image, gains):
    r, g, b, a = image.split()
    return Image.merge("RGBA", [c.point(lambda v, f=f: min(255, int(v * f))) for c, f in zip((r, g, b), gains)] + [a])


def mean_rgb(image):
    pixels = [p for p in image.getdata() if len(p) < 4 or p[3] > 200]
    return tuple(sum(p[i] for p in pixels) / len(pixels) for i in range(3))


def hardware_mask(image, kind):
    mask = Image.new("L", image.size, 0)
    if kind == "knob":
        ImageDraw.Draw(mask).ellipse((2, 2, image.width - 3, image.height - 3), fill=255)
        return mask.filter(ImageFilter.GaussianBlur(1.5))
    src, dst = image.load(), mask.load()
    for y in range(image.height):
        for x in range(image.width):
            r, g, b, a = src[x, y]
            if a > 200 and r > 60 and g > 0.62 * r:
                dst[x, y] = 255
    return mask.filter(ImageFilter.MaxFilter(3)).filter(ImageFilter.GaussianBlur(1))


def edge_gap(size, width, alpha):
    mask = Image.new("L", size, 0)
    ImageDraw.Draw(mask).rectangle((0, 0, size[0] - 1, size[1] - 1), outline=alpha, width=width)
    shade = Image.new("RGBA", size, (10, 5, 2, 255))
    shade.putalpha(mask.filter(ImageFilter.GaussianBlur(width / 2)))
    return shade


def top_shadow(size, height, alpha):
    shade = Image.new("RGBA", size, (8, 4, 2, 0))
    draw = ImageDraw.Draw(shade)
    for y in range(min(height, size[1])):
        draw.line([(0, y), (size[0], y)], fill=(8, 4, 2, int(alpha * (1.0 - y / height) ** 1.5)))
    return shade


bg = Image.open(BG).convert("RGB")


def furniture_rgb(boxes):
    pixels = []
    for l, t, r, b in boxes:
        pixels += list(bg.crop((int(l * K), int(t * K), int(r * K), int(b * K))).getdata())
    return tuple(sum(p[i] for p in pixels) / len(pixels) for i in range(3))


for name, (slot, around, plain, hardware, kind) in DRAWERS.items():
    closed = Image.open(DIR + name + "_closed_v1.png").convert("RGBA")
    front_w, front_h = round((slot[2] - slot[0]) * PX), round((slot[3] - slot[1]) * PX)
    pull = int(front_h * PULL_SHARE)
    top = pull + 12

    pieces = [closed.crop(box) for box in plain]
    wood = Image.new("RGBA", (sum(p.width for p in pieces), pieces[0].height))
    x = 0
    for piece in pieces:
        wood.paste(piece, (x, 0))
        x += piece.width
    gains = [f / w * BRIGHTEN for f, w in zip(furniture_rgb(around), mean_rgb(wood))]
    front = recolour(wood.resize((front_w, front_h), Image.LANCZOS), gains)

    parts = closed.crop(hardware)
    parts.putalpha(ImageChops.multiply(parts.getchannel("A"), hardware_mask(parts, kind)))
    parts = parts.crop(parts.getbbox())
    fit = min((front_h - 12) / parts.height, front_w * 0.45 / parts.width)
    parts = parts.resize((max(1, int(parts.width * fit)), max(1, int(parts.height * fit))), Image.LANCZOS)
    parts = recolour(parts, (0.85, 0.83, 0.8) if kind == "brass" else gains)
    front.alpha_composite(parts, ((front_w - parts.width) // 2, (front_h - parts.height) // 2))
    front.alpha_composite(edge_gap(front.size, 5, 210))

    size = (front_w + 16, front_h + 2 * top)
    new_closed = Image.new("RGBA", size, (0, 0, 0, 0))
    new_closed.alpha_composite(front, (8, top))
    new_closed.save(DIR + name + "_closed_v2.png")

    inside = recolour(wood.resize((front_w, pull), Image.LANCZOS), [g * 0.55 for g in gains])
    inside.alpha_composite(top_shadow(inside.size, int(pull * 0.6), 220))
    backing = Image.new("RGBA", inside.size, (16, 8, 4, 255))
    backing.alpha_composite(inside)
    new_open = Image.new("RGBA", size, (0, 0, 0, 0))
    new_open.alpha_composite(backing, (8, top))
    shadow = Image.new("RGBA", size, (0, 0, 0, 0))
    ImageDraw.Draw(shadow).rectangle((14, top + pull + front_h, front_w + 2, top + pull + front_h + 8), fill=(0, 0, 0, 130))
    new_open.alpha_composite(shadow.filter(ImageFilter.GaussianBlur(4)))
    new_open.alpha_composite(front, (8, top + pull))
    new_open.save(DIR + name + "_open_v3.png")
    print(name, "canvas", size, "centre", ((slot[0] + slot[2]) / 2, (slot[1] + slot[3]) / 2),
          "front top", slot[1], "pull", pull / PX)

# The filing cabinet, inside the niche.
for state in ("closed", "open"):
    cabinet = Image.open(DIR + "filing_cabinet_%s_v1.png" % state).convert("RGBA")
    if state == "closed":
        bbox = cabinet.getbbox()
        scale = NICHE_WIDTH * PX / (bbox[2] - bbox[0])
    picture = cabinet.resize((round(cabinet.width * scale), round(cabinet.height * scale)), Image.LANCZOS)
    # Where the picture's top-left corner lands (room pixels): the CLOSED cabinet's foot on the niche floor.
    left = NICHE[0] - bbox[0] * scale / PX
    top = NICHE[1] - bbox[3] * scale / PX
    alpha = picture.getchannel("A")
    draw = ImageDraw.Draw(alpha)
    draw.polygon([((x - left) * PX, (y - top) * PX) for x, y in TABLE_TOP], fill=0)
    l, t, r, b = PINCUSHION
    draw.ellipse(((l - left) * PX, (t - top) * PX, (r - left) * PX, (b - top) * PX), fill=0)
    picture.putalpha(alpha)
    picture.save(DIR + "filing_cabinet_%s_v2.png" % state)
    print("filing_cabinet", state, picture.size, "centre",
          (round(left + picture.width / PX / 2, 2), round(top + picture.height / PX / 2, 2)),
          "click size", ((bbox[2] - bbox[0]) * scale, (bbox[3] - bbox[1]) * scale))
