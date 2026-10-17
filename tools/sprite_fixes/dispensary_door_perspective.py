"""Set the Dispensary office door into its painted doorway, in the painting's perspective.

Run from the project folder:  python3 tools/sprite_fixes/dispensary_door_perspective.py

The doorway is painted seen from the left: its top edge and the MATRON - PRIVATE plate
above it slope down to the right, the threshold slopes up, and the right jamb's lit
inner face shows. The v1 door pictures are flat front views, so their straight top and
bottom did not follow the frame or the plate. This warps both pictures (closed and open,
with the same warp, so the open one stays in place) so the closed door's front fills the
painted opening's four corners, OPENING.

Writes dispensary_office_door_{closed,open}_v2.png covering CANVAS (room pixels) at
4 picture pixels per room pixel. The scene draws them at scale 0.25, centred on CANVAS.
"""
from PIL import Image

DIR = "assets/objects/"
# The painted opening's front corners (room pixels): top left, top right,
# bottom right, bottom left. The lit right jamb (x 134..147) stays showing.
OPENING = [(36.0, 135.5), (134.0, 147.0), (134.0, 507.0), (36.0, 518.5)]
# The closed door's solid front in the v1 picture (left, top, right, bottom).
DOOR = (75, 32, 284, 429)
CANVAS = (0, 106, 170, 534)
PX = 4  # picture pixels per room pixel


def solve(a, b):
    """Gaussian elimination for the 8x8 perspective system."""
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


def coefficients(out_points, in_points):
    """PIL PERSPECTIVE data: maps each output point to its input point."""
    a, b = [], []
    for (x, y), (u, v) in zip(out_points, in_points):
        a.append([x, y, 1, 0, 0, 0, -u * x, -u * y])
        a.append([0, 0, 0, x, y, 1, -v * x, -v * y])
        b += [u, v]
    return solve(a, b)


size = ((CANVAS[2] - CANVAS[0]) * PX, (CANVAS[3] - CANVAS[1]) * PX)
out_corners = [((x - CANVAS[0]) * PX, (y - CANVAS[1]) * PX) for x, y in OPENING]
in_corners = [(DOOR[0], DOOR[1]), (DOOR[2], DOOR[1]), (DOOR[2], DOOR[3]), (DOOR[0], DOOR[3])]
data = coefficients(out_corners, in_corners)
for state in ("closed", "open"):
    picture = Image.open(DIR + "dispensary_office_door_%s_v1.png" % state).convert("RGBA")
    warped = picture.transform(size, Image.PERSPECTIVE, data, Image.BICUBIC)
    warped.save(DIR + "dispensary_office_door_%s_v2.png" % state)
    box = warped.getbbox()
    print(state, size, "covers room x %.1f..%.1f y %.1f..%.1f" % (
        CANVAS[0] + box[0] / PX, CANVAS[0] + box[2] / PX, CANVAS[1] + box[1] / PX, CANVAS[1] + box[3] / PX))
print("node position", ((CANVAS[0] + CANVAS[2]) / 2, (CANVAS[1] + CANVAS[3]) / 2), "scale", 1 / PX)
