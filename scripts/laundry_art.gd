@tool
class_name LaundryArt
extends RoomArt
## Placeholder drawing of House Three, Chapter Three: the wash-house in the
## cellar of Hollowmere Sanatorium, at night. See room_art.gd for how to
## replace it with a real image.
##
## Layout, left to right along the back wall: the wash copper in its brick
## setting (flue pipe on its left, the mouth of the laundry chute above, the
## lighting-up time chalked just over it: that is the code of the drying
## cabinet), the stone sink with a wall shelf over it and the cash tin's shelf
## beside it, a hook for a smock, the linen press and Nell's locker under the
## notice board, the drying cabinet and the iron door of the boiler room.
## On the flagstones in front: the sorting basket, the soap crate, the mangle
## (its drawer under the rollers) and the ironing table (its drawer in the apron).
##
## DryingRail draws the rail (y = 120) and the travelling sheets (down to
## y = 400). Everything between y = 170 and y = 370 on the back wall is meant
## to be hidden by them; everything else is kept below y = 415.

const FLOOR_Y := 540.0
const COPPER_BLOCK_RECT := Rect2(62, 446, 136, 100)
const CHALK_PATCH_RECT := Rect2(88, 418, 152, 28)
const CHUTE_RECT := Rect2(116, 150, 100, 92)
const SINK_RECT := Rect2(235, 470, 140, 42)
const WALL_SHELF_RECT := Rect2(232, 300, 160, 7)
const TIN_SHELF_RECT := Rect2(388, 460, 90, 6)
const BOARD_RECT := Rect2(560, 205, 160, 120)
const PRESS_RECT := Rect2(482, 390, 96, 150)
const LOCKER_RECT := Rect2(598, 390, 64, 150)
const CABINET_RECT := Rect2(688, 380, 84, 160)
const DOOR_RECT := Rect2(875, 327, 100, 210)
const MANGLE_X := 455.0
const TABLE_TOP_RECT := Rect2(616, 600, 188, 10)
const WHITEWASH := Color(0.5, 0.53, 0.51)
const WHITEWASH_DARK := Color(0.3, 0.33, 0.33)
const BRICK := Color(0.42, 0.24, 0.18)
const BRICK_DARK := Color(0.25, 0.14, 0.11)
const STONE := Color(0.5, 0.5, 0.47)
const STONE_DARK := Color(0.3, 0.3, 0.29)
const IRON := Color(0.15, 0.15, 0.17)
const IRON_LIGHT := Color(0.32, 0.33, 0.36)
const WOOD := Color(0.4, 0.28, 0.17)
const WOOD_DARK := Color(0.21, 0.14, 0.09)
const WOOD_PALE := Color(0.66, 0.56, 0.4)
const LINEN := Color(0.82, 0.82, 0.78)
const CHALK := Color(0.93, 0.93, 0.88)
const INK := Color(0.14, 0.14, 0.2)


func _draw_background() -> void:
	_draw_walls()
	_draw_floor()
	_draw_laundry_chute()
	_draw_wash_copper()
	_draw_sink()
	_draw_wall_shelf()
	_draw_smock_hook()
	_draw_notice_board()
	_draw_back_wall_cupboards()
	_draw_boiler_door()
	_draw_mangle()
	_draw_ironing_table()
	_draw_floor_things()


func _draw_foreground() -> void:
	_draw_vignette()


# ---------------------------------------------------------------------------

## Whitewashed brick, grey with steam, under a dark vaulted ceiling.
func _draw_walls() -> void:
	_vertical_gradient(Rect2(0, 0, room_size.x, FLOOR_Y), WHITEWASH_DARK, WHITEWASH)
	# Brick courses showing through the whitewash
	var course := 0
	var y := 72.0
	while y < FLOOR_Y:
		draw_line(Vector2(0, y), Vector2(room_size.x, y), Color(0.2, 0.22, 0.22, 0.35), 1.0)
		var x := 0.0 if course % 2 == 0 else 32.0
		while x < room_size.x:
			draw_line(Vector2(x, y), Vector2(x, y + 26.0), Color(0.2, 0.22, 0.22, 0.22), 1.0)
			x += 64.0
		y += 26.0
		course += 1
	# The ceiling and its shadow
	draw_rect(Rect2(0, 0, room_size.x, 64), Color(0.08, 0.09, 0.1))
	_vertical_gradient(Rect2(0, 64, room_size.x, 30), Color(0, 0, 0, 0.5), Color(0, 0, 0, 0))
	# Steam stains running down the wall
	for stain_x: float in [300.0, 520.0, 790.0, 1090.0]:
		_ellipse(Vector2(stain_x, 162), Vector2(70, 22), Color(0.3, 0.3, 0.22, 0.14))
		for drip in range(4):
			var drip_x := stain_x - 42.0 + drip * 28.0
			draw_line(Vector2(drip_x, 156), Vector2(drip_x, 236.0 + drip * 34.0), Color(0.28, 0.28, 0.2, 0.2), 3.0)
	# Flaking patches where the brick shows
	for patch: Vector2 in [Vector2(450, 196), Vector2(826, 356), Vector2(1120, 420), Vector2(34, 330)]:
		_ellipse(patch, Vector2(20, 11), Color(BRICK, 0.5))
		_ellipse(patch + Vector2(4, 2), Vector2(11, 6), Color(BRICK_DARK, 0.5))
	# A caged bulkhead lamp, the only light left on
	_glow(Vector2(812, 200), 16.0, 6, 14.0, Color(1.0, 0.82, 0.5, 0.035))
	draw_rect(Rect2(800, 176, 24, 8), IRON)
	_ellipse(Vector2(812, 200), Vector2(11, 15), Color(1.0, 0.86, 0.56))
	for bar_x: float in [803.0, 812.0, 821.0]:
		draw_line(Vector2(bar_x, 184), Vector2(bar_x, 216), IRON, 1.5)
	draw_line(Vector2(800, 200), Vector2(824, 200), IRON, 1.5)
	draw_line(Vector2(800, 216), Vector2(824, 216), IRON, 2.0)
	# A small barred window high up, under the objective list
	draw_rect(Rect2(1066, 164, 128, 84), STONE_DARK)
	draw_rect(Rect2(1074, 172, 112, 68), Color(0.06, 0.09, 0.15))
	for bar_x: float in [1096.0, 1118.0, 1140.0, 1162.0]:
		draw_line(Vector2(bar_x, 172), Vector2(bar_x, 240), IRON, 3.0)


## Worn stone flags with a drain and a few puddles.
func _draw_floor() -> void:
	_vertical_gradient(Rect2(0, FLOOR_Y, room_size.x, room_size.y - FLOOR_Y), Color(0.3, 0.3, 0.29), Color(0.2, 0.2, 0.2))
	var rows: Array[float] = [540.0, 564.0, 596.0, 638.0, 692.0, 760.0]
	for row in range(rows.size() - 1):
		draw_line(Vector2(0, rows[row]), Vector2(room_size.x, rows[row]), Color(0.12, 0.12, 0.12), 1.5)
		var width := 96.0 + row * 26.0
		var x := 640.0 - ceilf(640.0 / width) * width + (width * 0.5 if row % 2 == 1 else 0.0)
		while x < room_size.x:
			draw_line(Vector2(x, rows[row]), Vector2(x, rows[row + 1]), Color(0.12, 0.12, 0.12), 1.5)
			x += width
	# The skirting line of damp at the foot of the wall
	draw_rect(Rect2(0, FLOOR_Y - 6, room_size.x, 6), Color(0.16, 0.18, 0.17))
	# Drain grating
	_ellipse(Vector2(585, 606), Vector2(22, 7), IRON)
	for i in range(5):
		draw_line(Vector2(571 + i * 7.0, 601), Vector2(571 + i * 7.0, 611), IRON_LIGHT, 1.5)
	# Puddles
	_ellipse(Vector2(352, 578), Vector2(44, 6), Color(0.5, 0.56, 0.6, 0.25))
	_ellipse(Vector2(840, 598), Vector2(36, 5), Color(0.5, 0.56, 0.6, 0.2))
	_ellipse(Vector2(600, 700), Vector2(60, 7), Color(0.5, 0.56, 0.6, 0.15))


## The mouth of the laundry chute you came down, a sheet trailing out of it.
func _draw_laundry_chute() -> void:
	draw_rect(CHUTE_RECT.grow(8), IRON_LIGHT)
	draw_rect(CHUTE_RECT.grow(8), IRON, false, 2.0)
	draw_rect(CHUTE_RECT, Color(0.03, 0.03, 0.04))
	# The sloping tin lining, catching a little light
	_polygon([CHUTE_RECT.position, Vector2(CHUTE_RECT.end.x, CHUTE_RECT.position.y),
		Vector2(CHUTE_RECT.end.x - 22, CHUTE_RECT.position.y + 30), Vector2(CHUTE_RECT.position.x + 22, CHUTE_RECT.position.y + 30)],
		Color(0.14, 0.15, 0.17))
	for corner: Vector2 in [Vector2(110, 144), Vector2(222, 144), Vector2(110, 248), Vector2(222, 248)]:
		draw_circle(corner, 2.5, IRON)
	# The flap, propped open
	draw_rect(Rect2(108, 250, 116, 8), IRON)
	# A sheet caught on the lip
	_polygon([Vector2(150, 226), Vector2(196, 222), Vector2(204, 262), Vector2(186, 296), Vector2(160, 282), Vector2(146, 256)], LINEN.darkened(0.15))
	draw_line(Vector2(170, 228), Vector2(174, 284), Color(0.5, 0.5, 0.48), 1.0)
	draw_line(Vector2(186, 226), Vector2(190, 288), Color(0.5, 0.5, 0.48), 1.0)
	draw_string(ThemeDB.fallback_font, Vector2(132, 142), "LINEN", HORIZONTAL_ALIGNMENT_LEFT, -1, 11, Color(INK, 0.7))


## The brick setting of the wash copper, its firebox and flue, and the chalked lighting-up time.
func _draw_wash_copper() -> void:
	_ellipse(Vector2(COPPER_BLOCK_RECT.get_center().x, FLOOR_Y + 8), Vector2(84, 7), Color(0, 0, 0, 0.4))
	# Flue pipe: up the wall, then an elbow into the brickwork
	draw_rect(Rect2(66, 172, 16, 276), IRON)
	draw_rect(Rect2(68, 172, 4, 276), IRON_LIGHT)
	draw_rect(Rect2(52, 160, 30, 16), IRON)
	for band_y: float in [240.0, 340.0, 430.0]:
		draw_rect(Rect2(64, band_y, 20, 5), IRON_LIGHT)
	# Soot on the wall round the pipe
	_ellipse(Vector2(74, 300), Vector2(22, 120), Color(0, 0, 0, 0.12))
	# The brick block
	draw_rect(COPPER_BLOCK_RECT, BRICK)
	for row in range(5):
		var row_y := COPPER_BLOCK_RECT.position.y + 8.0 + row * 20.0
		draw_line(Vector2(COPPER_BLOCK_RECT.position.x, row_y), Vector2(COPPER_BLOCK_RECT.end.x, row_y), BRICK_DARK, 1.5)
		var joint_x := COPPER_BLOCK_RECT.position.x + (18.0 if row % 2 == 0 else 36.0)
		while joint_x < COPPER_BLOCK_RECT.end.x:
			draw_line(Vector2(joint_x, row_y), Vector2(joint_x, minf(row_y + 20.0, COPPER_BLOCK_RECT.end.y)), BRICK_DARK, 1.5)
			joint_x += 36.0
	# Stone slab on top, with the round hole the copper sits in
	draw_rect(Rect2(COPPER_BLOCK_RECT.position.x - 4, COPPER_BLOCK_RECT.position.y - 2, COPPER_BLOCK_RECT.size.x + 8, 8), STONE)
	draw_rect(Rect2(80, 448, 100, 78), Color(0.06, 0.05, 0.05))
	# Firebox door under the copper, long cold
	draw_rect(Rect2(108, 527, 44, 17), IRON)
	draw_rect(Rect2(108, 527, 44, 17), IRON_LIGHT, false, 1.0)
	draw_circle(Vector2(146, 535), 2.0, IRON_LIGHT)
	_ellipse(Vector2(130, 548), Vector2(26, 3), Color(0.5, 0.5, 0.48, 0.6))  # spilt ash
	# The lighting-up time, chalked on a patch of sooty bare brick
	draw_rect(CHALK_PATCH_RECT, Color(0.16, 0.14, 0.14))
	draw_rect(CHALK_PATCH_RECT, Color(0.1, 0.09, 0.09), false, 1.0)
	draw_string(ThemeDB.fallback_font, CHALK_PATCH_RECT.position + Vector2(7, 20), "COPPER LIT 05.40", HORIZONTAL_ALIGNMENT_LEFT, -1, 15, CHALK)
	draw_line(CHALK_PATCH_RECT.position + Vector2(96, 24), CHALK_PATCH_RECT.position + Vector2(144, 24), Color(CHALK, 0.7), 1.0)


## The big stone sink on brick piers, its tap, and the little shelf beside it for the cash tin.
func _draw_sink() -> void:
	_ellipse(Vector2(SINK_RECT.get_center().x, FLOOR_Y + 6), Vector2(78, 6), Color(0, 0, 0, 0.35))
	# Piers
	for pier_x: float in [243.0, 345.0]:
		draw_rect(Rect2(pier_x, SINK_RECT.end.y, 22, FLOOR_Y - SINK_RECT.end.y), BRICK)
		draw_line(Vector2(pier_x, SINK_RECT.end.y + 14), Vector2(pier_x + 22, SINK_RECT.end.y + 14), BRICK_DARK, 1.0)
	draw_rect(Rect2(265, SINK_RECT.end.y, 80, FLOOR_Y - SINK_RECT.end.y), Color(0.05, 0.05, 0.06))
	# Waste pipe
	draw_rect(Rect2(300, SINK_RECT.end.y, 8, 26), IRON_LIGHT)
	# Trough
	draw_rect(SINK_RECT, STONE)
	draw_rect(Rect2(SINK_RECT.position, Vector2(SINK_RECT.size.x, 6)), STONE.lightened(0.2))
	draw_rect(Rect2(SINK_RECT.position.x, SINK_RECT.end.y - 5, SINK_RECT.size.x, 5), STONE_DARK)
	draw_line(Vector2(292, 478), Vector2(296, 508), Color(0.36, 0.36, 0.3, 0.6), 2.0)  # a rust streak
	# Tap on a pipe that comes along the wall
	draw_line(Vector2(240, 436), Vector2(322, 436), IRON_LIGHT, 4.0)
	draw_line(Vector2(322, 434), Vector2(322, 452), IRON_LIGHT, 4.0)
	draw_rect(Rect2(314, 428, 16, 4), Color(0.7, 0.55, 0.28))
	draw_line(Vector2(322, 454), Vector2(322, 468), Color(0.7, 0.8, 0.9, 0.35), 1.0)  # a slow drip
	# Duckboard to stand on
	draw_rect(Rect2(244, 548, 122, 8), WOOD_DARK)
	for i in range(6):
		draw_line(Vector2(250 + i * 22.0, 548), Vector2(250 + i * 22.0, 556), WOOD, 3.0)
	# The shelf by the sink (the cash tin stands on it)
	draw_rect(TIN_SHELF_RECT, WOOD)
	draw_rect(Rect2(TIN_SHELF_RECT.position.x, TIN_SHELF_RECT.end.y - 2, TIN_SHELF_RECT.size.x, 2), WOOD_DARK)
	for bracket_x: float in [398.0, 464.0]:
		_polygon([Vector2(bracket_x, 466), Vector2(bracket_x + 5, 466), Vector2(bracket_x + 5, 490)], IRON)
		draw_rect(Rect2(bracket_x + 3, 466, 3, 26), IRON)


## The long shelf on the back wall, with a packet of starch on it.
func _draw_wall_shelf() -> void:
	draw_rect(Rect2(WALL_SHELF_RECT.position.x + 4, WALL_SHELF_RECT.end.y, WALL_SHELF_RECT.size.x - 8, 5), Color(0, 0, 0, 0.25))
	draw_rect(WALL_SHELF_RECT, WOOD)
	draw_rect(Rect2(WALL_SHELF_RECT.position, Vector2(WALL_SHELF_RECT.size.x, 2)), WOOD.lightened(0.2))
	for bracket_x: float in [246.0, 372.0]:
		_polygon([Vector2(bracket_x, 307), Vector2(bracket_x + 6, 307), Vector2(bracket_x + 6, 332)], IRON)
	# A packet of starch, between the two things worth finding
	draw_rect(Rect2(298, 276, 18, 24), Color(0.3, 0.4, 0.58))
	draw_rect(Rect2(300, 282, 14, 9), Color(0.86, 0.86, 0.8))
	# A coil of spare washing line at the far end
	draw_arc(Vector2(380, 293), 6.0, 0.0, TAU, 14, WOOD_PALE, 2.0, true)


## A row of iron hooks; the smock hangs on the middle one.
func _draw_smock_hook() -> void:
	draw_rect(Rect2(410, 262, 60, 6), WOOD_DARK)
	for hook_x: float in [418.0, 440.0, 462.0]:
		draw_line(Vector2(hook_x, 265), Vector2(hook_x, 272), IRON, 2.0)
		draw_arc(Vector2(hook_x, 274), 3.0, 0.0, PI, 8, IRON, 2.0, true)


## The cork notice board: wash-day rota, rules, and room for one pink ticket.
func _draw_notice_board() -> void:
	draw_rect(BOARD_RECT.grow(5), WOOD_DARK)
	draw_rect(BOARD_RECT, Color(0.52, 0.4, 0.26))
	var font := ThemeDB.fallback_font
	var at := BOARD_RECT.position
	# The rota
	draw_rect(Rect2(at.x + 8, at.y + 10, 58, 76), Color(0.9, 0.88, 0.8))
	draw_string(font, at + Vector2(12, 24), "WASH DAYS", HORIZONTAL_ALIGNMENT_LEFT, -1, 8, Color(0.5, 0.1, 0.1))
	for i in range(6):
		draw_line(at + Vector2(12, 34 + i * 8.0), at + Vector2(60 if i != 5 else 40, 34 + i * 8.0), Color(INK, 0.6), 1.0)
	draw_circle(at + Vector2(37, 14), 2.0, Color(0.7, 0.14, 0.12))
	# A rule, typed and pinned low down
	draw_rect(Rect2(at.x + 20, at.y + 92, 110, 22), Color(0.94, 0.93, 0.88))
	draw_string(font, at + Vector2(25, 107), "WARD 7: BY HAND", HORIZONTAL_ALIGNMENT_LEFT, -1, 10, INK)
	draw_circle(at + Vector2(24, 96), 2.0, Color(0.2, 0.3, 0.6))
	# The bare cork where the laundry ticket is pinned
	draw_rect(Rect2(at.x + 72, at.y + 44, 38, 26), Color(0.44, 0.33, 0.21))
	# A curling bus timetable in the corner
	_polygon([at + Vector2(122, 12), at + Vector2(152, 10), at + Vector2(153, 50), at + Vector2(144, 56), at + Vector2(123, 54)], Color(0.8, 0.8, 0.66))
	for i in range(4):
		draw_line(at + Vector2(126, 20 + i * 8.0), at + Vector2(148, 20 + i * 8.0), Color(INK, 0.5), 1.0)


## What the linen press, Nell's locker and the drying cabinet stand against, and the cabinet's duct.
func _draw_back_wall_cupboards() -> void:
	for rect: Rect2 in [PRESS_RECT, LOCKER_RECT, CABINET_RECT]:
		# Shadow on the wall and on the flags, and a dark recess behind
		draw_rect(Rect2(rect.position.x + 6, rect.position.y + 6, rect.size.x + 4, rect.size.y - 6), Color(0, 0, 0, 0.3))
		draw_rect(rect, Color(0.07, 0.07, 0.08))
		_ellipse(Vector2(rect.get_center().x, FLOOR_Y + 4), Vector2(rect.size.x * 0.6, 5), Color(0, 0, 0, 0.4))
	# The cornice of the linen press
	draw_rect(Rect2(PRESS_RECT.position.x - 5, PRESS_RECT.position.y - 8, PRESS_RECT.size.x + 10, 9), WOOD_PALE.darkened(0.25))
	draw_rect(Rect2(PRESS_RECT.position.x - 5, PRESS_RECT.position.y - 8, PRESS_RECT.size.x + 10, 2), WOOD_PALE)
	# A cap of slanted tin on the locker
	_polygon([Vector2(LOCKER_RECT.position.x - 2, LOCKER_RECT.position.y + 1), Vector2(LOCKER_RECT.end.x + 2, LOCKER_RECT.position.y + 1),
		Vector2(LOCKER_RECT.end.x - 4, LOCKER_RECT.position.y - 8), Vector2(LOCKER_RECT.position.x + 4, LOCKER_RECT.position.y - 8)],
		Color(0.2, 0.26, 0.24))
	# The warm-air duct out of the top of the drying cabinet
	var duct_x := CABINET_RECT.get_center().x
	draw_rect(Rect2(duct_x - 11, 344, 22, 38), IRON_LIGHT)
	draw_rect(Rect2(duct_x - 11, 344, 6, 38), IRON_LIGHT.lightened(0.15))
	draw_rect(Rect2(duct_x - 15, 336, 30, 10), IRON)
	draw_rect(Rect2(CABINET_RECT.position.x - 3, CABINET_RECT.position.y - 4, CABINET_RECT.size.x + 6, 5), IRON)
	# Chalked beside the cabinet, on another sooty patch
	draw_rect(Rect2(782, 418, 78, 38), Color(0.16, 0.14, 0.14))
	var font := ThemeDB.fallback_font
	draw_string(font, Vector2(787, 433), "Same as", HORIZONTAL_ALIGNMENT_LEFT, -1, 11, CHALK)
	draw_string(font, Vector2(787, 449), "lighting-up", HORIZONTAL_ALIGNMENT_LEFT, -1, 11, CHALK)
	draw_line(Vector2(786, 440), Vector2(776, 440), Color(CHALK, 0.8), 1.5)
	draw_polyline(PackedVector2Array([Vector2(780, 436), Vector2(775, 440), Vector2(780, 444)]), Color(CHALK, 0.8), 1.5)


## The riveted frame of the boiler room door, its sign, and the furnace glow under it.
func _draw_boiler_door() -> void:
	_glow(Vector2(DOOR_RECT.get_center().x, FLOOR_Y), 30.0, 5, 16.0, Color(1.0, 0.35, 0.1, 0.035))
	var frame := DOOR_RECT.grow(8)
	draw_rect(frame, IRON_LIGHT)
	draw_rect(frame, IRON, false, 2.0)
	draw_rect(DOOR_RECT, Color(0.04, 0.03, 0.03))
	for rivet_y in range(int(frame.position.y) + 10, int(frame.end.y), 28):
		draw_circle(Vector2(frame.position.x + 4, rivet_y), 2.0, IRON)
		draw_circle(Vector2(frame.end.x - 4, rivet_y), 2.0, IRON)
	# Enamel sign above
	var plate := Rect2(DOOR_RECT.position.x + 4, frame.position.y - 30, 92, 22)
	draw_rect(plate, Color(0.86, 0.86, 0.8))
	draw_rect(plate, INK, false, 1.5)
	draw_string(ThemeDB.fallback_font, plate.position + Vector2(5, 16), "BOILER ROOM", HORIZONTAL_ALIGNMENT_LEFT, -1, 12, INK)
	# Red light leaking under the door and across the flags
	draw_rect(Rect2(DOOR_RECT.position.x, FLOOR_Y - 4, DOOR_RECT.size.x, 4), Color(1.0, 0.4, 0.12, 0.85))
	_polygon([Vector2(DOOR_RECT.position.x, FLOOR_Y), Vector2(DOOR_RECT.end.x, FLOOR_Y), Vector2(DOOR_RECT.end.x + 14, FLOOR_Y + 30),
		Vector2(DOOR_RECT.position.x - 14, FLOOR_Y + 30)], Color(1.0, 0.36, 0.1, 0.14))


## The iron mangle: two wooden rollers, a crank wheel, and the housing of its little drawer.
func _draw_mangle() -> void:
	_ellipse(Vector2(MANGLE_X, 694), Vector2(74, 7), Color(0, 0, 0, 0.45))
	# Side frames with splayed feet
	for side: float in [-1.0, 1.0]:
		var frame_x := MANGLE_X + side * 47.0
		draw_rect(Rect2(frame_x - 5, 562, 10, 126), IRON)
		draw_rect(Rect2(frame_x - 5, 562, 3, 126), IRON_LIGHT)
		_polygon([Vector2(frame_x - 5, 668), Vector2(frame_x + 5, 668), Vector2(frame_x + 5 + side * 12.0, 692),
			Vector2(frame_x - 5 + side * 12.0, 692)], IRON)
	# Top bar and the pressure screw
	draw_rect(Rect2(MANGLE_X - 52, 560, 104, 9), IRON)
	draw_rect(Rect2(MANGLE_X - 3, 550, 6, 28), IRON_LIGHT)
	draw_rect(Rect2(MANGLE_X - 16, 547, 32, 5), IRON)
	# Rollers
	for roller_y: float in [578.0, 598.0]:
		draw_rect(Rect2(MANGLE_X - 42, roller_y, 84, 18), WOOD_PALE)
		draw_rect(Rect2(MANGLE_X - 42, roller_y, 84, 4), WOOD_PALE.lightened(0.2))
		draw_rect(Rect2(MANGLE_X - 42, roller_y + 14, 84, 4), WOOD_PALE.darkened(0.3))
	# A corner of sheet still caught between them
	_polygon([Vector2(MANGLE_X - 30, 596), Vector2(MANGLE_X + 6, 596), Vector2(MANGLE_X + 2, 622), Vector2(MANGLE_X - 26, 620)], LINEN)
	# Drip board, and the housing the drawer slides into
	draw_rect(Rect2(MANGLE_X - 48, 620, 96, 7), WOOD)
	draw_rect(Rect2(MANGLE_X - 42, 629, 84, 32), IRON)
	draw_rect(Rect2(MANGLE_X - 42, 629, 84, 32), IRON_LIGHT, false, 1.0)
	draw_rect(Rect2(MANGLE_X - 36, 633, 72, 24), Color(0.04, 0.04, 0.05))
	# Crank wheel on the right
	var hub := Vector2(MANGLE_X + 62, 597)
	draw_arc(hub, 17.0, 0.0, TAU, 28, IRON, 4.0, true)
	for spoke in range(4):
		var direction := Vector2.from_angle(0.5 + spoke * PI * 0.5)
		draw_line(hub, hub + direction * 16.0, IRON, 2.5)
	draw_circle(hub, 4.0, IRON_LIGHT)
	draw_rect(Rect2(hub.x + 10, hub.y - 20, 6, 12), WOOD)


## The ironing table: a scorched blanket on top, a drawer in the apron, a half-pressed sheet.
func _draw_ironing_table() -> void:
	_ellipse(Vector2(TABLE_TOP_RECT.get_center().x, 696), Vector2(100, 7), Color(0, 0, 0, 0.45))
	for leg_x: float in [628.0, 782.0]:
		draw_rect(Rect2(leg_x, TABLE_TOP_RECT.end.y, 10, 696 - TABLE_TOP_RECT.end.y), WOOD_DARK)
	draw_rect(Rect2(638, 668, 144, 5), WOOD_DARK)  # stretcher
	# Apron, with the opening for the drawer
	draw_rect(Rect2(626, TABLE_TOP_RECT.end.y, 168, 30), WOOD)
	draw_rect(Rect2(666, 612, 88, 26), Color(0.06, 0.04, 0.03))
	# Top and its blanket
	draw_rect(TABLE_TOP_RECT, WOOD.lightened(0.15))
	draw_rect(Rect2(TABLE_TOP_RECT.position.x, TABLE_TOP_RECT.end.y - 3, TABLE_TOP_RECT.size.x, 3), WOOD_DARK)
	draw_rect(Rect2(630, 597, 136, 4), Color(0.56, 0.54, 0.46))
	draw_rect(Rect2(690, 597, 16, 4), Color(0.3, 0.22, 0.14))  # a scorch the shape of an iron
	# The sheet she was pressing, hanging off the right-hand end
	_polygon([Vector2(762, 596), Vector2(806, 598), Vector2(812, 660), Vector2(798, 672), Vector2(790, 640), Vector2(784, 602)], LINEN)
	draw_line(Vector2(798, 602), Vector2(802, 664), Color(0.6, 0.6, 0.56), 1.0)


## A bucket, a dolly tub and a heap of dropped washing: nothing to find in any of them.
func _draw_floor_things() -> void:
	# Faint shadows where the sorting basket and the soap crate stand
	_ellipse(Vector2(130, 664), Vector2(52, 6), Color(0, 0, 0, 0.4))
	_ellipse(Vector2(290, 666), Vector2(48, 5), Color(0, 0, 0, 0.4))
	# A galvanised bucket by the boiler door
	_ellipse(Vector2(886, 676), Vector2(30, 5), Color(0, 0, 0, 0.4))
	_polygon([Vector2(860, 626), Vector2(912, 626), Vector2(906, 674), Vector2(866, 674)], Color(0.44, 0.47, 0.5))
	_ellipse(Vector2(886, 626), Vector2(26, 5), Color(0.2, 0.22, 0.24))
	draw_arc(Vector2(886, 626), 26.0, PI, TAU, 16, IRON_LIGHT, 1.5, true)
	draw_line(Vector2(864, 650), Vector2(908, 650), Color(0.3, 0.32, 0.34), 1.5)
	# A wooden dolly tub under the objective list, with its dolly stick
	_ellipse(Vector2(1110, 664), Vector2(60, 7), Color(0, 0, 0, 0.4))
	_polygon([Vector2(1060, 566), Vector2(1160, 566), Vector2(1150, 660), Vector2(1070, 660)], WOOD)
	for hoop_y: float in [584.0, 640.0]:
		draw_line(Vector2(1062, hoop_y), Vector2(1158, hoop_y), IRON, 3.0)
	_ellipse(Vector2(1110, 566), Vector2(50, 7), WOOD_DARK)
	draw_line(Vector2(1122, 566), Vector2(1140, 470), WOOD_PALE, 5.0)
	draw_line(Vector2(1128, 474), Vector2(1152, 478), WOOD_PALE, 5.0)
	# Washing dropped on the flags, bottom left
	_ellipse(Vector2(40, 700), Vector2(46, 14), LINEN.darkened(0.3))
	_ellipse(Vector2(30, 692), Vector2(28, 10), LINEN.darkened(0.15))
