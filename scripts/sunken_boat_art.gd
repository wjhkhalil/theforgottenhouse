@tool
class_name SunkenBoatArt
extends RoomArt
## Placeholder drawing of House Two, Chapter Five: the wreck of the Lady Margaret
## on the bed of Blackwater Lake. See room_art.gd for how to replace it with a real image.
##
## Layout: the boat lies on the lake bed, keeled over, with its bow sunk in
## the silt on the right. Part of the hull has broken away, so we look into
## it like a doll's house (a "cut-away"):
##   * Left: the stern, with the boat's name and Mara's porthole, forced open
##     from the inside. Below it, the silt and weed of the lake bed.
##   * Middle: the saloon (the cabin door, a galley cupboard, a table).
##   * Right: the hold, with the drilled holes in the hull planks.
##   * Above the hold: the wheelhouse (chart table, key box, chalk slate, wheel).
## Drifting specks and rising bubbles are drawn by AirSupply, so they can move.
##
## THE TILT: the whole boat is drawn in its own "upright" coordinates and then
## turned by BOAT_TILT around BOAT_PIVOT with draw_set_transform_matrix().
## The objects and containers inside the boat use the same rotation in the scene.

const BOAT_TILT := 0.12
const BOAT_PIVOT := Vector2(540, 420)
const SILT_Y := 604.0
const WATER_TOP := Color(0.11, 0.25, 0.26)
const WATER_BOTTOM := Color(0.03, 0.09, 0.1)
const SILT := Color(0.24, 0.25, 0.18)
const SILT_DARK := Color(0.13, 0.14, 0.1)
const WEED := Color(0.16, 0.3, 0.16)
const WEED_DARK := Color(0.09, 0.19, 0.11)
const HULL := Color(0.22, 0.24, 0.2)
const HULL_DARK := Color(0.12, 0.14, 0.12)
const PLANK := Color(0.27, 0.22, 0.16)
const PLANK_DARK := Color(0.15, 0.12, 0.09)
const BRASS := Color(0.55, 0.5, 0.3)
const CHALK := Color(0.86, 0.88, 0.84)


func _draw_background() -> void:
	_draw_water()
	_draw_light_shafts()
	_draw_far_bed()
	_draw_silt()
	_draw_anchor()
	_draw_back_weed()
	# Everything on the boat is drawn upright, then tipped over.
	draw_set_transform_matrix(_boat_transform())
	_draw_hull()
	_draw_saloon()
	_draw_hold()
	_draw_wheelhouse()
	_draw_stern()
	draw_set_transform_matrix(Transform2D.IDENTITY)


func _draw_foreground() -> void:
	# A silt bank heaped against the buried bow.
	_polygon([Vector2(770, 720), Vector2(800, 652), Vector2(860, 628), Vector2(940, 618), Vector2(1030, 624),
		Vector2(1120, 646), Vector2(1200, 690), Vector2(1220, 720)], Color(0.2, 0.21, 0.15))
	draw_polyline(PackedVector2Array([Vector2(800, 652), Vector2(860, 628), Vector2(940, 618), Vector2(1030, 624),
		Vector2(1120, 646)]), Color(0.32, 0.33, 0.24), 2.0)
	# Weed fronds in front, at the far left (partly hiding something in the weed).
	_draw_weed_clump(Vector2(104, 720), 7, 150.0, 3.0, WEED_DARK)
	_draw_weed_clump(Vector2(1180, 720), 6, 200.0, 4.0, WEED_DARK)
	# A frayed mooring rope drifting down from the surface over the bow.
	draw_polyline(PackedVector2Array([Vector2(1080, 60), Vector2(1066, 180), Vector2(1084, 300), Vector2(1060, 420),
		Vector2(1030, 520)]), Color(0.42, 0.38, 0.28, 0.8), 4.0, true)
	_draw_vignette()
	# Murky water is darker at the very bottom than the usual vignette.
	_vertical_gradient(Rect2(0, room_size.y - 40, room_size.x, 40), Color(0, 0.02, 0.02, 0), Color(0, 0.02, 0.02, 0.4))


# ---------------------------------------------------------------------------

## Maps the boat's upright drawing onto the tipped-over wreck.
func _boat_transform() -> Transform2D:
	return Transform2D(BOAT_TILT, BOAT_PIVOT) * Transform2D(0.0, -BOAT_PIVOT)


## Murky green-blue lake water, lighter towards the far-off surface.
func _draw_water() -> void:
	_vertical_gradient(Rect2(0, 0, room_size.x, room_size.y), WATER_TOP, WATER_BOTTOM)
	# A paler patch where a little moonlight gets down through the water.
	_ellipse(Vector2(380, 40), Vector2(420, 120), Color(0.4, 0.6, 0.55, 0.06))


## Faint slanted beams of light from the surface far above.
func _draw_light_shafts() -> void:
	for shaft in [[150.0, 90.0], [430.0, 60.0], [690.0, 110.0], [980.0, 70.0]]:
		var x: float = shaft[0]
		var width: float = shaft[1]
		draw_polygon(PackedVector2Array([Vector2(x, 0), Vector2(x + width, 0), Vector2(x + width + 160, 620), Vector2(x + 110, 620)]),
			PackedColorArray([Color(0.6, 0.8, 0.75, 0.07), Color(0.6, 0.8, 0.75, 0.07), Color(0.6, 0.8, 0.75, 0.0),
				Color(0.6, 0.8, 0.75, 0.0)]))


## Rocks and banks fading away into the murk behind the wreck.
func _draw_far_bed() -> void:
	var far := Color(0.07, 0.15, 0.15)
	_polygon([Vector2(0, 560), Vector2(140, 520), Vector2(300, 540), Vector2(520, 505), Vector2(760, 530),
		Vector2(980, 500), Vector2(1180, 525), Vector2(1280, 510), Vector2(1280, 620), Vector2(0, 620)], far)
	for rock in [Vector2(260, 532), Vector2(1100, 515), Vector2(640, 512)]:
		_ellipse(rock, Vector2(46, 18), Color(0.06, 0.12, 0.12))


## The silty lake bed, with ripple marks and a few stones.
func _draw_silt() -> void:
	var top := PackedVector2Array()
	var x := 0.0
	while x <= room_size.x:
		top.append(Vector2(x, _silt_height(x)))
		x += 40.0
	var outline: Array[Vector2] = []
	for point in top:
		outline.append(point)
	outline.append(Vector2(room_size.x, room_size.y))
	outline.append(Vector2(0, room_size.y))
	_polygon(outline, SILT)
	_vertical_gradient(Rect2(0, 640, room_size.x, 80), Color(SILT_DARK, 0.0), SILT_DARK)
	draw_polyline(top, Color(0.34, 0.35, 0.26), 2.0)
	# Ripple marks in the silt
	for i in range(9):
		var y := 630.0 + i * 10.0
		var start := 60.0 + (i % 3) * 40.0
		var ripple := PackedVector2Array()
		var rx := start
		while rx < 1240.0:
			ripple.append(Vector2(rx, y + sin(rx * 0.05 + i) * 2.0))
			rx += 20.0
		draw_polyline(ripple, Color(0.16, 0.17, 0.12, 0.5), 1.0)
	# Stones half sunk in the silt
	var rng := RandomNumberGenerator.new()
	rng.seed = 1988
	for i in range(14):
		var stone := Vector2(rng.randf_range(90, 1240), rng.randf_range(624, 712))
		var radius := Vector2(rng.randf_range(6, 16), rng.randf_range(4, 8))
		_ellipse(stone + Vector2(2, 2), radius, Color(0.08, 0.09, 0.07, 0.6))
		_ellipse(stone, radius, Color(0.3, 0.31, 0.26))
		_ellipse(stone - Vector2(radius.x * 0.3, radius.y * 0.4), radius * 0.4, Color(0.4, 0.42, 0.35, 0.5))


func _silt_height(x: float) -> float:
	return SILT_Y + sin(x * 0.011) * 8.0 + sin(x * 0.031 + 1.0) * 3.0


## The boat's anchor, its chain running up to the bow.
func _draw_anchor() -> void:
	var chain := Color(0.2, 0.17, 0.14)
	var points := PackedVector2Array()
	for i in range(18):
		var t := i / 17.0
		points.append(Vector2(lerpf(960, 1150, t), lerpf(420, 640, t) + sin(t * PI) * 40.0))
	for i in range(points.size() - 1):
		draw_arc(points[i].lerp(points[i + 1], 0.5), 5.0, 0, TAU, 8, chain, 2.5)
	# The anchor, dug into the silt
	var at := Vector2(1150, 640)
	draw_line(at + Vector2(0, -36), at + Vector2(0, 10), chain, 6.0)
	draw_line(at + Vector2(-14, -30), at + Vector2(14, -30), chain, 5.0)
	draw_arc(at + Vector2(0, -6), 18, 0.3, PI - 0.3, 10, chain, 5.0)


## Tall lake weed swaying behind the wreck (drawn still; the water is calm down here).
func _draw_back_weed() -> void:
	_draw_weed_clump(Vector2(60, 612), 5, 210.0, 3.0, WEED)
	_draw_weed_clump(Vector2(300, 616), 4, 120.0, 2.5, WEED)
	_draw_weed_clump(Vector2(1000, 610), 5, 260.0, 3.0, WEED)
	_draw_weed_clump(Vector2(1240, 616), 4, 240.0, 3.0, WEED)
	_draw_weed_clump(Vector2(620, 622), 3, 70.0, 2.0, WEED)


func _draw_weed_clump(base: Vector2, stalks: int, height: float, width: float, color: Color) -> void:
	for s in range(stalks):
		var root := base + Vector2((s - stalks / 2.0) * 9.0, 0)
		var points := PackedVector2Array()
		var stalk_height := height * (0.6 + 0.4 * absf(sin(s * 2.3 + base.x)))
		for i in range(12):
			var t := i / 11.0
			points.append(root + Vector2(sin(t * 5.0 + s * 1.7 + base.x) * 14.0 * t, -stalk_height * t))
		draw_polyline(points, color, width, true)
		# Little leaves along the stalk
		for i in range(2, 11, 3):
			var leaf := points[i]
			_ellipse(leaf + Vector2(6 if i % 2 == 0 else -6, 0), Vector2(7, 2.5), color)


# ---------------------------------------------------------------------------
# The boat (all in upright coordinates; see _boat_transform)
# ---------------------------------------------------------------------------

## The outside of the hull, the broken-open middle, and the keel.
func _draw_hull() -> void:
	var outline: Array[Vector2] = [Vector2(80, 322), Vector2(1010, 296), Vector2(1000, 330), Vector2(975, 400),
		Vector2(935, 480), Vector2(880, 556), Vector2(820, 598), Vector2(200, 600), Vector2(150, 582),
		Vector2(112, 524), Vector2(92, 430)]
	_polygon(outline, HULL)
	# Planks along the hull, green with slime
	for i in range(1, 9):
		var y := 322.0 + i * 31.0
		draw_line(Vector2(96 + i * 2.0, y), Vector2(990 - i * i * 1.6, y - 20.0 + i * 1.5), HULL_DARK, 1.5)
	# The rubbing strake along the top of the hull, and the keel
	draw_line(Vector2(80, 324), Vector2(1008, 298), Color(0.32, 0.3, 0.24), 6.0)
	draw_line(Vector2(200, 602), Vector2(820, 600), Color(0.1, 0.1, 0.08), 8.0)
	# The rudder hanging off the stern
	_polygon([Vector2(104, 520), Vector2(70, 530), Vector2(66, 600), Vector2(110, 590)], HULL_DARK)
	# The broken-away part: we see the inside of the far side of the hull.
	var hole: Array[Vector2] = [Vector2(362, 348), Vector2(420, 342), Vector2(470, 352), Vector2(560, 340),
		Vector2(650, 346), Vector2(760, 338), Vector2(902, 344), Vector2(912, 400), Vector2(896, 470),
		Vector2(866, 540), Vector2(820, 584), Vector2(700, 578), Vector2(600, 588), Vector2(480, 580),
		Vector2(372, 586), Vector2(356, 520), Vector2(366, 440)]
	_polygon(hole, Color(0.09, 0.1, 0.09))
	# Ribs (the boat's frames) inside
	for x: float in [400.0, 470.0, 540.0, 610.0, 680.0, 750.0, 820.0]:
		draw_line(Vector2(x, 352), Vector2(x - 6, 580), Color(0.17, 0.14, 0.11), 7.0)
	# Splintered plank ends round the edge of the hole
	var rng := RandomNumberGenerator.new()
	rng.seed = 21
	for i in range(hole.size()):
		var a := hole[i]
		var b := hole[(i + 1) % hole.size()]
		for j in range(3):
			var p := a.lerp(b, (j + 0.5) / 3.0)
			var outward := (p - Vector2(630, 460)).normalized()
			draw_line(p, p - outward * rng.randf_range(6, 16) + Vector2(rng.randf_range(-4, 4), rng.randf_range(-4, 4)),
				PLANK, 3.0)
	# The underside of the deck across the top of the hole
	draw_rect(Rect2(362, 340, 548, 12), PLANK_DARK)
	# Weed growing off the hull
	_draw_weed_clump(Vector2(240, 600), 3, 40.0, 2.0, WEED)
	_draw_weed_clump(Vector2(900, 330), 3, 34.0, 2.0, WEED)


## The saloon: Mara's cabin door, a galley cupboard, the table and a calendar.
func _draw_saloon() -> void:
	# Panelled back wall
	draw_rect(Rect2(372, 354, 270, 214), Color(0.2, 0.17, 0.13))
	for x in range(380, 640, 26):
		draw_line(Vector2(x, 356), Vector2(x, 566), Color(0.14, 0.11, 0.08), 1.5)
	# The floor (the cabin sole)
	draw_rect(Rect2(372, 566, 520, 10), PLANK)
	# The doorway into Mara's cabin: a dark frame round the cabin door (the CabinDoor container sits in it)
	draw_rect(Rect2(376, 424, 68, 124), PLANK_DARK)
	draw_rect(Rect2(378, 426, 64, 120), Color(0.05, 0.05, 0.05))
	# A brass name plate above it: "CABIN" (scratched, as if someone tried to prise it off)
	draw_rect(Rect2(392, 408, 36, 12), BRASS)
	draw_string(ThemeDB.fallback_font, Vector2(394, 418), "CABIN", HORIZONTAL_ALIGNMENT_LEFT, -1, 9, Color(0.18, 0.15, 0.1))
	draw_line(Vector2(390, 406), Vector2(400, 422), Color(0.8, 0.75, 0.55), 1.0)
	# A heavy bolt on the OUTSIDE of the cabin door
	draw_rect(Rect2(446, 478, 16, 8), Color(0.3, 0.3, 0.3))
	draw_rect(Rect2(450, 474, 4, 16), Color(0.22, 0.22, 0.22))
	# The table bolted to the floor, and its bench
	draw_rect(Rect2(474, 512, 112, 8), PLANK)
	draw_rect(Rect2(524, 520, 10, 46), PLANK_DARK)
	draw_rect(Rect2(480, 540, 40, 6), PLANK)
	draw_line(Vector2(484, 546), Vector2(484, 566), PLANK_DARK, 3.0)
	# A plate rack, with one plate left in it, and a slipped calendar
	draw_rect(Rect2(600, 378, 34, 6), PLANK)
	draw_circle(Vector2(616, 372), 9, Color(0.6, 0.62, 0.58))
	draw_circle(Vector2(616, 372), 5, Color(0.5, 0.52, 0.48))
	draw_rect(Rect2(482, 368, 40, 50), Color(0.62, 0.6, 0.52))
	draw_rect(Rect2(482, 368, 40, 12), Color(0.45, 0.2, 0.18))
	draw_string(ThemeDB.fallback_font, Vector2(486, 378), "OCT 88", HORIZONTAL_ALIGNMENT_LEFT, -1, 9, CHALK)
	for row in range(3):
		for col in range(5):
			draw_rect(Rect2(486 + col * 7, 384 + row * 9, 4, 4), Color(0.35, 0.34, 0.3))
	# A broken oil lamp bracket
	draw_line(Vector2(458, 380), Vector2(458, 400), BRASS, 2.0)
	draw_arc(Vector2(458, 404), 5, 0, PI, 6, BRASS, 2.0)


## The hold: crates, rope, and the holes drilled through the hull.
func _draw_hold() -> void:
	draw_rect(Rect2(642, 354, 8, 212), PLANK_DARK)  # bulkhead
	# Crates slid down against the hull
	for crate in [Rect2(780, 500, 70, 64), Rect2(800, 452, 46, 48)]:
		draw_rect(crate, Color(0.3, 0.24, 0.16))
		draw_rect(crate.grow(-3), Color(0.18, 0.14, 0.1), false, 2.0)
		draw_line(crate.position + Vector2(3, 3), crate.end - Vector2(3, 3), Color(0.18, 0.14, 0.1), 2.0)
	# A coil of rope
	for r in range(4):
		_ellipse(Vector2(690, 556), Vector2(26 - r * 5, 8 - r * 1.5), Color(0.42, 0.37, 0.26) if r % 2 == 0 else Color(0.34, 0.3, 0.2))
	# Three holes drilled in the hull planks, the bungs pulled out. One bung still floats nearby.
	for hole: Vector2 in [Vector2(672, 576), Vector2(744, 578), Vector2(816, 576)]:
		draw_circle(hole, 5.0, Color(0.02, 0.03, 0.03))
		draw_arc(hole, 6.0, 0, TAU, 10, Color(0.42, 0.35, 0.22), 1.5)
	draw_rect(Rect2(764, 560, 9, 6), Color(0.5, 0.4, 0.26))
	# The steps up to the wheelhouse
	for i in range(5):
		draw_rect(Rect2(860 - i * 4, 548 - i * 40, 34, 6), PLANK)
	draw_line(Vector2(892, 350), Vector2(876, 566), PLANK_DARK, 4.0)


## The wheelhouse on deck: windows, a chalk slate, the chart table and the wheel.
func _draw_wheelhouse() -> void:
	var house := Rect2(632, 172, 276, 148)
	# Roof and walls
	draw_rect(Rect2(624, 160, 292, 14), PLANK_DARK)
	draw_rect(house, Color(0.24, 0.2, 0.15))
	for x in range(640, 906, 22):
		draw_line(Vector2(x, 174), Vector2(x, 318), Color(0.17, 0.14, 0.1), 1.5)
	# A row of windows, the glass long gone: just murky water beyond
	for i in range(3):
		var window := Rect2(654 + i * 58, 184, 46, 34)
		draw_rect(window.grow(3), PLANK_DARK)
		draw_rect(window, Color(0.1, 0.22, 0.22))
		draw_line(window.position + Vector2(4, 30), window.position + Vector2(18, 4), Color(0.4, 0.6, 0.55, 0.3), 1.5)
	# The chalk slate on the wall: Vane wrote up every trip
	var slate := Rect2(834, 184, 60, 42)
	draw_rect(slate.grow(3), Color(0.4, 0.3, 0.2))
	draw_rect(slate, Color(0.12, 0.13, 0.13))
	draw_string(ThemeDB.fallback_font, slate.position + Vector2(5, 14), "CAST OFF", HORIZONTAL_ALIGNMENT_LEFT, -1, 10, CHALK)
	draw_string(ThemeDB.fallback_font, slate.position + Vector2(9, 34), "21:40", HORIZONTAL_ALIGNMENT_LEFT, -1, 16, CHALK)
	draw_line(slate.position + Vector2(4, 37), slate.position + Vector2(56, 37), Color(CHALK, 0.4), 1.0)
	# The chart table (the ChartDrawer container sits under its top)
	draw_rect(Rect2(652, 268, 104, 7), PLANK)
	draw_rect(Rect2(656, 275, 96, 30), Color(0.2, 0.16, 0.12))
	draw_rect(Rect2(660, 305, 6, 14), PLANK_DARK)
	draw_rect(Rect2(742, 305, 6, 14), PLANK_DARK)
	# A sodden chart on the table top
	_polygon([Vector2(668, 262), Vector2(718, 260), Vector2(722, 268), Vector2(664, 268)], Color(0.6, 0.6, 0.5))
	# The empty lifebelt hooks on the wall: the lifebelt is gone.
	draw_arc(Vector2(790, 254), 15, 0, TAU, 20, Color(0.32, 0.27, 0.2), 6.0)
	draw_line(Vector2(778, 238), Vector2(778, 244), BRASS, 2.0)
	draw_line(Vector2(802, 238), Vector2(802, 244), BRASS, 2.0)
	# The ship's wheel on its pedestal
	var hub := Vector2(872, 272)
	draw_rect(Rect2(866, 272, 12, 46), PLANK_DARK)
	for i in range(8):
		var direction := Vector2.from_angle(TAU * i / 8.0 + 0.2)
		draw_line(hub, hub + direction * 30.0, Color(0.42, 0.3, 0.18), 3.0)
	draw_arc(hub, 22, 0, TAU, 24, Color(0.42, 0.3, 0.18), 4.0)
	draw_circle(hub, 5, BRASS)
	# The wheelhouse floor is the deck
	draw_rect(Rect2(632, 318, 276, 6), PLANK)
	# The broken mast lying back over the stern
	draw_line(Vector2(700, 160), Vector2(470, 72), Color(0.26, 0.22, 0.16), 9.0)
	draw_line(Vector2(470, 72), Vector2(440, 64), Color(0.26, 0.22, 0.16), 5.0)
	draw_line(Vector2(560, 106), Vector2(380, 330), Color(0.4, 0.36, 0.28, 0.6), 1.5)  # a loose stay


## The stern: the boat's name, the deck rail and Mara's porthole, forced open from inside.
func _draw_stern() -> void:
	# Deck rail
	for x in range(100, 620, 40):
		draw_line(Vector2(x, 320 - x * 0.012), Vector2(x, 296 - x * 0.012), Color(0.3, 0.28, 0.22), 3.0)
	draw_line(Vector2(96, 296), Vector2(620, 288), Color(0.34, 0.31, 0.24), 3.0)
	# The name, faded under the slime
	draw_string(ThemeDB.fallback_font, Vector2(118, 372), "LADY MARGARET", HORIZONTAL_ALIGNMENT_LEFT, -1, 18,
		Color(0.72, 0.74, 0.62, 0.75))
	# A closed porthole further along, still tight shut
	draw_circle(Vector2(320, 450), 15, BRASS.darkened(0.3))
	draw_circle(Vector2(320, 450), 11, Color(0.08, 0.12, 0.12))
	draw_line(Vector2(314, 444), Vector2(324, 454), Color(0.4, 0.55, 0.5, 0.4), 1.5)
	# Mara's porthole: the glass ring swung outwards, the dogs (clamps) bent back.
	var port := Vector2(230, 452)
	draw_circle(port, 22, BRASS.darkened(0.25))
	draw_circle(port, 17, Color(0.02, 0.03, 0.03))
	# The opened glass ring, hanging on its hinge below
	_ellipse(port + Vector2(-4, 34), Vector2(19, 8), BRASS.darkened(0.35))
	_ellipse(port + Vector2(-4, 34), Vector2(14, 5), Color(0.3, 0.4, 0.38))
	draw_line(port + Vector2(-6, 20), port + Vector2(-6, 28), BRASS, 3.0)
	# Bent clamps and fresh scratches round the rim: forced from the INSIDE
	for angle: float in [-0.6, 0.9, 2.4]:
		var direction := Vector2.from_angle(angle)
		draw_line(port + direction * 20.0, port + direction * 30.0 + direction.orthogonal() * 4.0, Color(0.5, 0.48, 0.42), 2.5)
	for i in range(5):
		var direction := Vector2.from_angle(3.5 + i * 0.25)
		draw_line(port + direction * 22.0, port + direction * 28.0, Color(0.85, 0.82, 0.7, 0.7), 1.0)
