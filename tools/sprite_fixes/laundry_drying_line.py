"""Painted pieces for the Laundry's drying line (scripts/drying_rail.gd).

Run from the project folder:  python3 tools/sprite_fixes/laundry_drying_line.py

Built from the Laundry background painting, so they share its light:
  - laundry_sheet_v1.png: one wet sheet (130 x 280 world pixels, drawn at 2x). The linen is
    the cloth hanging off the ironing table, stretched long; turned over the rail at the
    top, damp and darker towards a stitched hem with an uneven edge.
  - laundry_peg_v1.png: a split wooden peg with a wire band, from the wood of the shelf.
  - laundry_rail_v1.png / laundry_rail_hanger_v1.png: the iron pipe painted along the wall,
    as a strip that tiles along the rail and up the hanger rods. Its ends are blended so
    the repeat does not show a seam.
"""
import math

from PIL import Image, ImageChops, ImageDraw, ImageFilter

DIR = "assets/objects/"
background = Image.open("assets/backgrounds/laundry_background_v1.png").convert("RGB")
K = background.width / 1280  # background pixels per world pixel


def world_crop(box):
    return background.crop(tuple(int(v * K) for v in box))


def multiply(image, factors):
    bands = image.split()
    out = [b.point(lambda v, f=f: min(255, int(v * f))) for b, f in zip(bands[:3], factors)]
    return Image.merge(image.mode, out + list(bands[3:]))


# ---- Sheet -------------------------------------------------------------------------------
W, H = 260, 560
sheet = world_crop((1046, 474, 1166, 592)).resize((W, H), Image.LANCZOS).convert("RGBA")
sheet = multiply(sheet, (0.9, 0.92, 0.95))  # wet linen: a little darker and cooler

shade = Image.new("RGBA", (W, H), (0, 0, 0, 0))
draw = ImageDraw.Draw(shade)
FOLD = 26  # the part turned over the rail
for y in range(FOLD):
    draw.line([(0, y), (W, y)], fill=(255, 255, 250, int(40 * (1 - y / FOLD))))
for y in range(FOLD, FOLD + 10):  # shadow under the turned-over edge
    draw.line([(0, y), (W, y)], fill=(20, 22, 26, int(110 * (1 - (y - FOLD) / 10))))
DAMP = 170  # darker towards the hem, where the water gathers
for y in range(H - DAMP, H):
    t = (y - (H - DAMP)) / DAMP
    draw.line([(0, y), (W, y)], fill=(40, 44, 50, int(95 * t * t)))
sheet.alpha_composite(shade)

# Stitched hem.
hem = Image.new("RGBA", (W, H), (0, 0, 0, 0))
draw = ImageDraw.Draw(hem)
HEM_Y = H - 34
draw.line([(0, HEM_Y), (W, HEM_Y)], fill=(225, 222, 212, 150), width=2)
draw.line([(0, HEM_Y + 2), (W, HEM_Y + 2)], fill=(40, 42, 46, 110), width=1)
for x in range(4, W, 9):
    draw.line([(x, HEM_Y + 8), (x + 4, HEM_Y + 8)], fill=(60, 60, 62, 120), width=1)
sheet.alpha_composite(hem.filter(ImageFilter.GaussianBlur(0.6)))

# Soft folds running down from the pegs.
folds = Image.new("RGBA", (W, H), (0, 0, 0, 0))
draw = ImageDraw.Draw(folds)
for fx in (W * 0.2, W * 0.45, W * 0.72):
    draw.polygon([(fx - 3, FOLD), (fx + 3, FOLD), (fx + 9, H), (fx - 5, H)], fill=(30, 34, 40, 38))
sheet.alpha_composite(folds.filter(ImageFilter.GaussianBlur(5)))

# Outline: straight along the rail, an uneven wet hem at the bottom.
mask = Image.new("L", (W, H), 0)
edge = [(0, 0), (W, 0)]
for x in range(W, -1, -4):
    edge.append((x, H - 6 + 4 * math.sin(x / 19.0) + 2 * math.sin(x / 7.0)))
ImageDraw.Draw(mask).polygon(edge, fill=246)
sheet.putalpha(mask.filter(ImageFilter.GaussianBlur(1.2)))
sheet.save(DIR + "laundry_sheet_v1.png")

# ---- Peg ---------------------------------------------------------------------------------
PW, PH = 12, 34
peg = world_crop((300, 204, 330, 212)).resize((PH, PW), Image.LANCZOS).rotate(90, expand=True).convert("RGBA")
peg = multiply(peg, (1.05, 0.98, 0.9))
draw = ImageDraw.Draw(peg)
draw.line([(PW // 2, PH * 0.45), (PW // 2, PH)], fill=(25, 15, 8, 255), width=1)  # the split
draw.rectangle((0, int(PH * 0.38), PW, int(PH * 0.38) + 3), fill=(120, 118, 112, 255))  # wire band
mask = Image.new("L", (PW, PH), 0)
ImageDraw.Draw(mask).rounded_rectangle((0, 0, PW - 1, PH - 1), radius=4, fill=255)
peg.putalpha(mask)
peg.save(DIR + "laundry_peg_v1.png")

# ---- Rail --------------------------------------------------------------------------------
pipe = background.crop((int(600 * K), 74, int(900 * K), 84)).convert("RGBA")
# Fade the strip's top and bottom rows (wall) out, keep the pipe.
alpha = Image.new("L", pipe.size, 0)
for y, a in enumerate([0, 120, 255, 255, 255, 255, 255, 255, 120, 0]):
    ImageDraw.Draw(alpha).line([(0, y), (pipe.width, y)], fill=a)
pipe.putalpha(alpha)
# Blend the last 40 pixels into the first, so it tiles without a seam.
blend = 40
start = pipe.crop((0, 0, blend, pipe.height))
end = pipe.crop((pipe.width - blend, 0, pipe.width, pipe.height))
ramp = Image.linear_gradient("L").rotate(90).resize((blend, pipe.height))
pipe.paste(Image.composite(end, start, ramp), (0, 0))
pipe = pipe.crop((0, 0, pipe.width - blend, pipe.height))
pipe.save(DIR + "laundry_rail_v1.png")
pipe.rotate(90, expand=True).save(DIR + "laundry_rail_hanger_v1.png")
print("sheet", sheet.size, "peg", peg.size, "rail", pipe.size)
