"""Refit every open drawer so it slides out of its table instead of standing up on it.

Run from the project folder:  python3 tools/sprite_fixes/refit_all_drawers.py

The v1 "open" drawer pictures show the whole drawer box, so its back and sides
stick up above the table top. For each drawer listed below this writes a new
open picture (next version number) built the same way as
house_two_refit_drawers.py, but keeping the drawer's own colours:
  - the closed front (cut from the closed picture), pulled out lower down,
  - a strip of the drawer's inside showing above it, dark at the top where it
    goes under the table. Nothing reaches above the closed front's top edge.
Then it points the scene at the new picture and moves the object inside the
drawer down into the visible strip.

The new picture is padded equally top and bottom when the pulled-out front
needs more room, so its centre (and the clickable area) stays where it was.
"""
import math
import os
import re

from PIL import Image, ImageDraw, ImageFilter

# (room, drawer node). Boat Shed, Workshop and Lamp Room are refitted by
# house_two_refit_drawers.py instead.
DRAWERS = [
    ("boiler_room", "BenchDrawer"),
    ("dispensary", "PowderDrawer"),
    ("dispensary", "LabelDrawer"),
    ("gate_lodge", "DeskDrawer"),
    ("laundry", "MangleDrawer"),
    ("laundry", "IroningDrawer"),
    ("living_room", "DeskDrawer"),
    ("matrons_office", "DeskDrawerLeft"),
    ("matrons_office", "DeskDrawerRight"),
    ("matrons_office", "SewingDrawer"),
    ("staircase", "HallTableDrawer"),
    ("study", "DeskDrawer"),
    ("sunken_boat", "ChartDrawer"),
    ("vane_cottage", "DeskDrawer"),
    ("ward_seven", "NursesDeskDrawer"),
    ("xray_room", "DeskDrawer"),
]

# How far the open drawer comes out, as a share of the front's height.
PULL = 0.45


def solid_box(image, inset=2):
    """Bounding box of the clearly solid pixels, pulled in a little past the soft edge."""
    x0, y0, x1, y1 = image.getchannel("A").point(lambda v: 255 if v > 128 else 0).getbbox()
    return x0 + inset, y0 + inset, x1 - inset, y1 - inset


def top_shadow(size, height, alpha):
    """Dark at the top (under the table top), fading out downwards."""
    shade = Image.new("RGBA", size, (8, 4, 2, 0))
    draw = ImageDraw.Draw(shade)
    for y in range(min(height, size[1])):
        draw.line([(0, y), (size[0], y)], fill=(8, 4, 2, int(alpha * (1.0 - y / height) ** 1.5)))
    return shade


def next_version(path):
    match = re.search(r"_v(\d+)\.png$", path)
    return path[: match.start()] + "_v%d.png" % (int(match.group(1)) + 1)


def build_open(closed, opened):
    """Returns (new open picture, top of the inside strip, its height) in the new picture's pixels."""
    x0, y0, x1, y1 = solid_box(closed)
    w, h = x1 - x0, y1 - y0
    ox0, oy0, ox1, oy1 = solid_box(opened)
    front_top_open = oy1 - h  # where the front starts in the open picture
    inside_box = (
        ox0 + 8,
        oy0 + int((front_top_open - oy0) * 0.25),
        ox1 - 8,
        min(oy1, front_top_open + int(h * 0.1)),
    )
    pull = int(h * PULL)
    front = closed.crop((x0, y0, x1, y1))
    inside = opened.crop(inside_box).resize((w, pull), Image.LANCZOS)
    inside.alpha_composite(top_shadow(inside.size, int(pull * 0.55), 215))
    backing = Image.new("RGBA", inside.size, (20, 10, 4, 255))
    backing.alpha_composite(inside)

    # Room for the pulled-out front plus its shadow, padded equally top and bottom.
    need = y0 + pull + h + 12
    pad = max(0, need - closed.size[1])
    canvas = Image.new("RGBA", (closed.size[0], closed.size[1] + 2 * pad), (0, 0, 0, 0))
    top = y0 + pad
    canvas.alpha_composite(backing, (x0, top))
    shadow = Image.new("RGBA", canvas.size, (0, 0, 0, 0))
    ImageDraw.Draw(shadow).rectangle((x0 + 6, top + pull + h, x1 - 6, top + pull + h + 10), fill=(0, 0, 0, 120))
    canvas.alpha_composite(shadow.filter(ImageFilter.GaussianBlur(5)))
    canvas.alpha_composite(front, (x0, top + pull))
    return canvas, top, pull


def node_block(scene, name):
    start = scene.index('[node name="%s"' % name)
    end = scene.find("\n[node ", start + 1)
    return start, (len(scene) if end < 0 else end)


def vector(block, key, default):
    match = re.search(r"\n%s = Vector2\(([-\d.]+), ([-\d.]+)\)" % key, block)
    return (float(match.group(1)), float(match.group(2))) if match else default


def number(block, key, default):
    match = re.search(r"\n%s = ([-\d.]+)\n" % key, block)
    return float(match.group(1)) if match else default


refitted = []
for room, node in DRAWERS:
    path = "scenes/%s.tscn" % room
    scene = open(path).read()
    start, end = node_block(scene, node)
    block = scene[start:end]
    textures = {i: p for p, i in re.findall(r'\[ext_resource type="Texture2D"[^\]]*path="res://([^"]+)" id="([^"]+)"\]', scene)}
    closed_id = re.search(r'closed_texture = ExtResource\("([^"]+)"\)', block).group(1)
    open_id = re.search(r'open_texture = ExtResource\("([^"]+)"\)', block).group(1)
    closed_path, open_path = textures[closed_id], textures[open_id]
    if "_fit" in open_path:
        print(room, node, "already refitted")
        continue

    closed = Image.open(closed_path).convert("RGBA")
    opened = Image.open(open_path).convert("RGBA")
    picture, strip_top, strip_height = build_open(closed, opened)
    new_path = next_version(open_path).replace(".png", "_fit.png")
    picture.save(new_path)

    # Point the scene at the new picture (the import id is regenerated by Godot).
    scene = re.sub(
        r'\[ext_resource type="Texture2D"[^\]]*path="res://%s" id="%s"\]' % (re.escape(open_path), re.escape(open_id)),
        '[ext_resource type="Texture2D" path="res://%s" id="%s"]' % (new_path, open_id),
        scene,
    )

    # Move the drawer's contents to the middle of the inside strip.
    start, end = node_block(scene, node)
    block = scene[start:end]
    scale = vector(block, "scale", (1.0, 1.0))[0]
    rotation = number(block, "rotation", 0.0)
    px, py = vector(block, "position", (0.0, 0.0))
    local_y = (strip_top + strip_height * 0.55 - picture.size[1] / 2.0) * scale
    contents = re.search(r'contents = NodePath\("../(\w+)"\)', block).group(1)
    c_start, c_end = node_block(scene, contents)
    c_block = scene[c_start:c_end]
    cx, cy = vector(c_block, "position", (px, py))
    # Keep the contents' sideways place in the drawer, measured along the drawer.
    along = (cx - px) * math.cos(rotation) + (cy - py) * math.sin(rotation)
    nx = px + along * math.cos(rotation) - local_y * math.sin(rotation)
    ny = py + along * math.sin(rotation) + local_y * math.cos(rotation)
    c_block = re.sub(r"\nposition = Vector2\([^)]*\)", "\nposition = Vector2(%.1f, %.1f)" % (nx, ny), c_block, count=1)
    scene = scene[:c_start] + c_block + scene[c_end:]
    open(path, "w").write(scene)
    refitted.append((room, node))
    print(room, node, "->", os.path.basename(new_path), "contents", contents, "(%.1f, %.1f) -> (%.1f, %.1f)" % (cx, cy, nx, ny))


# Second pass: an object much taller than the inside strip pokes up out of the
# drawer, so shrink it (never below 70%) to sit in the strip. Only for drawers
# refitted just now, so running the script again never shrinks anything twice.
for room, node in refitted:
    path = "scenes/%s.tscn" % room
    scene = open(path).read()
    start, end = node_block(scene, node)
    block = scene[start:end]
    textures = {i: p for p, i in re.findall(r'\[ext_resource type="Texture2D"[^\]]*path="res://([^"]+)" id="([^"]+)"\]', scene)}
    resources = {i: p for p, i in re.findall(r'\[ext_resource type="Resource"[^\]]*path="res://([^"]+)" id="([^"]+)"\]', scene)}
    closed = Image.open(textures[re.search(r'closed_texture = ExtResource\("([^"]+)"\)', block).group(1)]).convert("RGBA")
    x0, y0, x1, y1 = solid_box(closed)
    strip = int((y1 - y0) * PULL) * vector(block, "scale", (1.0, 1.0))[0]
    contents = re.search(r'contents = NodePath\("../(\w+)"\)', block).group(1)
    c_start, c_end = node_block(scene, contents)
    c_block = scene[c_start:c_end]
    data = open(resources[re.search(r'data = ExtResource\("([^"]+)"\)', c_block).group(1)]).read()
    picture = Image.open(re.search(r'path="res://([^"]+\.png)"', data).group(1)).convert("RGBA")
    tx, ty = vector(c_block, "texture_scale", (1.0, 1.0))
    bx0, by0, bx1, by1 = picture.getchannel("A").getbbox()
    height = (by1 - by0) * ty
    factor = max(0.7, min(1.0, strip * 1.5 / height))
    if factor < 0.99:
        c_block = re.sub(r"\ntexture_scale = Vector2\([^)]*\)", "\ntexture_scale = Vector2(%.4f, %.4f)" % (tx * factor, ty * factor), c_block, count=1)
        scene = scene[:c_start] + c_block + scene[c_end:]
        open(path, "w").write(scene)
        print(room, contents, "height %.0f, strip %.0f, shrunk to %d%%" % (height, strip, factor * 100))
