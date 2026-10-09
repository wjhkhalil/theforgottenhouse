@tool
class_name StaircaseArt
extends RoomArt
## Placeholder drawing of the Chapter Four grand staircase.
## The room is two screens tall (1280 x 1440): set room_size on both layers.
## See room_art.gd for how to replace it with a real image.
##
## Layout (top to bottom): the upper landing with a bedroom door, the empty
## gilt frame and a tall stained-glass window; the first flight running down
## to the right to a half-landing; the second flight running back down to the
## left; and the front hall with the front door, coat stand, telephone table,
## hall table (with its lamp) and the grandfather clock.

const LANDING_Y := 470.0
const LANDING_END_X := 440.0
const HALF_LANDING_X := 860.0
const HALF_LANDING_Y := 820.0
const HALL_FLOOR_Y := 1180.0
const STEPS := 14
const FLIGHT_ONE_RUN := 30.0
const FLIGHT_ONE_RISE := 25.0
const FLIGHT_TWO_RUN := 40.0
const FLIGHT_TWO_RISE := 360.0 / 14.0
const RAIL_HEIGHT := 62.0

const WALL_TOP := Color(0.1, 0.11, 0.16)
const WALL_BOTTOM := Color(0.17, 0.14, 0.14)
const PANEL_WOOD := Color(0.19, 0.12, 0.09)
const PANEL_DARK := Color(0.13, 0.08, 0.06)
const CARPET := Color(0.42, 0.1, 0.12)
const CARPET_DARK := Color(0.28, 0.06, 0.08)
const BRASS := Color(0.72, 0.58, 0.3)
const GILT := Color(0.7, 0.56, 0.26)
const GILT_DARK := Color(0.42, 0.32, 0.14)
const BANISTER := Color(0.26, 0.15, 0.1)
const BANISTER_LIGHT := Color(0.4, 0.25, 0.16)
const MOONLIGHT := Color(0.7, 0.8, 1.0, 0.045)
const LAMP_LIGHT := Color(1.0, 0.72, 0.38, 0.045)


func _draw_background() -> void:
	_draw_walls()
	_draw_hall_wainscot()
	_draw_upper_landing()
	_draw_bedroom_door()
	_draw_empty_frame()
	_draw_window()
	_draw_upper_gallery()
	_draw_chandelier()
	_draw_lake_painting()
	_draw_flight_one()
	_draw_half_landing()
	_draw_flight_two()
	_draw_flight_two_banister()
	_draw_hall_floor()
	_draw_front_door()
	_draw_umbrella_stand()
	_draw_coat_stand()
	_draw_telephone_table()
	_draw_hall_table()
	_draw_grandfather_clock()
	_draw_fern()
	_draw_moonlight()
	_draw_lamp_glow()


func _draw_foreground() -> void:
	# The first flight's banister stands in front of its steps (one baluster
	# crosses the edge of the glove).
	_draw_flight_one_banister()
	# Two fern fronds droop over the right end of the nameplate.
	_draw_frond(Vector2(358, 452), Vector2(334, 472), Vector2(314, 490), Color(0.22, 0.33, 0.19))
	_draw_frond(Vector2(362, 454), Vector2(350, 480), Vector2(338, 500), Color(0.17, 0.26, 0.15))
	# A fallen rubber boot lies against the key ring.
	var boot := Color(0.14, 0.17, 0.13)
	_polygon([Vector2(192, 1276), Vector2(208, 1276), Vector2(210, 1302), Vector2(222, 1306),
		Vector2(222, 1316), Vector2(190, 1316)], boot)
	draw_line(Vector2(194, 1280), Vector2(194, 1312), Color(1, 1, 1, 0.08), 2.0)
	_draw_vignette()


# ---------------------------------------------------------------------------
# Walls
# ---------------------------------------------------------------------------

func _draw_walls() -> void:
	_vertical_gradient(Rect2(0, 0, room_size.x, HALL_FLOOR_Y), WALL_TOP, WALL_BOTTOM)
	# Striped wallpaper with a small diamond pattern between the stripes
	var x := 0.0
	var column := 0
	while x < room_size.x:
		draw_rect(Rect2(x, 0, 14, HALL_FLOOR_Y), Color(0.2, 0.2, 0.27, 0.35))
		draw_line(Vector2(x + 16, 0), Vector2(x + 16, HALL_FLOOR_Y), Color(0, 0, 0, 0.15), 1.0)
		var offset := 30.0 if column % 2 == 1 else 0.0
		var y := 30.0
		while y < HALL_FLOOR_Y:
			var c := Vector2(x + 46, y + offset)
			_polygon([c + Vector2(0, -7), c + Vector2(5, 0), c + Vector2(0, 7), c + Vector2(-5, 0)], Color(0.26, 0.24, 0.3, 0.3))
			y += 60.0
		x += 76.0
		column += 1
	# Damp patches and peeling paper (fixed seed = same every time)
	var rng := RandomNumberGenerator.new()
	rng.seed = 44
	for i in range(12):
		var spot := Vector2(rng.randf_range(0, room_size.x), rng.randf_range(80, HALL_FLOOR_Y - 80))
		_ellipse(spot, Vector2(rng.randf_range(30, 90), rng.randf_range(20, 60)), Color(0, 0, 0, rng.randf_range(0.04, 0.1)))
	for i in range(6):
		var corner := Vector2(rng.randf_range(20, 1000), rng.randf_range(560, 1000))
		_polygon([corner, corner + Vector2(18, 4), corner + Vector2(8, 22)], Color(0.06, 0.05, 0.07, 0.3))


func _draw_hall_wainscot() -> void:
	draw_rect(Rect2(0, 1040, room_size.x, HALL_FLOOR_Y - 1040), PANEL_WOOD)
	draw_rect(Rect2(0, 1034, room_size.x, 8), PlaceholderArt.WOOD)
	draw_rect(Rect2(0, 1034, room_size.x, 2), PlaceholderArt.WOOD_LIGHT)
	var px := 12.0
	while px < room_size.x:
		draw_rect(Rect2(px, 1056, 92, 104), PANEL_DARK, false, 2.0)
		draw_line(Vector2(px + 2, 1058), Vector2(px + 90, 1058), Color(1, 1, 1, 0.05), 1.0)
		px += 112.0
	draw_rect(Rect2(0, HALL_FLOOR_Y - 14, room_size.x, 14), Color(0.11, 0.07, 0.05))


# ---------------------------------------------------------------------------
# Top: the upper landing
# ---------------------------------------------------------------------------

func _draw_upper_landing() -> void:
	# Panelling under the dado rail
	draw_rect(Rect2(0, 380, LANDING_END_X, LANDING_Y - 380), PANEL_WOOD)
	draw_rect(Rect2(0, 374, LANDING_END_X, 7), PlaceholderArt.WOOD)
	for i in range(4):
		draw_rect(Rect2(14 + i * 106, 392, 90, 66), PANEL_DARK, false, 2.0)
	# Floorboards seen from a little above, with a carpet runner
	_vertical_gradient(Rect2(0, LANDING_Y, LANDING_END_X, 36), Color(0.2, 0.14, 0.1), Color(0.3, 0.21, 0.15))
	for board in range(1, 4):
		draw_line(Vector2(0, LANDING_Y + board * 9), Vector2(LANDING_END_X, LANDING_Y + board * 9), Color(0, 0, 0, 0.18), 1.0)
	draw_rect(Rect2(0, LANDING_Y + 4, 160, 26), CARPET_DARK)
	draw_rect(Rect2(0, LANDING_Y + 7, 156, 20), CARPET)
	# Thick front edge of the landing with mouldings
	draw_rect(Rect2(0, LANDING_Y + 36, LANDING_END_X + 4, 42), PlaceholderArt.WOOD_DARK)
	draw_rect(Rect2(0, LANDING_Y + 36, LANDING_END_X + 4, 4), PlaceholderArt.WOOD_LIGHT)
	draw_rect(Rect2(0, LANDING_Y + 70, LANDING_END_X + 4, 8), PlaceholderArt.WOOD)
	_vertical_gradient(Rect2(0, LANDING_Y + 78, LANDING_END_X, 50), Color(0, 0, 0, 0.4), Color(0, 0, 0, 0))


func _draw_bedroom_door() -> void:
	# A closed bedroom door at the far left of the landing
	draw_rect(Rect2(26, 214, 120, LANDING_Y - 214), PlaceholderArt.WOOD_DARK)
	draw_rect(Rect2(36, 224, 100, LANDING_Y - 224), Color(0.3, 0.2, 0.14))
	for panel: Rect2 in [Rect2(46, 236, 36, 92), Rect2(90, 236, 36, 92), Rect2(46, 344, 36, 110), Rect2(90, 344, 36, 110)]:
		draw_rect(panel, Color(0.24, 0.16, 0.11))
		draw_rect(panel, Color(0, 0, 0, 0.3), false, 1.5)
	draw_circle(Vector2(128, 352), 4, BRASS)
	draw_rect(Rect2(36, LANDING_Y - 4, 100, 4), Color(0.02, 0.02, 0.03))


func _draw_empty_frame() -> void:
	# Brighter, unfaded wallpaper where the portrait used to hang
	draw_rect(Rect2(196, 142, 150, 196), Color(0.24, 0.24, 0.32))
	for stripe in range(2):
		draw_rect(Rect2(226 + stripe * 76, 142, 14, 196), Color(0.3, 0.3, 0.38, 0.5))
	# The heavy gilt frame, now empty
	var outer := Rect2(186, 132, 170, 216)
	draw_rect(Rect2(outer.position + Vector2(5, 6), outer.size), Color(0, 0, 0, 0.35))
	draw_rect(outer, GILT_DARK)
	draw_rect(outer.grow(-4), GILT)
	draw_rect(outer.grow(-14), GILT_DARK)
	draw_rect(Rect2(204, 150, 134, 180), Color(0.24, 0.24, 0.32))
	draw_rect(Rect2(204, 150, 134, 180), Color(0, 0, 0, 0.25), false, 3.0)
	for corner: Vector2 in [outer.position, Vector2(outer.end.x, outer.position.y), outer.end, Vector2(outer.position.x, outer.end.y)]:
		draw_circle(corner, 9, GILT)
		draw_circle(corner, 4, GILT_DARK)
	draw_line(Vector2(190, 136), Vector2(352, 136), Color(1, 0.92, 0.6, 0.4), 2.0)
	# Hanging wire, and two empty screw holes where the nameplate was
	draw_line(Vector2(271, 80), Vector2(210, 132), Color(0.5, 0.48, 0.44), 1.5)
	draw_line(Vector2(271, 80), Vector2(332, 132), Color(0.5, 0.48, 0.44), 1.5)
	draw_circle(Vector2(271, 80), 3, BRASS)
	draw_rect(Rect2(250, 337, 42, 8), Color(GILT_DARK, 0.9))
	draw_circle(Vector2(254, 341), 1.5, Color(0.05, 0.04, 0.03))
	draw_circle(Vector2(288, 341), 1.5, Color(0.05, 0.04, 0.03))
	draw_line(Vector2(292, 345), Vector2(296, 352), Color(0.85, 0.75, 0.5, 0.5), 1.0)  # scratch


func _draw_window() -> void:
	# A tall arched stained-glass window above the stairwell
	var left := 600.0
	var right := 760.0
	var arch_center := Vector2(680, 168)
	var bottom := 402.0
	_glow(Vector2(680, 260), 70, 5, 22, Color(0.6, 0.7, 1.0, 0.025))
	# Stone surround
	draw_rect(Rect2(left - 14, arch_center.y, right - left + 28, bottom - arch_center.y + 8), Color(0.24, 0.23, 0.26))
	draw_circle(arch_center, 94, Color(0.24, 0.23, 0.26))
	# Glass: a grid of muted coloured panes under the arch, a fan of panes in it
	var colors: Array[Color] = [Color(0.3, 0.42, 0.66), Color(0.42, 0.3, 0.55), Color(0.6, 0.5, 0.3),
		Color(0.28, 0.48, 0.42), Color(0.5, 0.62, 0.78), Color(0.55, 0.25, 0.28)]
	var rng := RandomNumberGenerator.new()
	rng.seed = 7
	var pane_w := (right - left) / 6.0
	var y := arch_center.y
	while y < bottom:
		for col in range(6):
			var pane := Rect2(left + col * pane_w, y, pane_w, 26)
			draw_rect(pane, colors[rng.randi_range(0, colors.size() - 1)])
		y += 26.0
	for i in range(8):
		var a0 := PI + PI * i / 8.0
		var a1 := PI + PI * (i + 1) / 8.0
		_polygon([arch_center, arch_center + Vector2.from_angle(a0) * 80.0, arch_center + Vector2.from_angle(a1) * 80.0],
			colors[(i * 2 + 1) % colors.size()])
	# Rose in the middle: a pale moon circle with petals
	draw_circle(Vector2(680, 262), 34, Color(0.22, 0.2, 0.3))
	for i in range(8):
		var petal := Vector2(680, 262) + Vector2.from_angle(TAU * i / 8.0) * 22.0
		draw_circle(petal, 10, colors[i % colors.size()].lightened(0.15))
	draw_circle(Vector2(680, 262), 12, Color(PlaceholderArt.MOON, 0.9))
	# Lead lines
	var lead := Color(0.08, 0.08, 0.1)
	for col in range(7):
		draw_line(Vector2(left + col * pane_w, arch_center.y), Vector2(left + col * pane_w, bottom), lead, 2.0)
	var line_y := arch_center.y
	while line_y <= bottom:
		draw_line(Vector2(left, line_y), Vector2(right, line_y), lead, 2.0)
		line_y += 26.0
	for i in range(9):
		draw_line(arch_center, arch_center + Vector2.from_angle(PI + PI * i / 8.0) * 80.0, lead, 2.0)
	draw_arc(arch_center, 80, PI, TAU, 24, lead, 4.0, true)
	draw_arc(arch_center, 40, PI, TAU, 16, lead, 2.0, true)
	draw_arc(Vector2(680, 262), 34, 0, TAU, 28, lead, 3.0, true)
	# Moonlight shining through: a soft sheen over the glass
	_polygon([Vector2(left, 220), Vector2(left + 50, arch_center.y), Vector2(right, 330), Vector2(right, bottom)], Color(1, 1, 1, 0.06))
	# Stone sill
	draw_rect(Rect2(left - 22, bottom + 2, right - left + 44, 12), Color(0.32, 0.3, 0.33))
	draw_rect(Rect2(left - 22, bottom + 12, right - left + 44, 4), Color(0, 0, 0, 0.4))


func _draw_upper_gallery() -> void:
	# The landing continues on the far right (behind the objectives list) to a dark corridor.
	draw_rect(Rect2(1080, 236, 120, LANDING_Y - 236), Color(0.04, 0.04, 0.06))
	draw_rect(Rect2(1072, 228, 136, 8), PlaceholderArt.WOOD_DARK)
	draw_rect(Rect2(980, LANDING_Y, 300, 36), Color(0.26, 0.18, 0.13))
	draw_rect(Rect2(976, LANDING_Y + 36, 304, 42), PlaceholderArt.WOOD_DARK)
	draw_rect(Rect2(976, LANDING_Y + 36, 304, 4), PlaceholderArt.WOOD_LIGHT)
	draw_line(Vector2(976, LANDING_Y - 60), Vector2(1280, LANDING_Y - 60), BANISTER, 7.0)
	var bx := 990.0
	while bx < 1280.0:
		draw_line(Vector2(bx, LANDING_Y - 58), Vector2(bx, LANDING_Y + 36), BANISTER, 4.0)
		bx += 26.0


func _draw_chandelier() -> void:
	# A dead chandelier hanging in the stairwell, draped in cobwebs
	var center := Vector2(880, 210)
	draw_line(Vector2(880, 0), Vector2(880, center.y - 26), Color(0.3, 0.26, 0.2), 3.0)
	_ellipse(center + Vector2(0, 8), Vector2(60, 12), Color(0.36, 0.3, 0.18))
	_ellipse(center + Vector2(0, 4), Vector2(56, 9), Color(0.52, 0.42, 0.22))
	_polygon([center + Vector2(-14, -26), center + Vector2(14, -26), center + Vector2(8, 20), center + Vector2(-8, 20)], Color(0.45, 0.36, 0.2))
	for i in range(5):
		var arm_x := -48.0 + i * 24.0
		draw_rect(Rect2(center.x + arm_x - 3, center.y - 18, 6, 16), PlaceholderArt.BEIGE_DARK)
		draw_line(Vector2(center.x + arm_x, center.y - 18), Vector2(center.x + arm_x, center.y - 23), Color(0.1, 0.1, 0.1), 1.5)
		# Glass drops catching the moonlight
		draw_line(Vector2(center.x + arm_x, center.y + 14), Vector2(center.x + arm_x, center.y + 28), Color(0.7, 0.75, 0.85, 0.35), 1.0)
		draw_circle(Vector2(center.x + arm_x, center.y + 30), 2.5, Color(0.8, 0.86, 0.96, 0.6))
	var web := Color(0.85, 0.85, 0.9, 0.14)
	draw_line(center + Vector2(-56, 4), Vector2(880, 120), web, 1.0)
	draw_line(center + Vector2(56, 4), Vector2(880, 120), web, 1.0)
	draw_arc(Vector2(880, 160), 40, PI * 0.15, PI * 0.85, 10, web, 1.0, true)


func _draw_lake_painting() -> void:
	# A painting of the lake and the boathouse on the hall's upper wall
	var frame := Rect2(76, 612, 214, 150)
	draw_rect(Rect2(frame.position + Vector2(5, 6), frame.size), Color(0, 0, 0, 0.35))
	draw_rect(frame, GILT_DARK)
	draw_rect(frame.grow(-3), GILT)
	var canvas := frame.grow(-12)
	_vertical_gradient(Rect2(canvas.position, Vector2(canvas.size.x, 60)), Color(0.22, 0.26, 0.34), Color(0.4, 0.42, 0.44))
	_vertical_gradient(Rect2(canvas.position + Vector2(0, 60), Vector2(canvas.size.x, canvas.size.y - 60)), Color(0.16, 0.22, 0.28), Color(0.1, 0.13, 0.16))
	# Dark pines and the little boathouse on the far shore
	for i in range(9):
		var tree_x := canvas.position.x + 8 + i * 22.0
		_polygon([Vector2(tree_x, canvas.position.y + 62), Vector2(tree_x + 9, canvas.position.y + 28 + (i % 3) * 8),
			Vector2(tree_x + 18, canvas.position.y + 62)], Color(0.12, 0.17, 0.14))
	draw_rect(Rect2(canvas.position.x + 128, canvas.position.y + 48, 26, 14), Color(0.32, 0.22, 0.16))
	_polygon([Vector2(canvas.position.x + 124, canvas.position.y + 48), Vector2(canvas.position.x + 141, canvas.position.y + 36),
		Vector2(canvas.position.x + 158, canvas.position.y + 48)], Color(0.24, 0.16, 0.12))
	draw_line(canvas.position + Vector2(130, 70), canvas.position + Vector2(152, 70), Color(1, 1, 1, 0.12), 2.0)
	draw_line(canvas.position + Vector2(20, 90), canvas.position + Vector2(80, 90), Color(1, 1, 1, 0.08), 1.0)
	# Brass picture light (switched off)
	draw_rect(Rect2(160, 598, 56, 8), BRASS.darkened(0.3))


# ---------------------------------------------------------------------------
# Middle: the two flights and the half-landing
# ---------------------------------------------------------------------------

## Outline of a flight: the stepped top edge, then back along the underside.
func _flight_outline(start: Vector2, run: float, rise: float, direction: float, thickness: float) -> PackedVector2Array:
	var points := PackedVector2Array()
	var corner := start
	points.append(corner)
	for i in range(STEPS):
		corner += Vector2(0, rise)
		points.append(corner)
		corner += Vector2(run * direction, 0)
		points.append(corner)
	points.append(corner + Vector2(0, thickness))
	points.append(start + Vector2(0, thickness + rise))
	return points


## Draws the carpet runner and the brass stair rods along a flight.
func _draw_runner(start: Vector2, run: float, rise: float, direction: float) -> void:
	for i in range(STEPS):
		var riser_x := start.x + run * direction * i
		var top_y := start.y + rise * i
		var bottom_y := top_y + rise
		var riser_rect := Rect2(riser_x - 8, top_y, 8, rise + 8) if direction > 0 else Rect2(riser_x, top_y, 8, rise + 8)
		var tread_rect := Rect2(riser_x, bottom_y, run, 8) if direction > 0 else Rect2(riser_x - run, bottom_y, run, 8)
		draw_rect(riser_rect, CARPET)
		draw_rect(tread_rect, CARPET)
		draw_line(Vector2(tread_rect.position.x, bottom_y + 7), Vector2(tread_rect.end.x, bottom_y + 7), CARPET_DARK, 2.0)
		# Wooden nosing peeking out past the carpet, and the brass rod in the corner
		draw_line(Vector2(riser_x - 2 * direction, top_y), Vector2(riser_x - 10 * direction, top_y), PlaceholderArt.WOOD_LIGHT, 2.0)
		draw_circle(Vector2(riser_x, bottom_y + 1), 2.2, BRASS)


func _draw_flight_one() -> void:
	var start := Vector2(LANDING_END_X, LANDING_Y)
	var outline := _flight_outline(start, FLIGHT_ONE_RUN, FLIGHT_ONE_RISE, 1.0, 64.0)
	draw_colored_polygon(outline, Color(0.22, 0.14, 0.1))
	# Stringer panel line under the steps and the shadow below the flight
	var end := Vector2(HALF_LANDING_X, HALF_LANDING_Y)
	draw_line(start + Vector2(0, 52), end + Vector2(0, 52), PlaceholderArt.WOOD, 4.0)
	draw_line(start + Vector2(0, 86), end + Vector2(0, 86), Color(0, 0, 0, 0.3), 10.0)
	_draw_runner(start, FLIGHT_ONE_RUN, FLIGHT_ONE_RISE, 1.0)


func _draw_half_landing() -> void:
	var y := HALF_LANDING_Y
	_vertical_gradient(Rect2(HALF_LANDING_X, y, room_size.x - HALF_LANDING_X, 30), Color(0.24, 0.17, 0.12), Color(0.3, 0.21, 0.15))
	draw_rect(Rect2(HALF_LANDING_X + 20, y + 5, 240, 20), CARPET)
	draw_rect(Rect2(HALF_LANDING_X + 20, y + 5, 240, 20), CARPET_DARK, false, 2.0)
	draw_rect(Rect2(HALF_LANDING_X - 4, y + 30, room_size.x - HALF_LANDING_X + 4, 40), PlaceholderArt.WOOD_DARK)
	draw_rect(Rect2(HALF_LANDING_X - 4, y + 30, room_size.x - HALF_LANDING_X + 4, 4), PlaceholderArt.WOOD_LIGHT)
	draw_rect(Rect2(HALF_LANDING_X - 4, y + 62, room_size.x - HALF_LANDING_X + 4, 8), PlaceholderArt.WOOD)
	_vertical_gradient(Rect2(HALF_LANDING_X, y + 70, room_size.x - HALF_LANDING_X, 60), Color(0, 0, 0, 0.4), Color(0, 0, 0, 0))


func _draw_flight_two() -> void:
	var start := Vector2(HALF_LANDING_X, HALF_LANDING_Y)
	var outline := _flight_outline(start, FLIGHT_TWO_RUN, FLIGHT_TWO_RISE, -1.0, 60.0)
	# Shadow the nearer flight throws on the wall, then the flight itself
	var shadow := PackedVector2Array()
	for point in outline:
		shadow.append(point + Vector2(10, 12))
	draw_colored_polygon(shadow, Color(0, 0, 0, 0.3))
	draw_colored_polygon(outline, Color(0.25, 0.16, 0.11))
	var end := Vector2(HALF_LANDING_X - FLIGHT_TWO_RUN * STEPS, HALL_FLOOR_Y)
	draw_line(start + Vector2(0, 50), end + Vector2(0, 26), PlaceholderArt.WOOD, 4.0)
	_draw_runner(start, FLIGHT_TWO_RUN, FLIGHT_TWO_RISE, -1.0)


## The rail height above the second flight's nosing line at `x`.
func _flight_two_rail_y(x: float) -> float:
	return HALF_LANDING_Y + (HALF_LANDING_X - x) * FLIGHT_TWO_RISE / FLIGHT_TWO_RUN - RAIL_HEIGHT


func _draw_flight_two_banister() -> void:
	# Two balusters on every step, the handrail, and newel posts at both ends
	for i in range(STEPS):
		var riser_x := HALF_LANDING_X - FLIGHT_TWO_RUN * i
		var tread_y := HALF_LANDING_Y + FLIGHT_TWO_RISE * (i + 1)
		for offset: float in [12.0, 31.0]:
			var bx := riser_x - offset
			draw_line(Vector2(bx, tread_y), Vector2(bx, _flight_two_rail_y(bx)), BANISTER, 4.0)
			draw_line(Vector2(bx - 1, tread_y - 4), Vector2(bx - 1, _flight_two_rail_y(bx) + 4), Color(1, 1, 1, 0.06), 1.0)
	var rail_start := Vector2(HALF_LANDING_X, _flight_two_rail_y(HALF_LANDING_X))
	var rail_end := Vector2(312, _flight_two_rail_y(312))
	draw_line(rail_start + Vector2(2, 3), rail_end + Vector2(2, 3), Color(0, 0, 0, 0.35), 8.0)
	draw_line(rail_start, rail_end, BANISTER, 8.0)
	draw_line(rail_start + Vector2(0, -3), rail_end + Vector2(0, -3), BANISTER_LIGHT, 2.0)
	# Big newel post at the foot of the stairs, with a brass ball on top
	draw_rect(Rect2(298, rail_end.y - 8, 24, HALL_FLOOR_Y + 8 - rail_end.y), BANISTER)
	draw_rect(Rect2(298, rail_end.y - 8, 5, HALL_FLOOR_Y + 8 - rail_end.y), BANISTER_LIGHT)
	draw_rect(Rect2(294, rail_end.y - 14, 32, 8), BANISTER_LIGHT)
	draw_circle(Vector2(310, rail_end.y - 22), 10, BRASS)
	draw_circle(Vector2(306, rail_end.y - 26), 3, Color(1, 0.95, 0.75, 0.6))


func _draw_flight_one_banister() -> void:
	var start := Vector2(LANDING_END_X, LANDING_Y)
	var slope := FLIGHT_ONE_RISE / FLIGHT_ONE_RUN
	for i in range(STEPS):
		var bx := start.x + FLIGHT_ONE_RUN * i + 10.0
		var tread_y := start.y + FLIGHT_ONE_RISE * (i + 1)
		var rail_y := start.y + (bx - start.x) * slope - RAIL_HEIGHT
		draw_line(Vector2(bx, tread_y), Vector2(bx, rail_y), BANISTER, 3.5)
		draw_circle(Vector2(bx, tread_y - 10), 2.6, BANISTER)
	var rail_start := start + Vector2(0, -RAIL_HEIGHT)
	var rail_end := Vector2(HALF_LANDING_X, HALF_LANDING_Y - RAIL_HEIGHT)
	draw_line(rail_start + Vector2(2, 3), rail_end + Vector2(2, 3), Color(0, 0, 0, 0.35), 8.0)
	draw_line(rail_start, rail_end, BANISTER, 8.0)
	draw_line(rail_start + Vector2(0, -3), rail_end + Vector2(0, -3), BANISTER_LIGHT, 2.0)
	# Newel posts at the top and at the half-landing
	for post: Vector2 in [Vector2(LANDING_END_X - 4, LANDING_Y + 30), Vector2(HALF_LANDING_X + 2, HALF_LANDING_Y + 30)]:
		draw_rect(Rect2(post.x - 10, post.y - RAIL_HEIGHT - 44, 20, RAIL_HEIGHT + 44), BANISTER)
		draw_rect(Rect2(post.x - 10, post.y - RAIL_HEIGHT - 44, 4, RAIL_HEIGHT + 44), BANISTER_LIGHT)
		draw_rect(Rect2(post.x - 13, post.y - RAIL_HEIGHT - 50, 26, 7), BANISTER_LIGHT)
		draw_circle(Vector2(post.x, post.y - RAIL_HEIGHT - 57), 7, BRASS)


# ---------------------------------------------------------------------------
# Bottom: the front hall
# ---------------------------------------------------------------------------

func _draw_hall_floor() -> void:
	var top := HALL_FLOOR_Y
	var bottom := room_size.y
	_vertical_gradient(Rect2(0, top, room_size.x, bottom - top), Color(0.16, 0.15, 0.15), Color(0.24, 0.22, 0.21))
	# Black and white marble tiles in perspective
	var vanish := Vector2(640, 820)
	var rows: Array[float] = [top, 1205.0, 1236.0, 1274.0, 1320.0, 1376.0, bottom]
	for r in range(rows.size() - 1):
		var y0 := rows[r]
		var y1 := rows[r + 1]
		for col in range(-8, 9):
			if (col + r) % 2 == 0:
				continue
			var x_left := col * 80.0 + 640.0
			var x_right := x_left + 80.0
			var k0 := (y0 - vanish.y) / (top - vanish.y)
			var k1 := (y1 - vanish.y) / (top - vanish.y)
			_polygon([Vector2(vanish.x + (x_left - vanish.x) * k0, y0), Vector2(vanish.x + (x_right - vanish.x) * k0, y0),
				Vector2(vanish.x + (x_right - vanish.x) * k1, y1), Vector2(vanish.x + (x_left - vanish.x) * k1, y1)],
				Color(0.38, 0.36, 0.34, 0.45))
	# Rug in front of the stairs
	_polygon([Vector2(380, 1318), Vector2(900, 1318), Vector2(950, 1408), Vector2(330, 1408)], Color(0.3, 0.1, 0.1))
	_polygon([Vector2(394, 1326), Vector2(886, 1326), Vector2(930, 1400), Vector2(350, 1400)], Color(0.4, 0.16, 0.13))
	_polygon([Vector2(560, 1342), Vector2(720, 1342), Vector2(740, 1384), Vector2(540, 1384)], Color(0.5, 0.36, 0.2, 0.5))
	# Muddy footprints from the front door toward the stairs
	for i in range(6):
		var step := Vector2(150 + i * 36, 1238 - i * 7)
		_ellipse(step + Vector2(0, 5.0 if i % 2 == 0 else -5.0), Vector2(9, 3.5), Color(0.08, 0.06, 0.04, 0.45))


func _draw_front_door() -> void:
	# Heavy double front door with a fanlight, chained shut
	draw_rect(Rect2(40, 868, 176, HALL_FLOOR_Y - 868), Color(0.24, 0.23, 0.26))
	draw_rect(Rect2(52, 880, 152, 40), Color(0.08, 0.1, 0.16))
	for i in range(5):
		draw_line(Vector2(128, 920), Vector2(56 + i * 36, 882), Color(0.18, 0.18, 0.2), 2.0)
	draw_rect(Rect2(52, 924, 152, HALL_FLOOR_Y - 924), Color(0.2, 0.13, 0.09))
	for door in range(2):
		var x := 56.0 + door * 76.0
		draw_rect(Rect2(x, 928, 68, HALL_FLOOR_Y - 932), Color(0.27, 0.17, 0.12))
		draw_rect(Rect2(x + 10, 942, 48, 90), Color(0.22, 0.14, 0.1))
		draw_rect(Rect2(x + 10, 1050, 48, 110), Color(0.22, 0.14, 0.1))
		draw_rect(Rect2(x + 10, 942, 48, 90), Color(0, 0, 0, 0.3), false, 1.5)
		draw_rect(Rect2(x + 10, 1050, 48, 110), Color(0, 0, 0, 0.3), false, 1.5)
	draw_circle(Vector2(118, 1040), 5, BRASS)
	draw_circle(Vector2(138, 1040), 5, BRASS)
	draw_rect(Rect2(108, 1054, 6, 10), BRASS.darkened(0.3))
	# Chain and padlock across both handles
	var chain := Color(0.45, 0.45, 0.48)
	for i in range(7):
		var link := Vector2(106 + i * 7, 1044 + sin(i * 0.9) * 3)
		draw_arc(link, 3.5, 0, TAU, 8, chain, 1.5, true)
	draw_rect(Rect2(120, 1050, 14, 12), Color(0.3, 0.3, 0.32))
	draw_arc(Vector2(127, 1050), 5, PI, TAU, 8, chain, 2.0, true)
	# Doormat
	_polygon([Vector2(50, 1196), Vector2(208, 1196), Vector2(216, 1222), Vector2(42, 1222)], Color(0.32, 0.26, 0.18))


func _draw_umbrella_stand() -> void:
	_ellipse(Vector2(160, 1306), Vector2(26, 6), PlaceholderArt.SHADOW)
	draw_line(Vector2(150, 1240), Vector2(138, 1190), Color(0.12, 0.12, 0.14), 3.0)
	draw_line(Vector2(168, 1240), Vector2(176, 1196), Color(0.2, 0.12, 0.14), 3.0)
	draw_arc(Vector2(182, 1196), 6, PI, TAU, 8, Color(0.2, 0.12, 0.14), 3.0, true)
	draw_rect(Rect2(140, 1236, 40, 68), Color(0.24, 0.26, 0.24))
	draw_rect(Rect2(140, 1236, 40, 5), Color(0.34, 0.36, 0.34))
	draw_rect(Rect2(140, 1236, 8, 68), Color(1, 1, 1, 0.05))


func _draw_coat_stand() -> void:
	var pole := Vector2(262, 0)
	_ellipse(Vector2(262, 1298), Vector2(38, 7), PlaceholderArt.SHADOW)
	# Three curved feet and the tall pole
	for foot: float in [-30.0, 30.0, 0.0]:
		draw_line(Vector2(pole.x, 1270), Vector2(pole.x + foot, 1296 - absf(foot) * 0.1), PlaceholderArt.WOOD_DARK, 5.0)
	draw_line(Vector2(pole.x, 960), Vector2(pole.x, 1276), PlaceholderArt.WOOD_DARK, 7.0)
	draw_line(Vector2(pole.x - 2, 960), Vector2(pole.x - 2, 1276), PlaceholderArt.WOOD, 2.0)
	draw_circle(Vector2(pole.x, 956), 6, PlaceholderArt.WOOD)
	for hook: float in [-1.0, 1.0]:
		draw_line(Vector2(pole.x, 978), Vector2(pole.x + hook * 22, 966), PlaceholderArt.WOOD_DARK, 3.0)
	# A long dark overcoat and a scarf, a bowler hat on top
	_polygon([Vector2(240, 970), Vector2(252, 966), Vector2(258, 1000), Vector2(262, 1150), Vector2(226, 1158), Vector2(224, 1060)], Color(0.15, 0.16, 0.2))
	draw_line(Vector2(242, 990), Vector2(238, 1150), Color(0, 0, 0, 0.3), 2.0)
	_polygon([Vector2(272, 970), Vector2(286, 966), Vector2(300, 1050), Vector2(296, 1112), Vector2(276, 1116)], Color(0.32, 0.22, 0.2))
	draw_line(Vector2(278, 972), Vector2(282, 1110), Color(0.45, 0.32, 0.26), 2.0)
	_ellipse(Vector2(262, 950), Vector2(20, 5), Color(0.1, 0.1, 0.12))
	_ellipse(Vector2(262, 940), Vector2(12, 11), Color(0.12, 0.12, 0.14))


func _draw_telephone_table() -> void:
	_ellipse(Vector2(450, 1258), Vector2(58, 7), PlaceholderArt.SHADOW)
	draw_rect(Rect2(398, 1164, 104, 10), PlaceholderArt.WOOD_LIGHT)
	draw_rect(Rect2(402, 1174, 96, 16), PlaceholderArt.WOOD)
	for leg_x: float in [406.0, 488.0]:
		draw_rect(Rect2(leg_x, 1190, 6, 64), PlaceholderArt.WOOD_DARK)
	draw_rect(Rect2(406, 1226, 88, 6), PlaceholderArt.WOOD)
	# Directory on the shelf
	draw_rect(Rect2(420, 1214, 50, 12), Color(0.5, 0.42, 0.24))
	# The old rotary telephone, its handset on the cradle
	var phone := Color(0.08, 0.08, 0.09)
	_polygon([Vector2(424, 1164), Vector2(476, 1164), Vector2(470, 1140), Vector2(430, 1140)], phone)
	draw_circle(Vector2(450, 1152), 9, Color(0.75, 0.72, 0.65))
	draw_circle(Vector2(450, 1152), 3, phone)
	for i in range(8):
		draw_circle(Vector2(450, 1152) + Vector2.from_angle(PI * 0.8 + i * 0.28) * 6.0, 1.2, phone)
	draw_rect(Rect2(420, 1128, 60, 9), phone)
	draw_circle(Vector2(422, 1132), 7, phone)
	draw_circle(Vector2(478, 1132), 7, phone)
	draw_line(Vector2(424, 1129), Vector2(476, 1129), Color(1, 1, 1, 0.12), 1.5)
	# The cord runs off the table to the right, where it was cut
	draw_line(Vector2(476, 1160), Vector2(500, 1166), Color(0.12, 0.11, 0.11), 3.0)
	draw_line(Vector2(500, 1166), Vector2(512, 1172), Color(0.12, 0.11, 0.11), 3.0)
	# The other cut end, still plugged into the wall socket
	draw_rect(Rect2(546, 1140, 14, 18), Color(0.55, 0.5, 0.42))
	draw_circle(Vector2(553, 1149), 2, Color(0.2, 0.18, 0.15))
	draw_line(Vector2(553, 1158), Vector2(556, 1170), Color(0.12, 0.11, 0.11), 2.5)


func _draw_hall_table() -> void:
	_ellipse(Vector2(692, 1272), Vector2(118, 8), PlaceholderArt.SHADOW)
	# Long console table; its locked drawer is the clickable container.
	draw_rect(Rect2(592, 1172, 200, 12), PlaceholderArt.WOOD_LIGHT)
	draw_rect(Rect2(592, 1172, 200, 3), Color(1, 0.9, 0.7, 0.15))
	draw_rect(Rect2(598, 1184, 188, 40), PlaceholderArt.WOOD)
	draw_rect(Rect2(598, 1220, 188, 4), PlaceholderArt.WOOD_DARK)
	for leg_x: float in [602.0, 774.0]:
		_polygon([Vector2(leg_x, 1224), Vector2(leg_x + 9, 1224), Vector2(leg_x + 7, 1268), Vector2(leg_x + 2, 1268)], PlaceholderArt.WOOD_DARK)
	# Silver tray with unopened letters
	_ellipse(Vector2(630, 1168), Vector2(26, 5), Color(0.62, 0.62, 0.66))
	draw_rect(Rect2(614, 1160, 24, 8), PlaceholderArt.BEIGE)
	draw_rect(Rect2(620, 1157, 22, 8), Color(0.78, 0.74, 0.62))
	# The dim hall lamp
	_ellipse(Vector2(768, 1170), Vector2(16, 4), Color(0.3, 0.26, 0.2))
	draw_line(Vector2(768, 1168), Vector2(768, 1130), BRASS.darkened(0.2), 3.0)
	_polygon([Vector2(748, 1132), Vector2(788, 1132), Vector2(778, 1102), Vector2(758, 1102)], Color(0.86, 0.68, 0.42))
	_polygon([Vector2(748, 1132), Vector2(788, 1132), Vector2(786, 1126), Vector2(750, 1126)], Color(0.7, 0.5, 0.3))


func _draw_grandfather_clock() -> void:
	# The clock's head and face; the case door below is the clickable container.
	var wood := Color(0.27, 0.16, 0.1)
	var wood_light := Color(0.38, 0.24, 0.15)
	_ellipse(Vector2(930, 1256), Vector2(56, 7), PlaceholderArt.SHADOW)
	# Plinth and the case behind the door
	draw_rect(Rect2(886, 1204, 88, 48), wood)
	draw_rect(Rect2(882, 1246, 96, 8), wood_light)
	draw_rect(Rect2(890, 1092, 80, 116), wood.darkened(0.2))
	# Head with a broken-arch pediment
	draw_rect(Rect2(884, 990, 92, 102), wood)
	draw_rect(Rect2(880, 1086, 100, 8), wood_light)
	_polygon([Vector2(880, 992), Vector2(906, 966), Vector2(918, 966), Vector2(900, 992)], wood_light)
	_polygon([Vector2(980, 992), Vector2(954, 966), Vector2(942, 966), Vector2(960, 992)], wood_light)
	draw_circle(Vector2(930, 968), 6, BRASS)
	for column_x: float in [886.0, 968.0]:
		draw_rect(Rect2(column_x, 996, 6, 90), wood_light)
	# Brass dial and the hands, stopped
	var face := Vector2(930, 1040)
	draw_circle(face, 34, BRASS.darkened(0.25))
	draw_circle(face, 30, Color(0.86, 0.8, 0.66))
	draw_arc(face, 24, 0, TAU, 32, Color(0.3, 0.25, 0.2, 0.5), 1.0, true)
	for i in range(12):
		var mark := face + Vector2.from_angle(TAU * i / 12.0) * 26.0
		draw_circle(mark, 1.4, Color(0.2, 0.16, 0.12))
	draw_line(face, face + Vector2.from_angle(-PI * 0.5 - 0.5) * 16.0, Color(0.1, 0.08, 0.06), 2.5)
	draw_line(face, face + Vector2.from_angle(-PI * 0.5 + 1.95) * 23.0, Color(0.1, 0.08, 0.06), 1.5)
	draw_circle(face, 2.5, Color(0.1, 0.08, 0.06))
	draw_arc(face, 30, PI * 1.1, PI * 1.45, 8, Color(1, 1, 1, 0.4), 2.0, true)


func _draw_fern() -> void:
	# A fern in a pot on a stone pedestal at the top of the stairs
	_ellipse(Vector2(364, 505), Vector2(22, 4), PlaceholderArt.SHADOW)
	draw_rect(Rect2(354, 474, 20, 30), Color(0.4, 0.37, 0.36))
	draw_rect(Rect2(348, 468, 32, 7), Color(0.5, 0.47, 0.45))
	draw_rect(Rect2(354, 474, 5, 30), Color(1, 1, 1, 0.06))
	_polygon([Vector2(348, 446), Vector2(380, 446), Vector2(374, 468), Vector2(354, 468)], Color(0.45, 0.25, 0.18))
	draw_rect(Rect2(346, 443, 36, 5), Color(0.52, 0.3, 0.22))
	var frond := Color(0.2, 0.31, 0.18)
	_draw_frond(Vector2(360, 446), Vector2(346, 412), Vector2(326, 404), frond)
	_draw_frond(Vector2(364, 446), Vector2(366, 404), Vector2(356, 384), frond.lightened(0.08))
	_draw_frond(Vector2(368, 446), Vector2(386, 410), Vector2(404, 404), frond)
	_draw_frond(Vector2(370, 448), Vector2(394, 440), Vector2(412, 452), frond.darkened(0.15))


## A drooping fern frond: a curved stem from `base` through `bend` to `tip`, with leaflets.
func _draw_frond(base: Vector2, bend: Vector2, tip: Vector2, color: Color) -> void:
	var points := PackedVector2Array()
	for i in range(11):
		var t := i / 10.0
		points.append(base.lerp(bend, t).lerp(bend.lerp(tip, t), t))
	draw_polyline(points, color.darkened(0.2), 1.5, true)
	for i in range(1, points.size()):
		var along := (points[i] - points[i - 1]).normalized()
		var side := Vector2(-along.y, along.x)
		var length := 9.0 * (1.0 - i / 12.0)
		for sign: float in [-1.0, 1.0]:
			var leaf_tip := points[i] + (side * sign + along * 0.6) * length
			_polygon([points[i - 1], leaf_tip, points[i]], color)


# ---------------------------------------------------------------------------
# Light
# ---------------------------------------------------------------------------

func _draw_moonlight() -> void:
	# Pale beams from the stained-glass window falling down across the stairs
	_polygon([Vector2(600, 404), Vector2(760, 404), Vector2(640, 980), Vector2(400, 980)], MOONLIGHT)
	_polygon([Vector2(640, 404), Vector2(730, 404), Vector2(600, 900), Vector2(470, 900)], MOONLIGHT)
	# A few tinted spots where the coloured glass falls on the steps
	_ellipse(Vector2(560, 590), Vector2(30, 10), Color(0.4, 0.5, 0.9, 0.06))
	_ellipse(Vector2(600, 640), Vector2(22, 8), Color(0.7, 0.4, 0.6, 0.05))
	_ellipse(Vector2(520, 960), Vector2(36, 10), Color(0.6, 0.7, 1.0, 0.05))


func _draw_lamp_glow() -> void:
	_glow(Vector2(768, 1120), 26, 6, 26, LAMP_LIGHT)
	_ellipse(Vector2(720, 1300), Vector2(220, 40), Color(1.0, 0.75, 0.4, 0.04))
	draw_circle(Vector2(768, 1132), 8, Color(1.0, 0.85, 0.55, 0.5))
