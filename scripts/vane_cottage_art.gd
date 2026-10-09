@tool
class_name VaneCottageArt
extends RoomArt
## Placeholder drawing of House Two, Chapter Ten: Dr Vane's cottage, his
## parlour-and-surgery, late at night. See room_art.gd for how to replace it
## with a real image.
##
## Layout, left to right along the back wall: the heavy cellar door in a stone
## arch (with a wall calendar above it), the fireplace with a mantel clock and
## a fire in the grate, Vane's desk with its green lamp under the two front
## windows (the dark garden path outside: PatrolLantern draws his lantern
## there), the glass medicine cabinet, and a tall bookcase. The foreground adds
## the padlock on the cellar door (until it is opened), the desk chair, a fern
## and a coat stand.

const FLOOR_Y := 540.0
const DADO_Y := 420.0
const CELLAR_RECT := Rect2(98, 320, 100, 200)
const CALENDAR_RECT := Rect2(102, 128, 92, 136)
const CHIMNEY_RECT := Rect2(226, 60, 228, 480)
const MANTEL_RECT := Rect2(214, 296, 252, 12)
const GRATE_RECT := Rect2(276, 382, 128, 156)
## The two front windows (PatrolLantern uses the same rectangles).
const WINDOWS: Array[Rect2] = [Rect2(482, 160, 116, 196), Rect2(642, 160, 116, 196)]
const DESK_TOP_Y := 430.0
const LAMP := Vector2(726, 382)
const CABINET_RECT := Rect2(790, 150, 100, 390)
const BOOKCASE_RECT := Rect2(904, 96, 300, 444)
const SHELF_YS: Array[float] = [188.0, 280.0, 370.0, 460.0]
const WOOD := Color(0.3, 0.19, 0.12)
const WOOD_DARK := Color(0.17, 0.1, 0.07)
const WOOD_LIGHT := Color(0.44, 0.3, 0.19)
const STONE := Color(0.46, 0.43, 0.4)
const STONE_DARK := Color(0.3, 0.28, 0.26)
const FIRE := Color(1.0, 0.6, 0.22)
const LAMP_GREEN := Color(0.16, 0.46, 0.26)
const PAPER := Color(0.92, 0.88, 0.78)
const INK := Color(0.15, 0.13, 0.18)
const RED_INK := Color(0.7, 0.12, 0.1)

## The cellar door container: the foreground draws a padlock on it until it opens.
var _cellar_door: Node = null


func _ready() -> void:
	if Engine.is_editor_hint() or layer != Layer.FOREGROUND:
		return
	_cellar_door = get_parent().get_node_or_null("HiddenObjects/CellarDoor")
	if _cellar_door != null and _cellar_door.has_signal("opened"):
		_cellar_door.connect("opened", func(_container: Node) -> void: queue_redraw())


func _draw_background() -> void:
	_draw_walls()
	_draw_floor()
	_draw_cellar_door()
	_draw_calendar()
	_draw_fireplace()
	_draw_windows()
	_draw_desk()
	_draw_medicine_cabinet()
	_draw_bookcase()
	_draw_lamp_light()


func _draw_foreground() -> void:
	_draw_padlock()
	_draw_desk_chair()
	_draw_fern()
	_draw_coat_stand()
	_draw_vignette()


# ---------------------------------------------------------------------------

## Dark red patterned wallpaper above, wooden panelling below the dado rail.
func _draw_walls() -> void:
	_vertical_gradient(Rect2(0, 0, room_size.x, FLOOR_Y), Color(0.2, 0.09, 0.08), Color(0.3, 0.15, 0.12))
	# A faint damask pattern: rows of little diamonds.
	for row in range(14):
		for column in range(34):
			var at := Vector2(column * 40.0 + (20.0 if row % 2 == 1 else 0.0), 20.0 + row * 30.0)
			if at.y > DADO_Y - 10:
				continue
			_polygon([at + Vector2(0, -6), at + Vector2(5, 0), at + Vector2(0, 6), at + Vector2(-5, 0)], Color(0.42, 0.22, 0.17, 0.35))
	# Picture rail and dado rail
	draw_rect(Rect2(0, 96, room_size.x, 6), WOOD_DARK)
	draw_rect(Rect2(0, DADO_Y - 4, room_size.x, 8), WOOD_LIGHT)
	# Panelling below the dado rail
	draw_rect(Rect2(0, DADO_Y + 4, room_size.x, FLOOR_Y - DADO_Y - 4), WOOD)
	var x := 10.0
	while x < room_size.x:
		draw_rect(Rect2(x, DADO_Y + 16, 70, FLOOR_Y - DADO_Y - 34), WOOD_DARK, false, 2.0)
		x += 84.0
	# Skirting board
	draw_rect(Rect2(0, FLOOR_Y - 12, room_size.x, 12), WOOD_DARK)


## Polished floorboards with a worn red rug in the middle.
func _draw_floor() -> void:
	_vertical_gradient(Rect2(0, FLOOR_Y, room_size.x, room_size.y - FLOOR_Y), Color(0.24, 0.15, 0.1), Color(0.34, 0.22, 0.14))
	for y: float in [560.0, 586.0, 618.0, 656.0, 700.0]:
		draw_line(Vector2(0, y), Vector2(room_size.x, y), Color(0.14, 0.09, 0.06), 1.5)
	var rng := RandomNumberGenerator.new()
	rng.seed = 2350
	for row in range(5):
		var x := rng.randf_range(0, 120)
		while x < room_size.x:
			draw_line(Vector2(x, [540.0, 560.0, 586.0, 618.0, 656.0][row]), Vector2(x, [560.0, 586.0, 618.0, 656.0, 700.0][row]), Color(0.14, 0.09, 0.06), 1.0)
			x += rng.randf_range(140, 240)
	# The rug, seen in perspective
	var rug: Array[Vector2] = [Vector2(330, 578), Vector2(950, 578), Vector2(1010, 700), Vector2(270, 700)]
	_polygon(rug, Color(0.4, 0.12, 0.1))
	_polygon([Vector2(352, 586), Vector2(930, 586), Vector2(980, 690), Vector2(300, 690)], Color(0.5, 0.18, 0.13))
	_polygon([Vector2(400, 604), Vector2(880, 604), Vector2(912, 672), Vector2(368, 672)], Color(0.36, 0.13, 0.12))
	for i in range(5):
		var at := Vector2(500 + i * 70.0, 638)
		_polygon([at + Vector2(0, -16), at + Vector2(14, 0), at + Vector2(0, 16), at + Vector2(-14, 0)], Color(0.7, 0.5, 0.25, 0.6))
	# Fringe
	for i in range(40):
		var start := Vector2(270, 700).lerp(Vector2(1010, 700), i / 39.0)
		draw_line(start, start + Vector2(0, 6), Color(0.78, 0.7, 0.55), 1.0)


## The heavy cellar door in a stone arch, with stone steps in front.
func _draw_cellar_door() -> void:
	var arch := CELLAR_RECT.grow(14)
	draw_rect(Rect2(arch.position.x, arch.position.y + 20, arch.size.x, arch.size.y - 20), STONE_DARK)
	draw_circle(Vector2(arch.get_center().x, arch.position.y + 30), arch.size.x / 2.0, STONE_DARK)
	# Stone blocks round the arch
	for i in range(7):
		var angle := PI + i * PI / 6.0
		var at := Vector2(arch.get_center().x, arch.position.y + 30) + Vector2.from_angle(angle) * (arch.size.x / 2.0 - 6)
		draw_rect(Rect2(at - Vector2(9, 6), Vector2(18, 12)), STONE)
	for y in range(int(arch.position.y + 40), int(arch.end.y), 26):
		draw_rect(Rect2(arch.position.x, y, 12, 20), STONE)
		draw_rect(Rect2(arch.end.x - 12, y + 10, 12, 20), STONE)
	# The dark doorway behind the door
	draw_rect(CELLAR_RECT, Color(0.05, 0.04, 0.03))
	# A painted sign on the lintel
	draw_rect(Rect2(CELLAR_RECT.position.x + 18, CELLAR_RECT.position.y - 32, 64, 14), WOOD_DARK)
	draw_string(ThemeDB.fallback_font, Vector2(CELLAR_RECT.position.x + 26, CELLAR_RECT.position.y - 21), "CELLAR",
		HORIZONTAL_ALIGNMENT_LEFT, -1, 10, Color(0.85, 0.78, 0.6))
	# Worn stone step
	draw_rect(Rect2(arch.position.x - 4, CELLAR_RECT.end.y, arch.size.x + 8, 12), STONE)
	draw_line(Vector2(arch.position.x - 4, CELLAR_RECT.end.y), Vector2(arch.end.x + 4, CELLAR_RECT.end.y), Color(0.6, 0.57, 0.52), 1.5)


## A wall calendar for October, the 8th ringed in red, and "8th: fetch M." written underneath.
func _draw_calendar() -> void:
	var rect := CALENDAR_RECT
	draw_line(rect.position + Vector2(rect.size.x / 2.0, -8), rect.position + Vector2(10, 0), Color(0.6, 0.55, 0.45), 1.0)
	draw_line(rect.position + Vector2(rect.size.x / 2.0, -8), rect.position + Vector2(rect.size.x - 10, 0), Color(0.6, 0.55, 0.45), 1.0)
	draw_circle(rect.position + Vector2(rect.size.x / 2.0, -8), 2.0, Color(0.7, 0.62, 0.4))
	draw_rect(Rect2(rect.position + Vector2(3, 3), rect.size), Color(0, 0, 0, 0.35))
	draw_rect(rect, PAPER)
	# A small picture at the top (a lake at dawn)
	_vertical_gradient(Rect2(rect.position.x + 6, rect.position.y + 5, rect.size.x - 12, 22), Color(0.5, 0.6, 0.75), Color(0.85, 0.7, 0.55))
	draw_rect(Rect2(rect.position.x + 6, rect.position.y + 21, rect.size.x - 12, 6), Color(0.3, 0.4, 0.5))
	var font := ThemeDB.fallback_font
	draw_string(font, Vector2(rect.position.x + 20, rect.position.y + 38), "OCTOBER", HORIZONTAL_ALIGNMENT_LEFT, -1, 10, INK)
	# The days in a grid, starting on a Thursday.
	var cell := Vector2(12, 13)
	var grid_origin := Vector2(rect.position.x + 5, rect.position.y + 52)
	for day in range(1, 32):
		var slot := day + 2
		var column := slot % 7
		var row := slot / 7
		var at := grid_origin + Vector2(column * cell.x, row * cell.y)
		draw_string(font, at, str(day), HORIZONTAL_ALIGNMENT_LEFT, -1, 8, INK if day != 8 else RED_INK)
		if day == 8:
			# Ringed in red, with "M." squeezed in underneath.
			draw_arc(at + Vector2(3, -3), 7.0, 0.0, TAU, 16, RED_INK, 1.5, true)
	# Vane's note at the bottom, in the same red ink.
	draw_string(font, Vector2(rect.position.x + 6, rect.end.y - 5), "8th: fetch M.", HORIZONTAL_ALIGNMENT_LEFT, -1, 9, RED_INK)


## The chimney breast, mantelpiece, mirror, mantel clock and the fire in the grate.
func _draw_fireplace() -> void:
	draw_rect(CHIMNEY_RECT, Color(0.27, 0.13, 0.11))
	draw_rect(Rect2(CHIMNEY_RECT.position.x, CHIMNEY_RECT.position.y, 6, CHIMNEY_RECT.size.y), Color(0, 0, 0, 0.25))
	draw_rect(Rect2(CHIMNEY_RECT.end.x - 6, CHIMNEY_RECT.position.y, 6, CHIMNEY_RECT.size.y), Color(0, 0, 0, 0.25))
	# Gilt mirror above the mantel
	draw_rect(Rect2(272, 128, 136, 150), Color(0.62, 0.48, 0.24))
	_vertical_gradient(Rect2(280, 136, 120, 134), Color(0.24, 0.22, 0.26), Color(0.32, 0.24, 0.2))
	draw_line(Vector2(292, 150), Vector2(330, 250), Color(1, 1, 1, 0.08), 6.0)
	# Stone surround and the mantel shelf
	draw_rect(Rect2(GRATE_RECT.position.x - 34, MANTEL_RECT.end.y, GRATE_RECT.size.x + 68, FLOOR_Y - MANTEL_RECT.end.y), Color(0.62, 0.58, 0.52))
	draw_rect(Rect2(GRATE_RECT.position.x - 34, MANTEL_RECT.end.y, GRATE_RECT.size.x + 68, 70), Color(0.55, 0.51, 0.46))
	draw_rect(MANTEL_RECT, Color(0.7, 0.66, 0.6))
	draw_rect(Rect2(MANTEL_RECT.position.x, MANTEL_RECT.end.y, MANTEL_RECT.size.x, 4), Color(0.4, 0.37, 0.33))
	# The opening, with a black iron grate and the fire
	draw_rect(GRATE_RECT, Color(0.08, 0.05, 0.04))
	_ellipse(Vector2(GRATE_RECT.get_center().x, GRATE_RECT.end.y - 40), Vector2(70, 50), Color(1.0, 0.5, 0.15, 0.2))
	_draw_fire(Vector2(GRATE_RECT.get_center().x, GRATE_RECT.end.y - 34))
	draw_rect(Rect2(GRATE_RECT.position.x + 14, GRATE_RECT.end.y - 34, GRATE_RECT.size.x - 28, 6), Color(0.15, 0.13, 0.12))
	for i in range(6):
		draw_line(Vector2(GRATE_RECT.position.x + 20 + i * 18, GRATE_RECT.end.y - 34), Vector2(GRATE_RECT.position.x + 20 + i * 18, GRATE_RECT.end.y - 8), Color(0.15, 0.13, 0.12), 3.0)
	# The hearth slab and a brass fender
	draw_rect(Rect2(232, FLOOR_Y - 4, 216, 16), Color(0.5, 0.47, 0.43))
	draw_rect(Rect2(254, FLOOR_Y - 10, 172, 4), Color(0.76, 0.6, 0.3))
	# The mantel clock and two candlesticks
	_draw_mantel_clock(Vector2(340, MANTEL_RECT.position.y))
	for x: float in [236.0, 446.0]:
		draw_rect(Rect2(x - 4, MANTEL_RECT.position.y - 6, 8, 6), Color(0.75, 0.6, 0.3))
		draw_rect(Rect2(x - 1.5, MANTEL_RECT.position.y - 26, 3, 20), Color(0.75, 0.6, 0.3))
		draw_rect(Rect2(x - 3, MANTEL_RECT.position.y - 42, 6, 16), Color(0.92, 0.9, 0.82))


## Flames: layered tongues of orange and yellow over glowing coals.
func _draw_fire(base: Vector2) -> void:
	for coal in range(7):
		draw_circle(base + Vector2(-42 + coal * 14, 4), 7.0, Color(0.75, 0.2, 0.05))
	var tongues := [[-36.0, 34.0], [-18.0, 52.0], [0.0, 66.0], [18.0, 50.0], [34.0, 36.0]]
	for tongue in tongues:
		var x: float = tongue[0]
		var height: float = tongue[1]
		draw_primitive(PackedVector2Array([base + Vector2(x - 12, 2), base + Vector2(x + 12, 2), base + Vector2(x + 3, -height)]),
			PackedColorArray([FIRE, FIRE, Color(1.0, 0.4, 0.1, 0.4)]), PackedVector2Array())
		draw_primitive(PackedVector2Array([base + Vector2(x - 6, 2), base + Vector2(x + 6, 2), base + Vector2(x + 1, -height * 0.6)]),
			PackedColorArray([Color(1, 0.9, 0.5), Color(1, 0.9, 0.5), Color(1, 0.8, 0.3, 0.5)]), PackedVector2Array())


## A tall walnut mantel clock (just scenery).
func _draw_mantel_clock(base: Vector2) -> void:
	_polygon([base + Vector2(-26, 0), base + Vector2(26, 0), base + Vector2(22, -48), base + Vector2(0, -62), base + Vector2(-22, -48)], Color(0.3, 0.17, 0.1))
	draw_circle(base + Vector2(0, -34), 15.0, Color(0.7, 0.56, 0.3))
	draw_circle(base + Vector2(0, -34), 12.5, Color(0.94, 0.92, 0.84))
	for i in range(12):
		var direction := Vector2.from_angle(TAU * i / 12.0)
		draw_line(base + Vector2(0, -34) + direction * 10.0, base + Vector2(0, -34) + direction * 12.0, INK, 1.0)
	# Ten to midnight
	draw_line(base + Vector2(0, -34), base + Vector2(-2, -42), INK, 2.0)
	draw_line(base + Vector2(0, -34), base + Vector2(-9, -40), INK, 1.2)
	draw_rect(Rect2(base.x - 28, base.y - 4, 56, 4), Color(0.22, 0.12, 0.07))


## The two front windows: the dark garden path outside, curtains, and sills.
func _draw_windows() -> void:
	for rect in WINDOWS:
		draw_rect(rect.grow(10), WOOD_DARK)
		draw_rect(rect.grow(6), Color(0.85, 0.82, 0.74))
		# Night outside: sky, a hedge, the gravel path and the garden gate.
		_vertical_gradient(rect, Color(0.04, 0.06, 0.12), Color(0.09, 0.12, 0.18))
		draw_rect(Rect2(rect.position.x, rect.position.y + 108, rect.size.x, 40), Color(0.04, 0.07, 0.05))
		for i in range(6):
			draw_circle(Vector2(rect.position.x + 10 + i * 20, rect.position.y + 110), 12.0, Color(0.05, 0.09, 0.06))
		_polygon([Vector2(rect.position.x, rect.end.y - 46), Vector2(rect.end.x, rect.end.y - 52), Vector2(rect.end.x, rect.end.y),
			Vector2(rect.position.x, rect.end.y)], Color(0.2, 0.2, 0.22))
		for i in range(12):
			draw_circle(Vector2(rect.position.x + 6 + i * 9.5, rect.end.y - 30 + (i % 3) * 8), 1.2, Color(0.35, 0.35, 0.38))
		# A sliver of moon on the left window, the gate on the right one.
		if rect == WINDOWS[0]:
			draw_circle(rect.position + Vector2(30, 34), 10.0, Color(0.85, 0.88, 0.95))
			draw_circle(rect.position + Vector2(34, 31), 9.0, Color(0.05, 0.07, 0.13))
		else:
			for i in range(5):
				draw_line(Vector2(rect.position.x + 50 + i * 9, rect.position.y + 118), Vector2(rect.position.x + 50 + i * 9, rect.position.y + 150), Color(0.3, 0.28, 0.25), 2.0)
			draw_line(Vector2(rect.position.x + 48, rect.position.y + 124), Vector2(rect.position.x + 90, rect.position.y + 124), Color(0.3, 0.28, 0.25), 2.0)
		# Rain streaks on the glass
		for i in range(8):
			var x := rect.position.x + 8 + i * 14
			draw_line(Vector2(x, rect.position.y + 10 + (i % 3) * 30), Vector2(x - 2, rect.position.y + 30 + (i % 3) * 30), Color(0.6, 0.7, 0.8, 0.25), 1.0)
		# Glazing bars: four panes over four
		draw_line(Vector2(rect.get_center().x, rect.position.y), Vector2(rect.get_center().x, rect.end.y), Color(0.85, 0.82, 0.74), 5.0)
		draw_line(Vector2(rect.position.x, rect.get_center().y), Vector2(rect.end.x, rect.get_center().y), Color(0.85, 0.82, 0.74), 5.0)
		# Sill
		draw_rect(Rect2(rect.position.x - 14, rect.end.y + 6, rect.size.x + 28, 10), Color(0.8, 0.77, 0.7))
		# Heavy green velvet curtains drawn back to each side
		for side in [-1.0, 1.0]:
			var edge := rect.position.x - 16.0 if side < 0 else rect.end.x + 16.0
			_polygon([Vector2(edge, rect.position.y - 22), Vector2(edge - side * 22, rect.position.y - 22), Vector2(edge - side * 10, rect.end.y + 30),
				Vector2(edge + side * 6, rect.end.y + 30)], Color(0.14, 0.26, 0.18))
			draw_line(Vector2(edge - side * 12, rect.position.y - 20), Vector2(edge - side * 4, rect.end.y + 28), Color(0.1, 0.18, 0.12), 2.0)
		draw_rect(Rect2(rect.position.x - 44, rect.position.y - 28, rect.size.x + 88, 6), Color(0.6, 0.48, 0.24))  # curtain rail


## Vane's pedestal desk with a leather top, an inkwell, papers, and the green lamp.
func _draw_desk() -> void:
	var left := 470.0
	var right := 776.0
	# The desk top seen slightly from above
	_polygon([Vector2(left + 10, DESK_TOP_Y - 18), Vector2(right - 10, DESK_TOP_Y - 18), Vector2(right, DESK_TOP_Y), Vector2(left, DESK_TOP_Y)], WOOD_LIGHT)
	_polygon([Vector2(left + 34, DESK_TOP_Y - 15), Vector2(right - 34, DESK_TOP_Y - 15), Vector2(right - 28, DESK_TOP_Y - 3), Vector2(left + 28, DESK_TOP_Y - 3)], Color(0.15, 0.3, 0.2))
	draw_rect(Rect2(left, DESK_TOP_Y, right - left, 12), WOOD)
	# Pedestals with drawers, and the dark kneehole between them
	for pedestal_x: float in [left + 6, right - 98]:
		draw_rect(Rect2(pedestal_x, DESK_TOP_Y + 12, 92, FLOOR_Y - DESK_TOP_Y - 12), WOOD)
		for drawer in range(3):
			var drawer_rect := Rect2(pedestal_x + 6, DESK_TOP_Y + 20 + drawer * 30, 80, 24)
			draw_rect(drawer_rect, WOOD_DARK, false, 2.0)
			draw_rect(Rect2(drawer_rect.get_center().x - 7, drawer_rect.get_center().y - 2, 14, 4), Color(0.7, 0.58, 0.32))
	draw_rect(Rect2(left + 98, DESK_TOP_Y + 12, right - left - 196, FLOOR_Y - DESK_TOP_Y - 12), Color(0.08, 0.05, 0.04))
	# Inkwell and pen, a pile of papers
	draw_rect(Rect2(530, DESK_TOP_Y - 24, 14, 10), Color(0.1, 0.1, 0.12))
	draw_line(Vector2(540, DESK_TOP_Y - 24), Vector2(552, DESK_TOP_Y - 44), Color(0.85, 0.82, 0.75), 1.5)
	for i in range(3):
		draw_rect(Rect2(560 + i * 3, DESK_TOP_Y - 14 - i * 2, 40, 6), Color(0.88 - i * 0.04, 0.84, 0.74))
	# Vane's own reminder, propped against the lamp: the clue for the desk safe.
	var card := Rect2(612, DESK_TOP_Y - 54, 84, 38)
	draw_rect(Rect2(card.position + Vector2(2, 2), card.size), Color(0, 0, 0, 0.4))
	draw_rect(card, PAPER)
	var font := ThemeDB.fallback_font
	draw_string(font, card.position + Vector2(4, 11), "SAFE:", HORIZONTAL_ALIGNMENT_LEFT, -1, 9, RED_INK)
	draw_string(font, card.position + Vector2(4, 22), "the day I brought", HORIZONTAL_ALIGNMENT_LEFT, -1, 8, INK)
	draw_string(font, card.position + Vector2(4, 33), "M. here (dd mm)", HORIZONTAL_ALIGNMENT_LEFT, -1, 8, INK)
	# The green-shaded banker's lamp
	draw_rect(Rect2(LAMP.x - 16, DESK_TOP_Y - 20, 32, 6), Color(0.7, 0.56, 0.3))
	draw_rect(Rect2(LAMP.x - 2, LAMP.y + 6, 4, DESK_TOP_Y - 20 - LAMP.y - 6), Color(0.7, 0.56, 0.3))
	_polygon([LAMP + Vector2(-28, 10), LAMP + Vector2(28, 10), LAMP + Vector2(22, -6), LAMP + Vector2(-22, -6)], LAMP_GREEN)
	draw_line(LAMP + Vector2(-20, -4), LAMP + Vector2(20, -4), Color(0.4, 0.7, 0.5), 2.0)
	draw_rect(Rect2(LAMP.x - 28, LAMP.y + 9, 56, 3), Color(1.0, 0.95, 0.7))


## The tall medicine cabinet: glass doors over shelves of bottles, a cupboard below.
func _draw_medicine_cabinet() -> void:
	var rect := CABINET_RECT
	draw_rect(Rect2(rect.position + Vector2(4, 4), rect.size), Color(0, 0, 0, 0.35))
	draw_rect(rect, WOOD)
	draw_rect(Rect2(rect.position.x - 6, rect.position.y - 4, rect.size.x + 12, 8), WOOD_DARK)  # cornice
	var glass := Rect2(rect.position.x + 6, rect.position.y + 10, rect.size.x - 12, 236)
	draw_rect(glass, Color(0.1, 0.12, 0.12))
	var rng := RandomNumberGenerator.new()
	rng.seed = 190
	for shelf_y: float in [220.0, 290.0, 360.0]:
		draw_rect(Rect2(glass.position.x, shelf_y, glass.size.x, 4), WOOD_LIGHT)
		var x := glass.position.x + 4
		while x < glass.end.x - 10:
			# Leave a gap in the middle shelf for the specimen jar.
			if shelf_y == 290.0 and x > 836 and x < 866:
				x += 6
				continue
			var height := rng.randf_range(14, 30)
			var width := rng.randf_range(7, 12)
			var color: Color = [Color(0.35, 0.2, 0.1, 0.9), Color(0.2, 0.35, 0.5, 0.85), Color(0.75, 0.75, 0.7, 0.8), Color(0.25, 0.4, 0.25, 0.85)][rng.randi() % 4]
			draw_rect(Rect2(x, shelf_y - height, width, height), color)
			draw_rect(Rect2(x + width * 0.2, shelf_y - height - 4, width * 0.6, 4), Color(0.2, 0.18, 0.16))
			draw_rect(Rect2(x + 1, shelf_y - height * 0.6, width - 2, height * 0.3), Color(0.9, 0.86, 0.76, 0.8))  # label
			x += width + rng.randf_range(2, 6)
	# Reflections on the glass and the brass-edged glazing bars
	draw_rect(glass, Color(0.7, 0.85, 0.9, 0.08))
	draw_line(glass.position + Vector2(10, 10), glass.position + Vector2(40, 120), Color(1, 1, 1, 0.12), 6.0)
	draw_line(Vector2(glass.get_center().x, glass.position.y), Vector2(glass.get_center().x, glass.end.y), WOOD_DARK, 3.0)
	draw_rect(glass, WOOD_DARK, false, 3.0)
	# A red cross on the top
	draw_rect(Rect2(rect.get_center().x - 3, rect.position.y - 22, 6, 16), Color(0.75, 0.15, 0.12))
	draw_rect(Rect2(rect.get_center().x - 8, rect.position.y - 17, 16, 6), Color(0.75, 0.15, 0.12))


## A tall bookcase full of medical books (it runs on behind the objects panel).
func _draw_bookcase() -> void:
	var rect := BOOKCASE_RECT
	draw_rect(rect, WOOD_DARK)
	draw_rect(Rect2(rect.position.x - 6, rect.position.y - 8, rect.size.x + 12, 10), WOOD)
	var rng := RandomNumberGenerator.new()
	rng.seed = 1987
	var shelf_tops: Array[float] = [rect.position.y + 8.0]
	shelf_tops.append_array(SHELF_YS)
	var shelf_bottoms: Array[float] = []
	shelf_bottoms.append_array(SHELF_YS)
	shelf_bottoms.append(rect.end.y - 6.0)
	for row in range(shelf_bottoms.size()):
		var bottom: float = shelf_bottoms[row]
		var top: float = shelf_tops[row] + 4.0
		draw_rect(Rect2(rect.position.x + 8, top, rect.size.x - 16, bottom - top), Color(0.08, 0.05, 0.04))
		var x := rect.position.x + 10.0
		while x < rect.end.x - 14.0:
			# Leave room for the fake spines (row 1, at the left) and the carriage clock (row 2, at the left).
			if (row == 1 or row == 2) and x < 992.0:
				x = 992.0
				continue
			var width := rng.randf_range(8, 15)
			var height := rng.randf_range((bottom - top) * 0.6, (bottom - top) - 4.0)
			var shade := Color(rng.randf_range(0.2, 0.5), rng.randf_range(0.08, 0.25), rng.randf_range(0.05, 0.2))
			if rng.randf() < 0.12:
				# A book leaning over
				_polygon([Vector2(x, bottom), Vector2(x + width, bottom), Vector2(x + width + 10, bottom - height), Vector2(x + 10, bottom - height)], shade)
				x += width + 12
				continue
			draw_rect(Rect2(x, bottom - height, width - 1, height), shade)
			draw_line(Vector2(x + 2, bottom - height + 8), Vector2(x + width - 3, bottom - height + 8), Color(0.85, 0.7, 0.4, 0.6), 1.0)
			x += width
		draw_rect(Rect2(rect.position.x, bottom, rect.size.x, 6), WOOD)
	draw_rect(Rect2(rect.position.x, rect.position.y, 8, rect.size.y), WOOD)
	# A few books lying flat beside the carriage clock, and a leaning one by the fake spines.
	for i in range(4):
		draw_rect(Rect2(950 - i * 2, SHELF_YS[2] - 8 - i * 8, 34 + i * 3, 7), [Color(0.3, 0.12, 0.1), Color(0.15, 0.22, 0.3), Color(0.35, 0.28, 0.12), Color(0.2, 0.25, 0.15)][i])
	_polygon([Vector2(984, SHELF_YS[1]), Vector2(992, SHELF_YS[1]), Vector2(1000, SHELF_YS[1] - 50), Vector2(992, SHELF_YS[1] - 52)], Color(0.32, 0.2, 0.12))
	# A skull on the second-to-bottom shelf, for a doctor's study
	var skull := Vector2(1120, SHELF_YS[3] - 12)
	draw_circle(skull, 10.0, Color(0.85, 0.82, 0.72))
	draw_rect(Rect2(skull.x - 6, skull.y + 4, 12, 8), Color(0.85, 0.82, 0.72))
	draw_circle(skull + Vector2(-4, -1), 2.5, Color(0.1, 0.08, 0.06))
	draw_circle(skull + Vector2(4, -1), 2.5, Color(0.1, 0.08, 0.06))


## Warm pools of light from the lamp and the fire.
func _draw_lamp_light() -> void:
	_polygon([LAMP + Vector2(-28, 12), LAMP + Vector2(28, 12), Vector2(LAMP.x + 60, DESK_TOP_Y), Vector2(LAMP.x - 70, DESK_TOP_Y)], Color(1.0, 0.95, 0.65, 0.12))
	_ellipse(Vector2(LAMP.x - 10, DESK_TOP_Y - 8), Vector2(70, 12), Color(1.0, 0.95, 0.65, 0.12))
	_ellipse(Vector2(GRATE_RECT.get_center().x, FLOOR_Y + 40), Vector2(200, 50), Color(1.0, 0.6, 0.25, 0.1))


# ---------------------------------------------------------------------------
# Foreground
# ---------------------------------------------------------------------------

## A heavy iron hasp and padlock on the cellar door, until it is opened.
func _draw_padlock() -> void:
	if _cellar_door != null and _cellar_door.get("is_open"):
		return
	var at := Vector2(CELLAR_RECT.get_center().x, CELLAR_RECT.get_center().y + 8)
	draw_rect(Rect2(at.x - 22, at.y - 26, 44, 8), Color(0.2, 0.2, 0.21))
	draw_arc(at + Vector2(0, -8), 8.0, PI, TAU, 12, Color(0.55, 0.55, 0.58), 3.0, true)
	draw_rect(Rect2(at.x - 11, at.y - 9, 22, 20), Color(0.42, 0.4, 0.38))
	draw_rect(Rect2(at.x - 11, at.y - 9, 22, 4), Color(0.6, 0.58, 0.55))
	draw_circle(at + Vector2(0, 2), 2.5, Color(0.08, 0.07, 0.06))
	draw_rect(Rect2(at.x - 1, at.y + 2, 2, 5), Color(0.08, 0.07, 0.06))


## The back of Vane's desk chair, pushed out from the kneehole.
func _draw_desk_chair() -> void:
	var wood := Color(0.24, 0.14, 0.09)
	var top := 512.0
	# Legs
	for x: float in [576.0, 664.0]:
		draw_line(Vector2(x, top + 70), Vector2(x - 4, 660), wood, 6.0)
	# Seat seen from behind
	_polygon([Vector2(566, top + 64), Vector2(674, top + 64), Vector2(680, top + 78), Vector2(560, top + 78)], Color(0.3, 0.18, 0.11))
	# Back: a curved top rail and a few spindles
	draw_rect(Rect2(570, top, 100, 12), wood)
	for i in range(5):
		draw_line(Vector2(582 + i * 19, top + 12), Vector2(582 + i * 19, top + 64), wood, 4.0)
	draw_line(Vector2(570, top + 2), Vector2(670, top + 2), Color(0.4, 0.26, 0.16), 2.0)


## A potted fern in the bottom-left corner.
func _draw_fern() -> void:
	_polygon([Vector2(10, 650), Vector2(70, 650), Vector2(62, 720), Vector2(18, 720)], Color(0.5, 0.28, 0.18))
	draw_rect(Rect2(6, 644, 68, 10), Color(0.56, 0.32, 0.2))
	for i in range(9):
		var angle := -PI + 0.25 + i * 0.33
		var tip := Vector2(40, 646) + Vector2.from_angle(angle) * 70.0
		draw_line(Vector2(40, 646), tip, Color(0.16, 0.34, 0.16), 3.0)
		for leaf in range(6):
			var at := Vector2(40, 646).lerp(tip, 0.25 + leaf * 0.12)
			draw_line(at, at + Vector2.from_angle(angle - 0.8) * 9.0, Color(0.2, 0.42, 0.2), 2.0)
			draw_line(at, at + Vector2.from_angle(angle + 0.8) * 9.0, Color(0.2, 0.42, 0.2), 2.0)


## A coat stand on the far right with Vane's hat and travelling coat.
func _draw_coat_stand() -> void:
	draw_rect(Rect2(1226, 230, 8, 470), Color(0.2, 0.12, 0.08))
	draw_rect(Rect2(1200, 696, 60, 8), Color(0.2, 0.12, 0.08))
	_polygon([Vector2(1196, 262), Vector2(1262, 262), Vector2(1276, 520), Vector2(1186, 520)], Color(0.18, 0.18, 0.2))
	draw_line(Vector2(1230, 266), Vector2(1226, 516), Color(0.12, 0.12, 0.14), 2.0)
	_ellipse(Vector2(1230, 236), Vector2(30, 6), Color(0.12, 0.11, 0.12))
	draw_rect(Rect2(1212, 210, 36, 26), Color(0.12, 0.11, 0.12))
