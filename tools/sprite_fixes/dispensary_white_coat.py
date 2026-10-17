"""Hang the Dispensary white coat on a hook of the painted coat rail.

Run from the project folder:  python3 tools/sprite_fixes/dispensary_white_coat.py

The v1 coat pictures come with their own brass hook, which sat on top of the painted
iron hooks. This writes dispensary_white_coat_closed_v2.png / _open_v2.png:
  - the brass hook taken off (everything above the hanger), so the hanger hangs on the
    painted hook;
  - a soft shadow of the coat cast on the wall, down and to the right (the room's lamp
    is up to the left), so it hangs ON the wall instead of floating over it.
Same canvas size as v1. The scene darkens it to the corner's light with self_modulate.
"""
from PIL import Image, ImageDraw, ImageFilter

DIR = "assets/objects/"
HANGER_TOP = 82  # first row of the wooden hanger, below the brass hook
SHADOW_OFFSET = (7, 9)
SHADOW_ALPHA = 150

for state in ("closed", "open"):
    coat = Image.open(DIR + "dispensary_white_coat_%s_v1.png" % state).convert("RGBA")
    ImageDraw.Draw(coat).rectangle((0, 0, coat.width, HANGER_TOP - 1), fill=(0, 0, 0, 0))
    alpha = coat.getchannel("A").point(lambda v: v * SHADOW_ALPHA // 255)
    shadow = Image.new("RGBA", coat.size, (6, 8, 4, 0))
    shadow.putalpha(alpha)
    shadow = shadow.filter(ImageFilter.GaussianBlur(7))
    out = Image.new("RGBA", coat.size, (0, 0, 0, 0))
    out.alpha_composite(shadow, SHADOW_OFFSET)
    out.alpha_composite(coat)
    out.save(DIR + "dispensary_white_coat_%s_v2.png" % state)
    print(state, out.getbbox())
