#!/usr/bin/env python3
"""Takes the last lavender specks out of the Ice House ice sprites.

    python3 tools/sprite_fixes/ice_house_clean_ice.py

The ice on the sheets is translucent, so a little of the magenta background is left as faint
purple smears in the gaps between the broken chunks and on the rim of the brooch's ice.
Any pixel that is still pinker than ice ever is (red and blue both well above green) is pulled
back to a cold blue-grey. Re-run it after cut_sprites.py re-cuts these sprites.
"""
from pathlib import Path

from PIL import Image

OBJECTS = Path(__file__).resolve().parent.parent.parent / "assets" / "objects"
NAMES = ["frozen_brooch"] + [f"ice_house_{block}_ice_{state}" for block in ("pike", "brooch", "drain") for state in ("closed", "open")]
LIMIT = 10  # red and blue this far above green = left-over magenta

for name in NAMES:
    path = OBJECTS / f"{name}_v1.png"
    image = Image.open(path).convert("RGBA")
    pixels = image.load()
    fixed = 0
    for y in range(image.height):
        for x in range(image.width):
            r, g, b, a = pixels[x, y]
            if a > 0 and min(r, b) - g > LIMIT:
                pixels[x, y] = (g + 2, g, min(255, g + 14), a)
                fixed += 1
    image.save(path)
    print(name, fixed)
