#!/usr/bin/env python3
"""Keeps the painted telephone and desk lamp in front of the Matron's Office ward stair door.

    python3 tools/sprite_fixes/matrons_office_mask_door.py

The telephone and the green-shaded lamp on the desk are part of the background painting,
and the door sprites (the open door most of all) would cover them, so this cuts their
outlines out of the CLOSED and OPEN door pictures.
It reads where the door stands from scenes/matrons_office.tscn: run it again after
re-cutting OR moving the door. Running it twice does no harm.
"""
import re
from pathlib import Path

from PIL import Image, ImageDraw

ROOT = Path(__file__).resolve().parent.parent.parent
# The telephone's outline in room pixels.
PHONE = [(956, 414), (957, 401), (959, 394), (963, 391), (1002, 391), (1006, 394), (1008, 401), (1010, 414)]
# The lamp's outline in room pixels: the shade with its finial, the pull chain, the stem and the base.
LAMP_SHADE = [(1082, 315), (1088, 315), (1089, 326), (1105, 327), (1112, 331), (1118, 339), (1126, 341),
              (1126, 347), (1125, 354.5), (1042, 354.5), (1041.5, 349), (1047, 340), (1052, 332), (1060, 327), (1081, 326)]
LAMP_CHAIN = [(1110, 354), (1113.5, 354), (1113.5, 371), (1116, 373), (1115.5, 379.5), (1107, 379.5), (1106.5, 373), (1110, 371)]
LAMP_STEM = [(1079, 354), (1091, 354), (1091, 388), (1093, 390), (1093, 397), (1089.5, 398), (1089.5, 404),
             (1093, 406), (1094, 410), (1107, 416), (1108, 428), (1062, 428), (1063, 416), (1076, 410), (1077, 406),
             (1080.5, 404), (1080.5, 398), (1077, 397), (1077, 390), (1079, 388)]
SHAPES = [PHONE, LAMP_SHADE, LAMP_CHAIN, LAMP_STEM]

scene = (ROOT / "scenes" / "matrons_office.tscn").read_text()
block = re.search(r'\[node name="WardStairDoor".*?\n\n', scene, re.S).group(0)
px, py = map(float, re.search(r"^position = Vector2\(([-\d.]+), ([-\d.]+)\)", block, re.M).groups())
k = float(re.search(r"^scale = Vector2\(([-\d.]+),", block, re.M).group(1))
for state in ("closed", "open"):
    path = ROOT / "assets" / "objects" / ("matrons_office_ward_stair_door_%s_v1.png" % state)
    image = Image.open(path).convert("RGBA")
    w, h = image.size
    alpha = image.getchannel("A")
    for shape in SHAPES:
        ImageDraw.Draw(alpha).polygon([((x - px) / k + w / 2, (y - py) / k + h / 2) for x, y in shape], fill=0)
    image.putalpha(alpha)
    image.save(path)
    print("masked", path.name)
