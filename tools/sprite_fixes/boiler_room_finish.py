#!/usr/bin/env python3
"""Finishes two Boiler Room sprites. Run ONCE, straight after cut_sprites.py re-cuts them:

    python3 tools/cut_sprites.py tools/sprite_cuts/boiler_room.json --only clinker_rake,boiler_room_service_lift
    python3 tools/sprite_fixes/boiler_room_finish.py

* clinker_rake_v1.png is turned 0.45 rad anticlockwise and cropped again, so the rake leans
  upright and its click box is tight instead of a big diagonal square.
* boiler_room_service_lift_closed/open_v1.png are stretched to 1.42 times their height: the
  lift picture is nearly square and the painted doorway is tall.
Running it a second time on the same files turns and stretches them again.
"""
import math
from pathlib import Path

from PIL import Image

OBJECTS = Path(__file__).resolve().parent.parent.parent / "assets" / "objects"
RAKE_TURN = 0.45
LIFT_STRETCH = 1.42
PADDING = 4

rake_path = OBJECTS / "clinker_rake_v1.png"
rake = Image.open(rake_path).convert("RGBA").rotate(math.degrees(RAKE_TURN), resample=Image.BICUBIC, expand=True)
box = rake.getchannel("A").point(lambda v: 255 if v > 8 else 0).getbbox()
box = (max(0, box[0] - PADDING), max(0, box[1] - PADDING), min(rake.width, box[2] + PADDING), min(rake.height, box[3] + PADDING))
rake = rake.crop(box)
rake.save(rake_path)
print(rake_path.name, rake.size)

for state in ("closed", "open"):
    path = OBJECTS / f"boiler_room_service_lift_{state}_v1.png"
    lift = Image.open(path).convert("RGBA")
    lift = lift.resize((lift.width, int(lift.height * LIFT_STRETCH)), Image.LANCZOS)
    lift.save(path)
    print(path.name, lift.size)
