"""Stand the Ward Seven nurses' locker against the wall, as a box rather than a flat front.

Run from the project folder:  python3 tools/sprite_fixes/ward_seven_nurses_locker.py

The v1 locker stood out on the floor in front of the wall, over the edge of bed 6, and
was a flat front view in a room painted in perspective. This writes
ward_seven_nurses_locker_{closed,open}_v2.png covering CANVAS (room pixels) at 4 picture
pixels per room pixel:
  - the front fitted to FRONT, in the gap between the headboards of beds 5 and 6, its
    feet on the line where the wall meets the floor;
  - its left side and top, receding towards the painting's vanishing point (VP), made
    from the front's own green paint in shadow;
  - a soft shadow on the wall to its right and on the floor at its feet.
Both pictures use the same placement, so the open door swings out from the same box.
"""
from PIL import Image, ImageDraw, ImageEnhance, ImageFilter

DIR = "assets/objects/ward_seven_nurses_locker_"
PX = 4
CANVAS = (1270, 360, 1372, 510)
FRONT = (1290, 377, 1340, 497)       # room pixels: left, top, right, bottom (the feet)
V1_FRONT = (64, 10, 234, 417)        # the closed v1 locker's bounding box
VP = (1012, 300)                     # where the painting's lines meet
DEPTH = 0.03                         # how far the back edges are towards VP


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


def at(point):
    return ((point[0] - CANVAS[0]) * PX, (point[1] - CANVAS[1]) * PX)


def back(point):
    return (point[0] + (VP[0] - point[0]) * DEPTH, point[1] + (VP[1] - point[1]) * DEPTH)


def warp(image, quad, size):
    coeffs = perspective([at(p) for p in quad], [(0, 0), (image.width, 0), (image.width, image.height), (0, image.height)])
    return image.transform(size, Image.PERSPECTIVE, coeffs, Image.BICUBIC)


size = ((CANVAS[2] - CANVAS[0]) * PX, (CANVAS[3] - CANVAS[1]) * PX)
l, t, r, b = FRONT
k = (r - l) / (V1_FRONT[2] - V1_FRONT[0])   # room pixels per v1 pixel
closed_v1 = Image.open(DIR + "closed_v1.png").convert("RGBA")
# The side and top: a plain strip of the front's paint (beside the door, under the vents), in shadow.
paint = closed_v1.crop((V1_FRONT[0] + 4, 140, V1_FRONT[0] + 30, 380))
side = ImageEnhance.Brightness(paint).enhance(0.5)
top = ImageEnhance.Brightness(paint.rotate(90, expand=True)).enhance(0.75)

for state in ("closed", "open"):
    v1 = Image.open(DIR + "%s_v1.png" % state).convert("RGBA")
    picture = v1.resize((round(v1.width * k * PX), round(v1.height * k * PX)), Image.LANCZOS)
    origin = at((l - V1_FRONT[0] * k, t - V1_FRONT[1] * k))
    out = Image.new("RGBA", size, (0, 0, 0, 0))
    # Shadows: on the wall behind (to the right, the moonlight comes from the windows on the left) and on the floor.
    shadow = Image.new("L", size, 0)
    draw = ImageDraw.Draw(shadow)
    draw.rectangle([*at((l + 4, t + 3)), *at((r + 5, b - 1))], fill=150)
    draw.ellipse([*at((l - 10, b - 4)), *at((r + 8, b + 5))], fill=170)
    dark = Image.new("RGBA", size, (4, 5, 4, 255))
    dark.putalpha(shadow.filter(ImageFilter.GaussianBlur(4 * PX)))
    out.alpha_composite(dark)
    # The side and the top, then the front over them.
    out.alpha_composite(warp(side, [back((l, t)), (l, t), (l, b), back((l, b))], size))
    out.alpha_composite(warp(top, [back((l, t)), back((r, t)), (r, t), (l, t)], size))
    out.alpha_composite(picture, (round(origin[0]), round(origin[1])))
    out.save(DIR + "%s_v2.png" % state)
print("canvas", size, "centre", ((CANVAS[0] + CANVAS[2]) / 2, (CANVAS[1] + CANVAS[3]) / 2),
      "front click size at scale 0.25", ((r - l) * PX, (b - t) * PX), "front centre", ((l + r) / 2, (t + b) / 2))
