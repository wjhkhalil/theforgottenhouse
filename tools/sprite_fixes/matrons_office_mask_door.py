#!/usr/bin/env python3
"""Keeps the painted telephone in front of the Matron's Office ward stair door.

    python3 tools/sprite_fixes/matrons_office_mask_door.py

The telephone on the desk is part of the background painting and the closed door sprite
would cover its top, so this cuts the telephone's outline out of the CLOSED door picture.
It reads where the door stands from scenes/matrons_office.tscn: run it again after
re-cutting OR moving the door. Running it twice does no harm.
"""
import re
from pathlib import Path

from PIL import Image, ImageDraw

ROOT = Path(__file__).resolve().parent.parent.parent
# The telephone's outline in room pixels.
PHONE = [(956, 414), (957, 401), (959, 394), (963, 391), (1002, 391), (1006, 394), (1008, 401), (1010, 414)]

scene = (ROOT / "scenes" / "matrons_office.tscn").read_text()
block = re.search(r'\[node name="WardStairDoor".*?\n\n', scene, re.S).group(0)
px, py = map(float, re.search(r"^position = Vector2\(([-\d.]+), ([-\d.]+)\)", block, re.M).groups())
k = float(re.search(r"^scale = Vector2\(([-\d.]+),", block, re.M).group(1))
path = ROOT / "assets" / "objects" / "matrons_office_ward_stair_door_closed_v1.png"
image = Image.open(path).convert("RGBA")
w, h = image.size
alpha = image.getchannel("A")
ImageDraw.Draw(alpha).polygon([((x - px) / k + w / 2, (y - py) / k + h / 2) for x, y in PHONE], fill=0)
image.putalpha(alpha)
image.save(path)
print("masked", path.name)
