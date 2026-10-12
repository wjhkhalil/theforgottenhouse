@tool
class_name DispensaryArt
extends RoomArt
## Placeholder drawing of House Three, Chapter Five: the dispensary of
## Hollowmere Sanatorium, at night. See room_art.gd for how to replace it with
## a real image.
##
## Layout, left to right along the back wall: the panelled door to the matron's
## stairs, the peg where the white coat hangs with the hatch of the service lift
## under it, the sink with a shelf above it and the framed certificate over that
## (its year is the code of the controlled drugs safe), the tall bottle shelves,
## the window with a shelf under it, and two shelves on the right below the
## place of the poison cupboard. The long mahogany counter runs across the room
## from the lift hatch to the right edge: the spoon rack and the mortar stand on
## it, the two drawers, the bureau and the kneehole of the safe are in its front.
## The ice chest stands on the floor in front of it.
##
## LookAlikes draws two wrong-coloured copies beside six of the objects. The
## stretches where those rows stand are kept EMPTY here: one bottle shelf (the
## third board down), the shelf above the sink, the lower shelf on the right,
## the spoon rack, and two stretches of the counter top.

const FLOOR_Y := 540.0
const DADO_Y := 336.0
const DOOR_RECT := Rect2(55, 327, 100, 210)
const COAT_RECT := Rect2(175, 217, 60, 150)
const HATCH_RECT := Rect2(172, 420, 62, 114)
const CERTIFICATE_RECT := Rect2(268, 96, 128, 88)
const SINK_SHELF_RECT := Rect2(260, 290, 144, 6)
const BOTTLE_UNIT_RECT := Rect2(425, 100, 226, 232)
## Top of each shelf board in the bottle shelves. The third one carries the blue bottle row.
const BOTTLE_SHELF_YS: Array[float] = [150.0, 205.0, 260.0, 315.0]
const WINDOW_RECT := Rect2(682, 92, 116, 134)
const WINDOW_SHELF_RECT := Rect2(668, 258, 144, 6)
const POISON_CUPBOARD_RECT := Rect2(863, 100, 84, 100)
const UPPER_SHELF_RECT := Rect2(836, 232, 158, 6)
const LOWER_SHELF_RECT := Rect2(836, 300, 158, 6)
const COUNTER_TOP_RECT := Rect2(244, 430, 772, 12)
const COUNTER_FRONT_RECT := Rect2(252, 442, 756, 98)
const RACK_RECT := Rect2(430, 350, 138, 44)
const SPOON_XS: Array[float] = [452.0, 498.0, 544.0]
const DRAWER_RECTS: Array[Rect2] = [Rect2(280, 484, 80, 24), Rect2(380, 484, 80, 24)]
const BUREAU_FLAP_RECT := Rect2(515, 477, 90, 30)
const SAFE_HOLE_RECT := Rect2(660, 464, 80, 76)
const MAHOGANY := Color(0.34, 0.15, 0.1)
const MAHOGANY_DARK := Color(0.18, 0.08, 0.06)
const MAHOGANY_LIGHT := Color(0.5, 0.25, 0.15)
const PINE := Color(0.6, 0.48, 0.3)
const BRASS := Color(0.78, 0.6, 0.28)
const ENAMEL := Color(0.86, 0.88, 0.84)
const STEEL := Color(0.55, 0.59, 0.61)
const STEEL_DARK := Color(0.24, 0.27, 0.3)
const INK := Color(0.14, 0.13, 0.18)
const LAMP_GREEN := Color(0.1, 0.42, 0.26)


func _draw_background() -> void:
	_draw_walls()
	_draw_floor()
	_draw_office_door()
	_draw_coat_peg_and_lift_hatch()
	_draw_certificate()
	_draw_sink()
	_draw_bottle_shelves()
	_draw_window()
	_draw_right_shelves()
	_draw_counter()
	_draw_counter_fittings()
	_draw_floor_things()
	_draw_lamps()


func _draw_foreground() -> void:
	_draw_vignette()


# ---------------------------------------------------------------------------

## Dark green distemper above a dado of pale glazed tiles.
func _draw_walls() -> void:
	_vertical_gradient(Rect2(0, 0, room_size.x, DADO_Y), Color(0.12, 0.18, 0.16), Color(0.24, 0.32, 0.28))
	draw_rect(Rect2(0, DADO_Y, room_size.x, FLOOR_Y - DADO_Y), Color(0.56, 0.6, 0.53))
	var x := 0.0
	while x < room_size.x:
		draw_line(Vector2(x, DADO_Y), Vector2(x, FLOOR_Y), Color(0.4, 0.45, 0.4), 1.0)
		x += 34.0
	var y := DADO_Y
	while y < FLOOR_Y:
		draw_line(Vector2(0, y), Vector2(room_size.x, y), Color(0.4, 0.45, 0.4), 1.0)
		y += 34.0
	draw_rect(Rect2(0, DADO_Y - 7, room_size.x, 8), Color(0.08, 0.2, 0.16))
	# A picture rail high up
	draw_rect(Rect2(0, 74, room_size.x, 4), Color(0.08, 0.13, 0.11))
	# A tall plain cupboard on the right, under the objective list
	draw_rect(Rect2(1040, 150, 200, 390), MAHOGANY_DARK)
	draw_rect(Rect2(1050, 160, 86, 370), Color(0.24, 0.11, 0.08))
	draw_rect(Rect2(1144, 160, 86, 370), Color(0.24, 0.11, 0.08))
	draw_circle(Vector2(1130, 350), 3.0, BRASS.darkened(0.3))
	draw_circle(Vector2(1150, 350), 3.0, BRASS.darkened(0.3))


## Dark brown linoleum with a worn path behind the counter.
func _draw_floor() -> void:
	_vertical_gradient(Rect2(0, FLOOR_Y, room_size.x, room_size.y - FLOOR_Y), Color(0.2, 0.15, 0.12), Color(0.12, 0.09, 0.08))
	for line_y: float in [562.0, 592.0, 632.0, 684.0]:
		draw_line(Vector2(0, line_y), Vector2(room_size.x, line_y), Color(0.08, 0.06, 0.05), 1.0)
	for i in range(11):
		var top_x := 40.0 + i * 120.0
		var bottom_x := 640.0 + (top_x - 640.0) * 1.5
		draw_line(Vector2(top_x, FLOOR_Y), Vector2(bottom_x, room_size.y), Color(0.08, 0.06, 0.05, 0.7), 1.0)
	draw_rect(Rect2(0, FLOOR_Y - 8, room_size.x, 8), Color(0.07, 0.16, 0.13))
	# Lamp light pooled on the floor in front of the counter
	_ellipse(Vector2(600, 640), Vector2(330, 54), Color(0.6, 0.9, 0.6, 0.04))


## The frame of the door to the matron's stairs, with its brass plate above.
func _draw_office_door() -> void:
	var frame := DOOR_RECT.grow(9)
	draw_rect(Rect2(frame.position.x, frame.position.y, frame.size.x, FLOOR_Y - frame.position.y), MAHOGANY_DARK)
	draw_rect(DOOR_RECT, Color(0.05, 0.04, 0.03))
	draw_rect(Rect2(frame.position.x - 4, frame.position.y - 6, frame.size.x + 8, 7), MAHOGANY)
	# A line of light from the stairs shows under the door
	draw_rect(Rect2(DOOR_RECT.position.x, FLOOR_Y - 4, DOOR_RECT.size.x, 4), Color(1.0, 0.85, 0.5, 0.7))
	var plate := Rect2(DOOR_RECT.get_center().x - 46, frame.position.y - 30, 92, 18)
	draw_rect(plate, BRASS)
	draw_rect(plate, BRASS.darkened(0.45), false, 1.0)
	draw_string(ThemeDB.fallback_font, plate.position + Vector2(0, 13), "MATRON - PRIVATE", HORIZONTAL_ALIGNMENT_CENTER,
		plate.size.x, 9, INK)


## The peg rail the white coat hangs from, and the low hatch of the service lift under it.
func _draw_coat_peg_and_lift_hatch() -> void:
	draw_rect(Rect2(COAT_RECT.position.x - 8, COAT_RECT.position.y - 14, COAT_RECT.size.x + 16, 8), MAHOGANY)
	for peg_x: float in [COAT_RECT.position.x + 4, COAT_RECT.get_center().x, COAT_RECT.end.x - 4]:
		draw_circle(Vector2(peg_x, COAT_RECT.position.y - 8), 3.5, BRASS)
	# The shadow the coat throws on the wall
	draw_rect(Rect2(COAT_RECT.position + Vector2(6, 6), COAT_RECT.size), Color(0, 0, 0, 0.25))
	# The lift hatch: a steel frame, a dark shaft, two cables and the shutter pushed half up
	draw_rect(HATCH_RECT.grow(6), STEEL_DARK)
	draw_rect(HATCH_RECT, Color(0.03, 0.03, 0.04))
	for cable_x: float in [HATCH_RECT.position.x + 22, HATCH_RECT.position.x + 40]:
		draw_line(Vector2(cable_x, HATCH_RECT.position.y + 40), Vector2(cable_x, HATCH_RECT.end.y - 22), Color(0.3, 0.3, 0.32), 1.5)
	draw_rect(Rect2(HATCH_RECT.position.x, HATCH_RECT.end.y - 22, HATCH_RECT.size.x, 22), Color(0.2, 0.14, 0.1))
	draw_rect(Rect2(HATCH_RECT.position.x, HATCH_RECT.end.y - 22, HATCH_RECT.size.x, 3), Color(0.34, 0.25, 0.17))
	draw_rect(Rect2(HATCH_RECT.position, Vector2(HATCH_RECT.size.x, 40)), STEEL)
	for i in range(4):
		draw_line(HATCH_RECT.position + Vector2(0, 8 + i * 9.0), HATCH_RECT.position + Vector2(HATCH_RECT.size.x, 8 + i * 9.0),
			STEEL_DARK, 1.0)
	draw_rect(Rect2(HATCH_RECT.get_center().x - 8, HATCH_RECT.position.y + 33, 16, 4), STEEL_DARK)
	draw_string(ThemeDB.fallback_font, Vector2(HATCH_RECT.position.x - 6, HATCH_RECT.position.y - 10), "LIFT",
		HORIZONTAL_ALIGNMENT_CENTER, HATCH_RECT.size.x + 12, 9, Color(0.1, 0.16, 0.14))


## The dispenser's framed certificate. Its year is the code of the controlled drugs safe.
func _draw_certificate() -> void:
	draw_line(CERTIFICATE_RECT.position + Vector2(20, 0), Vector2(CERTIFICATE_RECT.get_center().x, CERTIFICATE_RECT.position.y - 14),
		Color(0.5, 0.45, 0.35), 1.0)
	draw_line(Vector2(CERTIFICATE_RECT.end.x - 20, CERTIFICATE_RECT.position.y),
		Vector2(CERTIFICATE_RECT.get_center().x, CERTIFICATE_RECT.position.y - 14), Color(0.5, 0.45, 0.35), 1.0)
	draw_rect(CERTIFICATE_RECT.grow(6), Color(0.1, 0.07, 0.05))
	draw_rect(CERTIFICATE_RECT.grow(4), BRASS.darkened(0.2))
	draw_rect(CERTIFICATE_RECT, Color(0.93, 0.9, 0.78))
	draw_rect(CERTIFICATE_RECT.grow(-4), Color(0.45, 0.38, 0.22), false, 1.0)
	var font := ThemeDB.fallback_font
	var at := CERTIFICATE_RECT.position
	var width := CERTIFICATE_RECT.size.x
	draw_string(font, at + Vector2(0, 18), "DISPENSING CHEMIST", HORIZONTAL_ALIGNMENT_CENTER, width, 8, Color(0.4, 0.34, 0.24))
	draw_string(font, at + Vector2(0, 42), "LICENSED", HORIZONTAL_ALIGNMENT_CENTER, width, 17, INK)
	draw_string(font, at + Vector2(0, 70), "1962", HORIZONTAL_ALIGNMENT_CENTER, width, 24, Color(0.55, 0.1, 0.08))
	draw_line(at + Vector2(34, 75), at + Vector2(width - 34, 75), Color(0.55, 0.1, 0.08), 1.5)
	# A red wax seal in the corner
	draw_circle(at + Vector2(width - 16, 70), 7.0, Color(0.6, 0.1, 0.08))
	draw_circle(at + Vector2(width - 16, 70), 4.0, Color(0.74, 0.18, 0.14))


## The small sink on the back wall, with the shelf above it (the measuring glasses stand there).
func _draw_sink() -> void:
	# The shelf on two iron brackets. Its top is left empty for the row of glasses.
	draw_rect(SINK_SHELF_RECT, MAHOGANY_LIGHT)
	draw_rect(Rect2(SINK_SHELF_RECT.position.x, SINK_SHELF_RECT.end.y - 2, SINK_SHELF_RECT.size.x, 2), MAHOGANY_DARK)
	for bracket_x: float in [SINK_SHELF_RECT.position.x + 12, SINK_SHELF_RECT.end.x - 12]:
		_polygon([Vector2(bracket_x - 2, SINK_SHELF_RECT.end.y), Vector2(bracket_x + 2, SINK_SHELF_RECT.end.y),
			Vector2(bracket_x + 2, SINK_SHELF_RECT.end.y + 16)], STEEL_DARK)
	# White splashback tiles
	var splash := Rect2(274, 308, 116, 28)
	draw_rect(splash, ENAMEL.darkened(0.12))
	for i in range(1, 4):
		draw_line(Vector2(splash.position.x + i * 29.0, splash.position.y), Vector2(splash.position.x + i * 29.0, splash.end.y),
			Color(0.6, 0.63, 0.6), 1.0)
	# The tap and its pipe
	draw_rect(Rect2(329, 314, 6, 22), BRASS)
	draw_rect(Rect2(322, 312, 20, 4), BRASS)
	draw_rect(Rect2(329, 336, 14, 4), BRASS)
	draw_rect(Rect2(339, 340, 4, 6), BRASS.darkened(0.2))
	# The basin
	_rounded_rect(Rect2(284, 346, 96, 36), ENAMEL.darkened(0.25), 10)
	_rounded_rect(Rect2(284, 346, 96, 30), ENAMEL, 10)
	_ellipse(Vector2(332, 356), Vector2(40, 7), Color(0.5, 0.55, 0.54))
	_ellipse(Vector2(332, 357), Vector2(4, 2), Color(0.1, 0.1, 0.1))
	draw_line(Vector2(322, 350), Vector2(319, 360), Color(0.5, 0.36, 0.2, 0.7), 2.0)
	# The waste pipe bends back into the wall
	draw_rect(Rect2(328, 382, 8, 10), STEEL_DARK)
	draw_rect(Rect2(328, 390, 26, 6), STEEL_DARK)


## The tall bottle shelves. The third board is kept clear for the blue bottle and its look-alikes.
func _draw_bottle_shelves() -> void:
	draw_rect(BOTTLE_UNIT_RECT.grow(6), MAHOGANY_DARK)
	draw_rect(BOTTLE_UNIT_RECT, Color(0.48, 0.45, 0.36))
	_vertical_gradient(Rect2(BOTTLE_UNIT_RECT.position, Vector2(BOTTLE_UNIT_RECT.size.x, 60)), Color(0, 0, 0, 0.35), Color(0, 0, 0, 0))
	# A carved cornice
	draw_rect(Rect2(BOTTLE_UNIT_RECT.position.x - 10, BOTTLE_UNIT_RECT.position.y - 12, BOTTLE_UNIT_RECT.size.x + 20, 8), MAHOGANY)
	for shelf_y: float in BOTTLE_SHELF_YS:
		draw_rect(Rect2(BOTTLE_UNIT_RECT.position.x, shelf_y, BOTTLE_UNIT_RECT.size.x, 6), MAHOGANY)
		draw_rect(Rect2(BOTTLE_UNIT_RECT.position.x, shelf_y + 6, BOTTLE_UNIT_RECT.size.x, 4), Color(0, 0, 0, 0.3))
	draw_rect(Rect2(BOTTLE_UNIT_RECT.position.x, BOTTLE_UNIT_RECT.end.y - 6, BOTTLE_UNIT_RECT.size.x, 6), MAHOGANY_DARK)
	# Small dull stock bottles on every board except the third
	_stock_bottles(BOTTLE_SHELF_YS[0], BOTTLE_UNIT_RECT.position.x + 12, 12, 0)
	_stock_bottles(BOTTLE_SHELF_YS[1], BOTTLE_UNIT_RECT.position.x + 16, 11, 3)
	_stock_bottles(BOTTLE_SHELF_YS[3], BOTTLE_UNIT_RECT.position.x + 12, 12, 5)
	# A paper strip pinned to the edge of the third board
	draw_rect(Rect2(BOTTLE_UNIT_RECT.position.x + 8, BOTTLE_SHELF_YS[2] + 1, 30, 4), Color(0.85, 0.8, 0.62))


## A row of small brown, grey and black bottles standing on a shelf (scenery only).
func _stock_bottles(shelf_y: float, from_x: float, count: int, offset: int) -> void:
	var dull: Array[Color] = [Color(0.27, 0.2, 0.13), Color(0.3, 0.31, 0.28), Color(0.17, 0.16, 0.15), Color(0.36, 0.31, 0.24)]
	for i in range(count):
		var bottle_x := from_x + i * 18.0
		var height := 11.0 + ((i * 7 + offset * 3) % 4) * 2.0
		var glass := dull[(i + offset) % dull.size()]
		draw_rect(Rect2(bottle_x - 4, shelf_y - height, 8, height), glass)
		draw_rect(Rect2(bottle_x - 1.5, shelf_y - height - 4, 3, 4), glass.darkened(0.2))
		draw_rect(Rect2(bottle_x - 3, shelf_y - height + 4, 6, 4), Color(0.62, 0.58, 0.46, 0.8))


## The night window, with the shelf under it (the roll of labels lies there).
func _draw_window() -> void:
	draw_rect(WINDOW_RECT.grow(7), MAHOGANY_DARK)
	_vertical_gradient(WINDOW_RECT, Color(0.03, 0.05, 0.12), Color(0.08, 0.12, 0.22))
	# A blurred moon and rain on the glass
	_glow(Vector2(WINDOW_RECT.position.x + 82, WINDOW_RECT.position.y + 40), 8.0, 4, 5.0, Color(0.7, 0.78, 0.9, 0.08))
	draw_circle(Vector2(WINDOW_RECT.position.x + 82, WINDOW_RECT.position.y + 40), 8.0, Color(0.8, 0.85, 0.9, 0.7))
	for i in range(9):
		var rain_x := WINDOW_RECT.position.x + 8.0 + i * 12.5
		var rain_y := WINDOW_RECT.position.y + 14.0 + ((i * 37) % 80)
		draw_line(Vector2(rain_x, rain_y), Vector2(rain_x - 3, rain_y + 16), Color(0.7, 0.8, 0.95, 0.3), 1.0)
	# Glazing bars
	draw_rect(Rect2(WINDOW_RECT.get_center().x - 2, WINDOW_RECT.position.y, 4, WINDOW_RECT.size.y), MAHOGANY_DARK)
	draw_rect(Rect2(WINDOW_RECT.position.x, WINDOW_RECT.get_center().y - 2, WINDOW_RECT.size.x, 4), MAHOGANY_DARK)
	# A green blind rolled up at the top
	draw_rect(Rect2(WINDOW_RECT.position.x, WINDOW_RECT.position.y, WINDOW_RECT.size.x, 12), Color(0.14, 0.26, 0.2))
	draw_line(Vector2(WINDOW_RECT.get_center().x + 20, WINDOW_RECT.position.y + 12),
		Vector2(WINDOW_RECT.get_center().x + 20, WINDOW_RECT.position.y + 30), Color(0.6, 0.55, 0.4), 1.0)
	# The sill and the shelf under it
	draw_rect(Rect2(WINDOW_RECT.position.x - 10, WINDOW_RECT.end.y + 7, WINDOW_RECT.size.x + 20, 6), MAHOGANY)
	draw_rect(WINDOW_SHELF_RECT, MAHOGANY_LIGHT)
	draw_rect(Rect2(WINDOW_SHELF_RECT.position.x, WINDOW_SHELF_RECT.end.y - 2, WINDOW_SHELF_RECT.size.x, 2), MAHOGANY_DARK)
	for bracket_x: float in [WINDOW_SHELF_RECT.position.x + 12, WINDOW_SHELF_RECT.end.x - 12]:
		_polygon([Vector2(bracket_x - 2, WINDOW_SHELF_RECT.end.y), Vector2(bracket_x + 2, WINDOW_SHELF_RECT.end.y),
			Vector2(bracket_x + 2, WINDOW_SHELF_RECT.end.y + 16)], STEEL_DARK)
	# A pot of gum and a brush at the far end of the shelf
	draw_rect(Rect2(686, 247, 12, 11), Color(0.3, 0.24, 0.18))
	draw_line(Vector2(692, 247), Vector2(696, 236), Color(0.5, 0.42, 0.3), 1.5)


## Two shelves on the right, under the place of the poison cupboard. The lower one is kept clear for the ointment jars.
func _draw_right_shelves() -> void:
	# The shadow of the poison cupboard and the card that hangs under it
	draw_rect(Rect2(POISON_CUPBOARD_RECT.position + Vector2(5, 6), POISON_CUPBOARD_RECT.size), Color(0, 0, 0, 0.3))
	draw_rect(Rect2(POISON_CUPBOARD_RECT.get_center().x - 20, POISON_CUPBOARD_RECT.end.y + 4, 40, 14), Color(0.88, 0.84, 0.7))
	draw_line(Vector2(POISON_CUPBOARD_RECT.get_center().x - 15, POISON_CUPBOARD_RECT.end.y + 9),
		Vector2(POISON_CUPBOARD_RECT.get_center().x + 15, POISON_CUPBOARD_RECT.end.y + 9), INK, 1.0)
	draw_line(Vector2(POISON_CUPBOARD_RECT.get_center().x - 15, POISON_CUPBOARD_RECT.end.y + 13),
		Vector2(POISON_CUPBOARD_RECT.get_center().x + 8, POISON_CUPBOARD_RECT.end.y + 13), INK, 1.0)
	for shelf: Rect2 in [UPPER_SHELF_RECT, LOWER_SHELF_RECT]:
		draw_rect(shelf, MAHOGANY_LIGHT)
		draw_rect(Rect2(shelf.position.x, shelf.end.y - 2, shelf.size.x, 2), MAHOGANY_DARK)
		for bracket_x: float in [shelf.position.x + 12, shelf.end.x - 12]:
			_polygon([Vector2(bracket_x - 2, shelf.end.y), Vector2(bracket_x + 2, shelf.end.y),
				Vector2(bracket_x + 2, shelf.end.y + 16)], STEEL_DARK)
	# A few squat brown tins on the upper shelf (scenery only)
	for i in range(6):
		var tin_x := UPPER_SHELF_RECT.position.x + 20.0 + i * 24.0
		draw_rect(Rect2(tin_x - 7, UPPER_SHELF_RECT.position.y - 10, 14, 10), Color(0.27, 0.2, 0.14) if i % 2 == 0 else Color(0.2, 0.19, 0.17))
		draw_rect(Rect2(tin_x - 7, UPPER_SHELF_RECT.position.y - 10, 14, 2), Color(0.36, 0.3, 0.22))


## The long mahogany counter: the surrounds of the two drawers, the bureau and the kneehole of the safe.
func _draw_counter() -> void:
	_ellipse(Vector2(COUNTER_FRONT_RECT.get_center().x, FLOOR_Y + 5), Vector2(390, 9), Color(0, 0, 0, 0.45))
	_vertical_gradient(COUNTER_FRONT_RECT, MAHOGANY, MAHOGANY.darkened(0.3))
	draw_rect(Rect2(COUNTER_FRONT_RECT.position.x, FLOOR_Y - 8, COUNTER_FRONT_RECT.size.x, 8), MAHOGANY_DARK)
	# The drawer bank on the left: a frame round each drawer and a plain panel below
	var bank := Rect2(268, 452, 204, 78)
	draw_rect(bank, MAHOGANY_DARK, false, 2.0)
	for drawer: Rect2 in DRAWER_RECTS:
		draw_rect(drawer.grow(4), MAHOGANY_DARK)
		# A paper ticket above each drawer
		draw_rect(Rect2(drawer.get_center().x - 14, drawer.position.y - 20, 28, 10), Color(0.86, 0.82, 0.68))
		draw_line(Vector2(drawer.get_center().x - 10, drawer.position.y - 15), Vector2(drawer.get_center().x + 10, drawer.position.y - 15),
			INK, 1.0)
	draw_line(Vector2(274, 518), Vector2(466, 518), MAHOGANY_DARK, 1.5)
	# The dispenser's bureau, built into the counter: the flap goes in the dark frame
	var bureau := Rect2(502, 452, 116, 80)
	draw_rect(bureau, Color(0.26, 0.15, 0.08))
	draw_rect(bureau, MAHOGANY_DARK, false, 2.0)
	draw_rect(BUREAU_FLAP_RECT.grow(4), Color(0.1, 0.06, 0.04))
	draw_rect(Rect2(bureau.position.x + 4, bureau.position.y + 4, bureau.size.x - 8, 8), Color(0.34, 0.2, 0.12))
	for i in range(3):
		var hole := Rect2(bureau.position.x + 10 + i * 34.0, 514, 28, 14)
		draw_rect(hole, Color(0.1, 0.06, 0.04))
		draw_rect(Rect2(hole.position.x + 4, hole.position.y + 4, 16, 10), Color(0.8, 0.76, 0.62, 0.7))
	# The kneehole where the controlled drugs safe stands
	draw_rect(SAFE_HOLE_RECT, Color(0.04, 0.03, 0.03))
	draw_rect(SAFE_HOLE_RECT, MAHOGANY_DARK, false, 2.0)
	draw_rect(Rect2(SAFE_HOLE_RECT.position.x + 4, FLOOR_Y - 5, SAFE_HOLE_RECT.size.x - 8, 5), STEEL_DARK)
	# Plain panels along the rest of the front
	for panel: Rect2 in [Rect2(770, 456, 100, 70), Rect2(886, 456, 100, 70)]:
		draw_rect(panel, MAHOGANY.darkened(0.2))
		draw_rect(panel, MAHOGANY_DARK, false, 2.0)
		draw_line(panel.position + Vector2(3, 3), Vector2(panel.end.x - 3, panel.position.y + 3), MAHOGANY_LIGHT.darkened(0.2), 1.0)
	# The top, polished, with a brass strip along its edge
	draw_rect(COUNTER_TOP_RECT, MAHOGANY_LIGHT)
	draw_rect(Rect2(COUNTER_TOP_RECT.position, Vector2(COUNTER_TOP_RECT.size.x, 3)), MAHOGANY_LIGHT.lightened(0.2))
	draw_rect(Rect2(COUNTER_TOP_RECT.position.x, COUNTER_TOP_RECT.end.y - 3, COUNTER_TOP_RECT.size.x, 2), BRASS.darkened(0.25))
	draw_rect(Rect2(COUNTER_TOP_RECT.position.x, COUNTER_TOP_RECT.end.y - 1, COUNTER_TOP_RECT.size.x, 3), Color(0, 0, 0, 0.4))


## What stands on the counter: the spoon rack, the mortar, and the mats under the jar and the two cases.
func _draw_counter_fittings() -> void:
	var top_y := COUNTER_TOP_RECT.position.y
	# The spoon rack: a pale board on two posts, with a pair of pegs for each spoon
	for post_x: float in [RACK_RECT.position.x + 4, RACK_RECT.end.x - 8]:
		draw_rect(Rect2(post_x, RACK_RECT.end.y, 4, top_y - RACK_RECT.end.y), MAHOGANY_DARK)
	draw_rect(RACK_RECT.grow(3), MAHOGANY)
	draw_rect(RACK_RECT, PINE)
	draw_line(RACK_RECT.position + Vector2(0, 8), Vector2(RACK_RECT.end.x, RACK_RECT.position.y + 8), PINE.darkened(0.2), 1.0)
	for spoon_x: float in SPOON_XS:
		for peg_x: float in [spoon_x - 9, spoon_x + 9]:
			draw_rect(Rect2(peg_x - 1.5, RACK_RECT.position.y + 27, 3, 6), MAHOGANY_DARK)
	# The mortar (the pestle lies beside it)
	_ellipse(Vector2(468, top_y + 5), Vector2(20, 3), Color(0, 0, 0, 0.35))
	_polygon([Vector2(451, top_y - 20), Vector2(485, top_y - 20), Vector2(479, top_y + 3), Vector2(457, top_y + 3)], Color(0.8, 0.8, 0.76))
	_ellipse(Vector2(468, top_y - 20), Vector2(17, 4), Color(0.9, 0.9, 0.86))
	_ellipse(Vector2(468, top_y - 19), Vector2(13, 2.5), Color(0.5, 0.5, 0.48))
	draw_line(Vector2(455, top_y - 14), Vector2(459, top_y), Color(1, 1, 1, 0.3), 2.0)
	# A felt mat under the weights, a blotter by the scales, and mats under the jar and the cases
	draw_rect(Rect2(300, top_y + 2, 122, 5), Color(0.12, 0.3, 0.22))
	draw_rect(Rect2(622, top_y + 2, 130, 5), Color(0.66, 0.62, 0.5))
	_ellipse(Vector2(805, top_y + 5), Vector2(28, 3), Color(0, 0, 0, 0.35))
	draw_rect(Rect2(832, top_y + 2, 156, 5), Color(0.12, 0.3, 0.22))


## The shadow and melt water of the ice chest, a stool, and a crate by the right wall.
func _draw_floor_things() -> void:
	# Under the ice chest
	_ellipse(Vector2(860, 638), Vector2(56, 7), Color(0, 0, 0, 0.45))
	_ellipse(Vector2(812, 646), Vector2(22, 4), Color(0.5, 0.62, 0.66, 0.25))
	# The dispenser's stool
	_ellipse(Vector2(420, 668), Vector2(32, 5), Color(0, 0, 0, 0.4))
	for lean: float in [-1.0, 0.0, 1.0]:
		draw_line(Vector2(420 + lean * 18.0, 600), Vector2(420 + lean * 26.0, 666), MAHOGANY_DARK, 4.0)
	draw_line(Vector2(399, 640), Vector2(441, 640), MAHOGANY_DARK, 3.0)
	_ellipse(Vector2(420, 598), Vector2(26, 6), MAHOGANY_LIGHT)
	_ellipse(Vector2(420, 596), Vector2(22, 4), Color(0.14, 0.3, 0.22))
	# A crate of empties by the right wall
	draw_rect(Rect2(1090, 600, 120, 70), Color(0.34, 0.26, 0.17))
	for i in range(3):
		draw_line(Vector2(1090, 618 + i * 18.0), Vector2(1210, 618 + i * 18.0), Color(0.2, 0.15, 0.1), 2.0)


## Two green-shaded lamps on long flexes, and the light they throw.
func _draw_lamps() -> void:
	for lamp: Vector2 in [Vector2(666, 66), Vector2(1110, 150)]:
		draw_line(Vector2(lamp.x, 0), lamp, Color(0.05, 0.05, 0.05), 2.0)
		_polygon([Vector2(lamp.x - 22, lamp.y + 22), Vector2(lamp.x + 22, lamp.y + 22), Vector2(lamp.x + 8, lamp.y),
			Vector2(lamp.x - 8, lamp.y)], LAMP_GREEN)
		draw_line(Vector2(lamp.x - 20, lamp.y + 21), Vector2(lamp.x - 8, lamp.y + 2), LAMP_GREEN.lightened(0.3), 1.5)
		draw_rect(Rect2(lamp.x - 22, lamp.y + 22, 44, 2), Color(0.9, 1.0, 0.8))
		_glow(Vector2(lamp.x, lamp.y + 30), 24.0, 6, 34.0, Color(0.7, 1.0, 0.72, 0.022))
	# The light catches the glass on the bottle shelves
	for shelf_y: float in BOTTLE_SHELF_YS:
		draw_line(Vector2(BOTTLE_UNIT_RECT.position.x + 4, shelf_y + 1), Vector2(BOTTLE_UNIT_RECT.end.x - 4, shelf_y + 1),
			Color(0.8, 1.0, 0.8, 0.18), 1.0)
