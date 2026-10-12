#!/usr/bin/env python3
"""Makes the Laundry's four back-wall containers stand BEHIND the painted mangle and ironing table.

    python3 tools/sprite_fixes/laundry_bake_behind.py

The mangle and the ironing table are part of the background painting, so a sprite placed
over them would cover them. This erases their outline from the linen press, the drying
cabinet, Nell's locker and the boiler room door (closed and open pictures). It reads where
each one stands from scenes/laundry.tscn, so run it again after re-cutting OR moving them.
Running it twice is safe (it only thins the cut edge very slightly).
"""
import re
from pathlib import Path

from PIL import Image, ImageChops, ImageDraw

ROOT = Path(__file__).resolve().parent.parent.parent
OBJECTS = ROOT / "assets" / "objects"
NODES = {"LinenPress": "linen_press", "NellsLocker": "nells_locker", "DryingCabinet": "drying_cabinet", "BoilerRoomDoor": "boiler_room_door"}
SUPERSAMPLE = 4


def foreground_mask() -> Image.Image:
    """The painted things in front of the back wall, in room pixels (1280 x 720), drawn four times larger."""
    s = SUPERSAMPLE
    mask = Image.new("L", (1280 * s, 720 * s), 0)
    draw = ImageDraw.Draw(mask)

    def polygon(points):
        draw.polygon([(x * s, y * s) for x, y in points], fill=255)

    # The mangle: screw handle, top arch, right post, then the rollers and everything below them.
    polygon([(497, 357), (500, 354), (520, 355), (523, 352), (531, 352), (534, 355), (553, 354), (557, 358), (556, 365), (552, 368),
            (534, 366), (534, 383), (538, 386), (538, 390), (515, 390), (515, 386), (520, 383), (520, 366), (500, 367), (497, 364)])
    polygon([(400, 400), (470, 392), (500, 387), (530, 386), (560, 388), (590, 392), (613, 396), (613, 411), (400, 411)])
    polygon([(612, 393), (637, 393), (638, 470), (612, 470)])
    polygon([(400, 421), (613, 421), (613, 470), (400, 470)])
    # Its crank wheel (a ring).
    cx, cy, rx, ry = 656.5, 463, 16.5, 56.5
    draw.ellipse([(cx - rx) * s, (cy - ry) * s, (cx + rx) * s, (cy + ry) * s], outline=255, width=int(5.5 * s))
    # The ironing table top and all below it.
    polygon([(738, 470), (739, 455), (744, 450), (760, 448), (985, 447), (1100, 446), (1100, 600), (738, 600)])
    return mask


scene = (ROOT / "scenes" / "laundry.tscn").read_text()
mask = foreground_mask()
for node, container in NODES.items():
    block = re.search(r'\[node name="%s".*?\n\n' % node, scene, re.S).group(0)
    px, py = map(float, re.search(r"^position = Vector2\(([-\d.]+), ([-\d.]+)\)", block, re.M).groups())
    kx, ky = map(float, re.search(r"^scale = Vector2\(([-\d.]+), ([-\d.]+)\)", block, re.M).groups())
    for state in ("closed", "open"):
        path = OBJECTS / f"laundry_{container}_{state}_v1.png"
        image = Image.open(path).convert("RGBA")
        w, h = image.size
        # Sprite pixel (u, v) -> room pixel: the texture is drawn centred on the node.
        s = SUPERSAMPLE
        behind = mask.transform((w, h), Image.AFFINE, (kx * s, 0, (px - w / 2 * kx) * s, 0, ky * s, (py - h / 2 * ky) * s), resample=Image.BILINEAR)
        image.putalpha(ImageChops.multiply(image.getchannel("A"), ImageChops.invert(behind)))
        image.save(path)
        print("baked", path.name)
