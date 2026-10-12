#!/usr/bin/env python3
"""Turns the Ice House ice pick upright (handle up, point down).

    python3 tools/sprite_fixes/ice_house_stand_pick.py

The pick is painted lying down on its sheet but leans against a shelf post in the room.
The frost patch (scripts/frost_cover.gd) is sized from the upright placeholder drawing and
turned with the node, so the sprite itself has to be upright for the frost to cover it.
Re-run it once after cut_sprites.py re-cuts ice_pick (running it twice turns it too far).
"""
from pathlib import Path

from PIL import Image

path = Path(__file__).resolve().parent.parent.parent / "assets" / "objects" / "ice_pick_v1.png"
image = Image.open(path)
if image.width > image.height:
    image.rotate(90, expand=True).save(path)
    print("ice_pick turned upright", image.height, "x", image.width)
else:
    print("ice_pick is already upright")
