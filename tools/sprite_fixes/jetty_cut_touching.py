#!/usr/bin/env python3
"""Cuts the Jetty sprites that almost touch a neighbour on their sheet.

    python3 tools/sprite_fixes/jetty_cut_touching.py

The registration and the prescription are 8 pixels apart, and the tipped-over bait bucket
is 12 pixels from the open tackle box, so cut_sprites.py joins each pair into one drawing.
They are therefore not in tools/sprite_cuts/jetty.json (the bait bucket and the tackle box
are cut here, closed and open). Each is masked off with a plain rectangle first, then cut with the same matte.
Re-run after cut_sprites.py whenever the Jetty sheets change.
"""
import sys
from pathlib import Path

from PIL import Image, ImageDraw

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
import cut_sprites as c

OBJECTS = "jetty_objects_sheet_v1.png"
CONTAINERS = "jetty_containers_sheet_v1.png"
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


for object_id, keep, shadow in [
    ("registration", [940, 462, 1323, 890], True),
    ("prescription", [1325, 462, 1668, 890], False),
]:
    piece = c.fit(masked_cut(OBJECTS, keep, shadow), c.OBJECT_SIZE)
    save(f"{object_id}_v1.png", c.on_canvas(piece, piece.size, "bottom"))

# The bait bucket (open = tipped over, bait spilled out) and the tackle box, closed and open.
for container_id, closed_keep, open_keep, match, open_scale in [
    ("jetty_bait_bucket", [24, 48, 368, 412], [0, 524, 437, 884], "height", 0.92),
    ("jetty_tackle_box", [400, 108, 832, 380], [439, 476, 840, 880], "width", 1.0),
]:
    closed = c.fit(masked_cut(CONTAINERS, closed_keep), c.CONTAINER_SIZE)
    opened = masked_cut(CONTAINERS, open_keep)
    factor = closed.height / opened.height if match == "height" else closed.width / opened.width
    opened = c.scaled(opened, factor * open_scale)
    size = (max(closed.width, opened.width), max(closed.height, opened.height))
    save(f"{container_id}_closed_v1.png", c.on_canvas(closed, size, "bottom"))
    save(f"{container_id}_open_v1.png", c.on_canvas(opened, size, "bottom"))
