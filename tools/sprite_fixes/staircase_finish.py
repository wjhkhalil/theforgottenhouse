#!/usr/bin/env python3
"""Hand finishing for two Grand Staircase sprites after tools/cut_sprites.py.

    python3 tools/sprite_fixes/staircase_finish.py

1. Grandfather clock, OPEN picture: the glass of the swung-open door was painted with the
   magenta sheet showing through it, which the cutter leaves as a muddy purple pane. The
   purple is turned into clear, faintly smoky glass so the wall behind shows through.
2. Blue hair ribbon: it was painted tied round a turned banister post. The post is removed
   so that only the ribbon is left, ready to be tied to the painted handrail in the room.

Run it again every time the staircase sprites are re-cut. Running it twice does no harm.
"""
from pathlib import Path

from PIL import Image, ImageChops, ImageFilter

OBJECTS = Path(__file__).resolve().parent.parent.parent / "assets" / "objects"
GLASS_ALPHA = 70  # how solid the clear glass stays (0 = invisible, 255 = solid)


def clear_clock_glass() -> None:
    path = OBJECTS / "staircase_grandfather_clock_open_v1.png"
    image = Image.open(path).convert("RGBA")
    r, g, b, a = image.split()
    # How purple a pixel is: the smaller of red and blue, minus green.
    purple = ImageChops.subtract(ImageChops.darker(r, b), g)
    pane = purple.point(lambda v: 255 if v >= 9 else 0)
    # Only the door pane (right of the case, a big patch); stray specks elsewhere are left alone.
    half = Image.new("L", image.size, 0)
    half.paste(255, (image.width // 2, 0, image.width, image.height))
    pane = ImageChops.multiply(pane, half)
    # Drop specks, then close the gaps (dark smears and cobweb lines on the glass are not purple).
    pane = pane.filter(ImageFilter.MinFilter(3)).filter(ImageFilter.MaxFilter(3))
    for _ in range(3):
        pane = pane.filter(ImageFilter.MaxFilter(13))
    for _ in range(3):
        pane = pane.filter(ImageFilter.MinFilter(13))
    pane = pane.filter(ImageFilter.MinFilter(3))
    pane = pane.filter(ImageFilter.GaussianBlur(1))
    # Clear glass: a cool dark grey taken from the green channel, mostly see-through.
    glass = Image.merge("RGB", (g.point(lambda v: int(v * 0.85)), g.point(lambda v: int(v * 0.95)), g.point(lambda v: min(255, int(v * 1.1)))))
    # Purple left on the door frame round the pane: take the cast out (red and blue down to green).
    cast = ImageChops.multiply(purple.point(lambda v: 255 if v >= 5 else 0), half)
    plain = Image.merge("RGB", (ImageChops.subtract(r, purple), g, ImageChops.subtract(b, purple)))
    colour = Image.composite(plain, image.convert("RGB"), cast)
    colour = Image.composite(glass, colour, pane)
    thin = a.point(lambda v: v * GLASS_ALPHA // 255)
    alpha = Image.composite(ImageChops.darker(a, thin), a, pane)
    result = colour.convert("RGBA")
    result.putalpha(alpha)
    result.save(path)
    print("cleared glass in", path.name)


def ribbon_only() -> None:
    path = OBJECTS / "hair_ribbon_v1.png"
    image = Image.open(path).convert("RGBA")
    r, g, b, a = image.split()
    # The ribbon is blue (blue well above red); the post is dark brown (red above blue).
    blue = ImageChops.subtract(b, r).point(lambda v: 255 if v >= 10 else 0)
    blue = ImageChops.multiply(blue, a.point(lambda v: 255 if v > 40 else 0))
    # Close the small worn, faded patches inside the ribbon, drop specks on the post.
    blue = blue.filter(ImageFilter.MinFilter(3)).filter(ImageFilter.MaxFilter(3))
    blue = blue.filter(ImageFilter.MaxFilter(9)).filter(ImageFilter.MinFilter(9))
    blue = blue.filter(ImageFilter.GaussianBlur(0.8))
    image.putalpha(ImageChops.multiply(a, blue))
    box = image.getchannel("A").point(lambda v: 255 if v > 40 else 0).getbbox()
    image = image.crop((max(0, box[0] - 6), max(0, box[1] - 6), min(image.width, box[2] + 6), min(image.height, box[3] + 6)))
    image.save(path)
    print("kept only the ribbon in", path.name, image.size)


clear_clock_glass()
ribbon_only()
