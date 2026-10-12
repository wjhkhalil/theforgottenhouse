#!/usr/bin/env python3
"""Cut an AI-generated sprite sheet into separate, named PNG sprites.

    python3 tools/slice_sheet.py <sheet.png> <sheet_key> [--out DIR] [--force]

<sheet_key> is the key shown above each prompt in SPRITE_SHEET_PROMPTS.md (for
example attic_objects_1). The names and layout for every key are stored in
tools/sprite_sheets.json.

The sprites are found by their transparent gaps, not by an exact grid, so the
sheet only needs the right number of items, in reading order, not touching.
Needs Pillow (pip install pillow).
"""

import argparse
import json
import sys
from collections import deque
from pathlib import Path

from PIL import Image, ImageChops, ImageDraw, ImageFilter

MANIFEST = Path(__file__).with_name("sprite_sheets.json")
DEFAULT_OUT = Path(__file__).resolve().parent.parent / "assets" / "objects"
ALPHA_CUTOFF = 24      # pixels fainter than this count as empty
PADDING = 6            # transparent pixels kept around each sprite
MIN_AREA_SHARE = 0.0004  # blobs smaller than this share of the sheet are specks


def remove_flat_background(image: Image.Image, tolerance: int) -> Image.Image:
    """Makes a plain single-colour background transparent (for sheets saved without alpha)."""
    rgb = image.convert("RGB")
    w, h = rgb.size
    background = rgb.getpixel((2, 2))
    r, g, b = ImageChops.difference(rgb, Image.new("RGB", rgb.size, background)).split()
    # The largest channel difference, so a colour that only differs in blue still counts.
    difference = ImageChops.lighter(ImageChops.lighter(r, g), b)
    near = difference.point(lambda v: 255 if v <= tolerance else 0)
    # Only background connected to the image edge is removed, so pale areas
    # inside an object are kept.
    edge = [(x, y) for x in range(0, w, 12) for y in (0, h - 1)]
    edge += [(x, y) for y in range(0, h, 12) for x in (0, w - 1)]
    for point in edge:
        if near.getpixel(point) == 255:
            ImageDraw.floodfill(near, point, 128)
    result = rgb.convert("RGBA")
    result.putalpha(near.point(lambda v: 0 if v == 128 else 255))
    return result


def find_blobs(alpha: Image.Image) -> list[dict]:
    """Returns one box per separate drawing, in full-size pixel coordinates."""
    w, h = alpha.size
    step = max(1, max(w, h) // 400)
    small = alpha.point(lambda v: 255 if v > ALPHA_CUTOFF else 0).reduce(step)
    # Join loose parts of one drawing (a chain, a detached shadow) into one blob.
    small = small.point(lambda v: 255 if v > 0 else 0).filter(ImageFilter.MaxFilter(5))
    sw, sh = small.size
    pixels = bytearray(small.tobytes())
    blobs = []
    for start in range(sw * sh):
        if pixels[start] != 255:
            continue
        pixels[start] = 1
        queue = deque([start])
        x0, y0, x1, y1, area = sw, sh, 0, 0, 0
        while queue:
            i = queue.popleft()
            x, y = i % sw, i // sw
            x0, y0, x1, y1, area = min(x0, x), min(y0, y), max(x1, x), max(y1, y), area + 1
            for j in (i - 1 if x > 0 else -1, i + 1 if x < sw - 1 else -1, i - sw, i + sw):
                if 0 <= j < sw * sh and pixels[j] == 255:
                    pixels[j] = 1
                    queue.append(j)
        if area >= MIN_AREA_SHARE * sw * sh:
            blobs.append({"box": [x0 * step, y0 * step, min(w, (x1 + 1) * step), min(h, (y1 + 1) * step)], "area": area})
    return blobs


def centre(blob: dict) -> tuple[float, float]:
    x0, y0, x1, y1 = blob["box"]
    return (x0 + x1) / 2, (y0 + y1) / 2


def merge_extras(blobs: list[dict], wanted: int) -> list[dict]:
    """Folds the smallest blobs into their nearest neighbour until `wanted` are left."""
    blobs = list(blobs)
    while len(blobs) > wanted:
        smallest = min(blobs, key=lambda b: b["area"])
        blobs.remove(smallest)
        sx, sy = centre(smallest)
        nearest = min(blobs, key=lambda b: (centre(b)[0] - sx) ** 2 + (centre(b)[1] - sy) ** 2)
        a, b = nearest["box"], smallest["box"]
        nearest["box"] = [min(a[0], b[0]), min(a[1], b[1]), max(a[2], b[2]), max(a[3], b[3])]
        nearest["area"] += smallest["area"]
    return blobs


def reading_order(blobs: list[dict], rows: int) -> list[list[dict]]:
    """Groups blobs into rows (split at the biggest vertical gaps), each sorted left to right."""
    ordered = sorted(blobs, key=lambda b: centre(b)[1])
    gaps = sorted(range(1, len(ordered)), key=lambda i: centre(ordered[i])[1] - centre(ordered[i - 1])[1], reverse=True)
    cuts = sorted(gaps[: rows - 1])
    result, previous = [], 0
    for cut in cuts + [len(ordered)]:
        result.append(sorted(ordered[previous:cut], key=lambda b: centre(b)[0]))
        previous = cut
    return result


def crop(image: Image.Image, blob: dict) -> Image.Image:
    piece = image.crop(blob["box"])
    tight = piece.getchannel("A").point(lambda v: 255 if v > ALPHA_CUTOFF else 0).getbbox()
    return piece.crop(tight) if tight else piece


def padded(piece: Image.Image, size: tuple[int, int] | None = None) -> Image.Image:
    """Adds the transparent border. With `size`, also stands the piece bottom-centre on a canvas of that size."""
    w, h = size or piece.size
    canvas = Image.new("RGBA", (w + PADDING * 2, h + PADDING * 2), (0, 0, 0, 0))
    canvas.paste(piece, (PADDING + (w - piece.width) // 2, PADDING + h - piece.height))
    return canvas


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("sheet", type=Path, help="the downloaded sprite sheet image")
    parser.add_argument("key", help="sheet key from SPRITE_SHEET_PROMPTS.md, e.g. attic_objects_1")
    parser.add_argument("--out", type=Path, default=DEFAULT_OUT, help="folder to write into (default: assets/objects)")
    parser.add_argument("--force", action="store_true", help="overwrite sprites that already exist")
    parser.add_argument("--bg-tolerance", type=int, default=28, help="how close to the corner colour counts as background, for sheets without transparency")
    args = parser.parse_args()

    sheets = json.loads(MANIFEST.read_text())
    if args.key not in sheets:
        print(f"Unknown sheet key '{args.key}'. See SPRITE_SHEET_PROMPTS.md for the list.", file=sys.stderr)
        return 1
    sheet = sheets[args.key]
    names, is_containers = sheet["names"], sheet["type"] == "containers"
    wanted = len(names) * 2 if is_containers else len(names)

    image = Image.open(args.sheet).convert("RGBA")
    if image.getchannel("A").getextrema()[0] == 255:
        print("The sheet has no transparency; removing its flat background (edges may be rougher).")
        image = remove_flat_background(image, args.bg_tolerance)

    blobs = find_blobs(image.getchannel("A"))
    if len(blobs) < wanted:
        print(f"Found {len(blobs)} separate drawings but '{args.key}' needs {wanted}. "
              "Some are probably touching or missing; ask for the sheet again with wider gaps.", file=sys.stderr)
        return 1
    rows = reading_order(merge_extras(blobs, wanted), sheet["rows"])

    outputs: list[tuple[str, Image.Image]] = []
    if is_containers:
        if len(rows) != 2 or len(rows[0]) != len(names) or len(rows[1]) != len(names):
            print(f"Expected {len(names)} closed drawings above {len(names)} open ones, "
                  f"but the rows hold {[len(r) for r in rows]}.", file=sys.stderr)
            return 1
        for name, closed_blob, open_blob in zip(names, rows[0], rows[1]):
            closed, opened = crop(image, closed_blob), crop(image, open_blob)
            # Both states share one canvas size so the container does not jump when it opens.
            size = (max(closed.width, opened.width), max(closed.height, opened.height))
            outputs.append((f"{name}_closed_v1.png", padded(closed, size)))
            outputs.append((f"{name}_open_v1.png", padded(opened, size)))
    else:
        flat = [blob for row in rows for blob in row]
        outputs = [(f"{name}_v1.png", padded(crop(image, blob))) for name, blob in zip(names, flat)]

    existing = [name for name, _ in outputs if (args.out / name).exists()]
    if existing and not args.force:
        print("These files already exist (use --force to replace them):\n  " + "\n  ".join(existing), file=sys.stderr)
        return 1
    args.out.mkdir(parents=True, exist_ok=True)
    for name, sprite in outputs:
        sprite.save(args.out / name)
        print(f"{name}  {sprite.width} x {sprite.height}")
    print(f"Wrote {len(outputs)} sprites to {args.out}. Check each one shows the object its name says.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
