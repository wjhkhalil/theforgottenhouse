#!/usr/bin/env python3
"""Cuts the Living Room's spare_keys sprite, which hangs too close to the open piano bench on its sheet.

    python3 tools/sprite_fixes/living_room_cut_touching.py

cut_sprites.py takes the key ring and the bench lid below it for one drawing and drops both, so
spare_keys is not in tools/sprite_cuts/living_room.json. The bench corner is masked off with a
hand-drawn outline first, then the keys are cut with the same matte. Re-run it after re-cutting
the room (it does not depend on the other cuts).
"""
import sys
from pathlib import Path

from PIL import Image, ImageDraw

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
import cut_sprites as c

SHEET = "living_room_objects_sheet_v1.png"
# Everything around the key ring, minus the bottom-left corner where the bench lid comes up.
OUTLINE = [(632, 300), (978, 300), (978, 604), (790, 604), (790, 568), (632, 568)]
BOX = [632, 300, 978, 604]

full = c.matte(c.OBJECTS_DIR / SHEET)
mask = Image.new("L", full.size, 0)
ImageDraw.Draw(mask).polygon(OUTLINE, fill=255)
image = full.copy()
image.putalpha(Image.composite(image.getchannel("A"), Image.new("L", full.size, 0), mask))
c._matted[SHEET] = image
piece = c.fit(c.cut({"sheet": SHEET, "box": BOX}), c.OBJECT_SIZE)
c.on_canvas(piece, piece.size, "bottom").save(c.OBJECTS_DIR / "spare_keys_v1.png")
print("spare_keys", piece.size)
