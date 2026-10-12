#!/usr/bin/env python3
"""Makes re-spaced copies of the two Boat Shed sprite sheets, with room between the pictures.

    python3 tools/sprite_fixes/boat_shed_make_fix_sheets.py

On the painted sheets some pictures are only 10-12 pixels apart (the ship's bell above the
ether bottle; the open strongbox, drawer, net basket and tool chest side by side), which
cut_sprites.py takes for one drawing. This writes
    assets/objects/boat_shed_objects_fix_sheet_v1.png     (the ether bottle moved down)
    assets/objects/boat_shed_containers_fix_sheet_v1.png  (the five columns moved apart)
which is what tools/sprite_cuts/boat_shed.json cuts from. Nothing is repainted; the only thing
removed is the open top of the CLOSED workbench drawer, so that just its front panel is left
(the drawer is set into the painted workbench, where its top could not be seen).
Re-run it (then cut_sprites.py) only if the original sheets change.
"""
from pathlib import Path

from PIL import Image

OBJECTS = Path(__file__).resolve().parent.parent.parent / "assets" / "objects"
GAP = 60

# Objects: everything in the right-hand column below the bell's rope moves down.
sheet = Image.open(OBJECTS / "boat_shed_objects_sheet_v1.png").convert("RGB")
w, h = sheet.size
magenta = sheet.getpixel((3, 3))
fixed = sheet.copy()
bottle = sheet.crop((1300, 325, w, 700))
fixed.paste(magenta, (1300, 325, w, 700))
fixed.paste(bottle, (1300, 325 + GAP))
fixed.save(OBJECTS / "boat_shed_objects_fix_sheet_v1.png")

# Containers: each row is split between its five pictures and the pieces are spread out.
sheet = Image.open(OBJECTS / "boat_shed_containers_sheet_v1.png").convert("RGB")
w, h = sheet.size
magenta = sheet.getpixel((3, 3))
fixed = Image.new("RGB", (w + GAP * 4, h), magenta)
ROW_SPLIT = 440
for (top, bottom), splits in [((0, ROW_SPLIT), [0, 306, 655, 978, 1304, w]), ((ROW_SPLIT, h), [0, 324, 638, 972, 1299, w])]:
    for column in range(5):
        piece = sheet.crop((splits[column], top, splits[column + 1], bottom))
        fixed.paste(piece, (splits[column] + GAP * column, top))
# The closed drawer (third picture, top row): keep the front panel only.
DRAWER_FRONT_TOP = 230
fixed.paste(magenta, (655 + GAP * 2, 0, 978 + GAP * 2, DRAWER_FRONT_TOP))
fixed.save(OBJECTS / "boat_shed_containers_fix_sheet_v1.png")
print("Wrote the two boat_shed fix sheets.")
