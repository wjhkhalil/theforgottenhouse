@tool
class_name IslandChapelArt
extends RoomArt
## Placeholder drawing of House Two, Chapter Nine: the little stone chapel on
## the island, at night. See room_art.gd for how to replace it with a real image.
##
## Layout: we look up the chapel towards the altar. In the middle of the back
## wall is a stained-glass window, faintly lit by the moon, with the altar and
## its cloth below it. Left: the bell rope, the wooden pulpit with its steps,
## the hymn board, the alms box and the stone font. Right: the aumbry (a small
## cupboard in the wall), the arched vestry door and the parish chest.
## Rows of pews fill the front, on both sides of the aisle.
## The candles themselves are drawn by CandleLights, which also makes it dark.

const FLOOR_Y := 440.0
const WINDOW_RECT := Rect2(585, 85, 110, 205)
const ALTAR_RECT := Rect2(535, 356, 210, 82)
const STEP_RECT := Rect2(495, 436, 285, 20)
const PULPIT_RECT := Rect2(165, 250, 130, 115)
const FONT_X := 430.0
const VESTRY_RECT := Rect2(858, 238, 94, 208)
const BELL_ROPE_X := 112.0
const STONE := Color(0.25, 0.25, 0.27)
const STONE_DARK := Color(0.15, 0.15, 0.17)
const STONE_LIGHT := Color(0.36, 0.36, 0.38)
const OAK := Color(0.33, 0.22, 0.14)
const OAK_DARK := Color(0.19, 0.13, 0.08)
const OAK_LIGHT := Color(0.45, 0.32, 0.2)
const MOON := Color(0.72, 0.8, 0.95)
const PEW_ROWS_BACK: Array[float] = [560.0, 625.0]
const PEW_ROW_FRONT := 690.0


func _draw_background() -> void:
	_draw_wall()
	_draw_roof()
	_draw_window()
	_draw_floor()
	_draw_bell_rope()
	_draw_hymn_board()
	_draw_alms_post()
	_draw_altar()
	_draw_aumbry()
	_draw_vestry_arch()
	_draw_pulpit()
	_draw_font()
	_draw_veil_peg()
	for row_top in PEW_ROWS_BACK:
		_draw_pew_row(row_top)


func _draw_foreground() -> void:
	# The front row of pews, nearest to us: only the back rail and carved ends show.
	_draw_pew_row(PEW_ROW_FRONT)
	# Stone pillars at both edges frame the view.
	for x: float in [0.0, 1222.0]:
		draw_rect(Rect2(x, 0, 58, room_size.y), STONE_DARK)
		draw_rect(Rect2(x + 6, 0, 8, room_size.y), Color(STONE_LIGHT, 0.4))
		for y in range(0, int(room_size.y), 64):
			draw_line(Vector2(x, y), Vector2(x + 58, y), Color(0, 0, 0, 0.4), 1.5)
	# A cobweb in the top left corner under the roof beam.
	var corner := Vector2(58, 70)
	for i in range(5):
		var angle := 0.15 + i * 0.32
		draw_line(corner, corner + Vector2(cos(angle), sin(angle)) * 70.0, Color(0.85, 0.85, 0.9, 0.16), 1.0)
	_draw_vignette()


# ---------------------------------------------------------------------------

## Rough stone blocks, darker towards the top.
func _draw_wall() -> void:
	_vertical_gradient(Rect2(0, 0, room_size.x, FLOOR_Y), Color(0.1, 0.1, 0.13), Color(0.2, 0.2, 0.23))
	var rng := RandomNumberGenerator.new()
	rng.seed = 909
	var row := 0
	var y := 70.0
	while y < FLOOR_Y:
		var height := 34.0
		var x := -30.0 + (row % 2) * 34.0
		while x < room_size.x:
			var width := rng.randf_range(52.0, 84.0)
			var shade := rng.randf_range(-0.03, 0.03)
			draw_rect(Rect2(x + 1, y + 1, width - 2, height - 2), Color(0.2 + shade, 0.2 + shade, 0.23 + shade, 0.55))
			draw_line(Vector2(x, y), Vector2(x, y + height), Color(0, 0, 0, 0.35), 1.5)
			x += width
		draw_line(Vector2(0, y), Vector2(room_size.x, y), Color(0, 0, 0, 0.35), 1.5)
		y += height
		row += 1
	# Lime-washed plaster, flaking, high up behind the altar
	_ellipse(Vector2(640, 330), Vector2(190, 70), Color(0.6, 0.6, 0.58, 0.06))


## Dark roof timbers across the top.
func _draw_roof() -> void:
	draw_rect(Rect2(0, 0, room_size.x, 70), Color(0.07, 0.055, 0.05))
	draw_rect(Rect2(0, 58, room_size.x, 14), OAK_DARK)
	draw_line(Vector2(0, 58), Vector2(room_size.x, 58), Color(0.3, 0.22, 0.15), 1.5)
	for x in range(40, int(room_size.x), 150):
		draw_rect(Rect2(x, 0, 16, 60), Color(0.13, 0.09, 0.07))
		# Curved wooden braces
		draw_arc(Vector2(x + 8, 60), 26, PI, PI * 1.5, 8, Color(0.16, 0.11, 0.08), 6.0)


## The pointed stained-glass window, faintly lit by the moon behind it.
func _draw_window() -> void:
	var rect := WINDOW_RECT
	var centre_x := rect.get_center().x
	var arch_y := rect.position.y + rect.size.x * 0.5
	# Stone surround
	_window_shape(rect.grow(9), arch_y - 2, STONE_LIGHT)
	_window_shape(rect, arch_y, Color(0.12, 0.14, 0.22))
	# Coloured panes in a lead grid
	var colours := [Color(0.25, 0.35, 0.6), Color(0.55, 0.18, 0.2), Color(0.6, 0.5, 0.2), Color(0.22, 0.42, 0.3)]
	var pane := 0
	for py in range(int(arch_y), int(rect.end.y) - 4, 22):
		for px in range(int(rect.position.x) + 3, int(rect.end.x) - 4, 26):
			draw_rect(Rect2(px, py, 24, 20), Color(colours[pane % colours.size()], 0.75))
			pane += 1
		pane += 1
	# The arched top: a golden sun of glass
	draw_circle(Vector2(centre_x, arch_y + 4), rect.size.x * 0.42, Color(0.6, 0.5, 0.22, 0.7))
	for i in range(8):
		var direction := Vector2.from_angle(PI + PI * i / 7.0)
		draw_line(Vector2(centre_x, arch_y + 4), Vector2(centre_x, arch_y + 4) + direction * rect.size.x * 0.42, Color(0.1, 0.1, 0.12), 2.0)
	# A white dove in the middle panel
	_polygon([Vector2(centre_x - 14, 182), Vector2(centre_x, 174), Vector2(centre_x + 14, 182), Vector2(centre_x + 4, 186),
		Vector2(centre_x, 196), Vector2(centre_x - 4, 186)], Color(0.85, 0.88, 0.95, 0.85))
	# Lead lines and the mullion
	draw_line(Vector2(centre_x, arch_y - 10), Vector2(centre_x, rect.end.y), Color(0.08, 0.08, 0.1), 3.0)
	for py in range(int(arch_y), int(rect.end.y), 22):
		draw_line(Vector2(rect.position.x, py), Vector2(rect.end.x, py), Color(0.08, 0.08, 0.1), 2.0)
	# Moonlight shining through
	_glow(Vector2(centre_x - 20, arch_y + 10), 10, 4, 12, Color(MOON, 0.05))
	# Deep stone sill
	draw_rect(Rect2(rect.position.x - 14, rect.end.y, rect.size.x + 28, 10), STONE_LIGHT)
	draw_rect(Rect2(rect.position.x - 14, rect.end.y + 10, rect.size.x + 28, 3), STONE_DARK)


## A rectangle with a pointed (Gothic) top.
func _window_shape(rect: Rect2, arch_y: float, color: Color) -> void:
	var points: Array[Vector2] = [Vector2(rect.position.x, rect.end.y), Vector2(rect.position.x, arch_y)]
	var half := rect.size.x * 0.5
	for i in range(1, 8):
		var t := i / 8.0
		points.append(Vector2(rect.position.x + half * t, arch_y - (arch_y - rect.position.y) * sin(t * PI * 0.5)))
	points.append(Vector2(rect.get_center().x, rect.position.y))
	for i in range(7, 0, -1):
		var t := i / 8.0
		points.append(Vector2(rect.end.x - half * t, arch_y - (arch_y - rect.position.y) * sin(t * PI * 0.5)))
	points.append(Vector2(rect.end.x, arch_y))
	points.append(rect.end)
	_polygon(points, color)


## Worn flagstones, with a faded red runner up the aisle.
func _draw_floor() -> void:
	_vertical_gradient(Rect2(0, FLOOR_Y, room_size.x, room_size.y - FLOOR_Y), Color(0.2, 0.19, 0.2), Color(0.13, 0.12, 0.13))
	var rng := RandomNumberGenerator.new()
	rng.seed = 41
	var rows: Array[float] = [FLOOR_Y, 478.0, 530.0, 595.0, 670.0, 760.0]
	for r in range(rows.size() - 1):
		var top := rows[r]
		var bottom := rows[r + 1]
		var x := -20.0 + rng.randf_range(0.0, 40.0)
		while x < room_size.x:
			var width := rng.randf_range(80.0, 140.0) * (1.0 + r * 0.15)
			var shade := rng.randf_range(-0.03, 0.04)
			draw_rect(Rect2(x + 2, top + 2, width - 4, bottom - top - 4), Color(0.22 + shade, 0.21 + shade, 0.22 + shade, 0.6))
			draw_line(Vector2(x, top), Vector2(x, bottom), Color(0, 0, 0, 0.45), 2.0)
			x += width
		draw_line(Vector2(0, top), Vector2(room_size.x, top), Color(0, 0, 0, 0.45), 2.0)
	# The runner carpet, wider as it comes towards us
	_polygon([Vector2(588, STEP_RECT.end.y), Vector2(692, STEP_RECT.end.y), Vector2(712, room_size.y), Vector2(568, room_size.y)],
		Color(0.36, 0.12, 0.12))
	draw_line(Vector2(592, STEP_RECT.end.y), Vector2(574, room_size.y), Color(0.6, 0.45, 0.2, 0.6), 2.0)
	draw_line(Vector2(688, STEP_RECT.end.y), Vector2(706, room_size.y), Color(0.6, 0.45, 0.2, 0.6), 2.0)
	# A faint patch of moonlight on the floor in front of the altar
	_ellipse(Vector2(640, 470), Vector2(70, 12), Color(MOON, 0.05))


## The bell rope hangs down from a hole in the ceiling, its striped grip (the sally) halfway down.
func _draw_bell_rope() -> void:
	var x := BELL_ROPE_X
	draw_circle(Vector2(x, 66), 10, Color(0.03, 0.03, 0.03))
	draw_line(Vector2(x, 60), Vector2(x, 430), Color(0.6, 0.52, 0.38), 3.0)
	# The woolly sally: red, white and blue stripes
	var stripes := [Color(0.6, 0.15, 0.15), Color(0.85, 0.83, 0.78), Color(0.2, 0.25, 0.5)]
	for i in range(9):
		draw_rect(Rect2(x - 6, 300 + i * 7, 12, 7), stripes[i % 3])
	draw_rect(Rect2(x - 6, 300, 3, 63), Color(1, 1, 1, 0.12))
	# The tail of the rope looped over an iron cleat on the wall
	draw_rect(Rect2(x + 10, 418, 14, 5), Color(0.2, 0.2, 0.2))
	draw_polyline(PackedVector2Array([Vector2(x, 430), Vector2(x + 6, 440), Vector2(x + 16, 420), Vector2(x + 20, 440),
		Vector2(x + 12, 452)]), Color(0.6, 0.52, 0.38), 3.0, true)


## A wooden hymn board with tonight's numbers still slotted in.
func _draw_hymn_board() -> void:
	var rect := Rect2(338, 170, 64, 100)
	draw_rect(Rect2(rect.position + Vector2(3, 3), rect.size), Color(0, 0, 0, 0.35))
	draw_rect(rect, OAK_DARK)
	draw_rect(rect.grow(-4), Color(0.12, 0.08, 0.05))
	# A little pointed top
	_polygon([rect.position, Vector2(rect.get_center().x, rect.position.y - 14), Vector2(rect.end.x, rect.position.y)], OAK_DARK)
	var font := ThemeDB.fallback_font
	var numbers := ["47", "312", "165", "9"]
	for i in range(numbers.size()):
		draw_rect(Rect2(rect.position.x + 8, rect.position.y + 8 + i * 22, rect.size.x - 16, 17), Color(0.2, 0.15, 0.1))
		draw_string(font, Vector2(rect.position.x + 8, rect.position.y + 22 + i * 22), numbers[i], HORIZONTAL_ALIGNMENT_CENTER,
			rect.size.x - 16, 14, Color(0.9, 0.88, 0.8))


## The alms box hangs on a short wooden board on the wall, with a painted sign.
func _draw_alms_post() -> void:
	draw_rect(Rect2(484, 262, 52, 60), OAK_DARK)
	draw_rect(Rect2(488, 266, 44, 52), OAK)
	draw_string(ThemeDB.fallback_font, Vector2(484, 258), "ALMS", HORIZONTAL_ALIGNMENT_CENTER, 52, 12, Color(0.75, 0.62, 0.35))


## The stone altar on its step, with a white cloth and an embroidered frontal.
func _draw_altar() -> void:
	# Step
	draw_rect(STEP_RECT, STONE_LIGHT)
	draw_rect(Rect2(STEP_RECT.position.x, STEP_RECT.end.y - 4, STEP_RECT.size.x, 4), STONE_DARK)
	# Stone table
	draw_rect(ALTAR_RECT, STONE)
	draw_rect(Rect2(ALTAR_RECT.position.x, ALTAR_RECT.position.y, 10, ALTAR_RECT.size.y), STONE_LIGHT)
	# White cloth over the top, hanging down at the sides
	var cloth := Color(0.86, 0.85, 0.8)
	draw_rect(Rect2(ALTAR_RECT.position.x - 8, ALTAR_RECT.position.y - 6, ALTAR_RECT.size.x + 16, 10), cloth)
	draw_rect(Rect2(ALTAR_RECT.position.x - 8, ALTAR_RECT.position.y + 4, 22, 40), cloth)
	draw_rect(Rect2(ALTAR_RECT.end.x - 14, ALTAR_RECT.position.y + 4, 22, 40), cloth)
	draw_line(Vector2(ALTAR_RECT.position.x + 2, ALTAR_RECT.position.y + 6), Vector2(ALTAR_RECT.position.x + 2, ALTAR_RECT.position.y + 42),
		Color(0.68, 0.67, 0.63), 1.5)
	draw_line(Vector2(ALTAR_RECT.end.x - 3, ALTAR_RECT.position.y + 6), Vector2(ALTAR_RECT.end.x - 3, ALTAR_RECT.position.y + 42),
		Color(0.68, 0.67, 0.63), 1.5)
	# Lace edge
	for x in range(int(ALTAR_RECT.position.x) - 6, int(ALTAR_RECT.end.x) + 6, 8):
		draw_arc(Vector2(x + 4, ALTAR_RECT.position.y + 4), 4, 0, PI, 5, cloth, 1.5)
	# The green frontal with a gold cross and fringe
	var frontal := Rect2(ALTAR_RECT.position.x + 40, ALTAR_RECT.position.y + 4, ALTAR_RECT.size.x - 80, 58)
	draw_rect(frontal, Color(0.18, 0.3, 0.22))
	draw_rect(frontal.grow(-4), Color(0.75, 0.6, 0.3, 0.6), false, 1.0)
	var middle := frontal.get_center()
	draw_rect(Rect2(middle.x - 3, middle.y - 20, 6, 36), Color(0.78, 0.63, 0.32))
	draw_rect(Rect2(middle.x - 13, middle.y - 10, 26, 6), Color(0.78, 0.63, 0.32))
	for x in range(int(frontal.position.x), int(frontal.end.x), 4):
		draw_line(Vector2(x, frontal.end.y), Vector2(x, frontal.end.y + 5), Color(0.75, 0.6, 0.3), 1.0)


## A small stone niche in the wall for the sacred vessels (the aumbry's door is the container).
func _draw_aumbry() -> void:
	draw_rect(Rect2(764, 270, 52, 60), STONE_LIGHT)
	draw_rect(Rect2(768, 274, 44, 52), Color(0.05, 0.05, 0.06))
	draw_rect(Rect2(760, 330, 60, 6), STONE_LIGHT)


## The stone arch around the vestry door, and a worn step.
func _draw_vestry_arch() -> void:
	var rect := VESTRY_RECT
	var centre := Vector2(rect.get_center().x, rect.position.y + rect.size.x * 0.5)
	draw_rect(Rect2(rect.position.x - 12, centre.y, rect.size.x + 24, rect.end.y - centre.y), STONE_LIGHT)
	draw_circle(centre, rect.size.x * 0.5 + 12, STONE_LIGHT)
	draw_circle(centre, rect.size.x * 0.5, Color(0.08, 0.06, 0.05))
	draw_rect(Rect2(rect.position.x, centre.y, rect.size.x, rect.end.y - centre.y), Color(0.08, 0.06, 0.05))
	# Wedge-shaped stones (voussoirs) round the arch
	for i in range(9):
		var direction := Vector2.from_angle(PI + PI * i / 8.0)
		draw_line(centre + direction * rect.size.x * 0.5, centre + direction * (rect.size.x * 0.5 + 12), STONE_DARK, 2.0)
	# The arched top of the door itself (the rest of the door is the container)
	draw_arc(centre, rect.size.x * 0.5 - 4, PI, TAU, 16, OAK_DARK, 8.0)
	draw_rect(Rect2(rect.position.x - 16, rect.end.y, rect.size.x + 32, 8), STONE)


## The wooden pulpit: a panelled box on a stem, with steps coming down on its right.
func _draw_pulpit() -> void:
	var rect := PULPIT_RECT
	# Steps and handrail
	for i in range(5):
		var step_x := rect.end.x + i * 14.0
		draw_rect(Rect2(step_x - 4, rect.end.y + i * 18.0, 30, 6), OAK_DARK)
		draw_rect(Rect2(step_x - 4, rect.end.y + i * 18.0 + 6, 30, 12), Color(0.12, 0.08, 0.05))
	draw_line(Vector2(rect.end.x, rect.end.y - 40), Vector2(rect.end.x + 82, FLOOR_Y - 24), OAK_LIGHT, 3.0)
	draw_line(Vector2(rect.end.x + 82, FLOOR_Y - 24), Vector2(rect.end.x + 82, FLOOR_Y + 12), OAK, 4.0)
	# Stem and base
	draw_rect(Rect2(rect.get_center().x - 16, rect.end.y, 32, FLOOR_Y - rect.end.y + 10), OAK_DARK)
	draw_rect(Rect2(rect.get_center().x - 30, FLOOR_Y + 6, 60, 10), OAK_DARK)
	# The panelled box
	draw_rect(rect, OAK)
	draw_rect(Rect2(rect.position.x, rect.position.y, rect.size.x, 10), OAK_LIGHT)
	for i in range(3):
		var panel := Rect2(rect.position.x + 10 + i * 40, rect.position.y + 18, 30, 44)
		draw_rect(panel, OAK_DARK, false, 2.0)
		draw_arc(Vector2(panel.get_center().x, panel.position.y + 8), 8, PI, TAU, 8, OAK_DARK, 1.5)
	draw_rect(Rect2(rect.position.x, rect.end.y - 8, rect.size.x, 8), OAK_DARK)
	draw_line(rect.position + Vector2(4, 12), Vector2(rect.position.x + 4, rect.end.y - 8), Color(1, 0.9, 0.7, 0.15), 2.0)
	# The sloping book rest
	_polygon([Vector2(rect.position.x + 50, rect.position.y), Vector2(rect.end.x - 6, rect.position.y),
		Vector2(rect.end.x - 12, rect.position.y - 10), Vector2(rect.position.x + 56, rect.position.y - 10)], OAK_LIGHT)


## The stone font: a carved bowl on a short pillar (its wooden lid is the container).
func _draw_font() -> void:
	var x := FONT_X
	_ellipse(Vector2(x, 556), Vector2(40, 7), Color(0, 0, 0, 0.35))
	draw_rect(Rect2(x - 28, 540, 56, 14), STONE)
	draw_rect(Rect2(x - 13, 488, 26, 54), STONE)
	draw_rect(Rect2(x - 13, 488, 6, 54), STONE_LIGHT)
	_polygon([Vector2(x - 38, 456), Vector2(x + 38, 456), Vector2(x + 28, 492), Vector2(x - 28, 492)], STONE_LIGHT)
	_polygon([Vector2(x - 32, 462), Vector2(x + 32, 462), Vector2(x + 24, 488), Vector2(x - 24, 488)], STONE)
	# Carved quatrefoils on the bowl
	for offset: float in [-16.0, 0.0, 16.0]:
		draw_arc(Vector2(x + offset, 475), 5, 0, TAU, 10, STONE_DARK, 1.5)


## The wooden peg by the vestry door where the veil hangs.
func _draw_veil_peg() -> void:
	draw_rect(Rect2(822, 352, 26, 6), OAK_DARK)


## One row of oak pews on both sides of the aisle. `top` is the top of the back rail.
func _draw_pew_row(top: float) -> void:
	for block: Vector2 in [Vector2(70, 548), Vector2(732, room_size.x)]:
		# The back panel and its thick top rail
		draw_rect(Rect2(block.x, top + 10, block.y - block.x, 34), OAK_DARK)
		draw_rect(Rect2(block.x, top, block.y - block.x, 12), OAK)
		draw_line(Vector2(block.x, top + 2), Vector2(block.y, top + 2), Color(1, 0.9, 0.7, 0.18), 2.0)
		for x in range(int(block.x) + 30, int(block.y), 60):
			draw_line(Vector2(x, top + 14), Vector2(x, top + 42), Color(0, 0, 0, 0.3), 1.5)
		# The carved end near the aisle, with a rounded top
		var end_x := block.y - 16 if block.x < 640 else block.x
		draw_rect(Rect2(end_x, top - 8, 16, 58), OAK)
		draw_circle(Vector2(end_x + 8, top - 8), 8, OAK)
		draw_arc(Vector2(end_x + 8, top + 18), 4, 0, TAU, 8, OAK_DARK, 1.5)
