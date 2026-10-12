#!/usr/bin/env python3
"""Cuts the two Ice House sprites that touch each other on their sheet.

    python3 tools/sprite_fixes/ice_house_cut_touching.py

The bottom hem of the horse blanket and the top of the snowshoe are only two pixels apart on
ice_house_objects_sheet_v1.png, so cut_sprites.py cannot separate them and they are not in
tools/sprite_cuts/ice_house.json. Each is masked off with a rectangle first, then cut with the
same matte. Re-run it after cut_sprites.py if the sheet is ever repainted.
"""
import sys
from pathlib import Path

from PIL import Image, ImageDraw

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
import cut_sprites as c

SHEET = "ice_house_objects_sheet_v1.png"
SPLIT_Y = 303  # the blanket ends at y = 302, the snowshoe starts at y = 304

full = c.matte(c.OBJECTS_DIR / SHEET)
c._magenta_sheets.add(SHEET)
w, h = full.size
for object_id, keep, box in [
    ("horse_blanket", (630, 0, 1046, SPLIT_Y - 1), [630, 60, 1046, 330]),
    ("snowshoe", (740, SPLIT_Y + 1, 960, 680), [740, 270, 960, 680]),
]:
    image = full.copy()
    mask = Image.new("L", (w, h), 0)
    ImageDraw.Draw(mask).rectangle(keep, fill=255)
    image.putalpha(Image.composite(image.getchannel("A"), Image.new("L", (w, h), 0), mask))
    c._matted[SHEET] = image
    piece = c.fit(c.cut({"sheet": SHEET, "box": box}), c.OBJECT_SIZE)
    c.on_canvas(piece, piece.size, "bottom").save(c.OBJECTS_DIR / f"{object_id}_v1.png")
    print(object_id, piece.size)
