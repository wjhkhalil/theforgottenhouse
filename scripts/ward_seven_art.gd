@tool
class_name WardSevenArt
extends RoomArt
## Placeholder drawing of House Three, Chapter Seven: Ward Seven, the long
## ward under the roof of Hollowmere Sanatorium. See room_art.gd for how to
## replace it with a real image.
##
## The ward is drawn TWO SCREENS WIDE (2560 x 720). Seven iron beds stand in a
## row along the back wall, one every 300 px (260, 560 ... 2060), and a patient
## sits up in each: Toby, Ruth, Albert, Ivy, Sam, Dora and Winnie. (Keepsakes
## draws what they want above their heads; nothing here goes in that space.)
##
## Layout, left to right: the steel door from the X-ray room, bed 1 with the
## chart at its foot, a barred window over Toby's locker, the brass plate
## (WARD 7 - ENDOWED 1923: the code of the restraint cupboard) over Ruth's
## locker, a second window over Albert's locker, the restraint cupboard on the
## wall, a stopped clock, a third window over the tall nurses' locker, the
## shuttered end window, the fire bucket, the fire bell box and, behind the
## objective list, the end wall with the open door of the fire stair.
## On the bare boards in front of the beds: the linen chest, the medicine
## trolley, the nurses' desk (lamp, drawer, confiscation box) and the strongbox.

const FLOOR_Y := 540.0
const DADO_Y := 346.0
const CEILING_Y := 66.0
const BED_FIRST_X := 260.0
const BED_SPACING := 300.0
const BED_COUNT := 7
const MATTRESS_Y := 450.0
const END_WALL_X := 2270.0
const WINDOW_XS: Array[float] = [410.0, 1010.0, 1610.0]
const LOCKER_XS: Array[float] = [410.0, 710.0, 1010.0]
const PLATE_RECT := Rect2(585, 150, 250, 46)
const CUPBOARD_RECT := Rect2(1275, 170, 70, 100)
const SHUTTER_RECT := Rect2(1865, 150, 90, 120)
const BELL_BOX_RECT := Rect2(2170, 175, 60, 70)
const BUCKET_HOOK := Vector2(2130, 284)
const DESK_TOP_RECT := Rect2(1196, 600, 208, 10)
const DESK_FRONT_RECT := Rect2(1204, 610, 192, 80)
const LAMP_AT := Vector2(1232, 580)
const STAIR_DOOR_RECT := Rect2(2340, 300, 110, 240)

const IRON := Color(0.13, 0.14, 0.16)
const IRON_LIGHT := Color(0.32, 0.34, 0.38)
const ENAMEL := Color(0.84, 0.86, 0.83)
const LINEN := Color(0.82, 0.83, 0.8)
const BLANKET := Color(0.4, 0.42, 0.44)
const BLANKET_DARK := Color(0.27, 0.29, 0.31)
const SMOCK := Color(0.6, 0.62, 0.62)
const SMOCK_DARK := Color(0.44, 0.46, 0.47)
const SKIN := Color(0.86, 0.76, 0.68)
const SKIN_DARK := Color(0.68, 0.57, 0.5)
const WOOD := Color(0.34, 0.23, 0.14)
const WOOD_DARK := Color(0.19, 0.12, 0.08)
const BRASS := Color(0.78, 0.6, 0.28)
const BRASS_DARK := Color(0.42, 0.3, 0.12)
const INK := Color(0.12, 0.12, 0.16)
const MOONLIGHT := Color(0.62, 0.72, 0.92)
const LAMP := Color(1.0, 0.8, 0.46)

## One entry per patient: how big they are, half the width of their shoulders,
## how far the head leans, and the colour of their hair.
const PATIENT_BUILD: Array[float] = [0.9, 1.0, 0.96, 0.94, 1.04, 1.0, 0.78]
const PATIENT_SHOULDERS: Array[float] = [24.0, 26.0, 27.0, 24.0, 33.0, 29.0, 19.0]
const PATIENT_LEAN: Array[float] = [3.0, 0.0, 6.0, -2.0, 0.0, 2.0, 0.0]
const PATIENT_HAIR: Array[Color] = [
	Color(0.36, 0.22, 0.12), Color(0.14, 0.1, 0.09), Color(0.9, 0.9, 0.88), Color(0.88, 0.76, 0.42),
	Color(0.2, 0.14, 0.1), Color(0.44, 0.38, 0.34), Color(0.5, 0.26, 0.12),
]


func _init() -> void:
	room_size = Vector2(2560, 720)


func _draw_background() -> void:
	_draw_walls()
	_draw_roof_beams()
	_draw_floor()
	_draw_steel_door()
	for window_x: float in WINDOW_XS:
		_draw_barred_window(window_x)
	_draw_brass_plate()
	_draw_wall_fittings()
	_draw_shutter_window()
	_draw_fire_end()
	_draw_end_wall()
	for i in range(BED_COUNT):
		var bed_x := BED_FIRST_X + i * BED_SPACING
		_draw_bed(bed_x, i)
		_draw_patient(i, bed_x)
		_draw_blanket(bed_x, i)
	_draw_bedside_lockers()
	_draw_nurses_desk()
	_draw_floor_things()
	_draw_light()


func _draw_foreground() -> void:
	_draw_vignette()


# ---------------------------------------------------------------------------

## Cold grey-green distemper above a dark painted dado.
func _draw_walls() -> void:
	_vertical_gradient(Rect2(0, 0, room_size.x, DADO_Y), Color(0.17, 0.21, 0.24), Color(0.3, 0.36, 0.38))
	_vertical_gradient(Rect2(0, DADO_Y, room_size.x, FLOOR_Y - DADO_Y), Color(0.15, 0.21, 0.21), Color(0.1, 0.15, 0.15))
	draw_rect(Rect2(0, DADO_Y - 4, room_size.x, 6), Color(0.07, 0.1, 0.1))
	# Damp stains and cracks in the plaster
	var rng := RandomNumberGenerator.new()
	rng.seed = 1923
	for i in range(26):
		var stain := Vector2(rng.randf_range(0.0, room_size.x), rng.randf_range(CEILING_Y + 6.0, 150.0))
		_ellipse(stain, Vector2(rng.randf_range(20.0, 60.0), rng.randf_range(8.0, 22.0)), Color(0.1, 0.13, 0.15, 0.22))
	for i in range(12):
		var crack := Vector2(rng.randf_range(0.0, room_size.x), CEILING_Y)
		draw_polyline(PackedVector2Array([crack, crack + Vector2(6, 22), crack + Vector2(-3, 40), crack + Vector2(8, 66)]),
			Color(0.08, 0.1, 0.12, 0.6), 1.0)
	# The skirting board
	draw_rect(Rect2(0, FLOOR_Y - 10, room_size.x, 10), Color(0.06, 0.08, 0.08))


## The underside of the roof: dark rafters, a tie beam and three unlit lamps.
func _draw_roof_beams() -> void:
	draw_rect(Rect2(0, 0, room_size.x, CEILING_Y), Color(0.07, 0.07, 0.08))
	var x := -40.0
	while x < room_size.x:
		draw_line(Vector2(x, CEILING_Y), Vector2(x + 70, 0), Color(0.16, 0.12, 0.09), 7.0)
		x += 160.0
	draw_rect(Rect2(0, CEILING_Y - 6, room_size.x, 10), Color(0.13, 0.1, 0.08))
	draw_line(Vector2(0, CEILING_Y + 4), Vector2(room_size.x, CEILING_Y + 4), Color(0.03, 0.03, 0.03), 1.5)
	for lamp_x: float in [560.0, 1160.0, 1760.0]:
		draw_line(Vector2(lamp_x, CEILING_Y), Vector2(lamp_x, 96), IRON, 2.0)
		_polygon([Vector2(lamp_x - 22, 112), Vector2(lamp_x + 22, 112), Vector2(lamp_x + 9, 96), Vector2(lamp_x - 9, 96)],
			ENAMEL.darkened(0.45))
		draw_circle(Vector2(lamp_x, 114), 5.0, Color(0.3, 0.32, 0.3))


## Bare scrubbed boards running the length of the ward.
func _draw_floor() -> void:
	_vertical_gradient(Rect2(0, FLOOR_Y, room_size.x, room_size.y - FLOOR_Y), Color(0.24, 0.2, 0.17), Color(0.15, 0.12, 0.1))
	var rows: Array[float] = [540.0, 558.0, 582.0, 614.0, 656.0, 720.0]
	var rng := RandomNumberGenerator.new()
	rng.seed = 707
	for row in range(rows.size() - 1):
		draw_line(Vector2(0, rows[row]), Vector2(room_size.x, rows[row]), Color(0.08, 0.06, 0.05), 1.5)
		var x := rng.randf_range(0.0, 200.0)
		while x < room_size.x:
			draw_line(Vector2(x, rows[row]), Vector2(x, rows[row + 1]), Color(0.08, 0.06, 0.05, 0.8), 1.0)
			draw_circle(Vector2(x + 5, rows[row] + 5), 1.0, Color(0.05, 0.04, 0.04))
			x += rng.randf_range(220.0, 380.0)
	# A path worn pale down the middle by seven years of slippers
	draw_rect(Rect2(0, 560, room_size.x, 30), Color(1, 1, 1, 0.025))


## The steel door from the X-ray room, at the left end.
func _draw_steel_door() -> void:
	var door := Rect2(26, 318, 98, 222)
	draw_rect(door.grow(8), Color(0.2, 0.22, 0.25))
	draw_rect(door, Color(0.3, 0.33, 0.36))
	draw_rect(Rect2(door.position.x + 8, door.position.y + 10, door.size.x - 16, 80), Color(0.25, 0.28, 0.31), false, 2.0)
	draw_rect(Rect2(door.position.x + 8, door.position.y + 110, door.size.x - 16, 100), Color(0.25, 0.28, 0.31), false, 2.0)
	for rivet_y in range(int(door.position.y) + 10, int(door.end.y), 30):
		draw_circle(Vector2(door.position.x - 4, rivet_y), 2.0, IRON_LIGHT)
		draw_circle(Vector2(door.end.x + 4, rivet_y), 2.0, IRON_LIGHT)
	# The spy hatch and the handle
	draw_rect(Rect2(door.position.x + 34, door.position.y + 30, 30, 12), Color(0.04, 0.04, 0.05))
	draw_rect(Rect2(door.end.x - 20, door.position.y + 112, 8, 22), IRON)
	# It stands ajar: a strip of darkness down one edge
	draw_rect(Rect2(door.position.x, door.position.y, 6, door.size.y), Color(0, 0, 0, 0.75))


## One tall barred window with the night sky behind it.
func _draw_barred_window(window_x: float) -> void:
	var frame := Rect2(window_x - 42, 96, 84, 236)
	var glass := frame.grow(-6)
	draw_rect(frame, Color(0.1, 0.12, 0.13))
	_vertical_gradient(glass, Color(0.05, 0.08, 0.17), Color(0.16, 0.22, 0.36))
	if window_x < 500.0:
		# The moon stands in the first window
		_glow(Vector2(window_x + 8, 150), 16, 4, 6, Color(0.8, 0.86, 1.0, 0.06))
		draw_circle(Vector2(window_x + 8, 150), 14, Color(0.9, 0.92, 0.98))
		draw_circle(Vector2(window_x + 3, 146), 3.0, Color(0.76, 0.8, 0.88))
	else:
		for star: Vector2 in [Vector2(-20, 130), Vector2(14, 170), Vector2(-6, 220), Vector2(22, 260)]:
			draw_circle(Vector2(window_x + star.x, star.y), 1.2, Color(1, 1, 1, 0.7))
	# The line of the moor
	_polygon([Vector2(glass.position.x, 300), Vector2(window_x - 6, 286), Vector2(glass.end.x, 296),
		Vector2(glass.end.x, glass.end.y), Vector2(glass.position.x, glass.end.y)], Color(0.03, 0.05, 0.08))
	# Glazing bars, then the iron bars in front of them
	draw_line(Vector2(glass.position.x, 214), Vector2(glass.end.x, 214), Color(0.1, 0.12, 0.13), 3.0)
	for i in range(4):
		var bar_x := glass.position.x + 14.4 * (i + 1) - 7.0
		draw_line(Vector2(bar_x, glass.position.y), Vector2(bar_x, glass.end.y), IRON, 4.0)
		draw_line(Vector2(bar_x - 1, glass.position.y), Vector2(bar_x - 1, glass.end.y), IRON_LIGHT, 1.0)
	for bar_y: float in [140.0, 280.0]:
		draw_line(Vector2(glass.position.x, bar_y), Vector2(glass.end.x, bar_y), IRON, 4.0)
	draw_rect(Rect2(window_x - 48, 330, 96, 8), Color(0.07, 0.09, 0.1))


## The brass plate on the back wall. Its year is the code of the restraint cupboard.
func _draw_brass_plate() -> void:
	draw_rect(PLATE_RECT.grow(5), WOOD_DARK)
	draw_rect(PLATE_RECT, BRASS)
	draw_rect(PLATE_RECT.grow(-4), BRASS_DARK, false, 1.5)
	draw_rect(Rect2(PLATE_RECT.position, Vector2(PLATE_RECT.size.x, 4)), BRASS.lightened(0.3))
	for screw: Vector2 in [Vector2(10, 10), Vector2(240, 10), Vector2(10, 36), Vector2(240, 36)]:
		draw_circle(PLATE_RECT.position + screw, 2.5, BRASS_DARK)
	draw_string(ThemeDB.fallback_font, PLATE_RECT.position + Vector2(0, 30), "WARD 7 - ENDOWED 1923",
		HORIZONTAL_ALIGNMENT_CENTER, PLATE_RECT.size.x, 17, Color(0.16, 0.1, 0.04))


## What the restraint cupboard hangs on, and the stopped ward clock.
func _draw_wall_fittings() -> void:
	# A dark board behind the restraint cupboard, and a rail under it
	draw_rect(CUPBOARD_RECT.grow(6), Color(0, 0, 0, 0.35))
	draw_rect(Rect2(CUPBOARD_RECT.position.x - 10, CUPBOARD_RECT.end.y + 4, CUPBOARD_RECT.size.x + 20, 6), WOOD_DARK)
	for bracket_x: float in [CUPBOARD_RECT.position.x, CUPBOARD_RECT.end.x - 6.0]:
		draw_rect(Rect2(bracket_x, CUPBOARD_RECT.end.y + 10, 6, 12), WOOD_DARK)
	# The ward clock, stopped at ten to three
	var clock := Vector2(1460, 150)
	draw_circle(clock, 28, WOOD_DARK)
	draw_circle(clock, 23, Color(0.86, 0.85, 0.78))
	for i in range(12):
		var direction := Vector2.from_angle(TAU * i / 12.0)
		draw_line(clock + direction * 18.0, clock + direction * 21.0, INK, 1.5)
	draw_line(clock, clock + Vector2(9, -8), INK, 3.0)
	draw_line(clock, clock + Vector2(-17, -6), INK, 2.0)
	# A row of seven numbered coat pegs with nothing on them
	draw_rect(Rect2(150, 236, 190, 8), WOOD_DARK)
	for i in range(7):
		draw_line(Vector2(162 + i * 27.0, 240), Vector2(162 + i * 27.0, 252), IRON, 3.0)
	# A printed card of rules above Dora's bed
	draw_rect(Rect2(1722, 150, 76, 96), Color(0.8, 0.78, 0.68))
	draw_rect(Rect2(1722, 150, 76, 96), WOOD_DARK, false, 2.0)
	draw_string(ThemeDB.fallback_font, Vector2(1722, 170), "RULES", HORIZONTAL_ALIGNMENT_CENTER, 76, 12, Color(0.5, 0.1, 0.1))
	for i in range(7):
		draw_line(Vector2(1732, 182 + i * 8.0), Vector2(1788 - (i % 3) * 8.0, 182 + i * 8.0), Color(0.3, 0.3, 0.34), 1.0)


## The stone reveal of the end window (the iron shutter is screwed over it).
func _draw_shutter_window() -> void:
	var reveal := SHUTTER_RECT.grow(9)
	draw_rect(reveal, Color(0.1, 0.12, 0.13))
	draw_rect(SHUTTER_RECT, Color(0.05, 0.07, 0.12))
	draw_rect(Rect2(reveal.position.x - 6, reveal.end.y, reveal.size.x + 12, 8), Color(0.07, 0.09, 0.1))
	# Rust streaks running down the wall from the shutter
	for streak_x: float in [1876.0, 1912.0, 1944.0]:
		draw_line(Vector2(streak_x, reveal.end.y + 8), Vector2(streak_x + 2, reveal.end.y + 40), Color(0.4, 0.2, 0.1, 0.35), 2.0)
	# A thread of moonlight where the shutter does not quite fit
	draw_line(Vector2(reveal.position.x + 4, SHUTTER_RECT.position.y), Vector2(reveal.position.x + 4, SHUTTER_RECT.end.y),
		Color(MOONLIGHT, 0.5), 1.0)


## The far right end: the hook for the fire bucket and the board of the fire bell box.
func _draw_fire_end() -> void:
	# The red-painted board and hook the bucket hangs on
	draw_rect(Rect2(BUCKET_HOOK.x - 20, BUCKET_HOOK.y - 12, 40, 50), Color(0.3, 0.07, 0.06))
	draw_rect(Rect2(BUCKET_HOOK.x - 20, BUCKET_HOOK.y - 12, 40, 50), Color(0.14, 0.03, 0.03), false, 1.5)
	draw_arc(BUCKET_HOOK, 5.0, 0.0, PI, 8, IRON, 3.0, true)
	draw_rect(Rect2(BUCKET_HOOK.x - 2, BUCKET_HOOK.y - 9, 4, 9), IRON)
	# The board behind the fire bell box, its sign, and the bell chain up through the roof
	draw_rect(BELL_BOX_RECT.grow(6), Color(0.08, 0.03, 0.03))
	draw_line(Vector2(BELL_BOX_RECT.get_center().x, BELL_BOX_RECT.position.y - 6),
		Vector2(BELL_BOX_RECT.get_center().x, CEILING_Y), IRON, 3.0)
	for link_y in range(int(CEILING_Y) + 6, 126, 10):
		draw_circle(Vector2(BELL_BOX_RECT.get_center().x, link_y), 2.5, IRON_LIGHT)
	var sign_rect := Rect2(BELL_BOX_RECT.position.x - 12, BELL_BOX_RECT.position.y - 42, 84, 22)
	draw_rect(sign_rect, ENAMEL)
	draw_rect(sign_rect, Color(0.6, 0.1, 0.08), false, 2.0)
	draw_string(ThemeDB.fallback_font, sign_rect.position + Vector2(0, 16), "FIRE BELL", HORIZONTAL_ALIGNMENT_CENTER,
		sign_rect.size.x, 13, Color(0.6, 0.1, 0.08))


## The end wall and the open door at the top of the fire stair (behind the objective list).
func _draw_end_wall() -> void:
	draw_rect(Rect2(END_WALL_X, CEILING_Y, room_size.x - END_WALL_X, FLOOR_Y - CEILING_Y), Color(0, 0, 0, 0.28))
	draw_line(Vector2(END_WALL_X, CEILING_Y), Vector2(END_WALL_X, FLOOR_Y), Color(0.04, 0.05, 0.06), 3.0)
	# The doorway: night sky and the iron rail of the stair going down
	draw_rect(STAIR_DOOR_RECT.grow(8), Color(0.08, 0.09, 0.1))
	_vertical_gradient(STAIR_DOOR_RECT, Color(0.06, 0.09, 0.18), Color(0.15, 0.2, 0.32))
	draw_rect(Rect2(STAIR_DOOR_RECT.position.x, FLOOR_Y - 14, STAIR_DOOR_RECT.size.x, 14), IRON)
	draw_line(Vector2(2352, 440), Vector2(2448, 500), IRON, 4.0)
	for i in range(5):
		var post_x := 2356.0 + i * 21.0
		draw_line(Vector2(post_x, 442 + i * 13.0), Vector2(post_x, FLOOR_Y - 14), IRON, 2.5)
	draw_circle(Vector2(2420, 340), 1.3, Color(1, 1, 1, 0.8))
	draw_circle(Vector2(2380, 372), 1.0, Color(1, 1, 1, 0.6))
	# The door itself, thrown wide open
	_polygon([Vector2(2458, 296), Vector2(2516, 312), Vector2(2516, 560), Vector2(2458, 544)], Color(0.14, 0.24, 0.2))
	draw_line(Vector2(2458, 296), Vector2(2458, 544), Color(0.06, 0.1, 0.09), 2.0)
	draw_rect(Rect2(2500, 420, 6, 18), BRASS_DARK)
	# The sign above it
	var sign_rect := Rect2(2338, 258, 114, 24)
	draw_rect(sign_rect, ENAMEL.darkened(0.2))
	draw_string(ThemeDB.fallback_font, sign_rect.position + Vector2(0, 17), "FIRE STAIR", HORIZONTAL_ALIGNMENT_CENTER,
		sign_rect.size.x, 13, Color(0.1, 0.3, 0.2))
	# A nurse's cap dropped on the floor by the door
	_ellipse(Vector2(2310, 572), Vector2(16, 5), Color(0, 0, 0, 0.35))
	_polygon([Vector2(2296, 570), Vector2(2304, 554), Vector2(2320, 556), Vector2(2326, 570)], ENAMEL)


## One iron bedstead (headboard on the left) with its mattress and pillow.
func _draw_bed(bed_x: float, index: int) -> void:
	_ellipse(Vector2(bed_x, FLOOR_Y + 8), Vector2(124, 8), Color(0, 0, 0, 0.4))
	draw_rect(Rect2(bed_x - 104, 478, 208, 62), Color(0, 0, 0, 0.3))
	# Headboard: two posts, a curved top rail and upright bars
	for post_x: float in [bed_x - 112.0, bed_x - 92.0]:
		draw_rect(Rect2(post_x, 362, 5, FLOOR_Y + 6 - 362), IRON)
		draw_circle(Vector2(post_x + 2.5, 360), 4.5, BRASS)
	draw_line(Vector2(bed_x - 110, 372), Vector2(bed_x - 90, 372), IRON, 4.0)
	for bar: float in [-104.0, -99.0]:
		draw_line(Vector2(bed_x + bar, 372), Vector2(bed_x + bar, 452), IRON_LIGHT, 1.5)
	# Footboard, lower
	draw_rect(Rect2(bed_x + 105, 418, 5, FLOOR_Y + 6 - 418), IRON)
	draw_circle(Vector2(bed_x + 107.5, 416), 4.5, BRASS)
	draw_rect(Rect2(bed_x - 87, 478, 4, FLOOR_Y + 2 - 478), IRON)
	# Castors
	for castor_x: float in [bed_x - 109.5, bed_x + 107.5]:
		draw_circle(Vector2(castor_x, FLOOR_Y + 6), 4.0, Color(0.05, 0.05, 0.06))
	# Striped ticking mattress on the side rail
	_rounded_rect(Rect2(bed_x - 106, MATTRESS_Y, 212, 24), LINEN.darkened(0.12), 6)
	for i in range(10):
		draw_line(Vector2(bed_x - 98 + i * 21.0, MATTRESS_Y + 3), Vector2(bed_x - 98 + i * 21.0, MATTRESS_Y + 21),
			Color(0.4, 0.46, 0.6, 0.5), 1.5)
	draw_rect(Rect2(bed_x - 110, 472, 220, 6), IRON)
	draw_line(Vector2(bed_x - 110, 472), Vector2(bed_x + 110, 472), IRON_LIGHT, 1.0)
	# A thin pillow propped against the headboard
	_polygon([Vector2(bed_x - 90, 394), Vector2(bed_x - 60, 400), Vector2(bed_x - 38, MATTRESS_Y + 2),
		Vector2(bed_x - 90, MATTRESS_Y + 2)], LINEN)
	draw_line(Vector2(bed_x - 90, 394), Vector2(bed_x - 60, 400), Color(1, 1, 1, 0.6), 1.5)
	draw_line(Vector2(bed_x - 60, 400), Vector2(bed_x - 38, MATTRESS_Y + 2), LINEN.darkened(0.25), 1.5)
	# The bed number on an enamel disc at the head
	draw_circle(Vector2(bed_x - 101, 386), 7.0, ENAMEL)
	draw_string(ThemeDB.fallback_font, Vector2(bed_x - 104.5, 390), str(index + 1), HORIZONTAL_ALIGNMENT_LEFT, -1, 10, INK)
	if index == 0:
		# The hook on the rail that the bed chart hangs from
		draw_line(Vector2(bed_x + 90, 474), Vector2(bed_x + 90, 486), IRON_LIGHT, 2.0)


## One patient sitting up in bed in a grey smock. Faces are kept very simple.
func _draw_patient(index: int, bed_x: float) -> void:
	var build: float = PATIENT_BUILD[index]
	var half: float = PATIENT_SHOULDERS[index]
	var lean: float = PATIENT_LEAN[index]
	var hair: Color = PATIENT_HAIR[index]
	var shoulder_y := MATTRESS_Y - 58.0 * build
	var radius := 14.0 * build
	var head := Vector2(bed_x + lean, shoulder_y - radius - 1.0)
	# Hair that hangs behind the shoulders
	match index:
		1:
			_ellipse(head + Vector2(0, 3), Vector2(radius * 1.2, radius * 1.15), hair)
		3:
			_rounded_rect(Rect2(head.x - radius * 1.25, head.y - radius, radius * 2.5, radius * 3.3), hair, 10)
		5:
			_ellipse(head + Vector2(0, 2), Vector2(radius * 1.12, radius * 1.08), hair)
		6:
			for side: float in [-1.0, 1.0]:
				draw_line(head + Vector2(side * radius * 0.9, 0), head + Vector2(side * radius * 1.25, radius * 2.3), hair, 5.0)
				draw_circle(head + Vector2(side * radius * 1.25, radius * 2.3), 3.0, hair.darkened(0.2))
	# The smock: shoulders, body and arms
	var body: Array[Vector2] = [
		Vector2(bed_x + lean - half, shoulder_y + 6), Vector2(bed_x + lean - half * 0.55, shoulder_y),
		Vector2(bed_x + lean + half * 0.55, shoulder_y), Vector2(bed_x + lean + half, shoulder_y + 6),
		Vector2(bed_x + half * 0.92, MATTRESS_Y + 2), Vector2(bed_x - half * 0.92, MATTRESS_Y + 2),
	]
	_polygon(body, SMOCK)
	for side: float in [-1.0, 1.0]:
		draw_line(Vector2(bed_x + lean + side * (half - 3.0), shoulder_y + 9), Vector2(bed_x + side * half * 0.7, MATTRESS_Y - 4),
			SMOCK_DARK, 5.0 * build)
	draw_line(Vector2(bed_x + lean - 7 * build, shoulder_y), Vector2(bed_x + lean, shoulder_y + 10 * build), SMOCK_DARK, 1.5)
	draw_line(Vector2(bed_x + lean + 7 * build, shoulder_y), Vector2(bed_x + lean, shoulder_y + 10 * build), SMOCK_DARK, 1.5)
	# The number sewn on in place of a name
	draw_rect(Rect2(bed_x + lean + 5, shoulder_y + 16 * build, 11, 11), LINEN)
	draw_string(ThemeDB.fallback_font, Vector2(bed_x + lean + 7.5, shoulder_y + 16 * build + 9.5), str(index + 1),
		HORIZONTAL_ALIGNMENT_LEFT, -1, 9, INK)
	if index == 5:
		# Dora's dark shawl
		draw_line(Vector2(bed_x + lean - half, shoulder_y + 7), Vector2(bed_x + lean - 2, shoulder_y + 34), Color(0.2, 0.18, 0.24), 8.0)
		draw_line(Vector2(bed_x + lean + half, shoulder_y + 7), Vector2(bed_x + lean + 2, shoulder_y + 34), Color(0.2, 0.18, 0.24), 8.0)
	# Hands on the blanket
	draw_circle(Vector2(bed_x - half * 0.7, MATTRESS_Y - 5), 4.0 * build, SKIN)
	draw_circle(Vector2(bed_x + half * 0.7, MATTRESS_Y - 5), 4.0 * build if index != 2 else 5.5, SKIN if index != 2 else SKIN_DARK)
	# Neck and head
	draw_rect(Rect2(head.x - 4.5 * build, head.y + radius - 4, 9 * build, 7), SKIN_DARK)
	draw_circle(head, radius, SKIN)
	if index != 2:
		_ellipse(head + Vector2(0, -radius * 0.6), Vector2(radius * 1.04, radius * 0.52), hair)
	match index:
		0:
			# Toby: a tousled boy
			for tuft: float in [-6.0, -1.0, 5.0]:
				draw_line(head + Vector2(tuft, -radius * 0.9), head + Vector2(tuft + 3, -radius * 1.35), hair, 3.0)
			draw_line(head + Vector2(-radius, -radius * 0.4), head + Vector2(-radius * 0.5, -radius * 0.1), hair, 3.0)
		1:
			# Ruth: dark hair drawn back into a knot
			draw_circle(head + Vector2(-radius * 0.95, -radius * 0.75), radius * 0.42, hair)
		2:
			# Albert: bald, white at the sides, a white moustache
			for side: float in [-1.0, 1.0]:
				_ellipse(head + Vector2(side * radius * 0.95, -radius * 0.1), Vector2(3.5, 6.0), hair)
			draw_line(head + Vector2(-6, radius * 0.42), head + Vector2(6, radius * 0.42), hair, 3.5)
			draw_line(head + Vector2(-7, -radius * 0.12), head + Vector2(-2, -radius * 0.16), hair, 1.5)
			draw_line(head + Vector2(2, -radius * 0.16), head + Vector2(7, -radius * 0.12), hair, 1.5)
		3:
			# Ivy: long fair hair falling over her face on one side
			draw_line(head + Vector2(-radius * 0.95, -radius * 0.5), head + Vector2(-radius * 1.0, radius * 1.6), hair, 5.0)
			draw_line(head + Vector2(radius * 0.95, -radius * 0.5), head + Vector2(radius * 1.0, radius * 1.6), hair, 5.0)
		4:
			# Sam: cropped hair and a heavy jaw
			draw_line(head + Vector2(-radius * 0.7, radius * 0.8), head + Vector2(radius * 0.7, radius * 0.8), SKIN_DARK, 1.5)
		5:
			# Dora: greying hair parted in the middle
			draw_line(head + Vector2(0, -radius), head + Vector2(0, -radius * 0.2), hair.darkened(0.4), 1.0)
		6:
			# Winnie: a fringe above the plaits
			draw_rect(Rect2(head.x - radius * 0.8, head.y - radius * 0.4, radius * 1.6, 3), hair)
	# Eyes and mouth
	var eye_y := radius * 0.18
	draw_circle(head + Vector2(-radius * 0.36, eye_y), 1.3, INK)
	draw_circle(head + Vector2(radius * 0.36, eye_y), 1.3, INK)
	if index != 2:
		draw_line(head + Vector2(-radius * 0.22, radius * 0.6), head + Vector2(radius * 0.22, radius * 0.6), Color(0.45, 0.25, 0.22), 1.2)


## The grey blanket over the patient's knees, drawn in front of them.
func _draw_blanket(bed_x: float, index: int) -> void:
	var knee := 428.0 if index != 6 else 436.0
	var blanket: Array[Vector2] = [
		Vector2(bed_x - 36, MATTRESS_Y + 2), Vector2(bed_x - 20, MATTRESS_Y - 3), Vector2(bed_x + 28, MATTRESS_Y - 3),
		Vector2(bed_x + 48, knee + 2), Vector2(bed_x + 66, knee), Vector2(bed_x + 100, MATTRESS_Y - 4),
		Vector2(bed_x + 106, MATTRESS_Y + 6), Vector2(bed_x + 106, 482), Vector2(bed_x - 36, 482),
	]
	_polygon(blanket, BLANKET)
	# The turned-down sheet, a fold and the stripe along the hem
	draw_line(Vector2(bed_x - 34, MATTRESS_Y + 2), Vector2(bed_x + 26, MATTRESS_Y), LINEN, 5.0)
	draw_line(Vector2(bed_x + 58, knee + 4), Vector2(bed_x + 70, 478), BLANKET_DARK, 1.5)
	draw_line(Vector2(bed_x + 20, MATTRESS_Y + 6), Vector2(bed_x + 12, 478), BLANKET_DARK, 1.0)
	draw_line(Vector2(bed_x - 36, 476), Vector2(bed_x + 106, 476), Color(0.5, 0.2, 0.18), 2.0)
	draw_line(Vector2(bed_x - 36, 482), Vector2(bed_x + 106, 482), BLANKET_DARK, 2.0)


## Shadows and tops for the three bedside lockers, with a tin mug on each.
func _draw_bedside_lockers() -> void:
	for locker_x: float in LOCKER_XS:
		_ellipse(Vector2(locker_x, FLOOR_Y + 2), Vector2(36, 5), Color(0, 0, 0, 0.4))
		draw_rect(Rect2(locker_x - 31, 460, 62, 6), ENAMEL.darkened(0.3))
		draw_rect(Rect2(locker_x - 24, 534, 5, 8), IRON)
		draw_rect(Rect2(locker_x + 19, 534, 5, 8), IRON)
		# A tin mug
		draw_rect(Rect2(locker_x + 8, 446, 12, 14), Color(0.5, 0.53, 0.55))
		draw_arc(Vector2(locker_x + 21, 453), 4.0, -PI / 2.0, PI / 2.0, 8, Color(0.5, 0.53, 0.55), 1.5)
	# Shadow of the tall nurses' locker between the fifth and sixth beds
	_ellipse(Vector2(1610, FLOOR_Y + 2), Vector2(40, 5), Color(0, 0, 0, 0.45))
	draw_rect(Rect2(1574, 388, 72, 154), Color(0, 0, 0, 0.3))


## The nurses' desk on the boards in front of the beds: the lamp and the confiscation box stand on it.
func _draw_nurses_desk() -> void:
	_ellipse(Vector2(DESK_FRONT_RECT.get_center().x, 694), Vector2(112, 7), Color(0, 0, 0, 0.45))
	draw_rect(DESK_FRONT_RECT, WOOD)
	draw_rect(DESK_FRONT_RECT, WOOD_DARK, false, 2.0)
	# A cupboard door on the right of the desk front; the drawer goes on the left
	draw_rect(Rect2(1306, 620, 78, 62), WOOD_DARK, false, 2.0)
	draw_circle(Vector2(1316, 652), 3.0, BRASS)
	draw_rect(Rect2(1208, 652, 84, 30), WOOD_DARK, false, 2.0)
	draw_rect(DESK_TOP_RECT, WOOD.lightened(0.14))
	draw_rect(Rect2(DESK_TOP_RECT.position.x, DESK_TOP_RECT.end.y - 3, DESK_TOP_RECT.size.x, 3), WOOD_DARK)
	# The open night book and a pen, between the lamp and the box
	_polygon([Vector2(1258, 600), Vector2(1262, 593), Vector2(1298, 593), Vector2(1300, 600)], Color(0.86, 0.83, 0.72))
	draw_line(Vector2(1280, 593), Vector2(1279, 600), Color(0.4, 0.36, 0.3), 1.0)
	draw_line(Vector2(1384, 598), Vector2(1400, 594), INK, 2.0)
	# The nurse's stool, knocked askew
	draw_rect(Rect2(1424, 630, 46, 7), WOOD.lightened(0.1))
	draw_line(Vector2(1430, 637), Vector2(1424, 692), WOOD_DARK, 4.0)
	draw_line(Vector2(1464, 637), Vector2(1472, 692), WOOD_DARK, 4.0)
	draw_line(Vector2(1428, 668), Vector2(1468, 668), WOOD_DARK, 2.0)


## Shadows, wheels and bolts for the linen chest, the medicine trolley and the strongbox.
func _draw_floor_things() -> void:
	# The linen chest stands on two battens
	_ellipse(Vector2(520, 680), Vector2(70, 6), Color(0, 0, 0, 0.45))
	draw_rect(Rect2(466, 672, 14, 8), WOOD_DARK)
	draw_rect(Rect2(560, 672, 14, 8), WOOD_DARK)
	# A grey blanket folded on the boards beside it
	_rounded_rect(Rect2(600, 652, 60, 22), BLANKET, 5)
	draw_line(Vector2(602, 662), Vector2(658, 662), BLANKET_DARK, 1.5)
	# The medicine trolley: legs, wheels and its push handle
	_ellipse(Vector2(800, 692), Vector2(52, 6), Color(0, 0, 0, 0.45))
	for wheel_x: float in [768.0, 832.0]:
		draw_rect(Rect2(wheel_x - 2, 672, 4, 12), ENAMEL.darkened(0.3))
		draw_circle(Vector2(wheel_x, 686), 6.0, Color(0.06, 0.06, 0.07))
		draw_circle(Vector2(wheel_x, 686), 2.0, IRON_LIGHT)
	draw_polyline(PackedVector2Array([Vector2(838, 600), Vector2(856, 592), Vector2(856, 580)]), ENAMEL.darkened(0.2), 3.0)
	draw_rect(Rect2(756, 580, 88, 6), ENAMEL.darkened(0.15))
	# A brown medicine bottle and a spoon on the trolley top
	draw_rect(Rect2(770, 562, 12, 18), Color(0.36, 0.2, 0.08))
	draw_rect(Rect2(773, 556, 6, 6), Color(0.2, 0.12, 0.06))
	draw_line(Vector2(796, 578), Vector2(822, 576), ENAMEL, 2.0)
	# The strongbox: an iron plate bolted through the boards
	_ellipse(Vector2(1840, 676), Vector2(48, 6), Color(0, 0, 0, 0.45))
	draw_rect(Rect2(1796, 668, 88, 8), IRON)
	draw_line(Vector2(1796, 668), Vector2(1884, 668), IRON_LIGHT, 1.0)
	for bolt_x: float in [1802.0, 1878.0]:
		draw_circle(Vector2(bolt_x, 672), 3.0, IRON_LIGHT)


## Cold moonlight through the three windows, and the one warm lamp on the desk.
func _draw_light() -> void:
	for window_x: float in WINDOW_XS:
		var shaft: Array[Vector2] = [Vector2(window_x - 40, FLOOR_Y), Vector2(window_x + 40, FLOOR_Y),
			Vector2(window_x + 170, room_size.y), Vector2(window_x + 10, room_size.y)]
		_polygon(shaft, Color(MOONLIGHT, 0.07))
		# Shadows of the bars across the pool of light
		for i in range(3):
			var along := (i + 1) * 20.0
			draw_line(Vector2(window_x - 40 + along, FLOOR_Y), Vector2(window_x + 10 + along * 2.0, room_size.y),
				Color(0, 0, 0, 0.16), 3.0)
		_glow(Vector2(window_x, 214), 60, 4, 26, Color(MOONLIGHT, 0.012))
	_glow(LAMP_AT, 18, 9, 20, Color(LAMP, 0.028))
	_ellipse(Vector2(LAMP_AT.x + 10, DESK_TOP_RECT.position.y + 3), Vector2(86, 5), Color(LAMP, 0.16))
	_ellipse(Vector2(LAMP_AT.x, 700), Vector2(170, 16), Color(LAMP, 0.05))
