#!/usr/bin/env python3
"""Rebuilds assets/objects/study_containers_fix_sheet_v1.png for the Study.

    python3 tools/sprite_fixes/study_make_fix_sheet.py

On study_containers_sheet_v1.png the open desk drawer almost touches the handle of the
open wall safe, so cut_sprites.py takes them for one drawing. This copies the sheet with a
strip of plain magenta inserted between them (at x = SPLIT, GAP pixels wide): everything
right of the strip sits GAP pixels further right than on the original sheet.
Run it before re-cutting the Study, if the containers sheet changes.
"""
from pathlib import Path

from PIL import Image

OBJECTS = Path(__file__).resolve().parent.parent.parent / "assets" / "objects"
SPLIT = 857
GAP = 60

sheet = Image.open(OBJECTS / "study_containers_sheet_v1.png").convert("RGB")
w, h = sheet.size
fixed = Image.new("RGB", (w + GAP, h), sheet.getpixel((3, 3)))
fixed.paste(sheet.crop((0, 0, SPLIT, h)), (0, 0))
fixed.paste(sheet.crop((SPLIT, 0, w, h)), (SPLIT + GAP, 0))
fixed.save(OBJECTS / "study_containers_fix_sheet_v1.png")
print("saved", fixed.size)
