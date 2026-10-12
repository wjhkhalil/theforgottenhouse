#!/usr/bin/env python3
"""Cuts the four X-Ray Room sprites that touch a neighbour on their sheet.

    python3 tools/sprite_fixes/xray_room_cut_touching.py

cut_sprites.py cannot separate them, so they are not in tools/sprite_cuts/xray_room.json.
Each is masked off with a hand-drawn outline first, then cut with the same matte.
"""
import sys
from pathlib import Path

from PIL import Image, ImageDraw

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
import cut_sprites as c

SHEET_HEIGHT = 1254


def run(sheet_name: str, jobs: list) -> None:
    full = c.matte(c.OBJECTS_DIR / sheet_name)
    w, h = full.size
    for object_id, outline, box in jobs:
        image = full.copy()
        mask = Image.new("L", (w, h), 0)
        ImageDraw.Draw(mask).polygon(outline, fill=255)
        image.putalpha(Image.composite(image.getchannel("A"), Image.new("L", (w, h), 0), mask))
        c._matted[sheet_name] = image
        piece = c.fit(c.cut({"sheet": sheet_name, "box": box}), c.OBJECT_SIZE)
        c.on_canvas(piece, piece.size, "bottom").save(c.OBJECTS_DIR / f"{object_id}_v1.png")
        print(object_id, piece.size)


run("xray_room_objects_a_sheet_v1.png", [
    ("ward_map", [(0, 0), (425, 0), (425, 600), (438, 600), (438, SHEET_HEIGHT), (0, SHEET_HEIGHT)], [0, 370, 470, 830]),
    ("sewn_photograph", [(426, 0), (426, 600), (439, 600), (439, SHEET_HEIGHT), (900, SHEET_HEIGHT), (900, 0)], [400, 400, 900, 770]),
])
run("xray_room_objects_b_sheet_v1.png", [
    ("name_tags", [(380, 440), (886, 440), (886, 780), (380, 780)], [370, 440, 920, 780]),
    ("matrons_memo", [(887, 380), (1254, 380), (1254, 830), (887, 830)], [860, 390, 1254, 830]),
])
