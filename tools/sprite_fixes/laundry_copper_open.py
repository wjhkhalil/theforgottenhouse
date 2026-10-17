"""Make the Laundry's wash copper open as itself, with its full-size lid pushed aside.

Run from the project folder:  python3 tools/sprite_fixes/laundry_copper_open.py

The v1 open picture is a different pot (narrower, on legs) with a lid a third the size of
the closed one. This writes laundry_wash_copper_open_v2.png from the CLOSED picture: the
same pot, its top open on hot water (the water from the v1 open picture), and the same
wooden lid pushed over to the right, resting on the rim. The canvas is widened equally on
both sides for the overhanging lid, so the pot stays where it was in the room.
"""
from PIL import Image, ImageChops, ImageDraw, ImageFilter

DIR = "assets/objects/"
closed = Image.open(DIR + "laundry_wash_copper_closed_v1.png").convert("RGBA")
old_open = Image.open(DIR + "laundry_wash_copper_open_v1.png").convert("RGBA")
W, H = closed.size

LID_BOTTOM = 104          # the lid sits on the pot down to here
OPENING = (30, 46, 398, 106)  # the pot's mouth, as an ellipse
SHIFT = 150               # how far the lid is pushed to the right
PAD = SHIFT               # canvas widened by this on each side

# The pot without its lid: everything below the lid, plus the side handles.
body_mask = Image.new("L", closed.size, 0)
draw = ImageDraw.Draw(body_mask)
draw.rectangle((0, LID_BOTTOM, W, H), fill=255)
draw.rectangle((0, 0, 26, H), fill=255)
draw.rectangle((W - 26, 0, W, H), fill=255)
body = closed.copy()
body.putalpha(ImageChops.multiply(closed.getchannel("A"), body_mask))
# Where the lid's edge hid the top of the pot's front, put copper back.
front = closed.crop((60, 140, 360, 170)).resize((OPENING[2] - OPENING[0], LID_BOTTOM + 2 - 76), Image.LANCZOS)

# The mouth: a copper rim round dark copper inside walls and the water.
copper = closed.crop((60, 140, 360, 230))
mouth = Image.new("RGBA", closed.size, (0, 0, 0, 0))
wall = copper.resize((OPENING[2] - OPENING[0], OPENING[3] - OPENING[1]), Image.LANCZOS)
wall = Image.merge("RGBA", [c.point(lambda v: int(v * 0.45)) for c in wall.convert("RGB").split()] + [Image.new("L", wall.size, 255)])
mouth.alpha_composite(wall, (OPENING[0], OPENING[1]))
water = old_open.crop((90, 48, 330, 82))
inner = (OPENING[0] + 14, OPENING[1] + 16, OPENING[2] - 14, OPENING[3] - 4)
water = water.resize((inner[2] - inner[0], inner[3] - inner[1]), Image.LANCZOS)
water_mask = Image.new("L", water.size, 0)
ImageDraw.Draw(water_mask).ellipse((0, 0, water.width - 1, water.height - 1), fill=255)
water.putalpha(water_mask.filter(ImageFilter.GaussianBlur(2)))
mouth.alpha_composite(water, inner[:2])
mouth_mask = Image.new("L", closed.size, 0)
ImageDraw.Draw(mouth_mask).ellipse(OPENING, fill=255)
mouth.putalpha(ImageChops.multiply(mouth.getchannel("A"), mouth_mask))
rim = Image.new("RGBA", closed.size, (0, 0, 0, 0))
rim_colour = closed.crop((150, 160, 260, 200)).resize((1, 1), Image.BOX).getpixel((0, 0))
ImageDraw.Draw(rim).ellipse(OPENING, outline=tuple(min(255, int(c * 1.35)) for c in rim_colour[:3]) + (255,), width=7)
mouth.alpha_composite(rim.filter(ImageFilter.GaussianBlur(1)))

# The lid: the closed picture above the pot, the same size, pushed right and tipped a little.
lid_mask = Image.new("L", closed.size, 0)
ImageDraw.Draw(lid_mask).rectangle((26, 0, W - 26, LID_BOTTOM), fill=255)
lid = closed.copy()
lid.putalpha(ImageChops.multiply(closed.getchannel("A"), lid_mask))
lid = lid.crop(lid.getbbox()).rotate(-5, resample=Image.BICUBIC, expand=True)

canvas = Image.new("RGBA", (W + 2 * PAD, H), (0, 0, 0, 0))
canvas.alpha_composite(front, (PAD + OPENING[0], 76))
canvas.alpha_composite(body, (PAD, 0))
canvas.alpha_composite(mouth, (PAD, 0))
lid_x = PAD + 26 + SHIFT
lid_y = 30
shadow = Image.new("RGBA", canvas.size, (0, 0, 0, 0))
shadow.alpha_composite(Image.merge("RGBA", [Image.new("L", lid.size, 0)] * 3 + [lid.getchannel("A").point(lambda v: v * 150 // 255)]), (lid_x - 12, lid_y + 14))
canvas.alpha_composite(shadow.filter(ImageFilter.GaussianBlur(6)))
canvas.alpha_composite(lid, (lid_x, lid_y))
canvas.save(DIR + "laundry_wash_copper_open_v2.png")
print("open copper", canvas.size, canvas.getbbox(), "lid at", (lid_x, lid_y))
