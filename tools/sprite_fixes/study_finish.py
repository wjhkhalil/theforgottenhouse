#!/usr/bin/env python3
"""Hand-finishing for three Study sprites. Safe to run again: it re-cuts them first.

    python3 tools/sprite_fixes/study_finish.py

Run it after re-cutting the Study (tools/sprite_cuts/study.json).
- magnifying_glass: the lens is painted as solid grey glass; it is made see-through
  (only a faint sheen and the highlights are kept) so the room shows through it.
- forged_signatures: squashed flat, so the sheet lies on the desk top, which the
  painting shows almost edge-on.
- calendar_page: turned a little and squashed flat, so the page lies on the floor.
"""
import subprocess
import sys
from pathlib import Path

from PIL import Image, ImageChops, ImageDraw, ImageFilter

ROOT = Path(__file__).resolve().parent.parent.parent
OBJECTS = ROOT / "assets" / "objects"
LENS_CENTRE, LENS_RADIUS = (80, 77), 46   # in magnifying_glass_v1.png as cut (264 x 206)
LENS_ALPHA = 0.22                         # how much of the plain glass is kept
SIGNATURES_FLAT = 0.34
CALENDAR_TURN, CALENDAR_FLAT = -24, 0.42

subprocess.run([sys.executable, str(ROOT / "tools" / "cut_sprites.py"), str(ROOT / "tools" / "sprite_cuts" / "study.json"),
        "--only", "magnifying_glass,forged_signatures,calendar_page"], check=True, cwd=ROOT)


def crop(image: Image.Image) -> Image.Image:
    box = image.getchannel("A").point(lambda v: 255 if v > 8 else 0).getbbox()
    return image.crop((max(0, box[0] - 3), max(0, box[1] - 3), min(image.width, box[2] + 3), min(image.height, box[3] + 3)))


def flatten(name: str, factor: float, turn: float = 0.0) -> None:
    path = OBJECTS / f"{name}_v1.png"
    image = Image.open(path).convert("RGBA")
    if turn:
        image = image.rotate(turn, Image.BICUBIC, expand=True)
    image = image.resize((image.width, max(1, round(image.height * factor))), Image.LANCZOS)
    crop(image).save(path)
    print(name, "flattened")


# --- the lens ---
path = OBJECTS / "magnifying_glass_v1.png"
glass = Image.open(path).convert("RGBA")
r, g, b, a = glass.split()
cx, cy = LENS_CENTRE
disc = Image.new("L", glass.size, 0)
ImageDraw.Draw(disc).ellipse((cx - LENS_RADIUS, cy - LENS_RADIUS, cx + LENS_RADIUS, cy + LENS_RADIUS), fill=255)
# Glass is grey-blue (red no stronger than blue); the brass rim is not.
grey = ImageChops.subtract(r, b).point(lambda v: 255 if v < 12 else 0)
lens = ImageChops.multiply(disc, grey).filter(ImageFilter.MedianFilter(5)).filter(ImageFilter.GaussianBlur(1.2))
lum = glass.convert("L")
# Plain glass keeps a faint sheen, the bright reflections keep more.
keep = lum.point(lambda v: int(255 * min(0.8, LENS_ALPHA + max(0, v - 150) / 90.0)))
new_alpha = ImageChops.multiply(a, Image.composite(keep, Image.new("L", glass.size, 255), lens))
glass.putalpha(new_alpha)
glass.save(path)
print("magnifying_glass lens cleared")

flatten("forged_signatures", SIGNATURES_FLAT)
flatten("calendar_page", CALENDAR_FLAT, CALENDAR_TURN)
