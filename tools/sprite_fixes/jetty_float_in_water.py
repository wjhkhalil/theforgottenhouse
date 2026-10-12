#!/usr/bin/env python3
"""Makes the three drifting Jetty clues sit IN the lake instead of standing on it.

    python3 tools/sprite_fixes/jetty_float_in_water.py

The fishing float, the name board and the message bottle drift on the painted water
(scripts/drifter.gd also sets their rotation, so a tilt cannot be set in the scene).
This re-cuts the three from the sheet (using their entries in tools/sprite_cuts/jetty.json),
lays the bottle on its side, and fades and darkens the lowest part of each one so it looks
under water. Re-run after cut_sprites.py, which saves them standing dry again.
"""
import json
import sys
from pathlib import Path

from PIL import Image, ImageChops

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
import cut_sprites as c

# id: (degrees turned anticlockwise, share of the height that is under water, faintest alpha)
JOBS = {
    "fishing_float": (0, 0.30, 0.15),
    "name_board": (0, 0.22, 0.35),
    "message_bottle": (58, 0.34, 0.2),
}
WATER = (20, 34, 70)

specs = {s["id"]: s for s in json.loads((c.ROOT / "tools/sprite_cuts/jetty.json").read_text())["objects"]}
for object_id, (turn, under, faintest) in JOBS.items():
    piece = c.cut(specs[object_id])
    if turn:
        piece = piece.rotate(turn, resample=Image.BICUBIC, expand=True)
        piece = piece.crop(piece.getchannel("A").point(lambda v: 255 if v > c.ALPHA_CUTOFF else 0).getbbox())
    piece = c.fit(piece, c.OBJECT_SIZE)
    w, h = piece.size
    start = int(h * (1.0 - under))
    # 0 above the water line, rising to 255 at the bottom of the sprite.
    depth = Image.new("L", (w, h), 0)
    for y in range(start, h):
        depth.paste(int(255 * (y - start) / max(1, h - 1 - start)), (0, y, w, y + 1))
    tinted = Image.composite(Image.new("RGB", (w, h), WATER), piece.convert("RGB"), depth.point(lambda v: int(v * 0.75)))
    fade = depth.point(lambda v: int(255 - v * (1.0 - faintest)))
    alpha = ImageChops.multiply(piece.getchannel("A"), fade)
    result = tinted.convert("RGBA")
    result.putalpha(alpha)
    c.on_canvas(result, result.size, "bottom").save(c.OBJECTS_DIR / f"{object_id}_v1.png")
    print(object_id, result.size)
