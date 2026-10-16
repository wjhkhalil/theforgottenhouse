"""Turn the Lighthouse Steps medal box to face the player.

Run from the project folder:  python3 tools/sprite_fixes/lighthouse_steps_medal_box_front.py

The v1 sprites show the box from high above, but it sits on a shelf at eye level in a
room painted head-on. This writes v2 sprites seen from the front: each sprite is cut
into horizontal bands and every band is stretched or squashed on its own.
  - closed: the lid top shrinks to a thin sliver, the front grows.
  - open: the raised lid stays, the velvet tray shrinks to a sliver, the front grows.
The bottom edge stays where it was, so the box still stands on the same spot.
"""
from PIL import Image

DIR = "assets/objects/lighthouse_steps_medal_box_"

# (top, bottom, scale) of each band, top to bottom. Rows outside the bands are dropped.
BANDS = {
    "closed": [(128, 226, 0.16), (226, 304, 1.5), (304, 330, 1.0)],
    "open": [(34, 145, 0.95), (145, 167, 0.8), (167, 253, 0.22), (253, 304, 1.5), (304, 330, 1.0)],
}

for state, bands in BANDS.items():
    image = Image.open(f"{DIR}{state}_v1.png").convert("RGBA")
    pieces = []
    for top, bottom, scale in bands:
        piece = image.crop((0, top, image.width, bottom))
        pieces.append(piece.resize((image.width, max(1, round((bottom - top) * scale))), Image.LANCZOS))
    out = Image.new("RGBA", image.size, (0, 0, 0, 0))
    y = bands[-1][1] - sum(p.height for p in pieces)
    for piece in pieces:
        out.alpha_composite(piece, (0, y))
        y += piece.height
    out.save(f"{DIR}{state}_v2.png")
    print("wrote", f"{DIR}{state}_v2.png")
