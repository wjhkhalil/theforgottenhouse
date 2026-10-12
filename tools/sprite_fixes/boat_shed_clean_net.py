#!/usr/bin/env python3
"""Takes the pink and lime fringe out of the fishing net of the Boat Shed's open net basket.

    python3 tools/sprite_fixes/boat_shed_clean_net.py

The loose net hanging out of the open basket is painted as thin strands straight over the
magenta background, so cut_sprites.py leaves pink (and a lime-green halo) in its loops.
This recolours every strongly pink or lime pixel in the net part of
assets/objects/boat_shed_net_basket_open_v1.png to the net's own dull tan and thins it a little.
Re-run it every time cut_sprites.py has cut boat_shed_net_basket again.
"""
from pathlib import Path

from PIL import Image

PATH = Path(__file__).resolve().parent.parent.parent / "assets" / "objects" / "boat_shed_net_basket_open_v1.png"

image = Image.open(PATH).convert("RGBA")
w, h = image.size
pixels = image.load()
changed = 0
# The net hangs over the left half of the basket and below it.
for y in range(h):
    for x in range(int(w * 0.62)):
        r, g, b, a = pixels[x, y]
        if a == 0:
            continue
        pink = min(r, b) - g
        lime = g - max(r, b) if g > 70 else 0
        if pink > 10 or lime > 12:
            light = (r + g + b) / 3
            strength = min(1.0, max(pink, lime) / 40)
            tan = (min(255, int(light * 1.12)), int(light * 0.98), int(light * 0.74))
            pixels[x, y] = (tan[0], tan[1], tan[2], int(a * (1.0 - 0.45 * strength)))
            changed += 1
image.save(PATH)
print(f"Recoloured {changed} net pixels.")
