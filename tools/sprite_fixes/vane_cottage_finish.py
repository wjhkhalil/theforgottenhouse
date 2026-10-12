#!/usr/bin/env python3
"""Hand-finishing for the Vane's Cottage sprites. Safe to run again: it re-cuts everything first.

    python3 tools/sprite_fixes/vane_cottage_finish.py

Run it after changing tools/sprite_cuts/vane_cottage.json (it runs cut_sprites.py and
vane_cottage_cut_touching.py itself, so nothing else is needed). What it does:
- decanter, specimen_jar, grey_shawl, police_whistle: takes the pink that the magenta sheet
  left in the glass, the fringe and the chain back to plain grey. The whistle also loses a
  stray speck under it.
- stethoscope, cheque_book, pen_knife, police_whistle, timetable, death_certificate,
  passport, name_bracelet: squashed flat (the timetable is turned first), because the desk,
  mantelpiece, hearth, rug and drawer are painted almost edge-on.
- medicine cupboard: stretched a little taller, to the shape of the painted cabinet's bottom door.
- fake spines (open): the picture shows the box from above with its flap lying flat; the box
  is stretched to the height of the closed spines and the flap squeezed into a thin strip, so
  the box stays where the books stood on the cabinet top.
- cellar door: rebuilt on a canvas that matches the painted stone arch (see ARCH below, in
  room pixels). Closed = the door narrowed and trimmed to the round-topped opening, so it
  stands inside the arch. Open = only the door leaf, swung out against the left pier, so the
  painted steps show. The painted fern's fronds (found by their green in the background
  painting) are cut out of both, so the fern stays in front. The scene must keep CellarDoor at CANVAS's centre with h = its height.
"""
import subprocess
import sys
from pathlib import Path

from PIL import Image, ImageChops, ImageDraw, ImageFilter

ROOT = Path(__file__).resolve().parent.parent.parent
OBJECTS = ROOT / "assets" / "objects"

# The cellar arch in room pixels: the dark opening, and where its round top starts.
ARCH = (100, 270, 203, 498)
ARCH_SPRING = 318
CANVAS = (60, 262, 216, 502)   # room rectangle the door canvas covers (centre 138, 382; 156 x 240)
DOOR_IN_CUT = (40, 14, 348, 414)                       # the door inside the closed cut (388 x 428)
LEAF_IN_CUT = [(8, 6), (112, 6), (124, 400), (124, 426), (8, 426)]   # the open leaf inside the open cut
FERN_TOP, FERN_RIGHT = 415, 140   # the fern only reaches below and left of these (room pixels)
CUPBOARD_TALLER = 1.13
SPINES_SPLIT = 252      # row in the open fake-spines cut where the box ends and the flap starts
SPINES_FLAP = 0.13      # share of the height the squeezed flap keeps

subprocess.run([sys.executable, str(ROOT / "tools" / "cut_sprites.py"), str(ROOT / "tools" / "sprite_cuts" / "vane_cottage.json")], check=True, cwd=ROOT)
subprocess.run([sys.executable, str(ROOT / "tools" / "sprite_fixes" / "vane_cottage_cut_touching.py")], check=True, cwd=ROOT)


def load(name: str) -> Image.Image:
    return Image.open(OBJECTS / f"{name}_v1.png").convert("RGBA")


def crop(image: Image.Image) -> Image.Image:
    box = image.getchannel("A").point(lambda v: 255 if v > 8 else 0).getbbox()
    return image.crop((max(0, box[0] - 3), max(0, box[1] - 3), min(image.width, box[2] + 3), min(image.height, box[3] + 3)))


def depink(name: str, keep_violet: bool = False, fade: float = 1.0) -> None:
    """Pixels with more red AND blue than green are pink: pull red and blue down to the green."""
    image = load(name)
    r, g, b, a = image.split()
    pink = ImageChops.subtract(ImageChops.darker(r, b), g)          # min(r, b) - g
    amount = pink.point(lambda v: min(255, v * 40))                 # full strength from 6 up
    if keep_violet:
        # Violet flowers have clearly more blue than red: leave those alone.
        violet = ImageChops.subtract(b, r).point(lambda v: 255 if v > 14 else 0)
        amount = ImageChops.subtract(amount, violet)
    amount = amount.filter(ImageFilter.GaussianBlur(0.6))
    grey = Image.merge("RGB", (g, g, g))
    rgb = Image.composite(grey, image.convert("RGB"), amount)
    if fade < 1.0:
        a = Image.composite(a.point(lambda v: int(v * fade)), a, amount)
    rgb.putalpha(a)
    rgb.save(OBJECTS / f"{name}_v1.png")
    print(name, "pink removed")


def flatten(name: str, factor: float, turn: float = 0.0) -> None:
    image = load(name)
    if turn:
        image = image.rotate(turn, Image.BICUBIC, expand=True)
    image = image.resize((image.width, max(1, round(image.height * factor))), Image.LANCZOS)
    crop(image).save(OBJECTS / f"{name}_v1.png")
    print(name, "flattened")


# --- pink left by the magenta sheet ---
depink("decanter")
depink("specimen_jar", keep_violet=True)
depink("grey_shawl")
whistle = load("police_whistle")
alpha = whistle.getchannel("A")
alpha.paste(0, (0, int(whistle.height * 0.8), whistle.width, whistle.height))   # the stray speck
whistle.putalpha(alpha)
crop(whistle).save(OBJECTS / "police_whistle_v1.png")
depink("police_whistle")

# --- things that lie on a surface seen almost edge-on ---
flatten("stethoscope", 0.45)
flatten("cheque_book", 0.5)
flatten("pen_knife", 0.6)
flatten("police_whistle", 0.7)
flatten("timetable", 0.42, turn=-62)
flatten("death_certificate", 0.45)
flatten("passport", 0.6)
flatten("name_bracelet", 0.6)

# --- the medicine cupboard ---
for state in ("closed", "open"):
    name = f"vane_cottage_medicine_cupboard_{state}"
    image = load(name)
    image.resize((image.width, round(image.height * CUPBOARD_TALLER)), Image.LANCZOS).save(OBJECTS / f"{name}_v1.png")
print("medicine cupboard stretched")

# --- the fake spines, open ---
opened = load("vane_cottage_fake_spines_open")
box = opened.getchannel("A").point(lambda v: 255 if v > 8 else 0).getbbox()
top, bottom = box[1], box[3]
flap_height = round((bottom - top) * SPINES_FLAP)
upper = opened.crop((0, top, opened.width, SPINES_SPLIT)).resize((opened.width, bottom - top - flap_height), Image.LANCZOS)
flap = opened.crop((0, SPINES_SPLIT, opened.width, bottom)).resize((opened.width, flap_height), Image.LANCZOS)
rebuilt = Image.new("RGBA", opened.size, (0, 0, 0, 0))
rebuilt.alpha_composite(upper, (0, top))
rebuilt.alpha_composite(flap, (0, bottom - flap_height))
rebuilt.save(OBJECTS / "vane_cottage_fake_spines_open_v1.png")
print("fake spines rebuilt")

# --- the cellar door ---
K = 2   # canvas pixels per room pixel
size = ((CANVAS[2] - CANVAS[0]) * K, (CANVAS[3] - CANVAS[1]) * K)


def at(x: float, y: float) -> tuple[int, int]:
    return (round((x - CANVAS[0]) * K), round((y - CANVAS[1]) * K))


grow = 2
left, top = at(ARCH[0] - grow, ARCH[1] - grow)
right, bottom = at(ARCH[2] + grow, ARCH[3])
door = load("vane_cottage_cellar_door_closed").crop(DOOR_IN_CUT).resize((right - left, bottom - top), Image.LANCZOS)
closed = Image.new("RGBA", size, (0, 0, 0, 0))
closed.alpha_composite(door, (left, top))
scale = 4
mask = Image.new("L", (size[0] * scale, size[1] * scale), 0)
draw = ImageDraw.Draw(mask)
spring = at(0, ARCH_SPRING)[1]
draw.rectangle((left * scale, spring * scale, right * scale, bottom * scale), fill=255)
draw.ellipse((left * scale, top * scale, right * scale, (2 * spring - top) * scale), fill=255)
mask = mask.resize(size, Image.LANCZOS)
closed.putalpha(ImageChops.multiply(closed.getchannel("A"), mask))

# The painted fern stands in front of the arch: its fronds are the only green there.
painting = Image.open(ROOT / "assets" / "backgrounds" / "vane_cottage_background_v1.png").convert("RGB").resize((1280, 720), Image.LANCZOS)
patch = painting.crop(CANVAS).resize(size, Image.LANCZOS)
pr, pg, pb = patch.split()
green = ImageChops.multiply(ImageChops.subtract(pg, pb).point(lambda v: 255 if v > 22 else 0),
        ImageChops.subtract(pr, pg).point(lambda v: 255 if v < 10 else 0))
green.paste(0, (0, 0, size[0], at(0, FERN_TOP)[1]))
green.paste(0, (at(FERN_RIGHT, 0)[0], 0, size[0], size[1]))
fern = green.filter(ImageFilter.MedianFilter(5)).filter(ImageFilter.MaxFilter(5)).filter(ImageFilter.GaussianBlur(1.0))
not_fern = fern.point(lambda v: 255 - v)
closed.putalpha(ImageChops.multiply(closed.getchannel("A"), not_fern))
closed.save(OBJECTS / "vane_cottage_cellar_door_closed_v1.png")

source = load("vane_cottage_cellar_door_open")
leaf_mask = Image.new("L", source.size, 0)
ImageDraw.Draw(leaf_mask).polygon(LEAF_IN_CUT, fill=255)
source.putalpha(ImageChops.multiply(source.getchannel("A"), leaf_mask))
leaf = crop(source)
factor_y = (bottom - top + 8 * K) / leaf.height            # the near edge of the leaf hangs a little lower
factor_x = (right - left) / (DOOR_IN_CUT[2] - DOOR_IN_CUT[0])
leaf = leaf.resize((round(leaf.width * factor_x), round(leaf.height * factor_y)), Image.LANCZOS)
opened = Image.new("RGBA", size, (0, 0, 0, 0))
opened.alpha_composite(leaf, (max(0, at(ARCH[0] + 3, 0)[0] - leaf.width), top))
opened.putalpha(ImageChops.multiply(opened.getchannel("A"), not_fern))
opened.save(OBJECTS / "vane_cottage_cellar_door_open_v1.png")
print("cellar door rebuilt", size)
