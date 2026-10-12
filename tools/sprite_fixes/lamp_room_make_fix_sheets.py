#!/usr/bin/env python3
"""Rebuilds the two Lamp Room fix sheets that tools/sprite_cuts/lamp_room.json cuts from.

    python3 tools/sprite_fixes/lamp_room_make_fix_sheets.py

Makes assets/objects/lamp_room_objects_fix_sheet_v1.png and
assets/objects/lamp_room_containers_fix_sheet_v1.png out of the two painted sheets:

1. Spacing. On the painted sheets many pictures stand only 8 to 20 pixels apart (binoculars
   and wind gauge, bell hammer and funnel, mantle and valve, cabinet and locker...), which
   cut_sprites.py takes for one picture. Every picture is copied onto a regular grid with
   wide magenta gaps instead. The cell of each picture is listed in OBJECTS / CONTAINERS
   below (containers: closed picture in the left cell, its open picture in the next one).
2. No pink. The magenta shows through the gauze of the lamp mantle and the glass of the
   radio valve. Inside those two pictures every pinkish pixel is repainted without the
   pink: cream-white gauze for the mantle, plain grey glass for the valve. The small magenta
   gaps between the rope loops of the open basket and under the lid of the open writing box
   are painted as dark shadow, so no pink edge is left round them.

Run it again (and then cut_sprites.py) if either painted sheet is replaced.
"""
import sys
from collections import deque
from pathlib import Path

from PIL import Image

ROOT = Path(__file__).resolve().parent.parent.parent
OBJECTS_DIR = ROOT / "assets" / "objects"
MAGENTA = (255, 0, 255)
MARGIN = 5          # pixels copied round each picture's outline box
CELL = (520, 380)   # size of one grid cell on a fix sheet

# name: outline box of the picture on the painted sheet [x0, y0, x1, y1]
OBJECTS = {
    "telegram_form": [36, 67, 334, 285], "postcard": [381, 62, 694, 286],
    "pencil_sketch": [755, 17, 961, 312], "newspaper_page": [1036, 24, 1280, 318],
    "ferry_ticket": [1337, 93, 1633, 253], "lamp_mantle": [81, 327, 258, 579],
    "binoculars": [307, 336, 707, 587], "wind_gauge": [717, 331, 971, 588],
    "lens_cloth": [992, 360, 1298, 587], "tobacco_tin": [1328, 359, 1641, 574],
    "radio_valve": [107, 591, 223, 908], "bell_hammer": [309, 680, 670, 818],
    "oil_funnel": [682, 612, 951, 877], "rosary": [971, 620, 1242, 881],
    "chapel_key": [1296, 661, 1638, 883],
}
CONTAINERS = {
    "lens_cupboard_closed": [74, 18, 287, 218], "lens_cupboard_open": [406, 18, 711, 218],
    "desk_drawer_closed": [856, 85, 1218, 178], "desk_drawer_open": [1266, 44, 1641, 198],
    "radio_cabinet_closed": [56, 241, 314, 427], "radio_cabinet_open": [380, 241, 822, 427],
    "rope_basket_closed": [896, 230, 1186, 437], "rope_basket_open": [1302, 242, 1649, 441],
    "oil_locker_closed": [113, 437, 270, 693], "oil_locker_open": [384, 437, 683, 686],
    "writing_box_closed": [861, 519, 1213, 673], "writing_box_open": [1289, 449, 1617, 684],
    "sea_chest_closed": [23, 726, 436, 916], "sea_chest_open": [449, 696, 817, 921],
}
COLUMNS = {"objects": 5, "containers": 4}
# The pictures the magenta shows through, and what is repainted there (see without_pink).
NO_PINK = {"lamp_mantle": "gauze", "radio_valve": "glass", "rope_basket_open": "shadow", "writing_box_open": "shadow"}


def cell_box(kind: str, index: int) -> tuple[int, int, int, int]:
    """The grid cell of picture number `index` on the fix sheet (used by the cut list too)."""
    column, row = index % COLUMNS[kind], index // COLUMNS[kind]
    return (column * CELL[0], row * CELL[1], (column + 1) * CELL[0], (row + 1) * CELL[1])


def without_pink(piece: Image.Image, material: str) -> Image.Image:
    """Repaints the pink that shows through a picture; the magenta round it stays.

    "gauze": the mantle's threads are cream (much less blue than green). Where the magenta
    shows through they are rose (blue as high as green): those pixels get the cream tone
    back, keeping their own light and dark so the mesh still shows.
    "glass": pink glass becomes plain grey glass of the same brightness.
    "shadow": small gaps closed in by the picture (between the loops of rope hanging out of
    the open basket, the slit under the writing box lid) become dark brown shadow.
    """
    w, h = piece.size
    pixels = piece.load()

    def magenta(x: int, y: int) -> int:
        r, g, b = pixels[x, y]
        return min(r, b) - g - abs(r - b)

    # The real background: strong magenta joined to the edge of the piece.
    outside = [[False] * w for _ in range(h)]
    queue = deque((x, y) for x in range(w) for y in (0, h - 1))
    queue.extend((x, y) for y in range(h) for x in (0, w - 1))
    while queue:
        x, y = queue.popleft()
        if not (0 <= x < w and 0 <= y < h) or outside[y][x] or magenta(x, y) < 150:
            continue
        outside[y][x] = True
        queue.extend(((x + 1, y), (x - 1, y), (x, y + 1), (x, y - 1)))
    for y in range(h):
        for x in range(w):
            if outside[y][x]:
                continue
            # The soft edge next to the background (half magenta or more) is left to the cutter.
            if magenta(x, y) > 60 and any(outside[j][i] for i in range(max(0, x - 2), min(w, x + 3)) for j in range(max(0, y - 2), min(h, y + 3))):
                continue
            r, g, b = pixels[x, y]
            if material == "gauze":
                if b > g - 14 and r > g + 8:
                    pixels[x, y] = (min(255, g + 28), g, int(g * 0.82))
            elif material == "shadow":
                if min(r, b) - g > 12:
                    pixels[x, y] = (22 + int(g * 0.8), 17 + int(g * 0.72), 12 + int(g * 0.6))
            elif min(r, b) - g > 6:
                # Brightness without the magenta: green is the one channel it does not add to.
                level = g + (min(r, b) - g) * 0.35
                pixels[x, y] = (int(level * 0.9), int(level * 0.93), int(level * 0.95))
    return piece


def build(kind: str, boxes: dict) -> None:
    source = Image.open(OBJECTS_DIR / f"lamp_room_{kind}_sheet_v1.png").convert("RGB")
    rows = (len(boxes) + COLUMNS[kind] - 1) // COLUMNS[kind]
    sheet = Image.new("RGB", (CELL[0] * COLUMNS[kind], CELL[1] * rows), MAGENTA)
    for index, (name, box) in enumerate(boxes.items()):
        grown = (max(0, box[0] - MARGIN), max(0, box[1] - MARGIN), min(source.width, box[2] + MARGIN), min(source.height, box[3] + MARGIN))
        piece = source.crop(grown)
        if name in NO_PINK:
            piece = without_pink(piece, NO_PINK[name])
        cell = cell_box(kind, index)
        sheet.paste(piece, (cell[0] + (CELL[0] - piece.width) // 2, cell[1] + (CELL[1] - piece.height) // 2))
    name = f"lamp_room_{kind}_fix_sheet_v1.png"
    sheet.save(OBJECTS_DIR / name)
    print("saved", name, sheet.size)


if __name__ == "__main__":
    build("objects", OBJECTS)
    build("containers", CONTAINERS)
