"""Fit the Boiler Room bench drawer into the slot painted in the workbench.

Run from the project folder:  python3 tools/sprite_fixes/boiler_room_fit_drawer.py
Then run match_drawer_colours.py --apply to fine-tune its tint.

The v1 drawer is a box seen from a little above, bigger than the painted slot and
hanging below the bench. This writes, at scale 0.25 (4 picture pixels per world pixel):
  - boiler_room_bench_drawer_closed_v2.png: a flat front the size of the slot (world
    720..780 x 382..399), the wood stretched from the plain parts of the v1 front and
    recoloured to the bench; the iron handle scaled evenly so it keeps its shape.
  - boiler_room_bench_drawer_open_v3.png: the same front pulled down, the inside above it.
"""
from PIL import Image, ImageChops, ImageDraw, ImageFilter

DIR = "assets/objects/"
NAME = "boiler_room_bench_drawer"
SLOT = (720, 382, 780, 399)
# The v1 front's plain wood either side of the handle, and the handle.
PLAIN = [(48, 48, 124, 200), (300, 48, 376, 200)]
HANDLE = (128, 108, 292, 166)
BENCH_RGB = (42.0, 25.0, 16.0)  # the bench front round the slot
BRIGHTEN = 1.1
PULL_SHARE = 0.45


def recolour(image, gains):
    r, g, b, a = image.split()
    return Image.merge("RGBA", [c.point(lambda v, f=f: min(255, int(v * f))) for c, f in zip((r, g, b), gains)] + [a])


def mean_rgb(image):
    pixels = [p for p in image.getdata() if p[3] > 200]
    return tuple(sum(p[i] for p in pixels) / len(pixels) for i in range(3))


def iron_mask(image):
    """Iron is grey: red not much above blue. The wood round it is orange."""
    mask = Image.new("L", image.size, 0)
    src, dst = image.load(), mask.load()
    for y in range(image.height):
        for x in range(image.width):
            r, g, b, a = src[x, y]
            if a > 200 and r - b < 28:
                dst[x, y] = 255
    # Keep only solid parts (drops odd grey specks in the wood).
    return mask.filter(ImageFilter.MinFilter(3)).filter(ImageFilter.MaxFilter(5))


def edge_gap(size, width, alpha):
    mask = Image.new("L", size, 0)
    ImageDraw.Draw(mask).rectangle((0, 0, size[0] - 1, size[1] - 1), outline=alpha, width=width)
    shade = Image.new("RGBA", size, (10, 6, 3, 255))
    shade.putalpha(mask.filter(ImageFilter.GaussianBlur(width / 2)))
    return shade


def top_shadow(size, height, alpha):
    shade = Image.new("RGBA", size, (8, 4, 2, 0))
    draw = ImageDraw.Draw(shade)
    for y in range(min(height, size[1])):
        draw.line([(0, y), (size[0], y)], fill=(8, 4, 2, int(alpha * (1.0 - y / height) ** 1.5)))
    return shade


closed = Image.open(DIR + NAME + "_closed_v1.png").convert("RGBA")
front_w, front_h = (SLOT[2] - SLOT[0]) * 4, (SLOT[3] - SLOT[1]) * 4
pull = int(front_h * PULL_SHARE)
top = pull + 12

pieces = [closed.crop(box) for box in PLAIN]
wood = Image.new("RGBA", (sum(p.width for p in pieces), pieces[0].height))
x = 0
for piece in pieces:
    wood.paste(piece, (x, 0))
    x += piece.width
gains = [t / w * BRIGHTEN for t, w in zip(BENCH_RGB, mean_rgb(wood))]
front = recolour(wood.resize((front_w, front_h), Image.LANCZOS), gains)

handle = closed.crop(HANDLE)
handle.putalpha(ImageChops.multiply(handle.getchannel("A"), iron_mask(handle).filter(ImageFilter.GaussianBlur(1))))
handle = handle.crop(handle.getbbox())
fit = min((front_h * 0.55) / handle.height, (front_w * 0.4) / handle.width)
handle = handle.resize((int(handle.width * fit), int(handle.height * fit)), Image.LANCZOS)
front.alpha_composite(handle, ((front_w - handle.width) // 2, (front_h - handle.height) // 2 + 2))
front.alpha_composite(edge_gap(front.size, 5, 210))

size = (front_w + 16, front_h + 2 * top)
new_closed = Image.new("RGBA", size, (0, 0, 0, 0))
new_closed.alpha_composite(front, (8, top))
new_closed.save(DIR + NAME + "_closed_v2.png")

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
new_open.save(DIR + NAME + "_open_v3.png")
print("canvas", size, "centre", ((SLOT[0] + SLOT[2]) / 2, (SLOT[1] + SLOT[3]) / 2), "gains", [round(g, 2) for g in gains])
