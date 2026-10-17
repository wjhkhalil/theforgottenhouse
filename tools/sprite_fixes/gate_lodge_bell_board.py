"""Painted pieces for the Gate Lodge bell board (scripts/bell_board.gd).

Run from the project folder:  python3 tools/sprite_fixes/gate_lodge_bell_board.py

The board, its five brass-framed pigeonholes and the bell wires are painted in the
background. This writes the pieces that move, built from painted art already in the game:
  - gate_lodge_bell_v1.png: the brass body of hand_bell_v1 with its dark collar as the crown,
    dimmed a little to sit in the shadow of the wall. It hangs on a painted wire.
  - gate_lodge_bell_shutter_v1.png: a slatted roller shutter the size of one pigeonhole
    opening (38 x 41 world pixels, drawn at 4x), made of slats of painted desk wood
    recoloured to the board, with a brass finger-pull on the bottom slat.
  - gate_lodge_bell_plate_<n>_v1.png: an enamel number plate for each ward (24 x 12 world
    pixels at 4x), its enamel taken from the painted TO THE WARDS sign, numbers in its navy.
"""
import random

from PIL import Image, ImageChops, ImageDraw, ImageFilter, ImageFont

DIR = "assets/objects/"
LABELS = ["2", "4", "7", "9", "11"]
FONT = "/usr/share/fonts/truetype/freefont/FreeSerifBold.ttf"
K = 1672 / 1280  # background pixels per world pixel

random.seed(7)
background = Image.open("assets/backgrounds/gate_lodge_background_v1.png").convert("RGB")
drawer = Image.open(DIR + "gate_lodge_desk_drawer_closed_v1.png").convert("RGBA")


def recolour(image, gains):
    r, g, b, a = image.split()
    r = r.point(lambda v: min(255, int(v * gains[0])))
    g = g.point(lambda v: min(255, int(v * gains[1])))
    b = b.point(lambda v: min(255, int(v * gains[2])))
    return Image.merge("RGBA", (r, g, b, a))


# ---- Bell --------------------------------------------------------------------------------
hand_bell = Image.open(DIR + "hand_bell_v1.png").convert("RGBA")
bell = hand_bell.crop((14, 126, 155, 258))
bell = recolour(bell, (0.86, 0.84, 0.8))
bell.save(DIR + "gate_lodge_bell_v1.png")

# ---- Shutter -----------------------------------------------------------------------------
W, H, SLATS = 152, 164, 8
slat_h = H // SLATS
BOARD_RGB = (45.0, 23.5, 13.0)
WOOD_RGB = (72.4, 36.6, 16.8)
gains = [b / w * 1.35 for b, w in zip(BOARD_RGB, WOOD_RGB)]
wood = recolour(drawer.crop((24, 128, 404, 280)), gains)

shutter = Image.new("RGBA", (W, H), (0, 0, 0, 0))
for i in range(SLATS):
    # Only the plain wood left and right of the drawer's brass plate and knob.
    sy = random.randint(0, wood.height - 22)
    sx = random.choice([random.randint(0, 12), random.randint(238, 250)])
    slat = wood.crop((sx, sy, sx + 128, sy + 22)).resize((W, slat_h), Image.LANCZOS)
    shade = Image.new("RGBA", slat.size, (0, 0, 0, 0))
    draw = ImageDraw.Draw(shade)
    for y in range(slat_h):
        t = y / (slat_h - 1)
        if t < 0.18:  # rounded top edge catches the light
            draw.line([(0, y), (W, y)], fill=(255, 225, 180, int(55 * (1 - t / 0.18))))
        elif t > 0.75:  # the groove under it
            draw.line([(0, y), (W, y)], fill=(6, 3, 1, int(210 * (t - 0.75) / 0.25)))
    slat.alpha_composite(shade)
    shutter.alpha_composite(slat, (0, i * slat_h))

# Darker where it runs in the side grooves, and a thin dark edge all round.
sides = Image.new("RGBA", (W, H), (0, 0, 0, 0))
draw = ImageDraw.Draw(sides)
for x in range(10):
    a = int(150 * (1 - x / 10))
    draw.line([(x, 0), (x, H)], fill=(6, 3, 1, a))
    draw.line([(W - 1 - x, 0), (W - 1 - x, H)], fill=(6, 3, 1, a))
draw.rectangle((0, 0, W - 1, H - 1), outline=(6, 3, 1, 230), width=2)
shutter.alpha_composite(sides)

pull = drawer.crop((170, 140, 258, 180)).resize((40, 12), Image.LANCZOS)
pull = recolour(pull, (0.8, 0.78, 0.74))
shutter.alpha_composite(pull, ((W - pull.width) // 2, H - slat_h - 2))
shutter.save(DIR + "gate_lodge_bell_shutter_v1.png")

# ---- Number plates -----------------------------------------------------------------------
PW, PH = 96, 48
# The colour of the sign's enamel: the mean of its light pixels.
sign = background.crop((int(64 * K), int(40 * K), int(190 * K), int(78 * K)))
light = [p for p in sign.getdata() if sum(p) > 420]
enamel_rgb = tuple(int(sum(p[i] for p in light) / len(light)) for i in range(3))
navy = (34, 38, 62, 255)
font = ImageFont.truetype(FONT, 38)
for label in LABELS:
    plate = Image.new("RGBA", (PW, PH), enamel_rgb + (255,))
    # Mottled, a little grimy towards the edges, like the sign.
    grime = Image.effect_noise((PW // 4, PH // 4), 40).resize((PW, PH), Image.BICUBIC)
    edge = Image.new("L", (PW, PH), 0)
    ImageDraw.Draw(edge).rectangle((0, 0, PW - 1, PH - 1), outline=150, width=8)
    edge = edge.filter(ImageFilter.GaussianBlur(5))
    dark = Image.new("RGBA", (PW, PH), (70, 62, 50, 255))
    plate = Image.composite(dark, plate, ImageChops.multiply(edge, grime).point(lambda v: min(255, v * 2)))
    plate = Image.composite(dark, plate, grime.point(lambda v: 40 if v > 170 else 0))
    draw = ImageDraw.Draw(plate)
    draw.rounded_rectangle((1, 1, PW - 2, PH - 2), radius=5, outline=navy, width=3)
    for cx in (9, PW - 10):  # the two screws
        draw.ellipse((cx - 3, PH // 2 - 3, cx + 3, PH // 2 + 3), fill=(52, 46, 40, 255))
        draw.point((cx - 1, PH // 2 - 1), fill=(150, 140, 125, 255))
    text = Image.new("RGBA", (PW, PH), (0, 0, 0, 0))
    left, top, right, bottom = ImageDraw.Draw(text).textbbox((0, 0), label, font=font)
    ImageDraw.Draw(text).text(((PW - (right - left)) / 2 - left, (PH - (bottom - top)) / 2 - top), label, font=font, fill=navy)
    plate.alpha_composite(text.filter(ImageFilter.GaussianBlur(0.6)))
    # Rounded corners, softened.
    mask = Image.new("L", (PW, PH), 0)
    ImageDraw.Draw(mask).rounded_rectangle((0, 0, PW - 1, PH - 1), radius=6, fill=255)
    plate.putalpha(mask.filter(ImageFilter.GaussianBlur(0.8)))
    plate.save(DIR + "gate_lodge_bell_plate_%s_v1.png" % label)

print("bell", bell.size, "shutter", shutter.size, "plates", LABELS)
