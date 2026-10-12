#!/usr/bin/env python3
"""Cuts the Sunken Boat containers that cut_sprites.py cannot, and builds the cabin door.

    python3 tools/sprite_fixes/sunken_boat_finish.py

1. The open cabin door, the open skipper's locker, the open galley cupboard and the open
   ditty box sit 0 to 11 pixels from a neighbour on the containers sheet, so cut_sprites.py
   joins them into one drawing. They are therefore not in tools/sprite_cuts/sunken_boat.json:
   each is masked off with a plain rectangle first and then cut with the same matte.
2. The painted doorway of Mara's cabin is seen from the side, so it is tall and very narrow.
   The cabin door is squeezed sideways to fit it (DOOR_CANVAS). Its OPEN picture is only the
   door leaf, swung in against the left jamb and darkened: the painted doorway shows behind.

Re-run after cut_sprites.py whenever the Sunken Boat sheets change. Running it twice does no harm.
"""
import sys
from pathlib import Path

from PIL import Image, ImageDraw, ImageEnhance

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
import cut_sprites as c

CONTAINERS = "sunken_boat_containers_sheet_v1.png"
DOOR_CANVAS = (104, 480)   # the squeezed door, in sprite pixels (shown about 41 x 190 in the room)
LEAF_WIDTH = 26            # width of the swung-open door leaf on that canvas
_full: dict = {}


def masked_cut(keep: list, shadow: bool = True):
    """Cuts the drawing inside `keep` after hiding everything outside it."""
    if CONTAINERS not in _full:
        _full[CONTAINERS] = c.matte(c.OBJECTS_DIR / CONTAINERS)
    full = _full[CONTAINERS]
    w, h = full.size
    image = full.copy()
    mask = Image.new("L", (w, h), 0)
    ImageDraw.Draw(mask).rectangle(keep, fill=255)
    image.putalpha(Image.composite(image.getchannel("A"), Image.new("L", (w, h), 0), mask))
    c._matted[CONTAINERS] = image
    c._magenta_sheets.add(CONTAINERS)
    box = [max(0, keep[0] - 30), max(0, keep[1] - 30), min(w, keep[2] + 30), min(h, keep[3] + 30)]
    return c.cut({"sheet": CONTAINERS, "box": box, "shadow": shadow})


def save(name: str, sprite) -> None:
    sprite.save(c.OBJECTS_DIR / name)
    print(name, sprite.size)


def tight(piece):
    return piece.crop(piece.getchannel("A").point(lambda v: 255 if v > c.ALPHA_CUTOFF else 0).getbbox())


# id, closed rectangle, open rectangle, match, shadow, open_offset (sprite pixels)
for container_id, closed_keep, open_keep, match, shadow, offset in [
    ("sunken_boat_skipper_locker", [915, 266, 1180, 486], [1262, 268, 1606, 484], "height", True, (-74, 0)),
    ("sunken_boat_galley_cupboard", [36, 492, 396, 696], [440, 486, 830, 685], "height", False, (0, 0)),
    ("sunken_boat_ditty_box", [50, 718, 380, 905], [462, 689, 800, 935], "width", True, (0, 0)),
]:
    closed = c.fit(masked_cut(closed_keep, shadow), c.CONTAINER_SIZE)
    opened = masked_cut(open_keep, shadow)
    factor = closed.height / opened.height if match == "height" else closed.width / opened.width
    opened = c.scaled(opened, factor)
    size = (max(closed.width, opened.width + abs(offset[0]) * 2), max(closed.height, opened.height + abs(offset[1]) * 2))
    save(f"{container_id}_closed_v1.png", c.on_canvas(closed, size, "bottom"))
    save(f"{container_id}_open_v1.png", c.on_canvas(opened, size, "bottom", offset))

# The cabin door: squeezed to the narrow painted doorway.
door = tight(masked_cut([985, 4, 1183, 263], False)).resize(DOOR_CANVAS, Image.LANCZOS)
closed = Image.new("RGBA", DOOR_CANVAS, (0, 0, 0, 0))
closed.alpha_composite(door)
save("sunken_boat_cabin_door_closed_v1.png", closed)
# The swung leaf is the left part of the open picture (sheet x 1300 to 1405).
leaf = tight(masked_cut([1292, 4, 1405, 268], False)).resize((LEAF_WIDTH, DOOR_CANVAS[1]), Image.LANCZOS)
alpha = leaf.getchannel("A")
leaf = ImageEnhance.Brightness(leaf.convert("RGB")).enhance(0.6).convert("RGBA")
leaf.putalpha(alpha)
opened = Image.new("RGBA", DOOR_CANVAS, (0, 0, 0, 0))
opened.alpha_composite(leaf)
save("sunken_boat_cabin_door_open_v1.png", opened)
