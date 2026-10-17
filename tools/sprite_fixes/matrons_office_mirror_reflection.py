"""Paint the reflection in the Matron's Office swing mirror from the room's own painting.

Run from the project folder:  python3 tools/sprite_fixes/matrons_office_mirror_reflection.py

The mirror (scripts/wall_mirror.gd) shows the wall behind the player in three tilts: up,
level and down. This writes assets/backgrounds/matrons_office_mirror_reflection_v1.png:
one tall strip of the three views stacked top to bottom, each as big as the glass
(104 x 333 room pixels), at P picture pixels per room pixel. The views run on from
one another, so tilting the mirror slides along one wall:
  - up:    a ceiling cornice, the picture rail (the picture rail key hangs below it), a
           landscape print on cords, and the top of a tall wardrobe (the caddy key lies on it);
  - level: wallpaper with a nail for the ringed calendar and a brass hook for the cloak,
           then the dado rail and wainscot;
  - down:  the wainscot and skirting, floorboards (the valise stands on them) and the
           edge of the carpet (the galoshes stand on it).
Every piece is cut from matrons_office_background_v1.png: the wallpaper, picture rail,
wainscot, bookcase moulding, cabinet wood, the framed landscape, floor and carpet.
Positions are in glass coordinates (room pixels from the glass's top-left corner, the
three views stacked, so the level view starts at y 333 and the down view at y 666).
"""
from PIL import Image, ImageChops, ImageDraw, ImageEnhance, ImageFilter, ImageOps

BG = "assets/backgrounds/matrons_office_background_v1.png"
OUT = "assets/backgrounds/matrons_office_mirror_reflection_v1.png"
P = 3  # picture pixels per room pixel
GLASS = (104, 333)
VIEW = GLASS[1]

# Source boxes in the background (its own pixels).
WALLPAPER = (868, 165, 966, 335)    # clean damask left of the empty picture frame
RAIL = (300, 24, 530, 42)            # the picture rail moulding
CORNICE = (890, 345, 1157, 368)      # the bookcase's top moulding
PRINT = (1066, 191, 1174, 315)       # the framed landscape
WAINSCOT = (340, 356, 392, 600)      # one bay of the wainscot, dado rail to skirting
STILE = (390, 335, 405, 590)         # the open cabinet's front post
FLOOR = (850, 550, 1230, 585)        # the desk top's polished wood, laid as floorboards
PLANK = 6                            # floorboard width (room pixels)
CARPET = (250, 652, 432, 862)        # the carpet's edge, between the two tables

# Where things go (glass coordinates, room pixels).
CEILING_BOTTOM = 14
RAIL_Y = (51, 58)
PRINT_BOX = (44, 112, 98, 174)
WARDROBE_X = (0, 36)
WARDROBE_TOP = 69                    # the caddy key's bottom is at 70
WARDROBE_FOOT = VIEW * 2 + 128
NAIL = (52, VIEW + 98)
HOOK = (73, VIEW + 172)              # the cloak's hanger hooks over it at 168
WAINSCOT_Y = (VIEW + 255, VIEW * 2 + 124)
FLOOR_Y = (VIEW * 2 + 124, VIEW * 2 + 178)   # the valise's bottom is at 180
CARPET_TOP = VIEW * 2 + 176          # the galoshes stand at 263..293


def px(v):
    return int(round(v * P))


def box(l, t, r, b):
    return (px(l), px(t), px(r), px(b))


def fit(image, w, h):
    return image.resize((max(1, px(w)), max(1, px(h))), Image.LANCZOS)


def tile(piece, size):
    """Tiles `piece` over `size`, mirroring every other copy so the seams match."""
    out = Image.new("RGBA", size)
    flips = [piece, ImageOps.mirror(piece)]
    for row, y in enumerate(range(0, size[1], piece.height)):
        for col, x in enumerate(range(0, size[0], piece.width)):
            p = flips[col % 2]
            out.paste(p if row % 2 == 0 else ImageOps.flip(p), (x, y))
    return out


def shade(size, left, right, top=0.0, bottom=0.0):
    """A black layer: `left`..`right` alpha across, plus `top`/`bottom` edges."""
    w, h = size
    layer = Image.new("L", size)
    d = ImageDraw.Draw(layer)
    for x in range(w):
        d.line([(x, 0), (x, h)], fill=int(255 * (left + (right - left) * x / max(1, w - 1))))
    if top or bottom:
        edge = Image.new("L", size)
        e = ImageDraw.Draw(edge)
        band = max(1, h // 6)
        for y in range(band):
            e.line([(0, y), (w, y)], fill=int(255 * top * (1 - y / band)))
            e.line([(0, h - 1 - y), (w, h - 1 - y)], fill=int(255 * bottom * (1 - y / band)))
        layer = ImageChops.lighter(layer, edge)
    black = Image.new("RGBA", size, (0, 0, 0, 255))
    black.putalpha(layer)
    return black


def soft_shadow(canvas, rect, offset, blur, alpha):
    """A blurred dark rectangle cast on the wall behind `rect` (glass coordinates)."""
    mask = Image.new("L", canvas.size)
    l, t, r, b = rect
    ImageDraw.Draw(mask).rectangle(box(l + offset[0], t + offset[1], r + offset[0], b + offset[1]), fill=alpha)
    layer = Image.new("RGBA", canvas.size, (4, 6, 3, 255))
    layer.putalpha(mask.filter(ImageFilter.GaussianBlur(px(blur))))
    canvas.alpha_composite(layer)


bg = Image.open(BG).convert("RGBA")
size = (px(GLASS[0]), px(VIEW * 3))
canvas = Image.new("RGBA", size, (0, 0, 0, 255))

# The wall: damask wallpaper all the way down, a little darker the higher it is.
paper = fit(bg.crop(WALLPAPER), (WALLPAPER[2] - WALLPAPER[0]) / 1.30625, (WALLPAPER[3] - WALLPAPER[1]) / 1.30625)
canvas.alpha_composite(tile(paper, size))
top_dark = Image.new("L", size)
draw = ImageDraw.Draw(top_dark)
for y in range(px(VIEW)):
    draw.line([(0, y), (size[0], y)], fill=int(110 * (1 - y / px(VIEW)) ** 1.5))
layer = Image.new("RGBA", size, (0, 0, 0, 255))
layer.putalpha(top_dark)
canvas.alpha_composite(layer)

# The ceiling, and a cornice under it (the bookcase moulding, upside down).
ceiling = Image.new("RGBA", (size[0], px(CEILING_BOTTOM)), (34, 33, 28, 255))
ceiling.alpha_composite(shade(ceiling.size, 0.35, 0.15, top=0.6))
canvas.alpha_composite(ceiling)
cornice = ImageOps.flip(fit(bg.crop(CORNICE), GLASS[0], 8))
canvas.alpha_composite(cornice, (0, px(CEILING_BOTTOM - 2)))
soft_shadow(canvas, (0, CEILING_BOTTOM, GLASS[0], CEILING_BOTTOM + 6), (0, 1), 3, 150)

# The picture rail.
rail = fit(bg.crop(RAIL), GLASS[0], RAIL_Y[1] - RAIL_Y[0])
soft_shadow(canvas, (0, RAIL_Y[0], GLASS[0], RAIL_Y[1]), (0, 2), 1.5, 140)
canvas.alpha_composite(rail, (0, px(RAIL_Y[0])))

# The landscape print, hung from the rail on two cords to one hook.
l, t, r, b = PRINT_BOX
cords = ImageDraw.Draw(canvas)
hook = ((l + r) / 2, RAIL_Y[1] + 1)
for corner in ((l + 6, t + 2), (r - 6, t + 2)):
    cords.line([(px(hook[0]), px(hook[1])), (px(corner[0]), px(corner[1]))], fill=(118, 92, 52, 255), width=2)
cords.ellipse(box(hook[0] - 1.6, hook[1] - 1.2, hook[0] + 1.6, hook[1] + 1.8), fill=(150, 112, 56, 255))
soft_shadow(canvas, PRINT_BOX, (3, 4), 3, 170)
picture = ImageOps.mirror(fit(bg.crop(PRINT), r - l, b - t))
canvas.alpha_composite(picture, (px(l), px(t)))

# The nail for the calendar, and the brass hook for the cloak.
x, y = NAIL
cords.ellipse(box(x - 1.3, y - 1.3, x + 1.3, y + 1.3), fill=(22, 20, 16, 255))
cords.ellipse(box(x - 0.6, y - 0.9, x + 0.3, y), fill=(92, 86, 74, 255))
x, y = HOOK
# A round brass peg on a little back plate; the hanger's crook hangs over it.
soft_shadow(canvas, (x - 3, y - 9, x + 3, y - 1), (2, 2), 1.5, 160)
cords.ellipse(box(x - 3, y - 9, x + 3, y - 1), fill=(96, 66, 28, 255))
cords.ellipse(box(x - 2.2, y - 7.6, x + 2.2, y - 2.4), fill=(150, 110, 48, 255))
cords.ellipse(box(x - 1.5, y - 7, x + 0.6, y - 4.8), fill=(214, 172, 96, 255))

# The wainscot, dado rail to skirting, repeated across the wall.
w_top, w_bottom = WAINSCOT_Y
bay = fit(bg.crop(WAINSCOT), (WAINSCOT[2] - WAINSCOT[0]) / 1.30625, w_bottom - w_top)
panelling = tile(bay, (size[0], bay.height))
soft_shadow(canvas, (0, w_top, GLASS[0], w_top + 3), (0, -1), 2, 120)
canvas.alpha_composite(panelling, (0, px(w_top)))

# The floorboards, then the edge of the carpet.
f_top, f_bottom = FLOOR_Y
grain = bg.crop(FLOOR)
boards = Image.new("RGBA", (size[0], px(f_bottom - f_top)), (14, 8, 5, 255))
for row, y in enumerate(range(0, boards.height, px(PLANK))):
    # Each board a different stretch of the grain, its end joint somewhere else.
    strip = grain.crop((row * 37 % 120, 0, row * 37 % 120 + 240, grain.height))
    strip = strip.resize((size[0] * 2, px(PLANK) - 1), Image.LANCZOS)
    strip = ImageEnhance.Brightness(strip).enhance(0.42 + 0.06 * (row % 3))
    boards.alpha_composite(strip, (-(row * 53 % size[0]), y))
    ImageDraw.Draw(boards).line([(row * 71 % size[0], y), (row * 71 % size[0], y + px(PLANK) - 2)], fill=(10, 6, 4, 255), width=2)
canvas.alpha_composite(boards, (0, px(f_top)))
soft_shadow(canvas, (0, f_top, GLASS[0], f_top + 2), (0, 1), 2.5, 170)
carpet = fit(bg.crop(CARPET), GLASS[0], VIEW * 3 - CARPET_TOP)
carpet.alpha_composite(shade(carpet.size, 0.0, 0.0, top=0.25))
canvas.alpha_composite(carpet, (0, px(CARPET_TOP)))
# Where the valise and the galoshes stand, a soft shadow on the floor under them.
for l, r, y in ((9, 43, VIEW * 2 + 179), (46, 80, VIEW * 2 + 292)):
    soft_shadow(canvas, (l, y - 2, r, y + 1), (1, 0), 2, 200)

# The wardrobe at the left: a moulded top, a long panelled door and a front post.
w_left, w_right = WARDROBE_X
body_h = WARDROBE_FOOT - (WARDROBE_TOP + 9)
soft_shadow(canvas, (w_left, WARDROBE_TOP, w_right, WARDROBE_FOOT), (4, 2), 3, 190)
door = fit(ImageEnhance.Brightness(bg.crop(WAINSCOT)).enhance(1.3), w_right - w_left - 5, body_h)
door.alpha_composite(shade(door.size, 0.4, 0.0))
canvas.alpha_composite(door, (px(w_left), px(WARDROBE_TOP + 9)))
stile = fit(bg.crop(STILE), 6, body_h)
canvas.alpha_composite(stile, (px(w_right - 6), px(WARDROBE_TOP + 9)))
top = fit(bg.crop(CORNICE).crop((0, 0, 80, 23)), w_right - w_left + 3, 9)
canvas.alpha_composite(top, (px(w_left), px(WARDROBE_TOP)))
plinth = Image.new("RGBA", (px(w_right - w_left), px(6)), (20, 12, 7, 255))
canvas.alpha_composite(plinth, (px(w_left), px(WARDROBE_FOOT - 6)))
soft_shadow(canvas, (w_left, WARDROBE_FOOT - 1, w_right + 2, WARDROBE_FOOT + 3), (1, 1), 2, 200)

# The reflection is a little dimmer and cooler than the room.
canvas = ImageEnhance.Brightness(canvas).enhance(0.88)
r_, g_, b_, a_ = canvas.split()
canvas = Image.merge("RGBA", (r_.point(lambda v: int(v * 0.95)), g_, b_.point(lambda v: min(255, int(v * 1.04))), a_))
canvas.save(OUT)
print("wrote", OUT, canvas.size)
