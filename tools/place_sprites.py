#!/usr/bin/env python3
"""Assign sprites and lay out one House Three room.

    python3 tools/place_sprites.py <room> < layout.txt   (run from the project folder)

Each layout line is `NodeName: x y key=value ...`. Keys:
  size=N   objects: longest side of the sprite on screen, in room pixels
  h=N/w=N  containers: height or width of the sprite canvas on screen
  rot=R    rotation in radians        z=N   z_index
  hit=W,H  containers: click box on screen in room pixels (default 80% of the sprite)
  flip=1   mirror the sprite left-right
x and y may be `-` to leave the position alone. Lines starting with # are ignored.
The first run also wires the textures: object .tres files get texture + icon_texture,
containers get closed_texture + open_texture (assets/objects/<room>_<container_id>_*_v1.png).
"""
import re, sys
from pathlib import Path
from PIL import Image

room = sys.argv[1]
scene_path = Path(f"scenes/{room}.tscn")
s = scene_path.read_text()

def block(name):
    m = re.search(r'\[node name="%s"[^\]]*\]\n((?:(?!\[node |\n\[).*\n)*)' % re.escape(name), s)
    if not m: raise SystemExit(f"No node called {name}")
    return m

def get(name, key):
    m = re.search(r'^%s = (.*)$' % key, block(name).group(1), re.M)
    return m.group(1) if m else None

def setprop(name, key, val):
    global s
    m = block(name); body = m.group(1)
    line = f"{key} = {val}\n"
    if re.search(r'^%s = .*\n' % key, body, re.M):
        nb = re.sub(r'^%s = .*\n' % key, lambda _: line, body, count=1, flags=re.M)
    elif key in ("position", "z_index", "modulate"):
        nb = line + body
    else:
        nb = body.rstrip("\n") + "\n" + line
    s = s[:m.start(1)] + nb + s[m.end(1):]

def delprop(name, key):
    global s
    m = block(name)
    nb = re.sub(r'^%s = .*\n' % key, "", m.group(1), flags=re.M)
    s = s[:m.start(1)] + nb + s[m.end(1):]

def ext_id(path, kind="Texture2D"):
    """Returns the id of the ext_resource for `path`, adding it if needed."""
    global s
    m = re.search(r'\[ext_resource type="%s" path="%s" id="([^"]+)"\]' % (kind, re.escape(path)), s)
    if m: return m.group(1)
    new_id = "tex_" + Path(path).stem
    idx = s.rfind("[ext_resource"); end = s.index("\n", idx) + 1
    s = s[:end] + f'[ext_resource type="{kind}" path="{path}" id="{new_id}"]\n' + s[end:]
    return new_id

def fmt(v): return "%g" % round(v, 4)

def wire_object_tres(tres_path):
    t = Path(tres_path).read_text()
    oid = re.search(r'object_id = &"([^"]+)"', t).group(1)
    png = Path(f"assets/objects/{oid}_v1.png")
    if not png.exists(): raise SystemExit(f"Missing sprite {png}")
    if "texture = ExtResource" not in t:
        t = t.replace('[resource]', f'[ext_resource type="Texture2D" path="res://{png}" id="2_texture"]\n\n[resource]', 1)
        t = re.sub(r'\n\n\n\[resource\]', '\n\n[resource]', t)
        t = re.sub(r'^(placeholder_style = .*\n)', r'\1texture = ExtResource("2_texture")\nicon_texture = ExtResource("2_texture")\n', t, count=1, flags=re.M)
        assert "icon_texture" in t, tres_path
        Path(tres_path).write_text(t)
    return png

exts = dict((i, p) for p, i in re.findall(r'\[ext_resource type="Resource" path="res://([^"]+)" id="([^"]+)"\]', s))

for raw in sys.stdin:
    raw = raw.split("#")[0].strip()
    if not raw: continue
    name, rest = raw.split(":", 1); name = name.strip()
    parts = rest.split(); xy = parts[:2]; kv = dict(p.split("=", 1) for p in parts[2:])
    if xy[0] != "-":
        setprop(name, "position", f"Vector2({fmt(float(xy[0]))}, {fmt(float(xy[1]))})")
    if "rot" in kv: setprop(name, "rotation", fmt(float(kv["rot"])))
    if "z" in kv: setprop(name, "z_index", kv["z"])
    cid = get(name, "container_id")
    flip = -1.0 if kv.get("flip") == "1" else 1.0
    if cid:
        cid = cid.strip('&"')
        closed = Path(f"assets/objects/{room}_{cid}_closed_v1.png"); opened = Path(f"assets/objects/{room}_{cid}_open_v1.png")
        if not closed.exists(): raise SystemExit(f"Missing sprite {closed}")
        setprop(name, "closed_texture", f'ExtResource("{ext_id("res://" + str(closed))}")')
        setprop(name, "open_texture", f'ExtResource("{ext_id("res://" + str(opened))}")')
        tw, th = Image.open(closed).size
        if "h" in kv or "w" in kv:
            k = float(kv["h"]) / th if "h" in kv else float(kv["w"]) / tw
            setprop(name, "scale", f"Vector2({fmt(k * flip)}, {fmt(k)})")
        else:
            cur = get(name, "scale"); k = abs(float(re.findall(r"[-\d.]+", cur.split("(", 1)[1])[0])) if cur else 1.0
        if "hit" in kv:
            hw, hh = [float(v) for v in kv["hit"].split(",")]
            setprop(name, "size", f"Vector2({fmt(hw / k)}, {fmt(hh / k)})")
        elif "h" in kv or "w" in kv:
            setprop(name, "size", f"Vector2({fmt(tw * 0.8)}, {fmt(th * 0.8)})")
    else:
        data = get(name, "data")
        if data is None: 
            continue
        png = wire_object_tres(exts[re.search(r'"([^"]+)"', data).group(1)])
        if "size" in kv:
            k = float(kv["size"]) / max(Image.open(png).size)
            delprop(name, "scale")
            if flip < 0: setprop(name, "scale", "Vector2(-1, 1)")
            setprop(name, "texture_scale", f"Vector2({fmt(k)}, {fmt(k)})")
scene_path.write_text(s)
print("ok", room)
