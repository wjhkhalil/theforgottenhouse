#!/usr/bin/env python3
"""Cuts the seven Vane's Cottage objects, and the doctor's bag, that stand too close to a neighbour on their sheet.

    python3 tools/sprite_fixes/vane_cottage_cut_touching.py

cut_sprites.py takes each of these together with its neighbour (the gaps are only 10-20
pixels wide; the closed and open bag are 12 apart), so they are not in tools/sprite_cuts/vane_cottage.json. Each one is fenced
off with a rectangle first, then cut with the same matte. Run it after re-cutting the
cottage and BEFORE vane_cottage_finish.py. Running it twice does no harm.
"""
import sys
from pathlib import Path

from PIL import Image

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
import cut_sprites as c

SHEET = "vane_cottage_objects_sheet_v1.png"
# object id: the rectangle (sheet pixels) that holds it and nothing else.
FENCES = {
    "cheque_book": [300, 60, 693, 320],
    "pen_knife": [693, 60, 960, 320],
    "police_whistle": [205, 380, 480, 640],
    "death_certificate": [480, 345, 808, 640],
    "glass_syringe": [808, 380, 1133, 640],
    "medical_file": [1133, 335, 1388, 650],
    "grey_shawl": [1388, 345, 1672, 650],
}

BAG_SHEET = "vane_cottage_containers_b_sheet_v1.png"
BAG_CLOSED, BAG_OPEN = [0, 455, 423, 850], [423, 455, 850, 850]


def fenced_cut(sheet: str, full: Image.Image, fence: list) -> Image.Image:
    image = full.copy()
    mask = Image.new("L", full.size, 0)
    mask.paste(255, tuple(fence))
    image.putalpha(Image.composite(image.getchannel("A"), Image.new("L", full.size, 0), mask))
    c._matted[sheet] = image
    box = [max(0, fence[0] - 20), max(0, fence[1] - 20), min(full.width, fence[2] + 20), min(full.height, fence[3] + 20)]
    return c.cut({"sheet": sheet, "box": box})


full = c.matte(c.OBJECTS_DIR / SHEET)
for object_id, fence in FENCES.items():
    piece = c.fit(fenced_cut(SHEET, full, fence), c.OBJECT_SIZE)
    c.on_canvas(piece, piece.size, "bottom").save(c.OBJECTS_DIR / f"{object_id}_v1.png")
    print(object_id, piece.size)

# The doctor's bag: closed and open on one canvas, same height, standing on the same line.
full = c.matte(c.OBJECTS_DIR / BAG_SHEET)
closed = c.fit(fenced_cut(BAG_SHEET, full, BAG_CLOSED), c.CONTAINER_SIZE)
opened = fenced_cut(BAG_SHEET, full, BAG_OPEN)
opened = c.scaled(opened, closed.height / opened.height)
size = (max(closed.width, opened.width), max(closed.height, opened.height))
c.on_canvas(closed, size, "bottom").save(c.OBJECTS_DIR / "vane_cottage_doctors_bag_closed_v1.png")
c.on_canvas(opened, size, "bottom").save(c.OBJECTS_DIR / "vane_cottage_doctors_bag_open_v1.png")
print("vane_cottage_doctors_bag", size)
