"""Fit Ward Seven's iron shutter to its painted hatch, and hang the restraint cupboard on the wall.

Run from the project folder:  python3 tools/sprite_fixes/ward_seven_fit_wall.py

The barred hatch is painted square (frame room 1424..1525 x 183..280.5, opening 1438.75..
1511.75 x 197.5..267), but the v1 shutter is a tall plate that only covered its middle.
This writes, at 4 picture pixels per room pixel over SHUTTER_CANVAS:
  - ward_seven_barred_shutter_closed_v2.png: a square plate made from the v1 plate's top
    and bottom (both rivet rows and both hinges) with its latch in the middle, covering
    the opening and the inner part of the painted frame;
  - ward_seven_barred_shutter_open_v2.png: the moonlit window with its bars (from the v1
    open picture) in the painted opening, and the plate swung out on its hinges.
And, the same size as v1 with room for a shadow:
  - ward_seven_restraint_cupboard_{closed,open}_v2.png: the cupboard with a soft shadow on
    the wall, down and to the right, so it hangs on the wall instead of floating over it;
  - ward_seven_floor_shadow_v1.png: a soft dark ellipse for objects standing on the floor.
"""
from PIL import Image, ImageDraw, ImageEnhance, ImageFilter, ImageOps

DIR = "assets/objects/ward_seven_"
PX = 4
SHUTTER_CANVAS = (1418, 177, 1556, 291)
PLATE = (1433, 191)            # the closed plate's top-left corner (room pixels)
OPENING = (1438.75, 197.5, 1511.75, 267)
# In the v1 closed picture: the plate's top and bottom bands, its width, and the latch.
TOP_BAND = (18, 140)
BOTTOM_BAND = (280, 402)
PLATE_X = (100, 376)           # includes the latch (left) and hinges (right)
PLATE_LEFT = 110               # the plate's own left edge
LATCH = (100, 170, 180, 238)
# In the v1 open picture: a square of the window (moon, bars and hills).
WINDOW = (172, 85, 318, 224)


def solve(a, b):
    n = len(b)
    m = [row[:] + [b[i]] for i, row in enumerate(a)]
    for c in range(n):
        p = max(range(c, n), key=lambda r: abs(m[r][c]))
        m[c], m[p] = m[p], m[c]
        for r in range(n):
            if r != c:
                f = m[r][c] / m[c][c]
                m[r] = [x - f * y for x, y in zip(m[r], m[c])]
    return [m[i][n] / m[i][i] for i in range(n)]


def perspective(out_points, in_points):
    a, b = [], []
    for (x, y), (u, v) in zip(out_points, in_points):
        a.append([x, y, 1, 0, 0, 0, -u * x, -u * y])
        a.append([0, 0, 0, x, y, 1, -v * x, -v * y])
        b += [u, v]
    return solve(a, b)


def at(x, y):
    """Room pixels to picture pixels on the shutter canvas."""
    return ((x - SHUTTER_CANVAS[0]) * PX, (y - SHUTTER_CANVAS[1]) * PX)


# --- The shutter -----------------------------------------------------------
closed = Image.open(DIR + "barred_shutter_closed_v1.png").convert("RGBA")
top = closed.crop((PLATE_X[0], TOP_BAND[0], PLATE_X[1], TOP_BAND[1]))
bottom = closed.crop((PLATE_X[0], BOTTOM_BAND[0], PLATE_X[1], BOTTOM_BAND[1]))
square = Image.new("RGBA", (top.width, top.height + bottom.height), (0, 0, 0, 0))
square.alpha_composite(top, (0, 0))
square.alpha_composite(bottom, (0, top.height))
latch = closed.crop(LATCH)
square.alpha_composite(latch, (LATCH[0] - PLATE_X[0], square.height // 2 - latch.height // 2))
plate_w = PLATE_X[1] - PLATE_LEFT - (PLATE_X[1] - 358)   # the plate itself, without hinges
k = (OPENING[2] - OPENING[0] + 11) / plate_w             # room pixels per v1 pixel
plate = square.resize((round(square.width * k * PX), round(square.height * k * PX)), Image.LANCZOS)
size = ((SHUTTER_CANVAS[2] - SHUTTER_CANVAS[0]) * PX, (SHUTTER_CANVAS[3] - SHUTTER_CANVAS[1]) * PX)
origin = at(PLATE[0] - (PLATE_LEFT - PLATE_X[0]) * k, PLATE[1])
shut = Image.new("RGBA", size, (0, 0, 0, 0))
shadow = Image.new("RGBA", size, (0, 0, 0, 0))
shadow.alpha_composite(plate, (round(origin[0]) + 6, round(origin[1]) + 8))
dark = Image.new("RGBA", size, (4, 4, 4, 0))
dark.putalpha(shadow.getchannel("A").point(lambda v: v * 150 // 255).filter(ImageFilter.GaussianBlur(6)))
shut.alpha_composite(dark)
shut.alpha_composite(plate, (round(origin[0]), round(origin[1])))
shut.save(DIR + "barred_shutter_closed_v2.png")
plate_box = (PLATE[0], PLATE[1], PLATE[0] + plate_w * k, PLATE[1] + square.height * k)
print("shutter plate room box", [round(v, 1) for v in plate_box])

opened = Image.open(DIR + "barred_shutter_open_v1.png").convert("RGBA")
window = opened.crop(WINDOW)
l, t, r, b = OPENING
window = window.resize((round((r - l) * PX), round((b - t) * PX)), Image.LANCZOS)
inner = Image.new("RGBA", window.size, (0, 0, 0, 0))
ImageDraw.Draw(inner).rectangle((0, 0, window.width - 1, 26), fill=(0, 0, 0, 120))
window.alpha_composite(inner.filter(ImageFilter.GaussianBlur(10)))   # the frame's shadow on the glass
opened_canvas = Image.new("RGBA", size, (0, 0, 0, 0))
opened_canvas.alpha_composite(window, tuple(round(v) for v in at(l, t)))
# The plate swung out on its hinges (right), seen edge-on: its inner face, darker.
leaf = ImageEnhance.Brightness(ImageOps.mirror(square)).enhance(0.7)
hinge_x = plate_box[2] + 2
far_x = hinge_x + 30
corners = [at(hinge_x, plate_box[1]), at(far_x, plate_box[1] - 7), at(far_x, plate_box[3] + 7), at(hinge_x, plate_box[3])]
coeffs = perspective(corners, [(0, 0), (leaf.width, 0), (leaf.width, leaf.height), (0, leaf.height)])
swung = leaf.transform(size, Image.PERSPECTIVE, coeffs, Image.BICUBIC)
shade = Image.new("RGBA", size, (4, 4, 4, 0))
shade.putalpha(swung.getchannel("A").point(lambda v: v * 120 // 255).filter(ImageFilter.GaussianBlur(8)))
opened_canvas.alpha_composite(shade, (10, 10))
opened_canvas.alpha_composite(swung)
opened_canvas.save(DIR + "barred_shutter_open_v2.png")
print("shutter canvas", size, "centre", ((SHUTTER_CANVAS[0] + SHUTTER_CANVAS[2]) / 2, (SHUTTER_CANVAS[1] + SHUTTER_CANVAS[3]) / 2))

# --- The restraint cupboard, with its shadow on the wall --------------------
for state in ("closed", "open"):
    cupboard = Image.open(DIR + "restraint_cupboard_%s_v1.png" % state).convert("RGBA")
    pad = 40
    out = Image.new("RGBA", (cupboard.width + pad * 2, cupboard.height + pad * 2), (0, 0, 0, 0))
    shadow = Image.new("RGBA", out.size, (5, 6, 5, 0))
    alpha = Image.new("L", out.size, 0)
    alpha.paste(cupboard.getchannel("A").point(lambda v: v * 170 // 255), (pad + 14, pad + 18))
    shadow.putalpha(alpha.filter(ImageFilter.GaussianBlur(9)))
    out.alpha_composite(shadow)
    out.alpha_composite(cupboard, (pad, pad))
    out.save(DIR + "restraint_cupboard_%s_v2.png" % state)
    print("restraint cupboard", state, out.size, "(v1 picture is at", (pad, pad), ")")

# --- A floor shadow ----------------------------------------------------------
floor = Image.new("RGBA", (200, 60), (4, 3, 2, 0))
alpha = Image.new("L", floor.size, 0)
ImageDraw.Draw(alpha).ellipse((20, 15, 180, 45), fill=190)
floor.putalpha(alpha.filter(ImageFilter.GaussianBlur(8)))
floor.save(DIR + "floor_shadow_v1.png")
