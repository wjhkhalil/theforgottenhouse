"""Fit the Dispensary's two counter drawers into the slots painted in the background.

Run from the project folder:  python3 tools/sprite_fixes/dispensary_fit_drawers.py
Then run match_drawer_colours.py --apply to fine-tune their tint.

The v1 drawers are boxes seen from a little above, bigger than the painted slots. For each
this writes, at scale 0.25 (4 picture pixels per world pixel):
  - <name>_closed_v2.png: a flat front the size of its slot (and the slot's lit lip),
    the wood stretched from the plain parts of the v1 front and recoloured to the
    counter's frame wood; the brass label plate and handle scaled evenly so they keep
    their shape, and left brass.
  - <name>_open_v3.png: the same front pulled down, the drawer's inside (the same wood,
    in shadow) above it.
"""
from PIL import Image, ImageChops, ImageDraw, ImageFilter

DIR = "assets/objects/"
# Mean colour of the counter's frame wood round the slots (from the background).
FRAME_RGB = (44.5, 20.5, 12.0)
BRIGHTEN = 1.1  # a front faces the light a little more than the frame's edges
PULL_SHARE = 0.45

DRAWERS = {
    # name: (the slot with its lip, in world pixels (left, top, right, bottom),
    #        the brass plate and handle in the v1 picture)
    "dispensary_powder_drawer": ((345, 419, 430, 440), (163, 48, 260, 138)),
    "dispensary_label_drawer": ((455, 419, 538, 440), (163, 48, 266, 148)),
}
# The v1 front (below the box's top edge), and its plain wood either side of the brass.
FACE = (22, 34, 406, 160)
PLAIN = [(22, 34, 158, 160), (270, 34, 406, 160)]


def recolour(image, gains):
    r, g, b, a = image.split()
    return Image.merge("RGBA", [c.point(lambda v, f=f: min(255, int(v * f))) for c, f in zip((r, g, b), gains)] + [a])


def mean_rgb(image):
    pixels = [p for p in image.getdata() if p[3] > 200]
    return tuple(sum(p[i] for p in pixels) / len(pixels) for i in range(3))


def brass_mask(image):
    """Brass is yellower than the wood: green close to red, and bright enough.
    Only used inside the hand-picked hardware box (the wood has orange highlights too)."""
    mask = Image.new("L", image.size, 0)
    src, dst = image.load(), mask.load()
    for y in range(image.height):
        for x in range(image.width):
            r, g, b, a = src[x, y]
            if a > 200 and r > 60 and g > 0.62 * r:
                dst[x, y] = 255
    return mask


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


for name, (slot, hardware) in DRAWERS.items():
    closed = Image.open(DIR + name + "_closed_v1.png").convert("RGBA")
    front_w, front_h = (slot[2] - slot[0]) * 4, (slot[3] - slot[1]) * 4
    pull = int(front_h * PULL_SHARE)
    top = pull + 12

    pieces = [closed.crop(box) for box in PLAIN]
    wood = Image.new("RGBA", (sum(p.width for p in pieces), pieces[0].height))
    x = 0
    for piece in pieces:
        wood.paste(piece, (x, 0))
        x += piece.width
    gains = [f / w * BRIGHTEN for f, w in zip(FRAME_RGB, mean_rgb(wood))]
    front = recolour(wood.resize((front_w, front_h), Image.LANCZOS), gains)

    # Plate and handle: the brass parts, scaled evenly to fit the low front, dimmed a little.
    parts = closed.crop(hardware)
    brass = brass_mask(parts)
    parts.putalpha(ImageChops.multiply(parts.getchannel("A"), brass.filter(ImageFilter.MaxFilter(3)).filter(ImageFilter.GaussianBlur(1))))
    fit = (front_h - 10) / parts.height
    parts = recolour(parts.resize((max(1, int(parts.width * fit)), max(1, int(parts.height * fit))), Image.LANCZOS), (0.8, 0.78, 0.74))
    front.alpha_composite(parts, ((front_w - parts.width) // 2, (front_h - parts.height) // 2))
    front.alpha_composite(edge_gap(front.size, 5, 210))

    size = (front_w + 16, front_h + 2 * top)
    new_closed = Image.new("RGBA", size, (0, 0, 0, 0))
    new_closed.alpha_composite(front, (8, top))
    new_closed.save(DIR + name + "_closed_v2.png")

    # The inside: the same wood, in the shadow of the counter.
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
    centre = ((slot[0] + slot[2]) / 2, (slot[1] + slot[3]) / 2)
    print(name, "canvas", size, "centre", centre, "gains", [round(g, 2) for g in gains], "hardware", hardware)
