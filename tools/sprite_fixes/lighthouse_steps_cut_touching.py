#!/usr/bin/env python3
"""Cuts the Lighthouse Steps sprites that almost touch a neighbour on their sheet.

    python3 tools/sprite_fixes/lighthouse_steps_cut_touching.py [--preview DIR]

On lighthouse_steps_objects_sheet_v1.png the paraffin can stands right on top of the barometer
and the tip of a knitting needle reaches under the gull feather. On
lighthouse_steps_containers_sheet_v1.png the open pictures in each column are only a few pixels
apart (oil store / twine parcel, knitting basket / medal box / first aid tin). cut_sprites.py
takes each such group for one drawing and drops it, so paraffin_can, barometer, gull_feather,
knitting_needles and five of the six containers are NOT in tools/sprite_cuts/lighthouse_steps.json.
Here everything outside a hand-drawn outline is hidden first, then the sprite is cut with the
same matte and the same closed/open canvas rules as cut_sprites.py. Re-run it after re-cutting
the room, AFTER cut_sprites.py: its last step also takes the pink cast (magenta showing through
the loose gauze) out of bandage_roll_v1.png, which cut_sprites.py writes.
"""
import sys
from pathlib import Path

from PIL import Image, ImageDraw

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
import cut_sprites as c

OBJECTS = "lighthouse_steps_objects_sheet_v1.png"
CONTAINERS = "lighthouse_steps_containers_sheet_v1.png"
# id: (outline that holds only this drawing, soft shadow under it?)
OBJECT_CUTS = {
    "paraffin_can": ([(1366, 4), (1664, 4), (1664, 299), (1366, 299)], True),
    "barometer": ([(1400, 300), (1640, 300), (1640, 680), (1400, 680)], False),
    "gull_feather": ([(16, 330), (342, 330), (342, 500), (312, 500), (312, 640), (16, 640)], True),
    "knitting_needles": ([(342, 330), (730, 330), (730, 622), (312, 622), (312, 500), (342, 500)], True),
}
# id: closed box, open box (both [x0, y0, x1, y1], nothing outside is seen), then the same
# keys as a container in a sprite_cuts JSON file.
CONTAINER_CUTS = {
    "oil_store": ([88, 4, 320, 314], [412, 4, 768, 314], {"match": "height", "open_offset": [-78, 0], "shadow": False}),
    "knitting_basket": ([860, 36, 1192, 326], [1284, 24, 1644, 328], {"match": "width", "open_scale": 1.06}),
    "twine_parcel": ([24, 364, 392, 580], [396, 314, 852, 606], {"match": "width", "open_scale": 1.2}),
    "medal_box": ([864, 392, 1224, 576], [1284, 328, 1636, 590], {"match": "width"}),
    "first_aid_tin": ([856, 644, 1232, 888], [1276, 590, 1648, 896], {"match": "width"}),
}

saved = []


def cut_inside(sheet_name: str, full: Image.Image, outline: list, shadow: bool) -> Image.Image:
    """Cuts the one drawing inside `outline`; the rest of the sheet is hidden first."""
    mask = Image.new("L", full.size, 0)
    ImageDraw.Draw(mask).polygon(outline, fill=255)
    image = full.copy()
    image.putalpha(Image.composite(image.getchannel("A"), Image.new("L", full.size, 0), mask))
    c._matted[sheet_name] = image
    xs, ys = [p[0] for p in outline], [p[1] for p in outline]
    box = [max(0, min(xs) - 16), max(0, min(ys) - 16), min(full.width, max(xs) + 16), min(full.height, max(ys) + 16)]
    return c.cut({"sheet": sheet_name, "box": box, "shadow": shadow})


def rectangle(box: list) -> list:
    return [(box[0], box[1]), (box[2], box[1]), (box[2], box[3]), (box[0], box[3])]


full = c.matte(c.OBJECTS_DIR / OBJECTS)
for name, (outline, shadow) in OBJECT_CUTS.items():
    piece = c.fit(cut_inside(OBJECTS, full, outline, shadow), c.OBJECT_SIZE)
    saved.append((f"{name}_v1.png", c.on_canvas(piece, piece.size, "bottom")))

full = c.matte(c.OBJECTS_DIR / CONTAINERS)
for name, (closed_box, open_box, spec) in CONTAINER_CUTS.items():
    shadow = spec.get("shadow", True)
    closed = c.fit(cut_inside(CONTAINERS, full, rectangle(closed_box), shadow), c.CONTAINER_SIZE)
    opened = cut_inside(CONTAINERS, full, rectangle(open_box), shadow)
    factor = closed.height / opened.height if spec["match"] == "height" else closed.width / opened.width
    opened = c.scaled(opened, factor * spec.get("open_scale", 1.0))
    offset = spec.get("open_offset", [0, 0])
    size = (max(closed.width, opened.width + abs(offset[0]) * 2), max(closed.height, opened.height + abs(offset[1]) * 2))
    saved.append((f"lighthouse_steps_{name}_closed_v1.png", c.on_canvas(closed, size, "bottom")))
    saved.append((f"lighthouse_steps_{name}_open_v1.png", c.on_canvas(opened, size, "bottom", offset)))

for name, sprite in saved:
    sprite.save(c.OBJECTS_DIR / name)
    print(f"{name}  {sprite.width} x {sprite.height}")

# The bandage's loose gauze let the magenta through: pull red and blue down to green there.
path = c.OBJECTS_DIR / "bandage_roll_v1.png"
bandage = Image.open(path).convert("RGBA")
pixels = bandage.load()
for y in range(bandage.height):
    for x in range(bandage.width):
        r, g, b, a = pixels[x, y]
        if a and r > g + 6 and b > g - 4:
            pixels[x, y] = (min(r, g + 10), g, min(b, max(0, g - 14)), a)
bandage.save(path)
saved.append(("bandage_roll_v1.png", bandage))

if "--preview" in sys.argv:
    folder = Path(sys.argv[sys.argv.index("--preview") + 1])
    folder.mkdir(parents=True, exist_ok=True)
    tile, columns = 220, 6
    board = Image.new("RGB", (tile * columns, tile * ((len(saved) + columns - 1) // columns)), (52, 70, 60))
    draw = ImageDraw.Draw(board)
    for index, (name, sprite) in enumerate(saved):
        thumb = sprite.copy()
        thumb.thumbnail((tile - 16, tile - 30))
        x, y = (index % columns) * tile, (index // columns) * tile
        draw.rectangle([x + tile // 2, y, x + tile - 1, y + tile - 20], fill=(170, 150, 120))
        board.paste(thumb, (x + (tile - thumb.width) // 2, y + (tile - 22 - thumb.height) // 2), thumb)
        draw.text((x + 4, y + tile - 16), name.replace("_v1.png", "")[-34:], fill=(255, 255, 255))
    board.save(folder / "lighthouse_steps_touching_preview.png")
