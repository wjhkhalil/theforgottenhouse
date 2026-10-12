#!/usr/bin/env python3
"""Makes the lenses of the Attic's cracked spectacles clear glass instead of pink.

    python3 tools/sprite_fixes/attic_spectacles_glass.py

The sheet's magenta background shows through the lenses, and the cutter leaves them a
cloudy pink-purple. This first takes the purple cast out, then makes every grey (colourless)
pixel see-through: dull glass almost fully, bright cracks and scratches hardly at all. The
brass frame and the brown arms seen through the lenses have colour, so they stay solid.
Run it again every time cracked_spectacles is re-cut with tools/cut_sprites.py.
Running it twice makes the glass a little clearer still, which does no harm.
"""
from pathlib import Path

from PIL import Image

ROOT = Path(__file__).resolve().parent.parent.parent
SPRITE = ROOT / "assets" / "objects" / "cracked_spectacles_v1.png"
FULL_CAST = 14.0     # this much purple (blue above green) or more is fully corrected
GREY = 26            # largest gap between colour channels that still counts as glass
GLASS_ALPHA = 0.22   # how solid dull glass stays
BRIGHT = (95, 190)   # brightness where glass starts to stay solid, and where it is fully solid


def main() -> None:
    image = Image.open(SPRITE).convert("RGBA")
    pixels = image.load()
    for y in range(image.height):
        for x in range(image.width):
            r, g, b, a = pixels[x, y]
            if a == 0 or max(r, g, b) < 25:   # nothing there, or the soft shadow
                continue
            cast = b - g
            if cast > 2:
                amount = min(1.0, cast / FULL_CAST)
                grey = (int(g * 0.96), g, min(255, int(g * 1.06)))
                r, g, b = (round(c + (n - c) * amount) for c, n in zip((r, g, b), grey))
            gap = max(r, g, b) - min(r, g, b)
            if gap <= GREY:
                glassy = 1.0 if gap <= GREY - 10 else (GREY - gap) / 10
                solid = GLASS_ALPHA + (1 - GLASS_ALPHA) * min(1.0, max(0.0, (g - BRIGHT[0]) / (BRIGHT[1] - BRIGHT[0])))
                a = round(a * (1 - glassy * (1 - solid)))
            pixels[x, y] = (r, g, b, a)
    image.save(SPRITE)
    print(f"Cleared the glass in {SPRITE.name}")


if __name__ == "__main__":
    main()
