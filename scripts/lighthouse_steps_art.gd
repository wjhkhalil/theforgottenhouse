@tool
class_name LighthouseStepsArt
extends RoomArt
## Placeholder drawing of House Two, Chapter Seven: the inside of the
## lighthouse tower, where Agnes Hale lived as keeper. The room is two screens
## tall (1280 x 1440): set room_size on both layers.
## See room_art.gd for how to replace it with a real image.
##
## Layout (top to bottom): the iron floor of the lamp room above, and the top
## landing on the right, where an iron ladder climbs to the lamp room hatch
## (its lid hangs open, banging in the wind). An iron flight
## runs down to the left, to the keeper's landing (chair, shelf, a deep-set
## window and chalk on the wall). The next flight runs down to the right, to a
## small landing stacked with oil cans, and the last one runs back down to the
## left, to the stone floor, the oil locker under the stairs, and the door at the bottom.
## The whitewashed wall curves away at both sides (it is a round tower).
## The SweepingBeam node draws the dimness and the turning lamp's beam on top.

const TOP_LANDING := Rect2(900, 380, 380, 20)
const KEEPERS_LANDING := Rect2(0, 700, 600, 20)
const LOW_LANDING := Rect2(980, 1020, 300, 20)
const GROUND_Y := 1340.0
## The three iron flights: [top start, bottom end]. Each has 12 steps.
const FLIGHTS := [
	[Vector2(900, 380), Vector2(560, 700)],
	[Vector2(600, 700), Vector2(980, 1020)],
	[Vector2(980, 1020), Vector2(600, 1340)],
]
const STEPS := 12
const RAIL_HEIGHT := 58.0
## Deep-set windows: centre and size of the glass.
const WINDOWS := [
	[Vector2(340, 220), Vector2(78, 120)],
	[Vector2(505, 495), Vector2(66, 110)],
	[Vector2(1165, 760), Vector2(64, 110)],
	[Vector2(220, 915), Vector2(72, 116)],
	[Vector2(505, 1150), Vector2(64, 100)],
]
const DOOR_RECT := Rect2(140, 1110, 130, 230)
## The open hatch up into the lamp room (an iron ladder leads up to it).
const HATCH_RECT := Rect2(912, 78, 64, 12)

const WASH_LIGHT := Color(0.6, 0.62, 0.68)
const WASH_DARK := Color(0.26, 0.28, 0.34)
const IRON := Color(0.17, 0.18, 0.2)
const IRON_LIGHT := Color(0.32, 0.34, 0.37)
const IRON_DARK := Color(0.08, 0.08, 0.09)
const WOOD := Color(0.36, 0.24, 0.15)
const WOOD_DARK := Color(0.2, 0.13, 0.08)
const WOOD_LIGHT := Color(0.5, 0.35, 0.22)
const CHALK := Color(0.93, 0.93, 0.9, 0.9)
const STONE := Color(0.3, 0.29, 0.28)


func _draw_background() -> void:
	_draw_curved_wall()
	_draw_lamp_room_floor()
	for window: Array in WINDOWS:
		_draw_window(window[0], window[1])
	_draw_top_landing()
	_draw_keepers_landing()
	_draw_low_landing()
	_draw_ground_floor()
	for flight: Array in FLIGHTS:
		_draw_flight(flight[0], flight[1])
	_draw_landing_slab(TOP_LANDING)
	_draw_landing_slab(KEEPERS_LANDING)
	_draw_landing_slab(LOW_LANDING)


func _draw_foreground() -> void:
	# The iron handrails of the three flights and the two small landings.
	for flight: Array in FLIGHTS:
		_draw_flight_rail(flight[0], flight[1])
	for landing: Rect2 in [TOP_LANDING, LOW_LANDING]:
		# (The rail starts clear of the oil locker on the top landing.)
		var rail_x := maxf(landing.position.x, 1000.0)
		var rail_y := landing.position.y - RAIL_HEIGHT
		draw_line(Vector2(rail_x, rail_y), Vector2(landing.end.x, rail_y), IRON_LIGHT, 3.0)
		var x := rail_x + 20.0
		while x < landing.end.x:
			draw_line(Vector2(x, rail_y), Vector2(x, landing.position.y), IRON, 2.0)
			x += 46.0
	# Iron posts where the flights turn (the stair winds round them).
	for post: Vector2 in [Vector2(582, 700), Vector2(980, 1020)]:
		draw_rect(Rect2(post.x - 4, post.y - RAIL_HEIGHT - 10, 8, RAIL_HEIGHT + 14), IRON)
		draw_circle(Vector2(post.x, post.y - RAIL_HEIGHT - 12), 6, IRON_LIGHT)
	# The cut edges of the round wall at both sides, very dark.
	_horizontal_gradient(Rect2(0, 0, 36, room_size.y), Color(0.03, 0.03, 0.05), Color(0.03, 0.03, 0.05, 0.0))
	_horizontal_gradient(Rect2(room_size.x - 36, 0, 36, room_size.y), Color(0.03, 0.03, 0.05, 0.0), Color(0.03, 0.03, 0.05))
	# A rope hanging down from a hook under the top landing, swaying a little.
	draw_line(Vector2(1240, 400), Vector2(1236, 640), Color(0.5, 0.42, 0.28), 4.0)
	draw_circle(Vector2(1236, 646), 6, Color(0.45, 0.37, 0.24))
	_draw_vignette()


# ---------------------------------------------------------------------------

## The whitewashed inside of the tower: lighter in the middle, darker where it
## curves away at the sides, with curved stone courses under the whitewash.
func _draw_curved_wall() -> void:
	var half := room_size.x / 2.0
	_horizontal_gradient(Rect2(0, 0, half, room_size.y), WASH_DARK, WASH_LIGHT)
	_horizontal_gradient(Rect2(half, 0, half, room_size.y), WASH_LIGHT, WASH_DARK)
	# A bluish night tint, a little deeper at the top and the bottom.
	_vertical_gradient(Rect2(0, 0, room_size.x, 400), Color(0.05, 0.07, 0.14, 0.35), Color(0.05, 0.07, 0.14, 0.0))
	_vertical_gradient(Rect2(0, 1040, room_size.x, 400), Color(0.05, 0.05, 0.08, 0.0), Color(0.05, 0.05, 0.08, 0.35))
	# Curved courses: they bow up above eye level and down below it, as in a round room.
	var eye_y := room_size.y / 2.0
	var y := 40.0
	var course := 0
	while y < room_size.y:
		var bend := (y - eye_y) * 0.06
		var points := PackedVector2Array()
		for i in range(17):
			var x := i * room_size.x / 16.0
			var t := (x - half) / half
			points.append(Vector2(x, y + bend * t * t))
		draw_polyline(points, Color(0.2, 0.21, 0.26, 0.28), 1.5)
		# Vertical joints between the stones, staggered each course
		for j in range(9):
			var jx := 70.0 + j * 140.0 + (70.0 if course % 2 == 1 else 0.0)
			var jt := (jx - half) / half
			var jy := y + bend * jt * jt
			draw_line(Vector2(jx, jy), Vector2(jx, jy + 46.0), Color(0.2, 0.21, 0.26, 0.18), 1.0)
		y += 48.0
		course += 1
	# Flaking whitewash and damp stains.
	var rng := RandomNumberGenerator.new()
	rng.seed = 1988
	for i in range(18):
		var at := Vector2(rng.randf_range(60, 1220), rng.randf_range(80, 1320))
		_ellipse(at, Vector2(rng.randf_range(10, 34), rng.randf_range(6, 18)), Color(0.18, 0.19, 0.22, 0.22))
	for at: Vector2 in [Vector2(120, 520), Vector2(1100, 1180), Vector2(760, 260)]:
		_ellipse(at, Vector2(36, 70), Color(0.12, 0.16, 0.16, 0.22))


## The iron floor of the lamp room above, with rivets and a faint glow at the hatch.
func _draw_lamp_room_floor() -> void:
	draw_rect(Rect2(0, 0, room_size.x, 86), IRON)
	draw_rect(Rect2(0, 86, room_size.x, 6), IRON_DARK)
	draw_line(Vector2(0, 64), Vector2(room_size.x, 64), IRON_LIGHT, 1.5)
	for x in range(20, int(room_size.x), 40):
		draw_circle(Vector2(x, 76), 2.2, IRON_LIGHT)
	for x in range(0, int(room_size.x), 160):
		draw_line(Vector2(x, 0), Vector2(x, 86), IRON_DARK, 2.0)
	# Light from the great lamp leaks through a crack in the floor plates.
	draw_rect(Rect2(600, 84, 160, 3), Color(1.0, 0.95, 0.8, 0.35))
	_vertical_gradient(Rect2(580, 92, 200, 50), Color(1.0, 0.95, 0.8, 0.1), Color(1.0, 0.95, 0.8, 0.0))


## A small window set deep in the thick tower wall, with the storm outside.
func _draw_window(center: Vector2, glass_size: Vector2) -> void:
	var glass := Rect2(center - glass_size / 2.0, glass_size)
	var outer := glass.grow(16)
	# The deep reveal: lit side, shadow side, and a round top.
	draw_rect(outer, Color(0.66, 0.68, 0.73))
	draw_circle(Vector2(center.x, outer.position.y), outer.size.x / 2.0, Color(0.66, 0.68, 0.73))
	_polygon([outer.position, glass.position, Vector2(glass.position.x, glass.end.y), Vector2(outer.position.x, outer.end.y)],
		Color(0.42, 0.44, 0.5))
	_polygon([Vector2(outer.position.x, outer.end.y), Vector2(glass.position.x, glass.end.y), glass.end, outer.end],
		Color(0.5, 0.52, 0.58))
	# Stormy sky with torn clouds
	_vertical_gradient(glass, Color(0.1, 0.13, 0.2), Color(0.2, 0.24, 0.3))
	draw_circle(Vector2(center.x, glass.position.y), glass_size.x / 2.0, Color(0.1, 0.13, 0.2))
	for i in range(3):
		_ellipse(Vector2(glass.position.x + 14 + i * 22, glass.position.y + 16 + (i % 2) * 10), Vector2(18, 6),
			Color(0.3, 0.33, 0.4, 0.8))
	# Heaving dark water with whitecaps
	var water := Rect2(glass.position.x, glass.position.y + glass.size.y * 0.58, glass.size.x, glass.size.y * 0.42)
	draw_rect(water, Color(0.07, 0.12, 0.16))
	for row in range(3):
		var wy := water.position.y + 6 + row * 12
		var points := PackedVector2Array()
		var x := water.position.x
		while x <= water.end.x:
			points.append(Vector2(x, wy + sin(x * 0.2 + row * 1.7 + center.y) * 2.5))
			x += 4.0
		draw_polyline(points, Color(0.7, 0.76, 0.8, 0.5 - row * 0.12), 1.5)
	# Rain streaks on the glass
	for i in range(7):
		var rx := glass.position.x + 6 + i * glass.size.x / 7.0
		draw_line(Vector2(rx, glass.position.y + 6 + (i % 3) * 9), Vector2(rx - 6, glass.position.y + 30 + (i % 3) * 9),
			Color(0.75, 0.8, 0.9, 0.35), 1.0)
	# Iron glazing bars and the deep stone sill
	draw_line(Vector2(center.x, glass.position.y - glass_size.x / 2.0), Vector2(center.x, glass.end.y), IRON, 3.0)
	draw_line(Vector2(glass.position.x, center.y), Vector2(glass.end.x, center.y), IRON, 3.0)
	draw_rect(Rect2(outer.position.x - 8, outer.end.y - 4, outer.size.x + 16, 12), Color(0.55, 0.56, 0.6))
	draw_rect(Rect2(outer.position.x - 8, outer.end.y + 8, outer.size.x + 16, 4), Color(0, 0, 0, 0.35))


## The top landing: an iron ladder up to the lamp room hatch, which hangs
## open and bangs in the wind, and oil cans along the landing.
func _draw_top_landing() -> void:
	var hatch := HATCH_RECT
	# The open hatch in the lamp room floor, pale light spilling down
	draw_rect(hatch.grow(5), IRON_DARK)
	draw_rect(hatch, Color(0.85, 0.85, 0.78))
	_vertical_gradient(Rect2(hatch.position.x - 30, hatch.end.y, hatch.size.x + 60, 120), Color(0.95, 0.95, 0.85, 0.22),
		Color(0.95, 0.95, 0.85, 0.0))
	# The hatch lid hanging down on its hinge, swinging in the draught
	_polygon([Vector2(hatch.position.x, hatch.end.y), Vector2(hatch.position.x - 8, hatch.end.y + 70),
		Vector2(hatch.position.x - 20, hatch.end.y + 66), Vector2(hatch.position.x - 4, hatch.end.y)], IRON_LIGHT)
	draw_line(Vector2(hatch.position.x - 2, hatch.end.y + 4), Vector2(hatch.position.x - 12, hatch.end.y + 62), IRON_DARK, 2.0)
	for i in range(3):
		draw_arc(Vector2(hatch.position.x, hatch.end.y), 52 + i * 10, PI * 0.42, PI * 0.72, 6, Color(0.92, 0.92, 0.96, 0.4), 1.5)
	# The iron ladder from the top landing up to the hatch
	var ladder_left := hatch.position.x + 8
	var ladder_right := hatch.end.x - 8
	for x: float in [ladder_left, ladder_right]:
		draw_line(Vector2(x, hatch.end.y - 4), Vector2(x, TOP_LANDING.position.y), IRON, 5.0)
		draw_line(Vector2(x - 2, hatch.end.y - 4), Vector2(x - 2, TOP_LANDING.position.y), IRON_LIGHT, 1.0)
	var rung_y := hatch.end.y + 20
	while rung_y < TOP_LANDING.position.y:
		draw_line(Vector2(ladder_left, rung_y), Vector2(ladder_right, rung_y), IRON_LIGHT, 3.0)
		rung_y += 26.0
	# Oil cans along the landing
	for can: Array in [[Vector2(1000, 380), 1.0], [Vector2(1030, 380), 0.85], [Vector2(1190, 380), 1.1], [Vector2(1225, 380), 0.9]]:
		_draw_oil_can(can[0], can[1])


## The keeper's landing: a chair, a shelf, a rag rug, and chalk on the wall.
func _draw_keepers_landing() -> void:
	var floor_y := KEEPERS_LANDING.position.y
	# Rag rug
	_ellipse(Vector2(300, floor_y - 2), Vector2(120, 8), Color(0.4, 0.22, 0.2))
	_ellipse(Vector2(300, floor_y - 2), Vector2(96, 5), Color(0.32, 0.36, 0.42))
	# The shelf on two iron brackets, with books, a jar and a candle
	draw_rect(Rect2(140, 538, 300, 9), WOOD_LIGHT)
	draw_rect(Rect2(140, 547, 300, 3), WOOD_DARK)
	for bracket_x: float in [164.0, 410.0]:
		_polygon([Vector2(bracket_x, 550), Vector2(bracket_x + 6, 550), Vector2(bracket_x + 6, 578), Vector2(bracket_x, 566)], IRON)
	var book_x := 150.0
	for book: Array in [[Color(0.35, 0.18, 0.15), 30.0], [Color(0.2, 0.26, 0.32), 26.0], [Color(0.3, 0.3, 0.2), 32.0],
			[Color(0.42, 0.3, 0.18), 24.0]]:
		draw_rect(Rect2(book_x, 538 - book[1], 9, book[1]), book[0])
		draw_line(Vector2(book_x + 2, 538 - book[1] + 5), Vector2(book_x + 7, 538 - book[1] + 5), Color(0.8, 0.7, 0.4, 0.6), 1.0)
		book_x += 10.0
	draw_rect(Rect2(272, 518, 16, 20), Color(0.6, 0.7, 0.72, 0.5))
	draw_rect(Rect2(272, 515, 16, 4), Color(0.4, 0.3, 0.2))
	draw_rect(Rect2(420, 522, 7, 16), Color(0.9, 0.88, 0.8))
	# The keeper's wooden chair, a cushion on the seat
	var chair_x := 255.0
	draw_rect(Rect2(chair_x, 642, 76, 8), WOOD)
	for leg_x: float in [chair_x + 4, chair_x + 66]:
		draw_rect(Rect2(leg_x, 650, 6, floor_y - 650), WOOD_DARK)
	draw_rect(Rect2(chair_x + 2, 566, 7, 80), WOOD_DARK)
	draw_rect(Rect2(chair_x + 66, 566, 7, 80), WOOD_DARK)
	for rail_y: float in [574.0, 596.0, 618.0]:
		draw_rect(Rect2(chair_x + 2, rail_y, 71, 5), WOOD)
	draw_line(Vector2(chair_x + 10, 676), Vector2(chair_x + 66, 676), WOOD_DARK, 3.0)
	_ellipse(Vector2(chair_x + 38, 641), Vector2(34, 5), Color(0.5, 0.2, 0.18))
	# A knitted blanket thrown over the chair back
	_polygon([Vector2(chair_x + 40, 568), Vector2(chair_x + 78, 570), Vector2(chair_x + 82, 640), Vector2(chair_x + 60, 626)],
		Color(0.32, 0.45, 0.62))
	# Chalk on the wall by the window: the night Agnes found the girl.
	var font := ThemeDB.fallback_font
	draw_string(font, Vector2(432, 612), "3.10.88", HORIZONTAL_ALIGNMENT_LEFT, -1, 22, CHALK)
	draw_string(font, Vector2(436, 632), "found her - A.", HORIZONTAL_ALIGNMENT_LEFT, -1, 13, Color(CHALK, 0.75))
	draw_line(Vector2(430, 616), Vector2(512, 614), Color(CHALK, 0.6), 1.5)
	# Tally of gales Agnes kept, older chalk
	for i in range(6):
		draw_line(Vector2(80 + i * 7, 600), Vector2(80 + i * 7, 620), Color(CHALK, 0.4), 1.5)
	draw_line(Vector2(76, 616), Vector2(120, 604), Color(CHALK, 0.4), 1.5)
	# A coil of rope on a peg by the window
	draw_circle(Vector2(570, 470), 3, IRON)
	for i in range(4):
		draw_arc(Vector2(570, 494), 18 - i * 3, 0, TAU, 16, Color(0.55, 0.45, 0.3), 3.0)


## The small lower landing on the right, with oil cans and a coil of rope.
func _draw_low_landing() -> void:
	for can: Array in [[Vector2(1040, 1020), 1.0], [Vector2(1072, 1020), 1.15], [Vector2(1106, 1020), 0.9], [Vector2(1214, 1020), 1.0]]:
		_draw_oil_can(can[0], can[1])
	draw_circle(Vector2(1180, 900), 3, IRON)
	for i in range(5):
		draw_arc(Vector2(1180, 930), 26 - i * 4, 0, TAU, 18, Color(0.52, 0.42, 0.28), 3.5)


## The stone floor, the door at the bottom, a bench, a coat peg and the lifebelt.
func _draw_ground_floor() -> void:
	# Flagstones
	_vertical_gradient(Rect2(0, GROUND_Y, room_size.x, room_size.y - GROUND_Y), Color(0.27, 0.26, 0.25), Color(0.34, 0.33, 0.31))
	for row in range(3):
		var y := GROUND_Y + 18 + row * 28
		draw_line(Vector2(0, y), Vector2(room_size.x, y), Color(0.16, 0.15, 0.15), 1.5)
		for i in range(12):
			var x := 40.0 + i * 110.0 + (55.0 if row % 2 == 1 else 0.0)
			draw_line(Vector2(x, y - 28 if row > 0 else GROUND_Y), Vector2(x, y), Color(0.16, 0.15, 0.15), 1.5)
	draw_rect(Rect2(0, GROUND_Y - 4, room_size.x, 6), Color(0.2, 0.2, 0.22))
	# The heavy door at the bottom of the tower, rain seeping under it
	var door := DOOR_RECT
	draw_rect(door.grow(10), Color(0.5, 0.5, 0.52))
	draw_circle(Vector2(door.get_center().x, door.position.y), door.size.x / 2.0 + 10, Color(0.5, 0.5, 0.52))
	draw_rect(door, WOOD)
	draw_circle(Vector2(door.get_center().x, door.position.y), door.size.x / 2.0, WOOD)
	for i in range(1, 5):
		var px := door.position.x + i * door.size.x / 5.0
		draw_line(Vector2(px, door.position.y - 50), Vector2(px, door.end.y), WOOD_DARK, 2.0)
	for band_y: float in [door.position.y + 30, door.end.y - 50]:
		draw_rect(Rect2(door.position.x, band_y, door.size.x, 8), IRON)
		for i in range(5):
			draw_circle(Vector2(door.position.x + 14 + i * 25, band_y + 4), 2.5, IRON_LIGHT)
	draw_circle(Vector2(door.end.x - 22, door.get_center().y + 20), 6, IRON_LIGHT)
	_ellipse(Vector2(door.get_center().x, GROUND_Y + 10), Vector2(80, 8), Color(0.3, 0.4, 0.45, 0.4))
	# Coat peg with an oilskin coat hanging beside the door
	draw_rect(Rect2(296, 1140, 90, 8), WOOD_DARK)
	for peg_x: float in [310.0, 340.0, 370.0]:
		draw_rect(Rect2(peg_x, 1148, 5, 10), WOOD_LIGHT)
	_polygon([Vector2(360, 1150), Vector2(382, 1152), Vector2(396, 1262), Vector2(352, 1270), Vector2(346, 1200)],
		Color(0.7, 0.55, 0.14))
	draw_line(Vector2(366, 1160), Vector2(372, 1262), Color(0.5, 0.38, 0.08), 1.5)
	# Big coils of rope on the floor: rings of rope stacked up
	for coil: Vector2 in [Vector2(318, 1334), Vector2(394, 1336)]:
		_ellipse(coil + Vector2(0, 2), Vector2(32, 8), Color(0, 0, 0, 0.3))
		for i in range(5):
			var ring := PlaceholderArt.ellipse_points(coil + Vector2(0, -i * 5), 28.0 - i * 1.5, 8.0, 20)
			ring.append(ring[0])
			draw_polyline(ring, Color(0.36, 0.28, 0.18), 5.0)
			draw_polyline(ring, Color(0.6, 0.5, 0.32), 2.5)
		_ellipse(coil + Vector2(0, -22), Vector2(12, 3), Color(0.12, 0.1, 0.08))
		draw_line(coil + Vector2(24, -18), coil + Vector2(40, 2), Color(0.6, 0.5, 0.32), 3.0)
	# A wooden bench under the low window
	draw_rect(Rect2(430, 1288, 160, 10), WOOD_LIGHT)
	for leg_x: float in [440.0, 570.0]:
		draw_rect(Rect2(leg_x, 1298, 8, GROUND_Y - 1298), WOOD_DARK)
	# The lifebelt the girl was clinging to, hung on the wall
	var belt := Vector2(420, 1030)
	draw_circle(belt + Vector2(3, 4), 34, Color(0, 0, 0, 0.3))
	draw_arc(belt, 26, 0, TAU, 32, Color(0.9, 0.88, 0.82), 16.0)
	for i in range(4):
		draw_arc(belt, 26, i * PI / 2.0, i * PI / 2.0 + PI / 5.0, 8, Color(0.75, 0.2, 0.16), 16.0)
	draw_arc(belt, 34, PI * 0.15, PI * 0.85, 12, Color(0.6, 0.55, 0.45), 2.0)
	draw_string(ThemeDB.fallback_font, belt + Vector2(-44, 52), "LADY MARGARET", HORIZONTAL_ALIGNMENT_LEFT, -1, 12,
		Color(0.85, 0.82, 0.75, 0.85))


## One iron flight of open-tread steps from `start` (top) down to `end`.
func _draw_flight(start: Vector2, end: Vector2) -> void:
	var direction := signf(end.x - start.x)
	var run := absf(end.x - start.x) / STEPS
	var rise := (end.y - start.y) / STEPS
	# The stringer: a thick iron band under the steps, bolted to the wall
	var under := PackedVector2Array([start + Vector2(0, rise + 6), end + Vector2(0, 6), end + Vector2(0, 24), start + Vector2(0, rise + 24)])
	draw_colored_polygon(under, IRON)
	draw_line(start + Vector2(0, rise + 24), end + Vector2(0, 24), IRON_DARK, 2.0)
	for i in range(0, STEPS, 3):
		var bolt := start.lerp(end, (i + 0.5) / STEPS) + Vector2(0, rise * 0.5 + 15)
		draw_circle(bolt, 2.5, IRON_LIGHT)
	# Shadow of the stair on the wall behind
	draw_line(start + Vector2(direction * -10, rise + 40), end + Vector2(direction * -10, 40), Color(0, 0, 0, 0.18), 10.0)
	# Treads: checker-plate iron with a lighter front edge
	for i in range(STEPS):
		var x0 := start.x + direction * run * i
		var x1 := x0 + direction * run
		var y := start.y + rise * (i + 1)
		var left := minf(x0, x1)
		draw_rect(Rect2(left, y - 2, run, 8), IRON)
		draw_rect(Rect2(left, y - 4, run, 3), IRON_LIGHT)
		for k in range(3):
			draw_line(Vector2(left + 4 + k * run / 3.0, y + 1), Vector2(left + 8 + k * run / 3.0, y + 3), IRON_DARK, 1.0)
		# The open riser (an iron strap up to the step above)
		draw_line(Vector2(x0, y - rise), Vector2(x0, y), Color(IRON_DARK, 0.8), 2.0)


## The handrail and balusters on the open side of a flight (drawn in front).
func _draw_flight_rail(start: Vector2, end: Vector2) -> void:
	var direction := signf(end.x - start.x)
	var run := absf(end.x - start.x) / STEPS
	var rise := (end.y - start.y) / STEPS
	var top_start := start + Vector2(0, rise - RAIL_HEIGHT)
	var top_end := end + Vector2(0, -RAIL_HEIGHT)
	draw_line(top_start, top_end, IRON_DARK, 5.0)
	draw_line(top_start + Vector2(0, -1.5), top_end + Vector2(0, -1.5), IRON_LIGHT, 1.5)
	for i in range(0, STEPS, 2):
		var x := start.x + direction * run * (i + 0.5)
		var y := start.y + rise * (i + 1)
		draw_line(Vector2(x, y - 2), Vector2(x, y - RAIL_HEIGHT), IRON, 2.0)


## The thick iron edge of a landing floor.
func _draw_landing_slab(landing: Rect2) -> void:
	draw_rect(landing, IRON)
	draw_rect(Rect2(landing.position, Vector2(landing.size.x, 4)), IRON_LIGHT)
	draw_rect(Rect2(landing.position.x, landing.end.y, landing.size.x, 6), Color(0, 0, 0, 0.3))
	for x in range(int(landing.position.x) + 12, int(landing.end.x), 36):
		draw_circle(Vector2(x, landing.position.y + 12), 1.8, IRON_LIGHT)


## A dented oil can standing on a landing (scenery only).
func _draw_oil_can(bottom: Vector2, can_scale: float) -> void:
	var w := 22.0 * can_scale
	var h := 34.0 * can_scale
	var body := Rect2(bottom.x - w / 2.0, bottom.y - h, w, h)
	draw_rect(body, Color(0.36, 0.38, 0.3))
	draw_rect(Rect2(body.position, Vector2(4, h)), Color(0.48, 0.5, 0.4))
	draw_rect(Rect2(body.position.x, body.position.y + h * 0.35, w, 7 * can_scale), Color(0.55, 0.2, 0.15))
	draw_rect(Rect2(bottom.x - 3, body.position.y - 6, 6, 6), Color(0.3, 0.3, 0.28))
	draw_line(body.position + Vector2(2, 0), body.position + Vector2(w - 2, 0), Color(0.22, 0.22, 0.2), 2.0)
