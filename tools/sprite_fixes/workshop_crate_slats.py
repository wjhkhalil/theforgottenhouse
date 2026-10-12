#!/usr/bin/env python3
"""Takes the purple out of the gaps between the slats of the Workshop bung crate.

    python3 tools/sprite_fixes/workshop_crate_slats.py

The magenta background shows through the gaps between the crate's slats on the sheet, and
cut_sprites.py leaves thin purple lines there. Every pixel of the two crate sprites that is
still pinker than wood can be (red and blue both above green) is turned into the dark brown
of a shadowed gap. Re-run after cut_sprites.py whenever the crate is cut again.
"""
from pathlib import Path

from PIL import Image

OBJECTS_DIR = Path(__file__).resolve().parent.parent.parent / "assets" / "objects"
GAP = (22, 15, 10)

for state in ("closed", "open"):
    path = OBJECTS_DIR / f"workshop_bung_crate_{state}_v1.png"
    image = Image.open(path).convert("RGBA")
    pixels = image.load()
    changed = 0
    for y in range(image.height):
        for x in range(image.width):
            r, g, b, a = pixels[x, y]
            if a > 0 and min(r, b) - g > 6:
                pixels[x, y] = GAP + (a,)
                changed += 1
    image.save(path)
    print(path.name, changed, "pixels")
