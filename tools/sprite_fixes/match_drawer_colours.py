"""Tint every drawer to the colour of the painted furniture around it.

Run from the project folder:
    python3 tools/sprite_fixes/match_drawer_colours.py [--apply] [--sheet OUT.png]

For every container whose id or node name contains "drawer", in every scene:
  1. lays its closed picture over the room's background painting, as the game draws it
     (centred on its position, scaled, rotated, times its current self_modulate);
  2. takes the median colour of the drawer, and of the painting in a thin ring round it
     (RING_NEAR..RING_FAR world pixels out: the table or desk it sits in);
  3. works out the self_modulate that makes the two the same.
Without --apply it only prints the result (and writes the before/after sheet, if asked).
With --apply it writes self_modulate into the scenes. Running it again changes nothing
once the drawers match: every drawer then reports "ok".

`SKIP` lists drawers whose colour was set by hand on purpose.
"""
import math
import re
import statistics
import sys
from glob import glob

from PIL import Image, ImageChops, ImageDraw, ImageFilter

RING_NEAR = 2.0   # world pixels between the drawer's edge and the ring
RING_FAR = 12.0   # outer edge of the ring
MIN_GAIN, MAX_GAIN = 0.35, 1.8
# A drawer whose tint is already within this of the wanted tint is left alone.
TOLERANCE = 0.03
# How far the colour (not the brightness) of a drawer may be pushed, as a share.
HUE_LIMIT = 0.3
SKIP = set()
# Where the painting shows the wood each drawer belongs to, as world boxes (left, top,
# right, bottom), picked by eye. Where the furniture already has a drawer painted in,
# that painted drawer is the reference; where it has an empty slot, the frame round it.
# A drawer not listed here is measured on the ring round it.
REFERENCE = {
    ("boat_shed", "WorkbenchDrawer"): [(292, 320, 330, 338), (165, 320, 205, 338)],
    ("boiler_room", "BenchDrawer"): [(690, 385, 716, 397), (786, 385, 830, 397)],
    ("dispensary", "PowderDrawer"): [(330, 415, 343, 445), (425, 415, 440, 445), (345, 447, 420, 455)],
    ("dispensary", "LabelDrawer"): [(440, 415, 450, 445), (537, 415, 547, 445), (455, 447, 530, 455)],
    ("gate_lodge", "DeskDrawer"): [(690, 370, 720, 389), (548, 370, 572, 389)],
    ("island_chapel", "PulpitDrawer"): [(240, 348, 255, 378), (148, 348, 158, 378)],
    ("lamp_room", "DeskDrawer"): [(225, 443, 330, 470)],
    ("laundry", "MangleDrawer"): [(455, 540, 510, 560), (580, 540, 600, 560)],
    ("laundry", "IroningDrawer"): [(912, 500, 960, 514), (822, 500, 840, 514)],
    ("living_room", "DeskDrawer"): [(705, 330, 770, 342)],
    ("matrons_office", "DeskDrawerLeft"): [(648, 466, 657, 492), (767, 466, 776, 492)],
    ("matrons_office", "DeskDrawerRight"): [(800, 462, 835, 479), (950, 462, 985, 479)],
    ("matrons_office", "SewingDrawer"): [(345, 458, 375, 480), (445, 458, 475, 480)],
    ("staircase", "HallTableDrawer"): [(590, 1110, 620, 1122), (660, 1110, 700, 1122)],
    ("study", "DeskDrawer"): [(378, 465, 468, 498)],
    ("sunken_boat", "ChartDrawer"): [(840, 262, 895, 300)],
    ("vane_cottage", "DeskDrawer"): [(482, 456, 558, 480)],
    ("ward_seven", "NursesDeskDrawer"): [(1087, 471, 1133, 494)],
    ("workshop", "BenchDrawer"): [(430, 398, 470, 418), (300, 398, 330, 418)],
    ("xray_room", "DeskDrawer"): [(808, 472, 940, 506)],
}

apply = "--apply" in sys.argv
sheet_path = sys.argv[sys.argv.index("--sheet") + 1] if "--sheet" in sys.argv else None


def vector(block, key):
    match = re.search(r"\n%s = Vector2\(([-\d.]+), ([-\d.]+)\)" % key, block)
    return (float(match.group(1)), float(match.group(2))) if match else None


def colour(block, key):
    match = re.search(r"\n%s = Color\(([-\d.]+), ([-\d.]+), ([-\d.]+), ([-\d.]+)\)" % key, block)
    return tuple(float(match.group(i)) for i in range(1, 4)) if match else (1.0, 1.0, 1.0)


def median_rgb(image, mask):
    pixels = [p for p, m in zip(image.getdata(), mask.getdata()) if m > 200]
    if len(pixels) < 20:
        return None
    return tuple(statistics.median(p[i] for p in pixels) for i in range(3))


def placed(texture, background, room_size, position, scale, rotation, box):
    """The texture laid over the background's pixel grid, as the game draws it.
    Only the part of the grid inside `box` (left, top, right, bottom) is returned."""
    kx, ky = background.width / room_size[0], background.height / room_size[1]
    cos, sin = math.cos(rotation), math.sin(rotation)
    w, h = texture.size
    # Background pixel (u, v) -> world (u / kx, v / ky) -> texture pixel:
    #   t = R(-rotation) * (world - position) / scale + size / 2
    a = cos / kx / scale[0]
    b = sin / ky / scale[0]
    c = -(cos * position[0] + sin * position[1]) / scale[0] + w / 2
    d = -sin / kx / scale[1]
    e = cos / ky / scale[1]
    f = (sin * position[0] - cos * position[1]) / scale[1] + h / 2
    # Shift so output pixel (0, 0) is the box's corner.
    c += a * box[0] + b * box[1]
    f += d * box[0] + e * box[1]
    size = (box[2] - box[0], box[3] - box[1])
    return texture.transform(size, Image.AFFINE, (a, b, c, d, e, f), Image.BILINEAR)


def drawer_box(texture, background, room_size, position, scale, rotation, margin):
    """The background pixels the drawer covers, plus `margin` world pixels round it."""
    kx, ky = background.width / room_size[0], background.height / room_size[1]
    w, h = texture.size
    cos, sin = math.cos(rotation), math.sin(rotation)
    xs, ys = [], []
    for cx, cy in ((0, 0), (w, 0), (w, h), (0, h)):
        lx, ly = (cx - w / 2) * scale[0], (cy - h / 2) * scale[1]
        xs.append((position[0] + cos * lx - sin * ly) * kx)
        ys.append((position[1] + sin * lx + cos * ly) * ky)
    return (max(0, int(min(xs) - margin * kx)), max(0, int(min(ys) - margin * ky)),
            min(background.width, int(max(xs) + margin * kx) + 1), min(background.height, int(max(ys) + margin * ky) + 1))


def luminance(rgb):
    return 0.299 * rgb[0] + 0.587 * rgb[1] + 0.114 * rgb[2]


def gains(raw, target):
    """Tint that turns `raw` into `target`: brightness matched exactly, colour moved only
    as far as HUE_LIMIT allows, so a few dark pixels cannot swing it to a strange hue."""
    level = luminance(target) / max(luminance(raw), 1.0)
    out = []
    for t, r in zip(target, raw):
        channel = (t + 4.0) / (r + 4.0)  # +4: very dark channels are mostly noise
        out.append(max(MIN_GAIN, min(MAX_GAIN, level * max(1 - HUE_LIMIT, min(1 + HUE_LIMIT, channel / level)))))
    return tuple(out)


rows = []
for scene_path in sorted(glob("scenes/*.tscn")):
    scene = open(scene_path).read()
    resources = {i: p for p, i in re.findall(r'path="res://([^"]+)" id="([^"]+)"', scene)}
    room = scene_path.split("/")[-1][:-5]
    if '[node name="RoomBackground"' not in scene:
        continue
    background_block = scene[scene.index('[node name="RoomBackground"'):]
    background_block = background_block[: background_block.find("\n[node ", 1)]
    background_id = re.search(r'replacement_texture = ExtResource\("([^"]+)"\)', background_block)
    if background_id is None:
        continue
    room_size = vector(background_block, "room_size") or (1280.0, 720.0)
    background = Image.open(resources[background_id.group(1)]).convert("RGB")
    k = background.width / room_size[0]

    tints = {}
    for match in list(re.finditer(r'\n\[node name="(\w+)"[^\n]*\n', scene)):
        name = match.group(1)
        start = match.start() + 1
        end = scene.find("\n[node ", start + 1)
        end = len(scene) if end < 0 else end
        block = scene[start:end]
        container_id = re.search(r'container_id = &"(\w+)"', block)
        if container_id is None or ("drawer" not in container_id.group(1) and "drawer" not in name.lower()):
            continue
        if (room, name) in SKIP:
            continue
        texture_id = re.search(r'closed_texture = ExtResource\("([^"]+)"\)', block)
        texture = Image.open(resources[texture_id.group(1)]).convert("RGBA")
        position = vector(block, "position")
        scale = vector(block, "scale") or (1.0, 1.0)
        rotation = float(re.search(r"\nrotation = ([-\d.]+)", block).group(1)) if "\nrotation = " in block else 0.0
        modulate = colour(block, "self_modulate")

        box = drawer_box(texture, background, room_size, position, scale, rotation, RING_FAR + 4)
        drawer = placed(texture, background, room_size, position, scale, rotation, box)
        local = background.crop(box)
        mask = drawer.getchannel("A").point(lambda v: 255 if v > 200 else 0)
        near = mask.filter(ImageFilter.MaxFilter(2 * int(RING_NEAR * k) + 1))
        far = mask.filter(ImageFilter.MaxFilter(2 * int(RING_FAR * k) + 1))
        ring = ImageChops.subtract(far, near)
        # Only beside and below the drawer: above it is often the table top, a wall or
        # whatever stands on the table, not the wood the drawer is set in.
        top = mask.getbbox()[1] + (mask.getbbox()[3] - mask.getbbox()[1]) // 3
        ImageDraw.Draw(ring).rectangle((0, 0, ring.width, top), fill=0)
        if (room, name) in REFERENCE:
            ring = Image.new("L", local.size, 0)
            for left, top, right, bottom in REFERENCE[(room, name)]:
                ImageDraw.Draw(ring).rectangle((left * k - box[0], top * k - box[1], right * k - box[0], bottom * k - box[1]), fill=255)
            if ring.getbbox() is None or ImageChops.multiply(ring, Image.new("L", ring.size, 255)).getbbox() is None:
                print(room, name, "reference box outside the crop")
                continue
        raw = median_rgb(drawer.convert("RGB"), mask)
        target = median_rgb(local, ring)
        if raw is None or target is None:
            print(room, name, "not measured")
            continue
        shown = tuple(r * m for r, m in zip(raw, modulate))
        new = gains(raw, target)
        # Already tinted (within TOLERANCE) as this would tint it: nothing to do.
        status = "ok" if max(abs(m - n) for m, n in zip(modulate, new)) <= TOLERANCE else "retint"
        print("%-15s %-17s shown %s ring %s  %s -> self_modulate %s" % (
            room, name, tuple(round(v) for v in shown), tuple(round(v) for v in target), status, tuple(round(v, 2) for v in new)))
        rows.append((room, name, local, drawer, mask, far, modulate, new, status))

        if apply and status == "retint":
            tints[name] = new
    # Written after measuring every drawer: each edit shifts the text after it.
    for name, new in tints.items():
        start = scene.index('[node name="%s"' % name)
        end = scene.find("\n[node ", start + 1)
        end = len(scene) if end < 0 else end
        block = scene[start:end]
        line = "self_modulate = Color(%.3f, %.3f, %.3f, 1)" % new
        if "\nself_modulate = " in block:
            block = re.sub(r"\nself_modulate = Color\([^)]*\)", "\n" + line, block)
        else:
            block = block.rstrip("\n") + "\n" + line + "\n"
        scene = scene[:start] + block + scene[end:]
    if tints:
        open(scene_path, "w").write(scene)

if sheet_path:
    # Each drawer: before | after, cropped round the drawer with some room to spare.
    tiles = []
    for room, name, background, drawer, mask, far, old, new, status in rows:
        box = (0, 0, background.width, background.height)
        pair = []
        for tint in (old, new):
            r, g, b, a = drawer.split()
            tinted = Image.merge("RGBA", [r.point(lambda v, t=tint[0]: min(255, int(v * t))),
                                          g.point(lambda v, t=tint[1]: min(255, int(v * t))),
                                          b.point(lambda v, t=tint[2]: min(255, int(v * t))), a])
            view = background.convert("RGBA")
            view.alpha_composite(tinted)
            pair.append(view.crop(box))
        tile = Image.new("RGB", (pair[0].width * 2 + 10, pair[0].height + 18), (20, 20, 20))
        tile.paste(pair[0], (0, 18))
        tile.paste(pair[1], (pair[0].width + 10, 18))
        ImageDraw.Draw(tile).text((4, 3), "%s / %s  (%s)" % (room, name, status), fill=(255, 255, 0))
        tile.thumbnail((620, 400))
        tiles.append(tile)
    columns = 2
    cell_w, cell_h = 630, 410
    sheet = Image.new("RGB", (cell_w * columns, cell_h * math.ceil(len(tiles) / columns)), (40, 40, 40))
    for i, tile in enumerate(tiles):
        sheet.paste(tile, ((i % columns) * cell_w, (i // columns) * cell_h))
    sheet.save(sheet_path)
