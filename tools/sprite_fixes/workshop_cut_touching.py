#!/usr/bin/env python3
"""Cuts the Workshop sprites that almost touch a neighbour on their sheet.

    python3 tools/sprite_fixes/workshop_cut_touching.py

The boat model and the torn hull plan are 8 pixels apart, the job book and the wooden bung
17, and the open log basket and the open cash box 19, so cut_sprites.py joins each pair into
one drawing. They are therefore not in tools/sprite_cuts/workshop.json (the log basket and
the cash box are cut here, closed and open; the open picture is scaled to the closed one's
width times its scale and shifted by its offset, as "open_scale" / "open_offset" do there).
Each is masked off with a plain rectangle first, then cut with the same matte.
Re-run after cut_sprites.py whenever the Workshop sheets change.
"""
import sys
from pathlib import Path

from PIL import Image, ImageDraw

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
import cut_sprites as c

OBJECTS = "workshop_objects_sheet_v1.png"
CONTAINERS = "workshop_containers_sheet_v1.png"
_full: dict = {}


def masked_cut(sheet_name: str, keep: list, shadow: bool = True):
    """Cuts the drawing inside `keep` after hiding everything outside it."""
    if sheet_name not in _full:
        _full[sheet_name] = c.matte(c.OBJECTS_DIR / sheet_name)
    full = _full[sheet_name]
    w, h = full.size
    image = full.copy()
    mask = Image.new("L", (w, h), 0)
    ImageDraw.Draw(mask).rectangle(keep, fill=255)
    image.putalpha(Image.composite(image.getchannel("A"), Image.new("L", (w, h), 0), mask))
    c._matted[sheet_name] = image
    c._magenta_sheets.add(sheet_name)
    box = [max(0, keep[0] - 30), max(0, keep[1] - 30), min(w, keep[2] + 30), min(h, keep[3] + 30)]
    return c.cut({"sheet": sheet_name, "box": box, "shadow": shadow})


def save(name: str, sprite) -> None:
    sprite.save(c.OBJECTS_DIR / name)
    print(name, sprite.size)


for object_id, keep in [
    ("boat_model", [0, 340, 363, 600]),
    ("hull_plan", [364, 320, 695, 610]),
    ("job_book", [696, 325, 1043, 610]),
    ("wooden_bung", [1044, 395, 1290, 575]),
]:
    piece = c.fit(masked_cut(OBJECTS, keep), c.OBJECT_SIZE)
    save(f"{object_id}_v1.png", c.on_canvas(piece, piece.size, "bottom"))

# The log basket and the cash box, closed and open (see OPEN_SCALE / OPEN_OFFSET below).
for container_id, closed_keep, open_keep, open_scale, open_offset in [
    ("workshop_log_basket", [15, 262, 412, 561], [414, 296, 838, 561], 1.26, [55, 0]),
    ("workshop_cash_box", [15, 600, 412, 855], [428, 562, 816, 860], 1.0, [0, 0]),
]:
    closed = c.fit(masked_cut(CONTAINERS, closed_keep), c.CONTAINER_SIZE)
    opened = masked_cut(CONTAINERS, open_keep)
    opened = c.scaled(opened, closed.width / opened.width * open_scale)
    size = (max(closed.width, opened.width + abs(open_offset[0]) * 2), max(closed.height, opened.height + abs(open_offset[1]) * 2))
    save(f"{container_id}_closed_v1.png", c.on_canvas(closed, size, "bottom"))
    save(f"{container_id}_open_v1.png", c.on_canvas(opened, size, "bottom", open_offset))
