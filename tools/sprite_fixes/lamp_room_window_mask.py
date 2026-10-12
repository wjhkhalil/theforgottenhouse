#!/usr/bin/env python3
"""Builds the Lamp Room's window mask: where the storm outside shows through the glass.

    python3 tools/sprite_fixes/lamp_room_window_mask.py

The lightning in scripts/lamp_room_art.gd is drawn over the background painting, so it
needs to know which parts of the painting are sky and sea. This writes
assets/backgrounds/lamp_room_window_mask_v1.png: white, and see-through everywhere except
the blue of the storm (the window frames, the bell, the lens and the room stay dark).
Run it again if the Lamp Room background changes, then re-import in Godot.
"""
from pathlib import Path

from PIL import Image, ImageChops, ImageDraw, ImageFilter

ROOT = Path(__file__).resolve().parent.parent.parent
SOURCE = ROOT / "assets" / "backgrounds" / "lamp_room_background_v2.png"
OUT = ROOT / "assets" / "backgrounds" / "lamp_room_window_mask_v1.png"
ROOM = (1280, 720)
# Nothing below the window sill is sky (room pixels).
SILL_Y = 412
# The lens and its cage (room pixels): its glass has blue glints that are not sky.
LENS = [(585, 0), (705, 0), (712, 60), (745, 110), (765, 160), (772, 340), (740, 400), (550, 400), (518, 340), (525, 160),
	(545, 110), (578, 60)]

room = Image.open(SOURCE).convert("RGB").resize(ROOM, Image.LANCZOS)
red, green, blue = room.split()
# How much bluer than warm a pixel is: the storm is blue, everything in the room is not.
warm = ImageChops.lighter(red, green)
alpha = ImageChops.subtract(blue, warm).point(lambda v: min(255, max(0, v - 6) * 7))
draw = ImageDraw.Draw(alpha)
draw.rectangle([0, SILL_Y, ROOM[0], ROOM[1]], fill=0)
draw.polygon(LENS, fill=0)
alpha = alpha.filter(ImageFilter.GaussianBlur(1.2))
mask = Image.new("RGBA", ROOM, (255, 255, 255, 0))
mask.putalpha(alpha)
# Half size is plenty for a soft mask.
mask.resize((ROOM[0] // 2, ROOM[1] // 2), Image.LANCZOS).save(OUT)
print("wrote", OUT.relative_to(ROOT))
