#!/usr/bin/env python3
"""Cut named sprites out of sprite sheets painted on a plain grey or magenta background.

    python3 tools/cut_sprites.py tools/sprite_cuts/<room>.json [--preview DIR]

Unlike slice_sheet.py this does not need the sheet to be in a fixed order: the
JSON file says which grid cell of which sheet holds each sprite, so a container
can take its closed picture from one sheet and its open picture from another.

The JSON file:

    {
      "objects": [
        {"id": "porters_cap", "sheet": "gate_lodge_objects_a_sheet_v1.png", "grid": [3, 3], "cell": [0, 0]}
      ],
      "containers": [
        {"id": "gate_lodge_coat_locker",
         "closed": {"sheet": "...closed_sheet_v1.png", "grid": [3, 3], "cell": [2, 0]},
         "open":   {"sheet": "...open_sheet_v1.png",   "grid": [3, 3], "cell": [2, 0]},
         "match": "height", "open_scale": 1.0, "open_offset": [0, 0], "align": "bottom"}
      ]
    }

"grid" is [columns, rows] and "cell" is [column, row], both counted from 0.
A cell may also be given as "box": [x0, y0, x1, y1] in sheet pixels.

Objects are saved as assets/objects/<id>_v1.png, at most OBJECT_SIZE pixels on
their longer side. Containers are saved as <id>_closed_v1.png and
<id>_open_v1.png on one shared canvas, so the container does not jump when it
opens. "match" says which side of the open picture is scaled to equal the
closed one ("height", "width" or "none"), "open_scale" then scales the open
picture a little more or less, and "align" is where both pictures are pinned
on the canvas ("bottom", "center" or "top").

The plain background is made transparent. On grey sheets the soft shadow under each
object is kept as a see-through dark patch. Magenta sheets have no shadows, so a soft one
is added under each sprite ("shadow": false in a cut switches it off) and glass that the
magenta shows through is made see-through.
Needs Pillow (pip install pillow).
"""

import argparse
import json
import sys
from collections import deque
from pathlib import Path

from PIL import Image, ImageChops, ImageDraw, ImageFilter

ROOT = Path(__file__).resolve().parent.parent
OBJECTS_DIR = ROOT / "assets" / "objects"
OBJECT_SIZE = 256       # longer side of a saved object sprite
CONTAINER_SIZE = 420    # longer side of a saved closed container sprite
PADDING = 4
ALPHA_CUTOFF = 40       # fainter pixels do not count when a sprite is cropped
NEUTRAL = 16            # largest gap between colour channels that still counts as grey
BACKGROUND_RANGE = 26   # how far from the background brightness still counts as background
SHADOW_STRENGTH = 1.5

KEY_KEEP = 20          # magenta sheets: this little magenta or less is kept whole
KEY_REMOVE = 140       # magenta sheets: this much magenta or more is removed
SYNTHETIC_SHADOW = 0.42  # darkness of the shadow added to sprites cut from magenta sheets

_matted: dict[str, Image.Image] = {}
_magenta_sheets: set[str] = set()


def _mask(image: Image.Image, test) -> Image.Image:
    return image.point(lambda v: 255 if test(v) else 0)


def matte_magenta(rgb: Image.Image) -> Image.Image:
    """Removes a bright magenta background (the House One and Two sheets).

    How magenta a pixel is = the smaller of red and blue, minus green. The background is
    fully magenta and is removed; glass that the magenta shows through is partly magenta
    and becomes see-through; the pink cast is taken out of whatever is kept.
    """
    r, g, b = rgb.split()
    key = ImageChops.subtract(ImageChops.darker(r, b), g)
    # True magenta has equal red and blue; real pinks, reds and purples in the art do not,
    # so the gap between red and blue is taken off before deciding.
    magenta = ImageChops.subtract(key, ImageChops.difference(r, b))
    alpha = magenta.point(lambda v: 255 if v <= KEY_KEEP else (0 if v >= KEY_REMOVE else int(255 * (KEY_REMOVE - v) / (KEY_REMOVE - KEY_KEEP))))
    # Take the pink cast out of whatever is at all magenta: pull red and blue down to green.
    spill = ImageChops.multiply(key, magenta.point(lambda v: 0 if v <= 8 else min(255, (v - 8) * 21)))
    r = ImageChops.subtract(r, spill)
    b = ImageChops.subtract(b, spill)
    result = Image.merge("RGB", (r, g, b)).convert("RGBA")
    result.putalpha(alpha)
    return result


def add_shadow(piece: Image.Image) -> Image.Image:
    """Puts a soft dark shadow under and just below a sprite that was painted without one."""
    size = max(piece.size)
    blur, drop, margin = size * 0.03, int(size * 0.025), int(size * 0.07)
    canvas = Image.new("RGBA", (piece.width + margin * 2, piece.height + margin * 2), (0, 0, 0, 0))
    shape = Image.new("L", canvas.size, 0)
    shape.paste(piece.getchannel("A"), (margin, margin + drop))
    shade = shape.filter(ImageFilter.GaussianBlur(blur)).point(lambda v: int(v * SYNTHETIC_SHADOW))
    canvas.putalpha(shade)
    canvas.alpha_composite(piece, (margin, margin))
    return canvas


def matte(path: Path) -> Image.Image:
    """Returns the sheet as RGBA with its plain background (grey or magenta) removed."""
    rgb = Image.open(path).convert("RGB")
    w, h = rgb.size
    corner = rgb.getpixel((3, 3))
    if corner[0] > 180 and corner[2] > 180 and corner[1] < 90:
        _magenta_sheets.add(path.name)
        return matte_magenta(rgb)
    r, g, b = rgb.split()
    high = ImageChops.lighter(ImageChops.lighter(r, g), b)
    low = ImageChops.darker(ImageChops.darker(r, g), b)
    neutral = _mask(ImageChops.subtract(high, low), lambda v: v <= NEUTRAL)
    lum = rgb.convert("L")
    # The background brightness: the middle value along the border of the sheet.
    border = sorted([lum.getpixel((x, y)) for x in range(0, w, 7) for y in (3, h - 4)]
            + [lum.getpixel((x, y)) for y in range(0, h, 7) for x in (3, w - 4)])
    level = border[len(border) // 2]
    # Smooth areas: the background and the shadows have no texture, the objects do.
    detail = ImageChops.difference(lum, lum.filter(ImageFilter.GaussianBlur(3)))
    smooth = _mask(detail.filter(ImageFilter.MaxFilter(5)), lambda v: v <= 5)
    plain = ImageChops.multiply(neutral, _mask(lum, lambda v: abs(v - level) <= BACKGROUND_RANGE))
    shadow = ImageChops.multiply(ImageChops.multiply(neutral, smooth), _mask(lum, lambda v: v < level - BACKGROUND_RANGE))
    removable = ImageChops.lighter(plain, shadow)
    # Only what is joined to the edge of the sheet is removed...
    for point in [(x, y) for x in range(0, w, 9) for y in (0, h - 1)] + [(x, y) for y in range(0, h, 9) for x in (0, w - 1)]:
        if removable.getpixel(point) == 255:
            ImageDraw.floodfill(removable, point, 128)
    # ...and also big smooth background patches enclosed by an object (inside a handle or a ring).
    inner = ImageChops.multiply(ImageChops.multiply(plain, smooth), _mask(removable, lambda v: v == 255))
    seeds = inner.filter(ImageFilter.MinFilter(15))
    step = 6
    small = seeds.resize((w // step, h // step), Image.NEAREST)
    data = small.tobytes()
    for index, value in enumerate(data):
        if value == 255:
            point = ((index % small.width) * step, (index // small.width) * step)
            if removable.getpixel(point) == 255 and seeds.getpixel(point) == 255:
                ImageDraw.floodfill(removable, point, 128)
    removed = _mask(removable, lambda v: v == 128).filter(ImageFilter.MedianFilter(3))
    # Inside the removed area, darker than the background = shadow: keep it as see-through black.
    darkness = lum.point(lambda v: int(max(0.0, min(0.5, (level - v - 14) / level * SHADOW_STRENGTH)) * 255))
    darkness = darkness.filter(ImageFilter.GaussianBlur(2))
    alpha = Image.composite(darkness, Image.new("L", (w, h), 255), removed)
    # Soften the cut edge by one pixel.
    alpha = Image.composite(alpha, alpha.filter(ImageFilter.GaussianBlur(0.8)), removed)
    colour = Image.composite(Image.new("RGB", (w, h), (0, 0, 0)), rgb, removed)
    result = colour.convert("RGBA")
    result.putalpha(alpha)
    return result


def sheet(name: str) -> Image.Image:
    if name not in _matted:
        _matted[name] = matte(OBJECTS_DIR / name)
    return _matted[name]


def cut(spec: dict) -> Image.Image:
    """Returns the tightly cropped sprite described by `spec`."""
    image = sheet(spec["sheet"])
    w, h = image.size
    if "box" in spec:
        cell = list(spec["box"])
        box = cell
    else:
        columns, rows = spec["grid"]
        column, row = spec["cell"]
        cell = [w * column // columns, h * row // rows, w * (column + 1) // columns, h * (row + 1) // rows]
        # Look a little beyond the cell: drawings often lean over its edge.
        grow_x, grow_y = int(w / columns * spec.get("grow", 0.3)), int(h / rows * spec.get("grow", 0.3))
        box = [max(0, cell[0] - grow_x), max(0, cell[1] - grow_y), min(w, cell[2] + grow_x), min(h, cell[3] + grow_y)]
    piece = image.crop(box)
    solid = piece.getchannel("A").point(lambda v: 255 if v > ALPHA_CUTOFF else 0)
    # Keep only the drawings whose middle lies inside the cell; the rest belong to its neighbours.
    step = 4
    small = solid.reduce(step).point(lambda v: 255 if v > 0 else 0).filter(ImageFilter.MaxFilter(5))
    sw, sh = small.size
    pixels = bytearray(small.tobytes())
    keep = Image.new("L", (sw, sh), 0)
    keep_pixels = keep.load()
    blobs = []
    for start in range(sw * sh):
        if pixels[start] != 255:
            continue
        pixels[start] = 1
        queue, members = deque([start]), [start]
        while queue:
            i = queue.popleft()
            x = i % sw
            for j in (i - 1 if x > 0 else -1, i + 1 if x < sw - 1 else -1, i - sw, i + sw):
                if 0 <= j < sw * sh and pixels[j] == 255:
                    pixels[j] = 1
                    queue.append(j)
                    members.append(j)
        xs = [m % sw for m in members]
        ys = [m // sw for m in members]
        centre_x = box[0] + (min(xs) + max(xs) + 1) / 2 * step
        centre_y = box[1] + (min(ys) + max(ys) + 1) / 2 * step
        inside = cell[0] <= centre_x <= cell[2] and cell[1] <= centre_y <= cell[3]
        # A drawing cut off by the edge of the search area is a neighbour, not ours.
        if (min(xs) == 0 and box[0] > 0) or (max(xs) == sw - 1 and box[2] < w) or (min(ys) == 0 and box[1] > 0) or (max(ys) == sh - 1 and box[3] < h):
            inside = False
        blobs.append((len(members), inside, members))
    biggest = max((size for size, inside, _ in blobs if inside), default=0)
    if biggest == 0:
        raise SystemExit(f"Nothing found in {spec}")
    for size, inside, members in blobs:
        if inside and size >= biggest * spec.get("min_part", 0.004):
            for m in members:
                keep_pixels[m % sw, m // sw] = 255
    keep = keep.filter(ImageFilter.MaxFilter(7)).resize((sw * step, sh * step), Image.NEAREST).crop((0, 0, piece.width, piece.height))
    piece.putalpha(ImageChops.multiply(piece.getchannel("A"), keep))
    tight = ImageChops.multiply(solid, keep).getbbox()
    # A margin so the soft shadow is not cut off square.
    margin = 10
    tight = (max(0, tight[0] - margin), max(0, tight[1] - margin), min(piece.width, tight[2] + margin), min(piece.height, tight[3] + margin))
    piece = piece.crop(tight)
    if spec["sheet"] in _magenta_sheets and spec.get("shadow", True):
        piece = add_shadow(piece)
    return piece


def fit(piece: Image.Image, longest: float) -> Image.Image:
    factor = longest / max(piece.size)
    return scaled(piece, factor)


def scaled(piece: Image.Image, factor: float) -> Image.Image:
    size = (max(1, round(piece.width * factor)), max(1, round(piece.height * factor)))
    return piece.resize(size, Image.LANCZOS)


def on_canvas(piece: Image.Image, size: tuple[int, int], align: str, offset=(0, 0)) -> Image.Image:
    canvas = Image.new("RGBA", (size[0] + PADDING * 2, size[1] + PADDING * 2), (0, 0, 0, 0))
    x = PADDING + (size[0] - piece.width) // 2 + offset[0]
    if align == "top":
        y = PADDING
    elif align == "center":
        y = PADDING + (size[1] - piece.height) // 2
    else:
        y = PADDING + size[1] - piece.height
    canvas.alpha_composite(piece, (max(0, x), max(0, y + offset[1])))
    return canvas


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("cuts", type=Path, help="the JSON file that lists the sprites")
    parser.add_argument("--preview", type=Path, help="also save contact sheets of the results into this folder")
    parser.add_argument("--only", default="", help="comma-separated ids: cut only these")
    args = parser.parse_args()
    cuts = json.loads(args.cuts.read_text())
    only = set(filter(None, args.only.split(",")))
    saved: list[tuple[str, Image.Image]] = []

    for spec in cuts.get("objects", []):
        if only and spec["id"] not in only:
            continue
        sprite = on_canvas(*(lambda p: (p, p.size, "bottom"))(fit(cut(spec), spec.get("size", OBJECT_SIZE))))
        saved.append((f"{spec['id']}_v1.png", sprite))

    for spec in cuts.get("containers", []):
        if only and spec["id"] not in only:
            continue
        closed = fit(cut(spec["closed"]), spec.get("size", CONTAINER_SIZE))
        opened = cut(spec["open"])
        match = spec.get("match", "height")
        factor = 1.0
        if match == "height":
            factor = closed.height / opened.height
        elif match == "width":
            factor = closed.width / opened.width
        elif match == "none":
            factor = spec.get("size", CONTAINER_SIZE) / max(opened.size)
        opened = scaled(opened, factor * spec.get("open_scale", 1.0))
        align = spec.get("align", "bottom")
        offset = spec.get("open_offset", [0, 0])
        size = (max(closed.width, opened.width + abs(offset[0]) * 2), max(closed.height, opened.height + abs(offset[1]) * 2))
        saved.append((f"{spec['id']}_closed_v1.png", on_canvas(closed, size, align)))
        saved.append((f"{spec['id']}_open_v1.png", on_canvas(opened, size, align, offset)))

    for name, sprite in saved:
        sprite.save(OBJECTS_DIR / name)
        print(f"{name}  {sprite.width} x {sprite.height}")

    if args.preview and saved:
        args.preview.mkdir(parents=True, exist_ok=True)
        tile, columns = 220, 6
        rows = (len(saved) + columns - 1) // columns
        board = Image.new("RGB", (tile * columns, tile * rows), (52, 70, 60))
        draw = ImageDraw.Draw(board)
        for index, (name, sprite) in enumerate(saved):
            thumb = sprite.copy()
            thumb.thumbnail((tile - 16, tile - 30))
            x, y = (index % columns) * tile, (index // columns) * tile
            # Half the tile is light, so dark sprites and their shadows both show.
            draw.rectangle([x + tile // 2, y, x + tile - 1, y + tile - 20], fill=(170, 150, 120))
            board.paste(thumb, (x + (tile - thumb.width) // 2, y + (tile - 22 - thumb.height) // 2), thumb)
            draw.text((x + 4, y + tile - 16), name.replace("_v1.png", "")[-34:], fill=(255, 255, 255))
        board.save(args.preview / f"{args.cuts.stem}_preview.png")
    print(f"Saved {len(saved)} sprites.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
