@tool
class_name GateLodgeArt
extends RoomArt
## Placeholder drawing of House Three, Chapter One: the gate lodge of
## Hollowmere Sanatorium, late at night. See room_art.gd for how to replace it
## with a real image.
##
## Layout, left to right along the back wall: the iron-bound inner door into
## the sanatorium, the porter's blackboard (its chalked date is the code of the
## key cabinet), the tall coat locker with a cap hook beside it, the iron
## stove, the porter's desk with the bell board above it (BellBoard draws the
## bells and shutters over the five pigeonholes), the key cabinet with a shelf
## under it, and the gate window. The foreground adds the porter's stool.

const FLOOR_Y := 540.0
const DADO_Y := 400.0
const DOOR_RECT := Rect2(82, 326, 104, 212)
const BLACKBOARD_RECT := Rect2(222, 116, 196, 124)
const STOVE_RECT := Rect2(372, 372, 68, 168)
## The bell board panel. The five pigeonholes must match the objects in the scene.
const BOARD_RECT := Rect2(496, 150, 376, 170)
const PIGEONHOLE_XS: Array[float] = [544.0, 614.0, 684.0, 754.0, 824.0]
const PIGEONHOLE_Y := 280.0
const PIGEONHOLE_SIZE := Vector2(60, 56)
const DESK_TOP_RECT := Rect2(468, 418, 424, 14)
const DESK_FRONT_RECT := Rect2(480, 432, 400, 108)
const KNEEHOLE_RECT := Rect2(740, 452, 90, 88)
const WINDOW_RECT := Rect2(1010, 130, 170, 200)
const SHELF_Y := 412.0
const WOOD := Color(0.32, 0.21, 0.13)
const WOOD_DARK := Color(0.18, 0.11, 0.07)
const WOOD_LIGHT := Color(0.46, 0.32, 0.2)
const IRON := Color(0.17, 0.17, 0.19)
const IRON_LIGHT := Color(0.33, 0.33, 0.36)
const STONE := Color(0.44, 0.43, 0.41)
const STONE_DARK := Color(0.28, 0.27, 0.26)
const CHALK := Color(0.9, 0.9, 0.84, 0.9)
const LAMP := Color(1.0, 0.8, 0.45)


func _draw_background() -> void:
	_draw_walls()
	_draw_floor()
	_draw_inner_door()
	_draw_blackboard()
	_draw_locker_and_hook()
	_draw_stove()
	_draw_bell_board()
	_draw_desk()
	_draw_window()
	_draw_right_wall()
	_draw_lamp_light()


func _draw_foreground() -> void:
	_draw_stool()
	_draw_vignette()


# ---------------------------------------------------------------------------

## Institution walls: cream distemper above, dark green gloss paint below.
func _draw_walls() -> void:
	_vertical_gradient(Rect2(0, 0, room_size.x, DADO_Y), Color(0.3, 0.29, 0.24), Color(0.42, 0.4, 0.32))
	_vertical_gradient(Rect2(0, DADO_Y, room_size.x, FLOOR_Y - DADO_Y), Color(0.14, 0.24, 0.2), Color(0.1, 0.18, 0.15))
	draw_rect(Rect2(0, DADO_Y - 3, room_size.x, 6), Color(0.08, 0.13, 0.11))
	# Damp stains creeping down from the ceiling
	var rng := RandomNumberGenerator.new()
	rng.seed = 3101
	for i in range(9):
		var at := Vector2(rng.randf_range(0, room_size.x), rng.randf_range(0, 60))
		_ellipse(at, Vector2(rng.randf_range(40, 110), rng.randf_range(20, 50)), Color(0.2, 0.2, 0.16, 0.25))
	draw_rect(Rect2(0, FLOOR_Y - 10, room_size.x, 10), Color(0.06, 0.1, 0.08))


## Worn stone flags.
func _draw_floor() -> void:
	_vertical_gradient(Rect2(0, FLOOR_Y, room_size.x, room_size.y - FLOOR_Y), Color(0.3, 0.29, 0.28), Color(0.4, 0.39, 0.37))
	var rows: Array[float] = [540.0, 566.0, 600.0, 644.0, 700.0, 760.0]
	for row in range(rows.size() - 1):
		draw_line(Vector2(0, rows[row]), Vector2(room_size.x, rows[row]), STONE_DARK, 1.5)
		var step := 110.0 + row * 26.0
		var x := -40.0 + (row % 2) * step * 0.5
		while x < room_size.x:
			draw_line(Vector2(x, rows[row]), Vector2(x - 8, rows[row + 1]), STONE_DARK, 1.2)
			x += step
	# The wet trail of the porter's boots, from the gate window to the inner door
	for i in range(7):
		var at := Vector2(1010, 690).lerp(Vector2(210, 572), i / 6.0)
		_ellipse(at + Vector2(0, (i % 2) * 10.0 - 5.0), Vector2(15, 6), Color(0.14, 0.15, 0.17, 0.45))


## The heavy door into the sanatorium, in a stone surround.
func _draw_inner_door() -> void:
	var arch := DOOR_RECT.grow(14)
	draw_rect(arch, STONE_DARK)
	for y in range(int(arch.position.y), int(arch.end.y), 28):
		draw_rect(Rect2(arch.position.x, y, 12, 22), STONE)
		draw_rect(Rect2(arch.end.x - 12, y + 12, 12, 22), STONE)
	draw_rect(Rect2(arch.position.x, arch.position.y, arch.size.x, 12), STONE)
	draw_rect(DOOR_RECT, Color(0.04, 0.04, 0.05))
	# An enamel sign over the lintel
	var sign_rect := Rect2(arch.position.x + 4, arch.position.y - 30, arch.size.x - 8, 22)
	draw_rect(sign_rect, Color(0.9, 0.9, 0.86))
	draw_rect(sign_rect, IRON, false, 1.5)
	draw_string(ThemeDB.fallback_font, sign_rect.position + Vector2(8, 16), "TO THE WARDS", HORIZONTAL_ALIGNMENT_LEFT, -1, 12, Color(0.12, 0.14, 0.3))
	draw_rect(Rect2(arch.position.x - 4, FLOOR_Y - 6, arch.size.x + 8, 8), STONE)


## The porter's blackboard. The chalked date is the code of the key cabinet.
func _draw_blackboard() -> void:
	draw_rect(BLACKBOARD_RECT.grow(6), WOOD)
	draw_rect(BLACKBOARD_RECT, Color(0.1, 0.13, 0.12))
	var font := ThemeDB.fallback_font
	var at := BLACKBOARD_RECT.position
	draw_string(font, at + Vector2(10, 22), "NIGHT PORTER", HORIZONTAL_ALIGNMENT_LEFT, -1, 13, CHALK)
	draw_line(at + Vector2(10, 28), at + Vector2(150, 28), CHALK, 1.0)
	draw_string(font, at + Vector2(10, 50), "Gate shut 9 sharp", HORIZONTAL_ALIGNMENT_LEFT, -1, 12, Color(CHALK, 0.6))
	draw_string(font, at + Vector2(10, 76), "WARD 7 CLOSED", HORIZONTAL_ALIGNMENT_LEFT, -1, 14, CHALK)
	draw_string(font, at + Vector2(10, 98), "14-03", HORIZONTAL_ALIGNMENT_LEFT, -1, 20, Color(1.0, 0.95, 0.7))
	draw_arc(at + Vector2(40, 91), 34.0, 0.0, TAU, 24, Color(CHALK, 0.5), 1.0, true)
	draw_string(font, at + Vector2(92, 114), "do NOT answer", HORIZONTAL_ALIGNMENT_LEFT, -1, 11, Color(CHALK, 0.6))
	# Chalk ledge with a stub of chalk and a rag
	draw_rect(Rect2(BLACKBOARD_RECT.position.x - 6, BLACKBOARD_RECT.end.y + 6, BLACKBOARD_RECT.size.x + 12, 5), WOOD_DARK)
	draw_rect(Rect2(BLACKBOARD_RECT.position.x + 30, BLACKBOARD_RECT.end.y + 2, 12, 4), Color(0.95, 0.95, 0.9))


## The alcove the coat locker stands in, and the cap hook beside it.
func _draw_locker_and_hook() -> void:
	draw_rect(Rect2(230, 326, 92, 214), Color(0, 0, 0, 0.35))
	draw_rect(Rect2(232, 322, 88, 8), IRON_LIGHT)
	# A row of three iron hooks on a board
	draw_rect(Rect2(326, 282, 44, 8), WOOD_DARK)
	for hook_x: float in [334.0, 346.0, 360.0]:
		draw_arc(Vector2(hook_x, 294), 4.0, 0.0, PI, 8, IRON, 2.0, true)


## A round-bellied iron stove with its pipe going up through the ceiling.
func _draw_stove() -> void:
	draw_rect(Rect2(398, 0, 16, STOVE_RECT.position.y), IRON)
	draw_rect(Rect2(400, 0, 4, STOVE_RECT.position.y), IRON_LIGHT)
	draw_rect(Rect2(394, 200, 24, 6), IRON_LIGHT)
	_ellipse(Vector2(STOVE_RECT.get_center().x, FLOOR_Y + 2), Vector2(46, 7), Color(0, 0, 0, 0.4))
	draw_rect(STOVE_RECT, IRON)
	draw_rect(Rect2(STOVE_RECT.position.x - 5, STOVE_RECT.position.y, STOVE_RECT.size.x + 10, 8), IRON_LIGHT)
	draw_rect(Rect2(STOVE_RECT.position.x + 4, STOVE_RECT.position.y + 12, 4, STOVE_RECT.size.y - 24), IRON_LIGHT)
	# The fire door, glowing through its slots
	var door := Rect2(STOVE_RECT.position.x + 12, STOVE_RECT.position.y + 60, 44, 50)
	draw_rect(door, Color(0.08, 0.07, 0.07))
	for i in range(4):
		draw_rect(Rect2(door.position.x + 6, door.position.y + 8 + i * 10, 32, 4), Color(1.0, 0.5, 0.15, 0.9))
	_glow(door.get_center(), 30.0, 5, 22.0, Color(1.0, 0.5, 0.2, 0.03))
	for leg_x: float in [STOVE_RECT.position.x + 4, STOVE_RECT.end.x - 10]:
		draw_rect(Rect2(leg_x, FLOOR_Y - 8, 6, 10), IRON)


## The wooden panel of the bell board with its five dark pigeonholes.
## (BellBoard draws the bells, the number plates and the shutters on top.)
func _draw_bell_board() -> void:
	draw_rect(BOARD_RECT.grow(6), WOOD_DARK)
	draw_rect(BOARD_RECT, WOOD)
	draw_rect(Rect2(BOARD_RECT.position.x, BOARD_RECT.position.y, BOARD_RECT.size.x, 4), WOOD_LIGHT)
	draw_string(ThemeDB.fallback_font, BOARD_RECT.position + Vector2(10, 16), "WARDS", HORIZONTAL_ALIGNMENT_LEFT, -1, 11, Color(0.85, 0.75, 0.5))
	for hole_x in PIGEONHOLE_XS:
		var hole := Rect2(Vector2(hole_x, PIGEONHOLE_Y) - PIGEONHOLE_SIZE / 2.0, PIGEONHOLE_SIZE)
		draw_rect(hole.grow(3), WOOD_DARK)
		draw_rect(hole, Color(0.05, 0.04, 0.03))
		draw_rect(Rect2(hole.position.x, hole.end.y - 5, hole.size.x, 5), Color(0.12, 0.09, 0.06))
		# The bell wire running up and away to the wards
		draw_line(Vector2(hole_x, BOARD_RECT.position.y + 20), Vector2(hole_x + 14, BOARD_RECT.position.y - 150), Color(0.5, 0.42, 0.25, 0.7), 1.0)


## The porter's desk: a long counter with a drawer and a kneehole for the strongbox.
func _draw_desk() -> void:
	_ellipse(Vector2(DESK_FRONT_RECT.get_center().x, FLOOR_Y + 4), Vector2(220, 9), Color(0, 0, 0, 0.4))
	draw_rect(DESK_FRONT_RECT, WOOD)
	for i in range(4):
		draw_rect(Rect2(DESK_FRONT_RECT.position.x + 12 + i * 62.0, DESK_FRONT_RECT.position.y + 50, 52, 46), WOOD_DARK, false, 2.0)
	draw_rect(KNEEHOLE_RECT, Color(0.05, 0.04, 0.03))
	draw_rect(DESK_TOP_RECT, WOOD_LIGHT)
	draw_rect(Rect2(DESK_TOP_RECT.position.x, DESK_TOP_RECT.end.y - 3, DESK_TOP_RECT.size.x, 3), WOOD_DARK)
	# On the desk: an inkwell, a brass bell-push and an open day book
	draw_rect(Rect2(700, 404, 70, 14), Color(0.9, 0.87, 0.76))
	draw_line(Vector2(735, 404), Vector2(735, 418), Color(0.6, 0.55, 0.45), 1.0)
	for i in range(3):
		draw_line(Vector2(704, 408 + i * 3.0), Vector2(730, 408 + i * 3.0), Color(0.25, 0.22, 0.3, 0.7), 0.8)
	draw_rect(Rect2(660, 408, 12, 10), Color(0.08, 0.08, 0.12))
	_ellipse(Vector2(840, 414), Vector2(12, 5), Color(0.75, 0.58, 0.28))
	draw_circle(Vector2(840, 409), 3.0, Color(0.6, 0.12, 0.1))


## The sliding window on to the gate: night, rain, and one gate lamp.
func _draw_window() -> void:
	draw_rect(WINDOW_RECT.grow(8), WOOD_DARK)
	_vertical_gradient(WINDOW_RECT, Color(0.03, 0.04, 0.08), Color(0.07, 0.09, 0.14))
	# The iron gates and a stone pillar with a lamp on it
	var base := WINDOW_RECT.end.y
	draw_rect(Rect2(WINDOW_RECT.position.x + 20, base - 120, 22, 120), Color(0.14, 0.15, 0.18))
	_glow(Vector2(WINDOW_RECT.position.x + 31, base - 132), 6.0, 5, 9.0, Color(1.0, 0.85, 0.5, 0.07))
	draw_circle(Vector2(WINDOW_RECT.position.x + 31, base - 132), 5.0, Color(1.0, 0.9, 0.6))
	for i in range(9):
		var bar_x := WINDOW_RECT.position.x + 52 + i * 13.0
		draw_line(Vector2(bar_x, base - 104 + absf(i - 4.0) * 5.0), Vector2(bar_x, base), Color(0.1, 0.11, 0.14), 2.0)
	draw_line(Vector2(WINDOW_RECT.position.x + 46, base - 40), Vector2(WINDOW_RECT.end.x, base - 40), Color(0.1, 0.11, 0.14), 2.0)
	# Rain
	var rng := RandomNumberGenerator.new()
	rng.seed = 77
	for i in range(46):
		var at := Vector2(rng.randf_range(WINDOW_RECT.position.x + 4, WINDOW_RECT.end.x - 8), rng.randf_range(WINDOW_RECT.position.y, base - 14))
		draw_line(at, at + Vector2(-4, 12), Color(0.7, 0.78, 0.9, 0.3), 1.0)
	draw_line(Vector2(WINDOW_RECT.get_center().x, WINDOW_RECT.position.y), Vector2(WINDOW_RECT.get_center().x, base), WOOD_DARK, 5.0)
	draw_rect(Rect2(WINDOW_RECT.position.x - 12, base + 6, WINDOW_RECT.size.x + 24, 8), WOOD)


## The backing of the key cabinet, and the shelf below it. (The objective list covers
## everything right of here, so nothing to find is placed further right.)
func _draw_right_wall() -> void:
	draw_rect(Rect2(892, 180, 96, 112), Color(0, 0, 0, 0.3))
	draw_rect(Rect2(888, SHELF_Y, 112, 7), WOOD)
	for bracket_x: float in [894.0, 990.0]:
		_polygon([Vector2(bracket_x, SHELF_Y + 7), Vector2(bracket_x + 6, SHELF_Y + 7), Vector2(bracket_x, SHELF_Y + 34)], WOOD_DARK)
	# A row of gate ledgers
	var colours: Array[Color] = [Color(0.3, 0.12, 0.1), Color(0.14, 0.2, 0.3), Color(0.2, 0.26, 0.16), Color(0.32, 0.24, 0.12)]
	for i in range(2):
		var height := 38.0 + i * 6.0
		draw_rect(Rect2(972 + i * 13.0, SHELF_Y - height, 11, height), colours[i])
		draw_rect(Rect2(974 + i * 13.0, SHELF_Y - height + 8, 7, 2), Color(0.85, 0.72, 0.4, 0.7))


## Warm light from the lamp on the desk.
func _draw_lamp_light() -> void:
	_glow(Vector2(516, 392), 20.0, 8, 34.0, Color(LAMP, 0.022))


## The porter's high stool, pushed back from the desk.
func _draw_stool() -> void:
	_ellipse(Vector2(664, 706), Vector2(40, 7), Color(0, 0, 0, 0.4))
	for leg_x: float in [-24.0, 24.0]:
		draw_line(Vector2(664 + leg_x * 0.6, 612), Vector2(664 + leg_x, 704), WOOD_DARK, 6.0)
	draw_line(Vector2(646, 666), Vector2(682, 666), WOOD_DARK, 4.0)
	_ellipse(Vector2(664, 608), Vector2(34, 9), WOOD_LIGHT)
	_ellipse(Vector2(664, 606), Vector2(30, 7), WOOD)

