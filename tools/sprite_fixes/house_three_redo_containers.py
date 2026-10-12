#!/usr/bin/env python3
"""Re-cuts six House Three containers from assets/objects/house_three_containers_redo_sheet_v1.png.

    python3 tools/sprite_fixes/house_three_redo_containers.py [--place]

The first pictures of these six did not match when opened (a different colour or shape):
the X-Ray Room film cabinet, drug safe and instrument case, the Laundry sorting basket,
the Ward Seven strongbox and the Dispensary white coat. The redo sheet has a matching
closed and open picture of each, at the same scale.

Each pair is saved on one shared canvas with the CLOSED picture in the middle (so the click
box sits on it) and the open picture lined up on the anchor points given below.
With --place the scene nodes are also re-scaled and moved so the new closed picture stands
exactly where the old one (the version in git HEAD) stood. Use --place only the first time.
"""
import io
import re
import subprocess
import sys
from pathlib import Path

from PIL import Image

ROOT = Path(__file__).resolve().parent.parent.parent
sys.path.insert(0, str(ROOT / "tools"))
import cut_sprites as c

SHEET = "house_three_containers_redo_sheet_v1.png"
LONGEST = 420
# id, scene, node, closed box, open box, closed anchor, open anchor (sheet pixels), how the old place is matched
JOBS = [
    ("xray_room_film_cabinet", "xray_room", "FilmCabinet", [25, 60, 360, 310], [362, 60, 725, 310], (192, 285), (543, 285), "bottom"),
    ("xray_room_drug_safe", "xray_room", "DrugSafe", [780, 55, 1025, 315], [1110, 55, 1440, 315], (922, 288), (1232, 288), "bottom"),
    ("xray_room_instrument_case", "xray_room", "InstrumentCase", [25, 415, 365, 610], [380, 365, 715, 625], (193, 582), (545, 598), "bottom"),
    ("laundry_sorting_basket", "laundry", "SortingBasket", [735, 390, 1070, 630], [1100, 400, 1440, 640], (900, 600), (1262, 603), "bottom"),
    ("ward_seven_ward_strongbox", "ward_seven", "WardStrongbox", [50, 730, 330, 995], [405, 685, 665, 1020], (190, 968), (535, 990), "bottom"),
    ("dispensary_white_coat", "dispensary", "WhiteCoat", [790, 625, 1005, 1060], [1150, 625, 1375, 1060], (897, 652), (1263, 652), "top"),
]


def solid_box(image: Image.Image):
    return image.getchannel("A").point(lambda v: 255 if v > 128 else 0).getbbox()


def cut_at(box, anchor):
    """Returns the cut picture and where `anchor` (sheet pixels) lies inside it."""
    full = c.sheet(SHEET)
    plain = full.crop(box)
    tight = plain.getchannel("A").point(lambda v: 255 if v > c.ALPHA_CUTOFF else 0).getbbox()
    piece = c.cut({"sheet": SHEET, "box": box})
    # cut() keeps a 10 px margin round the drawing and add_shadow() adds its own margin.
    margin = (piece.width - (min(plain.width, tight[2] + 10) - max(0, tight[0] - 10))) // 2
    left = box[0] + max(0, tight[0] - 10) - margin
    top = box[1] + max(0, tight[1] - 10) - margin
    return piece, (anchor[0] - left, anchor[1] - top)


def main() -> None:
    place = "--place" in sys.argv
    for name, room, node, closed_box, open_box, closed_anchor, open_anchor, pin in JOBS:
        closed, ca = cut_at(closed_box, closed_anchor)
        opened, oa = cut_at(open_box, open_anchor)
        # The closed picture goes in the middle of the canvas; the open one hangs on the same anchor.
        cb = solid_box(closed)
        centre = ((cb[0] + cb[2]) / 2, (cb[1] + cb[3]) / 2)
        offset = (ca[0] - oa[0], ca[1] - oa[1])  # open picture's corner, in closed-picture pixels
        reach_x = max(centre[0], closed.width - centre[0], centre[0] - offset[0], offset[0] + opened.width - centre[0])
        reach_y = max(centre[1], closed.height - centre[1], centre[1] - offset[1], offset[1] + opened.height - centre[1])
        size = (int(reach_x * 2) + 8, int(reach_y * 2) + 8)
        origin = (size[0] / 2 - centre[0], size[1] / 2 - centre[1])
        factor = LONGEST / max(cb[2] - cb[0], cb[3] - cb[1])
        results = {}
        for state, picture, at in (("closed", closed, origin), ("open", opened, (origin[0] + offset[0], origin[1] + offset[1]))):
            canvas = Image.new("RGBA", size, (0, 0, 0, 0))
            canvas.alpha_composite(picture, (round(at[0]), round(at[1])))
            canvas = canvas.resize((round(size[0] * factor), round(size[1] * factor)), Image.LANCZOS)
            path = c.OBJECTS_DIR / f"{name}_{state}_v1.png"
            results[state] = (path, canvas)
        if place:
            place_node(room, node, name, results["closed"][1], pin)
        for path, canvas in results.values():
            canvas.save(path)
            print(path.name, canvas.size)


def place_node(room: str, node: str, name: str, new_closed: Image.Image, pin: str) -> None:
    """Scales and moves the node so the new closed picture covers the place of the old one."""
    old = Image.open(io.BytesIO(subprocess.run(["git", "show", f"HEAD:assets/objects/{name}_closed_v1.png"],
            cwd=ROOT, capture_output=True, check=True).stdout)).convert("RGBA")
    scene_path = ROOT / "scenes" / f"{room}.tscn"
    scene = scene_path.read_text()
    match = re.search(r'\[node name="%s"[^\]]*\]\n((?:(?!\n\[).*\n)*)' % node, scene)
    body = match.group(1)
    px, py = map(float, re.search(r"^position = Vector2\(([-\d.]+), ([-\d.]+)\)", body, re.M).groups())
    kx, ky = map(float, re.search(r"^scale = Vector2\(([-\d.]+), ([-\d.]+)\)", body, re.M).groups())
    ob = solid_box(old)
    # Where the old closed picture is on screen.
    left, right = sorted((px + (ob[0] - old.width / 2) * kx, px + (ob[2] - old.width / 2) * kx))
    top, bottom = py + (ob[1] - old.height / 2) * ky, py + (ob[3] - old.height / 2) * ky
    nb = solid_box(new_closed)
    nw, nh = nb[2] - nb[0], nb[3] - nb[1]
    k = (bottom - top) / nh if pin == "top" else (right - left) / nw
    x = (left + right) / 2
    y = top + nh * k / 2 if pin == "top" else bottom - nh * k / 2
    sign = -1.0 if kx < 0 else 1.0
    for key, value in (("position", f"Vector2({x:.1f}, {y:.1f})"), ("scale", f"Vector2({k * sign:.4f}, {k:.4f})"),
            ("size", f"Vector2({nw * 0.94:.0f}, {nh * 0.94:.0f})")):
        body = re.sub(r"^%s = .*\n" % key, f"{key} = {value}\n", body, flags=re.M)
    scene_path.write_text(scene[:match.start(1)] + body + scene[match.end(1):])
    print(f"placed {node}: {x:.0f}, {y:.0f}, {nw * k:.0f} x {nh * k:.0f} on screen")


if __name__ == "__main__":
    main()
