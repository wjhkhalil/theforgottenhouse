"""Refit the Boat Shed workbench drawer and the Workshop bench drawer to their tables.

Run from the project folder:  python3 tools/sprite_fixes/house_two_refit_drawers.py

Reads the v1 sprites and writes v2 sprites next to them:
  - closed: the drawer front, recoloured to the wood of the painted table, with a dark
    gap round its edge so it sits IN the table instead of on it.
  - open: the same front pulled out (lower down), with a strip of the drawer's inside
    showing above it. Nothing reaches above the closed front's top edge, so the
    drawer's sides and back never poke up over the table top.
The scenes use self_modulate = white for these sprites: the colour is baked in here.
"""
from PIL import Image, ImageChops, ImageDraw, ImageFilter

DIR = "assets/objects/"

DRAWERS = [
    {
        "name": "boat_shed_workbench_drawer",
        # Front of the closed sprite (its solid part, without the soft edge), and the inside strip of the open sprite (left, top, right, bottom).
        "front": (42, 153, 387, 290),
        "inside": (40, 200, 387, 292),
        # How far the open drawer comes out, as a share of the front's height.
        # Kept small, so the pulled-out front still overlaps the table and looks half out.
        "pull": 0.35,
        # Mean colour of the v1 drawer as drawn in the scene, and of the table wood around it.
        "drawer_rgb": (105.6, 65.2, 35.5),
        # The self_modulate the v1 sprite was drawn with when drawer_rgb was measured.
        "old_modulate": (0.78, 0.66, 0.54),
        "table_rgb": (72.7, 38.3, 16.0),
        # Lift the colour above the table's, which looked a little too dark.
        "brighten": 1.15,
    },
    {
        "name": "workshop_bench_drawer",
        "front": (16, 106, 413, 217),
        "inside": (24, 45, 404, 120),
        "pull": 0.75,
        "drawer_rgb": (92.3, 50.6, 21.6),
        "old_modulate": (1.0, 0.88, 0.74),
        "table_rgb": (104.0, 48.0, 16.0),
    },
]


def recolour(image, gains):
    r, g, b, a = image.split()
    r = r.point(lambda v: min(255, int(v * gains[0])))
    g = g.point(lambda v: min(255, int(v * gains[1])))
    b = b.point(lambda v: min(255, int(v * gains[2])))
    return Image.merge("RGBA", (r, g, b, a))


def edge_gap(size, box, width, alpha, inside_of):
    """A soft dark frame just inside `box`: the gap between drawer and table.
    Clipped to the alpha of `inside_of`, so it never darkens the clear pixels round it."""
    mask = Image.new("L", size, 0)
    draw = ImageDraw.Draw(mask)
    draw.rectangle(box, outline=alpha, width=width)
    mask = mask.filter(ImageFilter.GaussianBlur(width / 2))
    mask = ImageChops.multiply(mask, inside_of.split()[-1])
    shade = Image.new("RGBA", size, (12, 6, 2, 255))
    shade.putalpha(mask)
    return shade


def top_shadow(size, height, alpha):
    """Dark at the top (under the table top), fading out downwards."""
    shade = Image.new("RGBA", size, (8, 4, 2, 0))
    for y in range(min(height, size[1])):
        a = int(alpha * (1.0 - y / height) ** 1.5)
        ImageDraw.Draw(shade).line([(0, y), (size[0], y)], fill=(8, 4, 2, a))
    return shade


for d in DRAWERS:
    closed = Image.open(DIR + d["name"] + "_closed_v1.png").convert("RGBA")
    opened = Image.open(DIR + d["name"] + "_open_v1.png").convert("RGBA")
    gains = [t * m / s for t, m, s in zip(d["table_rgb"], d["old_modulate"], d["drawer_rgb"])]
    gains = [g * d.get("brighten", 1.0) for g in gains]
    x0, y0, x1, y1 = d["front"]
    w, h = x1 - x0, y1 - y0

    front = recolour(closed.crop(d["front"]), gains)
    front.alpha_composite(edge_gap(front.size, (0, 0, w - 1, h - 1), 8, 200, front))

    new_closed = Image.new("RGBA", closed.size, (0, 0, 0, 0))
    new_closed.alpha_composite(front, (x0, y0))
    new_closed.save(DIR + d["name"] + "_closed_v2.png")

    pull = int(h * d["pull"])
    inside = recolour(opened.crop(d["inside"]), gains).resize((w, pull), Image.LANCZOS)
    inside.alpha_composite(top_shadow(inside.size, int(pull * 0.55), 215))
    # Fill any see-through corners of the strip with the dark of the table's insides.
    backing = Image.new("RGBA", inside.size, (20, 10, 4, 255))
    backing.alpha_composite(inside)

    new_open = Image.new("RGBA", closed.size, (0, 0, 0, 0))
    new_open.alpha_composite(backing, (x0, y0))
    # A soft shadow of the pulled-out front on what is below it.
    shadow = Image.new("RGBA", closed.size, (0, 0, 0, 0))
    ImageDraw.Draw(shadow).rectangle((x0 + 6, y0 + pull + h, x1 - 6, y0 + pull + h + 10), fill=(0, 0, 0, 120))
    new_open.alpha_composite(shadow.filter(ImageFilter.GaussianBlur(5)))
    new_open.alpha_composite(front, (x0, y0 + pull))
    new_open.save(DIR + d["name"] + "_open_v2.png")
    print(d["name"], "gains", [round(g, 2) for g in gains], "pull", pull)
