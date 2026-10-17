"""Fit the Dispensary bureau into the square recess painted in the counter.

Run from the project folder:  python3 tools/sprite_fixes/dispensary_bureau_fit.py

The v1 closed bureau is a slant-top desk: its fall front narrows to the top, so inside
the painting's square recess it looked tilted. This writes, at 4 picture pixels per room
pixel over CANVAS:
  - dispensary_bureau_closed_v2.png: the fall front warped flat and square, its face
    filling FACE (room pixels), the top moulding and base following above and below;
  - dispensary_bureau_open_v2.png: the open bureau with its pigeonhole case fitted to the
    same recess, the let-down flap hanging below it.
The scene draws both at scale 0.25, centred on CANVAS.
"""
from PIL import Image

DIR = "assets/objects/"
CANVAS = (566, 428, 660, 520)
PX = 4
# Closed: the slanted face's corners in the v1 picture (top left, top right, bottom
# right, bottom left), and where it goes in the room.
CLOSED_FACE = [(47, 40), (381, 40), (399, 180), (29, 180)]
FACE = (579, 443, 647, 474)
# Open: the pigeonhole case in the v1 picture, and where it goes.
OPEN_CASE = (50, 16, 380, 236)
CASE = (577, 437, 649, 480)


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


def corners(box):
    left, top, right, bottom = box
    return [((left - CANVAS[0]) * PX, (top - CANVAS[1]) * PX), ((right - CANVAS[0]) * PX, (top - CANVAS[1]) * PX),
            ((right - CANVAS[0]) * PX, (bottom - CANVAS[1]) * PX), ((left - CANVAS[0]) * PX, (bottom - CANVAS[1]) * PX)]


size = ((CANVAS[2] - CANVAS[0]) * PX, (CANVAS[3] - CANVAS[1]) * PX)
closed = Image.open(DIR + "dispensary_bureau_closed_v1.png").convert("RGBA")
warped = closed.transform(size, Image.PERSPECTIVE, perspective(corners(FACE), CLOSED_FACE), Image.BICUBIC)
warped.save(DIR + "dispensary_bureau_closed_v2.png")

opened = Image.open(DIR + "dispensary_bureau_open_v1.png").convert("RGBA")
l, t, r, b = OPEN_CASE
warped_open = opened.transform(size, Image.PERSPECTIVE, perspective(corners(CASE), [(l, t), (r, t), (r, b), (l, b)]), Image.BICUBIC)
warped_open.save(DIR + "dispensary_bureau_open_v2.png")
for name, image in (("closed", warped), ("open", warped_open)):
    x0, y0, x1, y1 = image.getbbox()
    print(name, "room x %.1f..%.1f y %.1f..%.1f" % (CANVAS[0] + x0 / PX, CANVAS[0] + x1 / PX, CANVAS[1] + y0 / PX, CANVAS[1] + y1 / PX))
print("node position", ((CANVAS[0] + CANVAS[2]) / 2, (CANVAS[1] + CANVAS[3]) / 2), "scale", 1 / PX)
