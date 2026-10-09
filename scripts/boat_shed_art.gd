@tool
class_name BoatShedArt
extends RoomArt
## Placeholder drawing of House Two, Chapter Two: inside the boat shed.
## See room_art.gd for how to replace it with a real image.
##
## Layout: raised wooden walkways on the left and right, and the boat slip
## between them, open to the lake through the broken boat doors at the back.
## The lake surges in and out of the slip (TideWater draws the water on top of
## this drawing). Left: the ladder up to the loft hatch, an oilskin coat on a
## hook, the first-aid box and the workbench. Right: a shelf with a basket of
## nets, a pinned-up ticket and the tool chest. A storm lantern hangs from the rafters.

const WALKWAY_TOP := 450.0
const WALKWAY_FRONT := 470.0
const SLIP_LEFT := 330.0
const SLIP_RIGHT := 850.0
const SLIP_BOTTOM := 692.0
const DOOR_RECT := Rect2(380, 130, 420, 320)
const BOARD := Color(0.26, 0.2, 0.15)
const BOARD_DARK := Color(0.15, 0.11, 0.08)
const BOARD_LIGHT := Color(0.36, 0.28, 0.2)
const PLANK := Color(0.38, 0.29, 0.2)
const WET := Color(0.13, 0.12, 0.1)
const LANTERN := Vector2(600, 112)
const LANTERN_LIGHT := Color(1.0, 0.8, 0.5)


func _draw_background() -> void:
	_draw_back_wall()
	_draw_boat_doors()
	_draw_rafters()
	_draw_slip()
	_draw_walkways()
	_draw_ladder()
	_draw_coat()
	_draw_workbench()
	_draw_right_wall()
	_draw_lantern()


func _draw_foreground() -> void:
	# A coil of mooring rope on the left walkway edge.
	for i in range(4):
		draw_arc(Vector2(290, 462), 20.0 - i * 4.0, PI * 1.02, TAU * 0.99, 16, Color(0.6, 0.5, 0.33), 3.0)
	# A rope draped from the right walkway down into the slip.
	draw_polyline(PackedVector2Array([Vector2(870, 458), Vector2(846, 500), Vector2(830, 560), Vector2(838, 640)]),
		Color(0.55, 0.45, 0.3), 4.0, true)
	# An old life ring leaning against the tool chest's side.
	draw_arc(Vector2(990, 440), 16, 0, TAU, 20, Color(0.85, 0.82, 0.78), 7.0)
	for angle in [0.4, 2.0, 3.6, 5.2]:
		draw_arc(Vector2(990, 440), 16, angle, angle + 0.5, 4, Color(0.75, 0.18, 0.12), 7.0)
	_draw_vignette()


# ---------------------------------------------------------------------------

func _draw_back_wall() -> void:
	_vertical_gradient(Rect2(0, 0, room_size.x, WALKWAY_TOP), Color(0.1, 0.075, 0.06), Color(0.2, 0.15, 0.11))
	var rng := RandomNumberGenerator.new()
	rng.seed = 2350
	var x := 0.0
	while x < room_size.x:
		var width := rng.randf_range(26.0, 34.0)
		var shade := rng.randf_range(-0.03, 0.03)
		draw_rect(Rect2(x + 1, 0, width - 2, WALKWAY_TOP), Color(BOARD.r + shade, BOARD.g + shade, BOARD.b + shade, 0.6))
		draw_line(Vector2(x, 0), Vector2(x, WALKWAY_TOP), BOARD_DARK, 2.0)
		x += width
	# Horizontal brace
	draw_rect(Rect2(0, 330, room_size.x, 12), BOARD_DARK)
	draw_line(Vector2(0, 330), Vector2(room_size.x, 330), BOARD_LIGHT, 1.0)


func _draw_boat_doors() -> void:
	var door := DOOR_RECT
	# Night outside: sky, far shore and the moonlit lake
	_vertical_gradient(Rect2(door.position, Vector2(door.size.x, 130)), Color(0.03, 0.05, 0.1), Color(0.08, 0.11, 0.2))
	var rng := RandomNumberGenerator.new()
	rng.seed = 5
	for i in range(18):
		draw_circle(door.position + Vector2(rng.randf_range(5, door.size.x - 5), rng.randf_range(4, 100)), 1.0, Color(1, 1, 1, 0.6))
	draw_rect(Rect2(door.position.x, door.position.y + 120, door.size.x, 14), Color(0.03, 0.05, 0.07))
	_vertical_gradient(Rect2(door.position.x, door.position.y + 134, door.size.x, door.size.y - 134),
		Color(0.06, 0.1, 0.17), Color(0.03, 0.06, 0.1))
	for i in range(10):
		var y := door.position.y + 145 + i * 17.0
		draw_line(Vector2(560 - 20 - i * 4, y), Vector2(620 + i * 4, y), Color(0.75, 0.8, 0.95, 0.22 - i * 0.015), 2.0)
	# Door frame, the left door hanging open and the right one broken off its hinge
	draw_rect(door, BOARD_DARK, false, 10.0)
	_polygon([door.position + Vector2(-4, 0), door.position + Vector2(40, 18), door.position + Vector2(40, 300),
		door.position + Vector2(-4, 320)], Color(0.2, 0.15, 0.11))
	_polygon([Vector2(door.end.x - 70, door.position.y + 60), Vector2(door.end.x + 4, door.position.y + 20),
		Vector2(door.end.x + 4, door.end.y), Vector2(door.end.x - 50, door.end.y - 10)], Color(0.18, 0.13, 0.1))
	draw_line(Vector2(door.end.x - 70, door.position.y + 60), Vector2(door.end.x - 50, door.end.y - 10), BOARD_DARK, 3.0)


func _draw_rafters() -> void:
	draw_rect(Rect2(0, 56, room_size.x, 22), BOARD_DARK)
	for x in range(60, int(room_size.x), 240):
		_polygon([Vector2(x, 78), Vector2(x + 16, 78), Vector2(x + 70, 130), Vector2(x + 54, 130)], Color(0.12, 0.09, 0.07))


func _draw_slip() -> void:
	# The sides and bottom of the channel, dark and wet (seen when the water drains).
	_vertical_gradient(Rect2(SLIP_LEFT, WALKWAY_TOP, SLIP_RIGHT - SLIP_LEFT, SLIP_BOTTOM - WALKWAY_TOP),
		Color(0.09, 0.08, 0.07), Color(0.05, 0.05, 0.04))
	for y in range(int(WALKWAY_TOP) + 20, int(SLIP_BOTTOM), 24):
		draw_line(Vector2(SLIP_LEFT, y), Vector2(SLIP_RIGHT, y), Color(0, 0, 0, 0.25), 1.0)
	# Green slime line where the water usually sits
	draw_rect(Rect2(SLIP_LEFT, 470, SLIP_RIGHT - SLIP_LEFT, 6), Color(0.15, 0.25, 0.12, 0.6))
	# Mud and stones on the bottom
	_vertical_gradient(Rect2(SLIP_LEFT, SLIP_BOTTOM - 8, SLIP_RIGHT - SLIP_LEFT, room_size.y - SLIP_BOTTOM + 8),
		Color(0.2, 0.16, 0.1), Color(0.12, 0.1, 0.07))
	var rng := RandomNumberGenerator.new()
	rng.seed = 74
	for i in range(22):
		_ellipse(Vector2(rng.randf_range(SLIP_LEFT + 10, SLIP_RIGHT - 10), rng.randf_range(SLIP_BOTTOM, room_size.y - 4)),
			Vector2(rng.randf_range(4, 10), rng.randf_range(2, 4)), Color(0.3, 0.27, 0.22))
	# An old chain lying in the mud
	for i in range(9):
		draw_arc(Vector2(470 + i * 11, 704 - (i % 2) * 2), 5, 0, TAU, 8, Color(0.3, 0.22, 0.15), 2.0)


func _draw_walkways() -> void:
	for side: Rect2 in [Rect2(0, WALKWAY_TOP, SLIP_LEFT, room_size.y - WALKWAY_TOP),
			Rect2(SLIP_RIGHT, WALKWAY_TOP, room_size.x - SLIP_RIGHT, room_size.y - WALKWAY_TOP)]:
		# Top surface...
		draw_rect(Rect2(side.position, Vector2(side.size.x, WALKWAY_FRONT - WALKWAY_TOP)), PLANK)
		draw_line(side.position, side.position + Vector2(side.size.x, 0), BOARD_LIGHT, 2.0)
		# ...and the front face of boards down to the water
		draw_rect(Rect2(side.position.x, WALKWAY_FRONT, side.size.x, room_size.y - WALKWAY_FRONT), Color(0.22, 0.16, 0.11))
		var x := side.position.x
		while x < side.end.x:
			draw_line(Vector2(x, WALKWAY_FRONT), Vector2(x, room_size.y), BOARD_DARK, 2.0)
			x += 30.0
		draw_line(Vector2(side.position.x, WALKWAY_FRONT), Vector2(side.end.x, WALKWAY_FRONT), BOARD_DARK, 3.0)
	# Wet dark edges where the walkways meet the slip
	draw_rect(Rect2(SLIP_LEFT - 8, WALKWAY_TOP, 8, room_size.y - WALKWAY_TOP), WET)
	draw_rect(Rect2(SLIP_RIGHT, WALKWAY_TOP, 8, room_size.y - WALKWAY_TOP), WET)


func _draw_ladder() -> void:
	# Up to the loft hatch in the ceiling (top left).
	draw_rect(Rect2(28, 56, 84, 16), Color(0.1, 0.07, 0.05))
	draw_rect(Rect2(32, 58, 76, 12), Color(0.3, 0.22, 0.15))
	draw_circle(Vector2(96, 64), 3, Color(0.55, 0.5, 0.4))
	for x in [44.0, 92.0]:
		draw_line(Vector2(x, 70), Vector2(x, WALKWAY_TOP), Color(0.34, 0.25, 0.17), 6.0)
	for y in range(100, int(WALKWAY_TOP), 38):
		draw_line(Vector2(44, y), Vector2(92, y), Color(0.38, 0.28, 0.19), 4.0)


func _draw_coat() -> void:
	draw_circle(Vector2(262, 150), 4, Color(0.2, 0.2, 0.22))
	# A yellow oilskin coat hanging from the hook
	_polygon([Vector2(250, 152), Vector2(274, 152), Vector2(300, 190), Vector2(304, 326), Vector2(222, 326), Vector2(226, 190)],
		Color(0.62, 0.5, 0.16))
	_polygon([Vector2(250, 152), Vector2(274, 152), Vector2(268, 176), Vector2(256, 176)], Color(0.45, 0.36, 0.1))
	draw_line(Vector2(262, 176), Vector2(262, 326), Color(0.45, 0.36, 0.1), 2.0)
	draw_line(Vector2(228, 200), Vector2(222, 300), Color(0.7, 0.58, 0.22), 2.0)
	# The bent nail sticking out beside the coat
	draw_line(Vector2(280, 296), Vector2(290, 292), Color(0.5, 0.5, 0.52), 2.0)


func _draw_workbench() -> void:
	# Top
	draw_rect(Rect2(110, 378, 210, 14), Color(0.42, 0.31, 0.2))
	draw_line(Vector2(110, 378), Vector2(320, 378), Color(0.55, 0.42, 0.28), 2.0)
	# Body with space for the drawer and two legs
	draw_rect(Rect2(118, 392, 194, 22), Color(0.3, 0.21, 0.14))
	for x in [122.0, 300.0]:
		draw_rect(Rect2(x, 392, 12, WALKWAY_TOP - 392 + 4), Color(0.3, 0.21, 0.14))
	# A vice on the end and tools hanging on the wall above
	draw_rect(Rect2(296, 362, 26, 16), Color(0.25, 0.3, 0.33))
	draw_line(Vector2(300, 370), Vector2(330, 370), Color(0.5, 0.52, 0.55), 2.0)
	draw_line(Vector2(140, 300), Vector2(140, 350), Color(0.4, 0.3, 0.2), 4.0)
	draw_rect(Rect2(132, 290, 16, 14), Color(0.4, 0.42, 0.45))
	draw_line(Vector2(180, 302), Vector2(196, 352), Color(0.55, 0.57, 0.6), 3.0)
	# The first-aid box hangs on the wall here (it is a container in the scene); a faint outline behind it
	draw_rect(Rect2(142, 214, 56, 52), Color(0, 0, 0, 0.25))


func _draw_right_wall() -> void:
	# Shelf for the net basket
	draw_rect(Rect2(866, 300, 140, 10), Color(0.4, 0.3, 0.2))
	for x in [878.0, 990.0]:
		_polygon([Vector2(x, 310), Vector2(x + 6, 310), Vector2(x + 6, 336), Vector2(x, 322)], Color(0.3, 0.22, 0.15))
	# Oars hanging on pegs (behind the objective list, for atmosphere)
	for i in range(3):
		var x := 1080.0 + i * 60.0
		draw_line(Vector2(x, 120), Vector2(x + 14, 420), Color(0.5, 0.38, 0.24), 6.0)
		_ellipse(Vector2(x + 14, 420), Vector2(10, 26), Color(0.5, 0.38, 0.24))
	# Notice board where the ticket is pinned
	draw_rect(Rect2(940, 160, 70, 80), Color(0.42, 0.33, 0.22))
	draw_rect(Rect2(944, 164, 62, 72), Color(0.55, 0.43, 0.3))
	draw_rect(Rect2(950, 170, 24, 30), Color(0.85, 0.82, 0.72, 0.7))


func _draw_lantern() -> void:
	draw_line(Vector2(LANTERN.x, 78), Vector2(LANTERN.x, LANTERN.y - 18), Color(0.15, 0.15, 0.16), 2.0)
	_glow(LANTERN, 18, 10, 20, Color(LANTERN_LIGHT, 0.03))
	_polygon([LANTERN + Vector2(-12, -16), LANTERN + Vector2(12, -16), LANTERN + Vector2(9, 16), LANTERN + Vector2(-9, 16)],
		Color(0.12, 0.12, 0.13))
	draw_rect(Rect2(LANTERN.x - 8, LANTERN.y - 12, 16, 24), LANTERN_LIGHT)
	draw_rect(Rect2(LANTERN.x - 14, LANTERN.y - 20, 28, 5), Color(0.12, 0.12, 0.13))
	# Light falling on the walkways
	_ellipse(Vector2(220, WALKWAY_TOP + 10), Vector2(140, 14), Color(LANTERN_LIGHT, 0.06))
	_ellipse(Vector2(960, WALKWAY_TOP + 10), Vector2(140, 14), Color(LANTERN_LIGHT, 0.06))
