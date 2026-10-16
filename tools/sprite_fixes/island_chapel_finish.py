"""Fit the Island Chapel pulpit drawer and font lid to the painted pulpit and font.

Run from the project folder:  python3 tools/sprite_fixes/island_chapel_finish.py

Reads the v1 sprites and writes v2 sprites next to them:
  - pulpit drawer, closed: the carved front, recoloured to the dark wood of the
    painted pulpit, with a dark gap round its edge so it sits IN the pulpit.
  - pulpit drawer, open: the same front pulled out lower down, with a strip of
    the drawer's inside above it (built like house_two_refit_drawers.py).
  - font lid, closed: the lid squashed flat, because the painted font is seen
    almost side-on at eye level, not from above.
  - font lid, open: only the raised lid, hinged on the back of the painted rim.
    The v1 open sprite also drew its own stone bowl, which sat on top of the
    painted font like a second one.
"""
from PIL import Image, ImageChops, ImageDraw, ImageFilter

DIR = "assets/objects/island_chapel_"


# The same helpers as house_two_refit_drawers.py.
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


# --- Pulpit drawer -----------------------------------------------------------
FRONT = (16, 16, 412, 124)
# Only the back board of the drawer: the papers are left out (the letter is its own sprite).
INSIDE = (40, 20, 398, 44)
PULL = 0.45
# Mean colour of the v1 front, and of the painted pulpit panel round it.
DRAWER_RGB = (78.1, 48.7, 23.6)
PULPIT_RGB = (38.4, 23.5, 19.3)
BRIGHTEN = 1.2

closed = Image.open(DIR + "pulpit_drawer_closed_v1.png").convert("RGBA")
opened = Image.open(DIR + "pulpit_drawer_open_v1.png").convert("RGBA")
gains = [p * BRIGHTEN / d for p, d in zip(PULPIT_RGB, DRAWER_RGB)]
x0, y0, x1, y1 = FRONT
w, h = x1 - x0, y1 - y0

front = recolour(closed.crop(FRONT), gains)
front.alpha_composite(edge_gap(front.size, (0, 0, w - 1, h - 1), 8, 200, front))
new_closed = Image.new("RGBA", closed.size, (0, 0, 0, 0))
new_closed.alpha_composite(front, (x0, y0))
new_closed.save(DIR + "pulpit_drawer_closed_v2.png")

pull = int(h * PULL)
inside = recolour(opened.crop(INSIDE), gains).resize((w, pull), Image.LANCZOS)
inside.alpha_composite(top_shadow(inside.size, int(pull * 0.55), 215))
backing = Image.new("RGBA", inside.size, (16, 9, 6, 255))
backing.alpha_composite(inside)
new_open = Image.new("RGBA", closed.size, (0, 0, 0, 0))
new_open.alpha_composite(backing, (x0, y0))
shadow = Image.new("RGBA", closed.size, (0, 0, 0, 0))
ImageDraw.Draw(shadow).rectangle((x0 + 6, y0 + pull + h, x1 - 6, y0 + pull + h + 10), fill=(0, 0, 0, 120))
new_open.alpha_composite(shadow.filter(ImageFilter.GaussianBlur(5)))
new_open.alpha_composite(front, (x0, y0 + pull))
new_open.save(DIR + "pulpit_drawer_open_v3.png")
print("pulpit drawer gains", [round(g, 2) for g in gains], "pull", pull)

# --- Font lid ----------------------------------------------------------------
# Where the painted rim sits in the sprite (the sprite's centre is the node's position).
RIM_FRONT_Y = 262   # front edge of the rim
RIM_BACK_Y = 222    # back edge of the rim, where the lid's hinges go

lid = Image.open(DIR + "font_cover_closed_v1.png").convert("RGBA")
top = lid.crop((0, 160, lid.width, 330)).resize((lid.width, 46), Image.LANCZOS)
band = lid.crop((0, 330, lid.width, 366)).resize((lid.width, 26), Image.LANCZOS)
new_lid = Image.new("RGBA", lid.size, (0, 0, 0, 0))
new_lid.alpha_composite(top, (0, RIM_FRONT_Y - band.height - top.height + 8))
new_lid.alpha_composite(band, (0, RIM_FRONT_Y - band.height))
new_lid.save(DIR + "font_cover_closed_v2.png")

raised = Image.open(DIR + "font_cover_open_v1.png").convert("RGBA").crop((0, 0, lid.width, 214))
new_raised = Image.new("RGBA", lid.size, (0, 0, 0, 0))
new_raised.alpha_composite(raised, (0, RIM_BACK_Y - raised.height))
new_raised.save(DIR + "font_cover_open_v2.png")
print("font lid written")
