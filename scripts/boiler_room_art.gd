@tool
class_name BoilerRoomArt
extends RoomArt
## Placeholder drawing of House Three, Chapter Four: the boiler room under
## Hollowmere Sanatorium, at night. See room_art.gd for how to replace it with
## a real image.
##
## Layout, left to right: the coal bunker (chalked above it: NEXT COAL 23-11,
## the code of the meter box), a lagged duct with the pipe hatch, the clinker
## rake leaning by the stoker's locker, the first valve stub, the big riveted
## boiler (gauge case on the wall above it, cracked gauge and maker's plate on
## its front, fire door low down, ash pit and hearth plate under it), the
## second valve stub, the workbench (billy can and lunch tin on top, a drawer
## in its front) under the meter board, the service lift in its boarded shaft
## and the third valve stub. Nothing to find is placed under the objective
## list on the right: there is only an archway full of coal.
##
## The SteamValves script draws three jets of steam and three red valve wheels
## on top of this. A nozzle is drawn at the top centre of every jet, and a
## pipe stub with a valve body where every wheel sits (VALVE_XS, VALVE_Y).
## The floor strip in front (the hearth plate, the tool box) is clear of steam.

const FLOOR_Y := 540.0
const MAIN_PIPE_RECT := Rect2(0, 76, 1280, 18)
const NOZZLE_XS: Array[float] = [180.0, 490.0, 800.0]
const VALVE_XS: Array[float] = [335.0, 645.0, 955.0]
const VALVE_Y := 300.0
const BUNKER_RECT := Rect2(73, 452, 110, 80)
const CHALK_RECT := Rect2(70, 312, 190, 36)
const HATCH_RECT := Rect2(156, 370, 60, 56)
const LOCKER_RECT := Rect2(220, 386, 66, 150)
const BOILER_RECT := Rect2(388, 200, 204, 316)
const FIRE_DOOR_RECT := Rect2(448, 435, 84, 70)
const PLATE_RECT := Rect2(513, 340, 34, 20)
const GAUGE_AT := Vector2(450, 280)
const GAUGE_CASE_RECT := Rect2(389, 127, 70, 50)
const BENCH_TOP_RECT := Rect2(690, 440, 112, 12)
const METER_RECT := Rect2(714, 220, 62, 60)
const LIFT_RECT := Rect2(812, 390, 96, 150)
const BRICK := Color(0.2, 0.11, 0.08)
const BRICK_DARK := Color(0.09, 0.05, 0.05)
const MORTAR := Color(0.06, 0.04, 0.04)
const IRON := Color(0.17, 0.17, 0.19)
const IRON_DARK := Color(0.09, 0.09, 0.1)
const IRON_LIGHT := Color(0.34, 0.33, 0.34)
const COPPER := Color(0.42, 0.24, 0.14)
const WOOD := Color(0.3, 0.2, 0.12)
const WOOD_DARK := Color(0.16, 0.1, 0.07)
const COAL := Color(0.05, 0.05, 0.06)
const FIRE := Color(1.0, 0.5, 0.14)
const EMBER := Color(0.8, 0.2, 0.06)
const CHALK := Color(0.93, 0.93, 0.86)


func _draw_background() -> void:
	_draw_walls()
	_draw_floor()
	_draw_fire_glow()
	_draw_coal_bunker()
	_draw_chalk_note()
	_draw_duct_and_locker()
	_draw_boiler()
	_draw_boiler_fittings()
	_draw_hearth()
	_draw_overhead_pipes()
	_draw_workbench()
	_draw_meter_board()
	_draw_service_lift()
	_draw_floor_things()


func _draw_foreground() -> void:
	_draw_vignette()


# ---------------------------------------------------------------------------

## Dark, sooty brick, with a coal archway far right (under the objective list).
func _draw_walls() -> void:
	_vertical_gradient(Rect2(0, 0, room_size.x, FLOOR_Y), BRICK_DARK, BRICK)
	var row := 0
	var y := 0.0
	while y < FLOOR_Y:
		draw_line(Vector2(0, y), Vector2(room_size.x, y), MORTAR, 1.0)
		var x := 24.0 if row % 2 == 0 else 0.0
		while x < room_size.x:
			draw_line(Vector2(x, y), Vector2(x, y + 20.0), MORTAR, 1.0)
			x += 48.0
		y += 20.0
		row += 1
	# A few bricks that catch the firelight
	for brick: Vector2 in [Vector2(312, 400), Vector2(624, 440), Vector2(336, 480), Vector2(600, 360), Vector2(648, 500),
			Vector2(288, 460), Vector2(624, 240)]:
		draw_rect(Rect2(brick + Vector2(1, 1), Vector2(46, 18)), Color(0.5, 0.2, 0.08, 0.22))
	# Soot on the wall above the boiler
	_ellipse(Vector2(490, 150), Vector2(150, 70), Color(0, 0, 0, 0.3))
	# The archway to the coal cellar, heaped with coal
	draw_rect(Rect2(1070, 330, 160, 210), Color(0.02, 0.02, 0.02))
	_ellipse(Vector2(1150, 330), Vector2(80, 46), Color(0.02, 0.02, 0.02))
	draw_arc(Vector2(1150, 330), 84.0, PI, TAU, 20, BRICK.lightened(0.08), 8.0, true)
	_polygon([Vector2(1070, 540), Vector2(1100, 470), Vector2(1160, 440), Vector2(1230, 480), Vector2(1230, 540)], COAL)
	for lump: Vector2 in [Vector2(1110, 480), Vector2(1150, 458), Vector2(1190, 476), Vector2(1130, 510), Vector2(1200, 512)]:
		draw_line(lump, lump + Vector2(10, -4), Color(0.3, 0.2, 0.16), 1.5)


## Worn stone flags, seen in perspective.
func _draw_floor() -> void:
	_vertical_gradient(Rect2(0, FLOOR_Y, room_size.x, room_size.y - FLOOR_Y), Color(0.15, 0.12, 0.11), Color(0.06, 0.05, 0.05))
	var rows: Array[float] = [540.0, 560.0, 588.0, 626.0, 676.0, 740.0]
	for row in range(rows.size() - 1):
		draw_line(Vector2(0, rows[row]), Vector2(room_size.x, rows[row]), Color(0, 0, 0, 0.5), 1.5)
		var width := 90.0 + row * 26.0
		var x := 640.0 - ceilf(640.0 / width) * width + (width * 0.5 if row % 2 == 0 else 0.0)
		while x < room_size.x:
			draw_line(Vector2(x, rows[row]), Vector2(x, rows[row + 1]), Color(0, 0, 0, 0.45), 1.5)
			x += width
	draw_rect(Rect2(0, FLOOR_Y - 6, room_size.x, 6), MORTAR)


## The orange light that spills from the fire door over the wall and the floor.
func _draw_fire_glow() -> void:
	_glow(Vector2(490, 470), 90.0, 6, 46.0, Color(1.0, 0.4, 0.1, 0.035))
	for ring in range(4):
		_ellipse(Vector2(490, 596), Vector2(110.0 + ring * 70.0, 24.0 + ring * 16.0), Color(1.0, 0.42, 0.1, 0.05))


## The timber bay the coal is tipped into (the game draws the bunker front).
func _draw_coal_bunker() -> void:
	_ellipse(Vector2(BUNKER_RECT.get_center().x, FLOOR_Y + 5), Vector2(76, 7), Color(0, 0, 0, 0.5))
	# Back boards and the heap of coal showing above the front
	draw_rect(Rect2(62, 404, 130, 136), WOOD_DARK)
	for board_y: float in [404.0, 426.0, 448.0]:
		draw_line(Vector2(62, board_y), Vector2(192, board_y), Color(0, 0, 0, 0.6), 1.0)
	_polygon([Vector2(68, 456), Vector2(86, 432), Vector2(120, 420), Vector2(156, 430), Vector2(186, 456)], COAL)
	for lump: Vector2 in [Vector2(92, 436), Vector2(118, 426), Vector2(144, 434), Vector2(164, 446), Vector2(104, 448)]:
		draw_line(lump, lump + Vector2(9, -3), Color(0.36, 0.22, 0.14), 1.5)
	# Corner posts
	draw_rect(Rect2(60, 400, 10, 140), WOOD)
	draw_rect(Rect2(185, 400, 8, 140), WOOD)
	# Coal spilt on the floor in front
	for lump: Vector2 in [Vector2(84, 548), Vector2(112, 556), Vector2(160, 550), Vector2(196, 558), Vector2(62, 560)]:
		_ellipse(lump, Vector2(6, 4), COAL)
		draw_line(lump + Vector2(-3, -2), lump + Vector2(3, -3), Color(0.32, 0.2, 0.14), 1.0)


## Hobbs's chalk note above the bunker. It is the code of the meter box.
func _draw_chalk_note() -> void:
	draw_rect(CHALK_RECT, Color(0.03, 0.03, 0.03, 0.8))
	draw_rect(CHALK_RECT, Color(0, 0, 0, 0.6), false, 2.0)
	draw_string(ThemeDB.fallback_font, CHALK_RECT.position + Vector2(10, 25), "NEXT COAL 23-11", HORIZONTAL_ALIGNMENT_LEFT, -1, 18, CHALK)
	draw_line(CHALK_RECT.position + Vector2(10, 31), CHALK_RECT.position + Vector2(170, 30), Color(CHALK, 0.6), 1.5)
	# An arrow down to the bunker, and a smear where an older date was rubbed out
	draw_line(Vector2(100, 352), Vector2(100, 380), Color(CHALK, 0.5), 1.5)
	draw_polyline(PackedVector2Array([Vector2(95, 373), Vector2(100, 381), Vector2(105, 373)]), Color(CHALK, 0.5), 1.5)
	_ellipse(Vector2(230, 300), Vector2(20, 6), Color(CHALK, 0.08))


## The lagged warm-air duct the pipe hatch opens into, and the locker's corner.
func _draw_duct_and_locker() -> void:
	# The duct runs along the wall from the left, low down, and ends at the hatch
	draw_rect(Rect2(0, 386, 160, 24), Color(0.4, 0.38, 0.33))
	draw_rect(Rect2(0, 386, 160, 5), Color(0.52, 0.5, 0.44))
	draw_rect(Rect2(0, 405, 160, 5), Color(0.24, 0.22, 0.2))
	for band_x: float in [30.0, 76.0, 122.0]:
		draw_rect(Rect2(band_x, 384, 5, 28), IRON)
	var hatch_frame := HATCH_RECT.grow(7)
	draw_rect(hatch_frame, IRON)
	draw_rect(HATCH_RECT, IRON_DARK)
	for corner: Vector2 in [hatch_frame.position + Vector2(4, 4), Vector2(hatch_frame.end.x - 4, hatch_frame.position.y + 4),
			Vector2(hatch_frame.position.x + 4, hatch_frame.end.y - 4), hatch_frame.end - Vector2(4, 4)]:
		draw_circle(corner, 2.0, IRON_LIGHT)
	# The locker stands in a shadowed corner on two short feet
	draw_rect(LOCKER_RECT.grow(5), Color(0, 0, 0, 0.5))
	draw_rect(Rect2(LOCKER_RECT.position.x + 4, LOCKER_RECT.end.y, 8, 4), IRON_DARK)
	draw_rect(Rect2(LOCKER_RECT.end.x - 12, LOCKER_RECT.end.y, 8, 4), IRON_DARK)
	_ellipse(Vector2(LOCKER_RECT.get_center().x, FLOOR_Y + 5), Vector2(44, 5), Color(0, 0, 0, 0.5))
	# Where the clinker rake stands, between the bunker and the locker
	_ellipse(Vector2(205, FLOOR_Y + 2), Vector2(10, 3), Color(0, 0, 0, 0.6))
	draw_line(Vector2(196, 500), Vector2(214, 500), Color(0.5, 0.2, 0.08, 0.3), 1.0)


## The big riveted boiler on its brick setting, and the glow round its fire door.
func _draw_boiler() -> void:
	_ellipse(Vector2(490, FLOOR_Y + 6), Vector2(130, 10), Color(0, 0, 0, 0.55))
	# The flue, up through the ceiling
	draw_rect(Rect2(536, 0, 40, 214), IRON_DARK)
	draw_rect(Rect2(540, 0, 6, 214), Color(IRON_LIGHT, 0.5))
	for band_y: float in [120.0, 176.0]:
		draw_rect(Rect2(533, band_y, 46, 6), IRON)
	# The shell
	_rounded_rect(BOILER_RECT, IRON_DARK, 44)
	_rounded_rect(Rect2(BOILER_RECT.position + Vector2(4, 4), BOILER_RECT.size - Vector2(8, 8)), IRON, 40)
	_horizontal_gradient(Rect2(404, 236, 80, 250), Color(1.0, 0.6, 0.3, 0.1), Color(1.0, 0.6, 0.3, 0.0))
	_horizontal_gradient(Rect2(520, 236, 66, 250), Color(0, 0, 0, 0.0), Color(0, 0, 0, 0.35))
	# Riveted seams
	for seam_y: float in [236.0, 318.0, 410.0]:
		draw_line(Vector2(396, seam_y), Vector2(584, seam_y), IRON_DARK, 2.0)
		for i in range(14):
			draw_circle(Vector2(402 + i * 13.5, seam_y - 5), 2.0, IRON_LIGHT)
	for i in range(12):
		draw_circle(Vector2(398, 250 + i * 20.0), 1.8, IRON_LIGHT)
		draw_circle(Vector2(582, 250 + i * 20.0), 1.8, Color(IRON_LIGHT, 0.6))
	# The brick setting it stands on, with the ash pit in the middle
	draw_rect(Rect2(378, 506, 224, 34), BRICK.lightened(0.06))
	draw_rect(Rect2(378, 506, 224, 34), MORTAR, false, 1.5)
	draw_line(Vector2(378, 522), Vector2(602, 522), MORTAR, 1.0)
	for joint_x: float in [410.0, 440.0, 540.0, 570.0]:
		draw_line(Vector2(joint_x, 506), Vector2(joint_x, 522), MORTAR, 1.0)
	draw_rect(Rect2(452, 514, 76, 26), Color(0.03, 0.02, 0.02))
	draw_rect(Rect2(456, 530, 68, 10), Color(EMBER, 0.6))
	# The door frame: firelight leaks out all round the door
	var frame := FIRE_DOOR_RECT.grow(9)
	draw_rect(frame, IRON_DARK)
	_glow(FIRE_DOOR_RECT.get_center(), 46.0, 4, 7.0, Color(1.0, 0.4, 0.1, 0.07))
	draw_rect(FIRE_DOOR_RECT.grow(3), EMBER)
	draw_rect(FIRE_DOOR_RECT, FIRE)
	for hinge_y: float in [448.0, 488.0]:
		draw_rect(Rect2(frame.position.x - 5, hinge_y, 10, 8), IRON_LIGHT)
	draw_rect(Rect2(frame.end.x - 3, 464, 12, 6), IRON_LIGHT)


## What is bolted to the boiler: the gauge stem, the plate's seat, a sight glass,
## the safety valve, and the board the gauge case hangs on.
func _draw_boiler_fittings() -> void:
	# The stem and backing ring of the pressure gauge
	draw_line(GAUGE_AT, GAUGE_AT + Vector2(0, 26), COPPER, 4.0)
	draw_rect(Rect2(GAUGE_AT.x - 6, GAUGE_AT.y + 24, 12, 6), IRON_LIGHT)
	draw_circle(GAUGE_AT, 14.0, IRON_DARK)
	draw_arc(GAUGE_AT, 14.0, 0.0, TAU, 24, COPPER, 1.5, true)
	# A faint seat where the maker's plate is riveted on
	draw_rect(PLATE_RECT.grow(2), Color(0.5, 0.36, 0.14, 0.35))
	draw_rect(PLATE_RECT.grow(2), Color(0.7, 0.52, 0.22, 0.6), false, 1.0)
	for corner: Vector2 in [PLATE_RECT.position, Vector2(PLATE_RECT.end.x, PLATE_RECT.position.y),
			Vector2(PLATE_RECT.position.x, PLATE_RECT.end.y), PLATE_RECT.end]:
		draw_circle(corner, 1.5, Color(0.7, 0.52, 0.22, 0.8))
	# Water sight glass
	draw_rect(Rect2(563, 258, 6, 50), Color(0.7, 0.85, 0.9, 0.35))
	draw_rect(Rect2(563, 284, 6, 24), Color(0.5, 0.7, 0.8, 0.5))
	draw_rect(Rect2(559, 254, 14, 5), COPPER)
	draw_rect(Rect2(559, 307, 14, 5), COPPER)
	# Safety valve with its weighted lever, on the crown
	draw_rect(Rect2(478, 188, 12, 16), COPPER)
	draw_line(Vector2(474, 189), Vector2(524, 184), IRON_LIGHT, 3.0)
	draw_circle(Vector2(522, 187), 6.0, IRON_DARK)
	# The board on the wall for the gauge case, and its two brackets
	var board := GAUGE_CASE_RECT.grow(6)
	draw_rect(Rect2(board.position + Vector2(4, 4), board.size), Color(0, 0, 0, 0.45))
	draw_rect(board, WOOD_DARK)
	for bracket_x: float in [board.position.x + 10, board.end.x - 14]:
		_polygon([Vector2(bracket_x, board.end.y), Vector2(bracket_x + 4, board.end.y), Vector2(bracket_x + 4, board.end.y + 10)], IRON_LIGHT)


## The iron hearth plate on the floor in front of the ash pit (the ash pan sits on it).
func _draw_hearth() -> void:
	_polygon([Vector2(432, 544), Vector2(548, 544), Vector2(566, 624), Vector2(414, 624)], IRON_DARK)
	draw_polyline(PackedVector2Array([Vector2(432, 544), Vector2(548, 544), Vector2(566, 624), Vector2(414, 624), Vector2(432, 544)]),
		Color(IRON_LIGHT, 0.6), 1.5)
	_polygon([Vector2(440, 548), Vector2(540, 548), Vector2(548, 580), Vector2(432, 580)], Color(1.0, 0.42, 0.1, 0.12))
	# Ash and clinker raked out round it
	for heap: Vector2 in [Vector2(424, 630), Vector2(552, 634), Vector2(604, 628)]:
		_ellipse(heap, Vector2(16, 4), Color(0.4, 0.38, 0.36, 0.6))
	for cinder: Vector2 in [Vector2(420, 628), Vector2(548, 632), Vector2(612, 626), Vector2(470, 640)]:
		draw_circle(cinder, 1.5, Color(EMBER, 0.8))


## The steam main and its three nozzles, the three valve stubs, and the smaller pipes.
func _draw_overhead_pipes() -> void:
	# A thin copper pipe above the main, with hangers from the ceiling
	draw_rect(Rect2(0, 62, room_size.x, 6), COPPER.darkened(0.3))
	for hanger_x: float in [90.0, 260.0, 410.0, 720.0, 880.0, 1040.0, 1200.0]:
		draw_rect(Rect2(hanger_x, 0, 4, MAIN_PIPE_RECT.end.y + 2), IRON_DARK)
	# The lagged steam main
	draw_rect(MAIN_PIPE_RECT, IRON)
	draw_rect(Rect2(MAIN_PIPE_RECT.position, Vector2(MAIN_PIPE_RECT.size.x, 4)), IRON_LIGHT)
	draw_rect(Rect2(0, MAIN_PIPE_RECT.end.y - 4, MAIN_PIPE_RECT.size.x, 4), IRON_DARK)
	var flange_x := 40.0
	while flange_x < room_size.x:
		draw_rect(Rect2(flange_x, MAIN_PIPE_RECT.position.y - 3, 7, MAIN_PIPE_RECT.size.y + 6), IRON_DARK)
		flange_x += 155.0
	# A nozzle pointing down at the top centre of every jet
	for nozzle_x: float in NOZZLE_XS:
		draw_rect(Rect2(nozzle_x - 7, MAIN_PIPE_RECT.end.y, 14, 10), COPPER)
		_polygon([Vector2(nozzle_x - 11, 104), Vector2(nozzle_x + 11, 104), Vector2(nozzle_x + 6, 113), Vector2(nozzle_x - 6, 113)],
			COPPER.lightened(0.15))
		draw_rect(Rect2(nozzle_x - 4, 111, 8, 3), IRON_DARK)
	# A pipe stub down the wall to each valve body (the red wheels are drawn on these)
	for valve_x: float in VALVE_XS:
		draw_rect(Rect2(valve_x - 6, MAIN_PIPE_RECT.end.y, 12, VALVE_Y - MAIN_PIPE_RECT.end.y), IRON)
		draw_rect(Rect2(valve_x - 6, MAIN_PIPE_RECT.end.y, 3, VALVE_Y - MAIN_PIPE_RECT.end.y), IRON_LIGHT)
		draw_rect(Rect2(valve_x - 9, 196, 18, 5), IRON_DARK)
		draw_rect(Rect2(valve_x - 24, VALVE_Y - 7, 48, 14), IRON)
		draw_rect(Rect2(valve_x - 28, VALVE_Y - 10, 6, 20), IRON_DARK)
		draw_rect(Rect2(valve_x + 22, VALVE_Y - 10, 6, 20), IRON_DARK)
		draw_circle(Vector2(valve_x, VALVE_Y), 15.0, IRON_DARK)
		draw_circle(Vector2(valve_x, VALVE_Y), 11.0, COPPER.darkened(0.2))
	# A branch pipe along the left wall: the stoker's cap hangs on its drain cock
	draw_rect(Rect2(0, 200, VALVE_XS[0] - 6, 12), IRON)
	draw_rect(Rect2(0, 200, VALVE_XS[0] - 6, 3), IRON_LIGHT)
	for band_x: float in [56.0, 236.0]:
		draw_rect(Rect2(band_x, 197, 6, 18), IRON_DARK)
	draw_rect(Rect2(127, 186, 6, 14), COPPER)
	draw_rect(Rect2(121, 184, 18, 4), COPPER.lightened(0.15))
	# A branch pipe along the right wall, behind the lift shaft
	draw_rect(Rect2(VALVE_XS[1] + 6, 178, room_size.x - VALVE_XS[1] - 6, 10), IRON)
	draw_rect(Rect2(VALVE_XS[1] + 6, 178, room_size.x - VALVE_XS[1] - 6, 3), IRON_LIGHT)
	# A down pipe at each end of the room
	draw_rect(Rect2(24, MAIN_PIPE_RECT.end.y, 10, FLOOR_Y - MAIN_PIPE_RECT.end.y), IRON_DARK)
	draw_rect(Rect2(1018, MAIN_PIPE_RECT.end.y, 10, FLOOR_Y - MAIN_PIPE_RECT.end.y), IRON_DARK)


## The stoker's workbench, with a rack of tools on the wall over it.
func _draw_workbench() -> void:
	_ellipse(Vector2(BENCH_TOP_RECT.get_center().x, FLOOR_Y + 5), Vector2(64, 6), Color(0, 0, 0, 0.5))
	# Tool rack: a hammer, a saw and a pair of tongs hanging on nails
	draw_rect(Rect2(698, 312, 98, 8), WOOD_DARK)
	draw_line(Vector2(714, 318), Vector2(714, 366), WOOD, 3.0)
	draw_rect(Rect2(706, 362, 16, 8), IRON_LIGHT)
	_polygon([Vector2(736, 320), Vector2(762, 320), Vector2(756, 372), Vector2(748, 372)], IRON_LIGHT.darkened(0.2))
	draw_rect(Rect2(738, 316, 22, 8), WOOD)
	draw_line(Vector2(778, 318), Vector2(774, 372), IRON_DARK, 2.5)
	draw_line(Vector2(782, 318), Vector2(788, 372), IRON_DARK, 2.5)
	# Legs, front rail (the drawer slides in it) and a low shelf
	for leg_x: float in [694.0, 790.0]:
		draw_rect(Rect2(leg_x, BENCH_TOP_RECT.end.y, 8, FLOOR_Y - BENCH_TOP_RECT.end.y), WOOD_DARK)
	draw_rect(Rect2(698, BENCH_TOP_RECT.end.y, 96, 34), WOOD)
	draw_rect(Rect2(698, BENCH_TOP_RECT.end.y, 96, 34), WOOD_DARK, false, 1.5)
	draw_rect(Rect2(696, 510, 100, 6), WOOD_DARK)
	_rounded_rect(Rect2(706, 494, 30, 16), Color(0.3, 0.12, 0.08), 3)  # an oil can on the shelf
	draw_line(Vector2(736, 498), Vector2(750, 490), IRON_LIGHT, 2.0)
	# The top, scarred and oil-stained
	draw_rect(BENCH_TOP_RECT, WOOD.lightened(0.12))
	draw_rect(Rect2(BENCH_TOP_RECT.position.x, BENCH_TOP_RECT.end.y - 3, BENCH_TOP_RECT.size.x, 3), WOOD_DARK)
	draw_rect(Rect2(724, 441, 12, 3), Color(0, 0, 0, 0.4))


## The board on the wall the meter box is screwed to, and its conduit.
func _draw_meter_board() -> void:
	var board := METER_RECT.grow(8)
	draw_rect(Rect2(board.position + Vector2(4, 4), board.size), Color(0, 0, 0, 0.45))
	draw_rect(board, WOOD_DARK)
	draw_rect(board, Color(0, 0, 0, 0.6), false, 1.5)
	draw_line(Vector2(METER_RECT.get_center().x, board.position.y), Vector2(METER_RECT.get_center().x, 188), IRON_LIGHT, 3.0)
	draw_line(Vector2(board.end.x - 10, board.end.y), Vector2(board.end.x - 10, 312), IRON_LIGHT, 2.0)


## The service lift: a boarded shaft up the wall, the gate frame and the winding gear.
func _draw_service_lift() -> void:
	# The boarded shaft, up to the ceiling
	draw_rect(Rect2(818, 118, 84, 272), WOOD_DARK)
	for board_x: float in [839.0, 860.0, 881.0]:
		draw_line(Vector2(board_x, 118), Vector2(board_x, 382), Color(0, 0, 0, 0.6), 1.0)
	draw_rect(Rect2(814, 114, 92, 6), WOOD)
	# The gate frame and the dark shaft behind the gate
	var frame := Rect2(LIFT_RECT.position.x - 7, LIFT_RECT.position.y - 8, LIFT_RECT.size.x + 14, LIFT_RECT.size.y + 8)
	draw_rect(frame, WOOD)
	draw_rect(frame, WOOD_DARK, false, 2.0)
	draw_rect(LIFT_RECT, Color(0.03, 0.03, 0.03))
	draw_line(Vector2(860, 390), Vector2(860, 470), Color(0.5, 0.42, 0.3, 0.7), 1.5)  # the rope
	draw_rect(Rect2(826, 470, 68, 6), WOOD_DARK)  # the tray shelf of the car
	# The card over the gate
	draw_rect(Rect2(822, 344, 76, 30), Color(0.86, 0.82, 0.68))
	draw_string(ThemeDB.fallback_font, Vector2(827, 357), "DISPENSARY", HORIZONTAL_ALIGNMENT_LEFT, -1, 10, Color(0.14, 0.12, 0.14))
	draw_string(ThemeDB.fallback_font, Vector2(838, 370), "- WARDS", HORIZONTAL_ALIGNMENT_LEFT, -1, 10, Color(0.14, 0.12, 0.14))
	# The winding gear beside it, with an empty square socket for the crank
	draw_circle(Vector2(932, 440), 10.0, IRON_DARK)
	draw_arc(Vector2(932, 440), 10.0, 0.0, TAU, 20, IRON_LIGHT, 1.5, true)
	draw_rect(Rect2(929, 437, 6, 6), Color(0.02, 0.02, 0.02))
	draw_line(Vector2(932, 430), Vector2(932, 392), Color(0.5, 0.42, 0.3, 0.7), 1.5)


## Shadows under the things on the floor, puddles under the jets and a coal scuttle.
func _draw_floor_things() -> void:
	# Under the tool box
	_ellipse(Vector2(760, 654), Vector2(50, 6), Color(0, 0, 0, 0.5))
	# Condensation pooled on the flags at the foot of each jet
	for nozzle_x: float in NOZZLE_XS:
		_ellipse(Vector2(nozzle_x, 566), Vector2(46, 5), Color(0.5, 0.56, 0.6, 0.12))
		_ellipse(Vector2(nozzle_x - 8, 565), Vector2(16, 2), Color(1.0, 0.6, 0.3, 0.14))
	# A drip of oil where the rag was dropped
	_ellipse(Vector2(640, 672), Vector2(22, 4), Color(0, 0, 0, 0.4))
	# A coal scuttle far right, under the objective list
	_ellipse(Vector2(1110, 668), Vector2(40, 6), Color(0, 0, 0, 0.5))
	_polygon([Vector2(1078, 604), Vector2(1146, 612), Vector2(1136, 664), Vector2(1088, 664)], IRON)
	_polygon([Vector2(1080, 606), Vector2(1100, 592), Vector2(1128, 594), Vector2(1144, 612)], COAL)
	draw_arc(Vector2(1112, 606), 30.0, PI + 0.3, TAU - 0.3, 14, IRON_LIGHT, 2.0, true)
