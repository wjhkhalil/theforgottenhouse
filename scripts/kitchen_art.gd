@tool
class_name KitchenArt
extends RoomArt
## Placeholder drawing of the Chapter Seven kitchen.
## See room_art.gd for how to replace it with a real image.
##
## Layout (left to right): a brick chimney breast with an iron cooking range
## (fire grate and oven) and a rail of utensils, a dresser with plates, a rack
## of hanging copper pans, a night window over a stone sink with a cupboard
## under it, a counter with a shelf of jars, and the servants' door in the
## far corner. A big scrubbed table with an oil lamp stands in front.
## The room is lit warmly by the fire and the lamp.

const FLOOR_Y := 520.0
const PLASTER := Color(0.36, 0.27, 0.19)
const BRICK := Color(0.38, 0.2, 0.14)
const IRON := Color(0.13, 0.12, 0.12)
const IRON_LIGHT := Color(0.26, 0.24, 0.23)
const COPPER := Color(0.72, 0.4, 0.22)
const COPPER_DARK := Color(0.48, 0.24, 0.13)
const BRASS := Color(0.76, 0.6, 0.3)
const STONE := Color(0.5, 0.47, 0.42)
const STONE_DARK := Color(0.34, 0.31, 0.28)
const FIRE := Color(1.0, 0.55, 0.18)
const LAMP_POS := Vector2(414, 486)
const FIRE_POS := Vector2(126, 432)


func _draw_background() -> void:
	_draw_back_wall()
	_draw_ceiling_beam()
	_draw_floor()
	_draw_chimney_breast()
	_draw_range()
	_draw_utensil_rail()
	_draw_hob_pans()
	_draw_dresser()
	_draw_pan_rack()
	_draw_window()
	_draw_sink()
	_draw_counter()
	_draw_servants_door()
	_draw_table()
	_draw_light()


func _draw_foreground() -> void:
	# The sink curtain hides part of the poison tin.
	_draw_sink_curtain()
	# A bunch of drying herbs hangs over a corner of the recipe card.
	_draw_herbs(Vector2(632, 198))
	# A jar on the shelf stands in front of the egg timer.
	_draw_jar(Vector2(969, 236), 10.0, 26.0, Color(0.55, 0.36, 0.18, 0.95))
	_draw_vignette()


# ---------------------------------------------------------------------------

func _draw_back_wall() -> void:
	_vertical_gradient(Rect2(0, 0, room_size.x, FLOOR_Y), Color(0.2, 0.14, 0.1), Color(0.33, 0.24, 0.17))
	# Patchy lime-washed plaster (fixed seed = same every time)
	var rng := RandomNumberGenerator.new()
	rng.seed = 707
	for i in range(70):
		var spot := Vector2(rng.randf_range(0, room_size.x), rng.randf_range(60, FLOOR_Y - 150))
		var shade := rng.randf_range(-0.04, 0.05)
		_ellipse(spot, Vector2(rng.randf_range(20, 60), rng.randf_range(10, 30)), Color(PLASTER.r + shade, PLASTER.g + shade, PLASTER.b + shade, 0.18))
	# Fine cracks
	for i in range(8):
		var start := Vector2(rng.randf_range(340, 1000), rng.randf_range(80, 300))
		var points := PackedVector2Array([start])
		for step in range(4):
			start += Vector2(rng.randf_range(-12, 12), rng.randf_range(6, 16))
			points.append(start)
		draw_polyline(points, Color(0.1, 0.07, 0.05, 0.35), 1.0)
	# Glazed tile dado along the lower wall
	var tile_top := FLOOR_Y - 150.0
	draw_rect(Rect2(0, tile_top, room_size.x, 150), Color(0.42, 0.36, 0.26))
	var y := tile_top
	while y < FLOOR_Y:
		var x := 0.0
		while x < room_size.x:
			var shade := rng.randf_range(-0.03, 0.03)
			draw_rect(Rect2(x + 1, y + 1, 28, 28), Color(0.5 + shade, 0.44 + shade, 0.32 + shade))
			draw_line(Vector2(x + 3, y + 4), Vector2(x + 14, y + 4), Color(1, 1, 1, 0.07), 2.0)
			x += 30.0
		y += 30.0
	draw_rect(Rect2(0, tile_top - 6, room_size.x, 7), Color(0.3, 0.2, 0.13))
	draw_rect(Rect2(0, tile_top - 6, room_size.x, 2), Color(0.5, 0.36, 0.24))


func _draw_ceiling_beam() -> void:
	draw_rect(Rect2(0, 40, room_size.x, 26), PlaceholderArt.WOOD_DARK)
	draw_rect(Rect2(0, 62, room_size.x, 4), Color(0.12, 0.08, 0.06))
	for x in range(30, int(room_size.x), 160):
		draw_rect(Rect2(x, 52, 8, 8), Color(0.12, 0.08, 0.06))


func _draw_floor() -> void:
	_vertical_gradient(Rect2(0, FLOOR_Y, room_size.x, room_size.y - FLOOR_Y), Color(0.24, 0.22, 0.2), Color(0.36, 0.33, 0.29))
	# Worn flagstones, rows getting deeper toward the viewer
	var rng := RandomNumberGenerator.new()
	rng.seed = 7
	var rows: Array[float] = [520.0, 548.0, 586.0, 636.0, 700.0, 760.0]
	for i in range(rows.size() - 1):
		var slab_width := 110.0 + i * 36.0
		var x := -rng.randf_range(0, slab_width)
		while x < room_size.x:
			var shade := rng.randf_range(-0.035, 0.035)
			var top := rows[i] + 2.0
			var bottom := rows[i + 1] - 2.0
			_polygon([Vector2(x + 3, top), Vector2(x + slab_width - 3, top), Vector2(x + slab_width + 2, bottom), Vector2(x - 2, bottom)],
				Color(0.33 + shade, 0.3 + shade, 0.27 + shade))
			x += slab_width
	for row_y in rows:
		draw_line(Vector2(0, row_y), Vector2(room_size.x, row_y), Color(0.1, 0.09, 0.08, 0.8), 2.0)
	# Skirting shadow and a rag rug in front of the range
	_vertical_gradient(Rect2(0, FLOOR_Y, room_size.x, 18), Color(0, 0, 0, 0.35), Color(0, 0, 0, 0))
	_ellipse(Vector2(200, 610), Vector2(150, 34), Color(0.4, 0.22, 0.17))
	_ellipse(Vector2(200, 610), Vector2(128, 27), Color(0.3, 0.32, 0.28))
	_ellipse(Vector2(200, 610), Vector2(100, 20), Color(0.46, 0.3, 0.2))
	_ellipse(Vector2(200, 610), Vector2(64, 12), Color(0.34, 0.2, 0.15))
	# Wet footprints coming in from the servants' door
	for i in range(5):
		var step := Vector2(1080 - i * 70, 560 + i * 16)
		_ellipse(step + Vector2(0, 5.0 if i % 2 == 0 else -5.0), Vector2(11, 4), Color(0.08, 0.1, 0.12, 0.35))


func _draw_chimney_breast() -> void:
	# Brick breast with a dark recess where the range sits
	draw_rect(Rect2(36, 66, 308, FLOOR_Y - 66), BRICK)
	var rng := RandomNumberGenerator.new()
	rng.seed = 71
	var row := 0
	var y := 66.0
	while y < FLOOR_Y:
		var x := 36.0 - (14.0 if row % 2 == 1 else 0.0)
		while x < 344.0:
			var shade := rng.randf_range(-0.04, 0.04)
			var left := maxf(x + 1.0, 37.0)
			var right := minf(x + 27.0, 343.0)
			draw_rect(Rect2(left, y + 1, right - left, 11), Color(BRICK.r + shade, BRICK.g + shade * 0.6, BRICK.b + shade * 0.5))
			x += 28.0
		y += 13.0
		row += 1
	draw_rect(Rect2(36, 66, 308, FLOOR_Y - 66), Color(0, 0, 0, 0.12))
	# Recess
	draw_rect(Rect2(56, 262, 268, FLOOR_Y - 262), Color(0.07, 0.05, 0.04))
	_vertical_gradient(Rect2(56, 262, 268, 60), Color(0, 0, 0, 0.6), Color(0, 0, 0, 0))
	# Wooden mantel shelf with a few things on it
	draw_rect(Rect2(28, 246, 324, 14), PlaceholderArt.WOOD)
	draw_rect(Rect2(28, 246, 324, 3), PlaceholderArt.WOOD_LIGHT)
	draw_rect(Rect2(28, 258, 324, 4), Color(0.12, 0.08, 0.06))
	draw_rect(Rect2(60, 216, 10, 30), BRASS)          # candlestick
	draw_rect(Rect2(56, 242, 18, 4), BRASS)
	draw_rect(Rect2(62, 206, 6, 10), PlaceholderArt.BEIGE)
	draw_rect(Rect2(110, 210, 34, 36), Color(0.62, 0.55, 0.42))  # tea caddy
	draw_rect(Rect2(110, 210, 34, 6), Color(0.45, 0.2, 0.15))
	_ellipse(Vector2(190, 236), Vector2(16, 10), Color(0.75, 0.72, 0.65))  # teapot
	draw_rect(Rect2(184, 222, 12, 5), Color(0.75, 0.72, 0.65))
	draw_line(Vector2(205, 232), Vector2(214, 226), Color(0.75, 0.72, 0.65), 3.0)
	draw_rect(Rect2(296, 214, 10, 32), BRASS)
	draw_rect(Rect2(292, 242, 18, 4), BRASS)


func _draw_range() -> void:
	_ellipse(Vector2(195, 522), Vector2(150, 8), Color(0, 0, 0, 0.5))
	# Iron body, hob plate and the brass rail along the front
	draw_rect(Rect2(62, 356, 256, 164), IRON)
	draw_rect(Rect2(54, 344, 272, 16), IRON_LIGHT)
	draw_rect(Rect2(54, 344, 272, 3), Color(0.38, 0.36, 0.34))
	draw_line(Vector2(66, 372), Vector2(314, 372), BRASS, 3.0)
	draw_circle(Vector2(66, 372), 3, BRASS)
	draw_circle(Vector2(314, 372), 3, BRASS)
	# Fire grate with glowing coals behind iron bars
	draw_rect(Rect2(80, 388, 92, 84), Color(0.06, 0.04, 0.03))
	_ellipse(Vector2(126, 446), Vector2(40, 22), Color(0.75, 0.25, 0.06))
	_ellipse(Vector2(126, 448), Vector2(30, 14), FIRE)
	_ellipse(Vector2(126, 450), Vector2(16, 7), Color(1, 0.86, 0.5))
	var rng := RandomNumberGenerator.new()
	rng.seed = 17
	for i in range(12):
		var coal := Vector2(rng.randf_range(90, 162), rng.randf_range(440, 466))
		draw_circle(coal, rng.randf_range(3, 6), Color(0.2, 0.06, 0.03, 0.8))
	_polygon([Vector2(104, 440), Vector2(112, 412), Vector2(120, 436), Vector2(130, 404), Vector2(140, 438), Vector2(150, 420), Vector2(152, 444)], Color(1, 0.62, 0.2, 0.75))
	for bar_x in range(86, 172, 12):
		draw_line(Vector2(bar_x, 388), Vector2(bar_x, 472), IRON_LIGHT, 3.0)
	draw_rect(Rect2(80, 388, 92, 84), IRON_LIGHT, false, 3.0)
	# Ash pan, and the frame round the oven door (the oven is a container node)
	draw_rect(Rect2(80, 482, 92, 22), IRON_LIGHT)
	draw_rect(Rect2(112, 490, 28, 5), BRASS)
	draw_rect(Rect2(202, 398, 106, 88), Color(0.08, 0.075, 0.07))
	draw_rect(Rect2(212, 488, 86, 18), IRON_LIGHT)
	for knob_x: float in [228.0, 255.0, 282.0]:
		draw_circle(Vector2(knob_x, 497), 3, BRASS)


func _draw_utensil_rail() -> void:
	# An iron rail across the top of the recess, hung with spoons and ladles.
	draw_line(Vector2(66, 276), Vector2(318, 276), IRON_LIGHT, 4.0)
	for hook_x: float in [92.0, 140.0, 190.0, 238.0, 296.0]:
		draw_line(Vector2(hook_x, 276), Vector2(hook_x, 282), IRON_LIGHT, 2.0)
	# Brass ladle
	draw_line(Vector2(92, 282), Vector2(92, 312), BRASS, 3.0)
	_ellipse(Vector2(92, 318), Vector2(9, 7), BRASS.darkened(0.2))
	# Fish slice
	draw_line(Vector2(140, 282), Vector2(140, 300), IRON_LIGHT, 3.0)
	draw_rect(Rect2(132, 300, 16, 18), Color(0.45, 0.45, 0.46))
	# Toasting fork
	draw_line(Vector2(190, 282), Vector2(190, 312), IRON_LIGHT, 2.0)
	for prong in range(3):
		draw_line(Vector2(186 + prong * 4, 312), Vector2(186 + prong * 4, 322), IRON_LIGHT, 1.5)
	# A wooden spatula (the real wooden spoon is a hidden object at the end of the rail)
	draw_line(Vector2(238, 282), Vector2(238, 300), Color(0.6, 0.45, 0.28), 4.0)
	draw_rect(Rect2(232, 300, 12, 16), Color(0.6, 0.45, 0.28))


func _draw_hob_pans() -> void:
	# Kettle and a stewpot on the hob
	_ellipse(Vector2(124, 322), Vector2(30, 22), Color(0.2, 0.19, 0.19))
	draw_rect(Rect2(94, 322, 60, 22), Color(0.2, 0.19, 0.19))
	_ellipse(Vector2(124, 302), Vector2(12, 4), Color(0.3, 0.29, 0.28))
	draw_arc(Vector2(124, 306), 22, PI * 1.1, PI * 1.9, 12, Color(0.3, 0.29, 0.28), 3.0, true)
	draw_line(Vector2(150, 324), Vector2(168, 306), Color(0.2, 0.19, 0.19), 5.0)
	draw_rect(Rect2(200, 318, 56, 26), COPPER_DARK)
	_ellipse(Vector2(228, 318), Vector2(28, 6), COPPER)
	draw_line(Vector2(256, 326), Vector2(272, 322), COPPER_DARK, 4.0)
	# Steam rising from the stewpot
	for i in range(3):
		draw_arc(Vector2(224 + i * 6, 300 - i * 14), 6, PI * 0.2, PI * 1.2, 8, Color(1, 1, 1, 0.08), 3.0, true)


func _draw_dresser() -> void:
	var wood := Color(0.36, 0.25, 0.16)
	var wood_dark := Color(0.22, 0.15, 0.1)
	_ellipse(Vector2(455, 522), Vector2(112, 8), Color(0, 0, 0, 0.45))
	# Plate rack with a carved top
	draw_rect(Rect2(354, 170, 202, 186), wood_dark)
	draw_rect(Rect2(346, 158, 218, 16), wood)
	draw_rect(Rect2(346, 158, 218, 3), PlaceholderArt.WOOD_LIGHT)
	for shelf_y: float in [230.0, 292.0]:
		draw_rect(Rect2(356, shelf_y, 198, 6), wood)
	# Plates standing on the shelves
	var plate_colors: Array[Color] = [Color(0.78, 0.76, 0.7), Color(0.45, 0.55, 0.7), Color(0.78, 0.76, 0.7)]
	for row in range(2):
		var plate_y := 204.0 + row * 62.0
		for i in range(6):
			var center := Vector2(376 + i * 32, plate_y)
			var color: Color = plate_colors[(i + row) % 3]
			draw_circle(center, 14, color.darkened(0.2))
			draw_circle(center, 11, color)
			draw_arc(center, 7, 0, TAU, 14, color.darkened(0.25), 1.0, true)
	# Cups on hooks under the top shelf
	for i in range(4):
		var cup := Vector2(384 + i * 46, 314)
		draw_rect(Rect2(cup.x - 7, cup.y, 14, 12), Color(0.8, 0.78, 0.72))
		draw_arc(cup + Vector2(8, 6), 4, -PI * 0.5, PI * 0.5, 6, Color(0.8, 0.78, 0.72), 2.0, true)
	# Base cupboard with a worktop
	draw_rect(Rect2(342, 352, 226, 14), wood)
	draw_rect(Rect2(342, 352, 226, 3), PlaceholderArt.WOOD_LIGHT)
	draw_rect(Rect2(348, 366, 214, 154), wood_dark)
	for door in range(2):
		var door_rect := Rect2(356 + door * 104, 376, 96, 136)
		draw_rect(door_rect, wood)
		draw_rect(door_rect.grow(-7), wood.lightened(0.06), false, 2.0)
		draw_circle(Vector2(door_rect.end.x - 12 if door == 0 else door_rect.position.x + 12, 444), 3, PlaceholderArt.BEIGE_DARK)
	# Jugs on the worktop
	draw_rect(Rect2(364, 324, 20, 28), Color(0.7, 0.66, 0.56))
	draw_rect(Rect2(364, 324, 20, 4), Color(0.4, 0.5, 0.65))
	draw_rect(Rect2(522, 330, 24, 22), COPPER_DARK)
	_ellipse(Vector2(534, 330), Vector2(12, 3), COPPER)


func _draw_pan_rack() -> void:
	# An iron rack hung from the ceiling beam on two chains.
	for chain_x: float in [420.0, 630.0]:
		for link in range(3):
			draw_arc(Vector2(chain_x, 70 + link * 6), 3, 0, TAU, 8, IRON_LIGHT, 1.5, true)
	draw_line(Vector2(400, 88), Vector2(652, 88), IRON_LIGHT, 5.0)
	draw_line(Vector2(400, 86), Vector2(652, 86), Color(0.4, 0.38, 0.36), 1.0)
	# Frying pan hanging by its handle
	draw_line(Vector2(448, 90), Vector2(448, 112), COPPER_DARK, 5.0)
	draw_circle(Vector2(448, 138), 27, COPPER_DARK)
	draw_circle(Vector2(448, 138), 23, COPPER)
	draw_arc(Vector2(448, 138), 16, PI * 1.1, PI * 1.5, 8, Color(1, 0.85, 0.65, 0.4), 3.0, true)
	# Small milk pan next to the tin opener
	draw_line(Vector2(486, 90), Vector2(486, 104), COPPER_DARK, 4.0)
	draw_rect(Rect2(474, 104, 24, 28), COPPER)
	draw_rect(Rect2(474, 104, 5, 28), Color(1, 0.8, 0.6, 0.25))
	draw_rect(Rect2(474, 128, 24, 4), COPPER_DARK)
	# Saucepan and a big stockpot lid
	draw_line(Vector2(572, 90), Vector2(572, 112), COPPER_DARK, 5.0)
	draw_rect(Rect2(552, 112, 40, 40), COPPER_DARK)
	draw_rect(Rect2(555, 112, 34, 37), COPPER)
	draw_rect(Rect2(558, 116, 6, 30), Color(1, 0.8, 0.6, 0.25))
	draw_line(Vector2(626, 90), Vector2(626, 104), IRON_LIGHT, 2.0)
	draw_circle(Vector2(626, 124), 18, COPPER_DARK)
	draw_circle(Vector2(626, 124), 15, COPPER)
	draw_circle(Vector2(626, 124), 4, COPPER_DARK)
	# Hooks (the middle one holds the tin opener)
	for hook_x: float in [448.0, 486.0, 520.0, 572.0, 626.0]:
		draw_arc(Vector2(hook_x, 92), 3, 0, PI, 6, IRON_LIGHT, 1.5, true)


func _draw_window() -> void:
	var frame := Color(0.3, 0.22, 0.15)
	draw_rect(Rect2(656, 106, 150, 190), frame)
	_vertical_gradient(Rect2(664, 114, 134, 176), Color(0.05, 0.07, 0.14), Color(0.1, 0.14, 0.22))
	# Night outside: a dark treeline and the lake glinting
	_polygon([Vector2(664, 240), Vector2(690, 222), Vector2(716, 236), Vector2(744, 214), Vector2(772, 232), Vector2(798, 220), Vector2(798, 290), Vector2(664, 290)], Color(0.03, 0.04, 0.05))
	draw_line(Vector2(690, 262), Vector2(740, 262), Color(0.6, 0.7, 0.85, 0.25), 1.0)
	draw_circle(Vector2(770, 146), 8, Color(PlaceholderArt.MOON, 0.7))
	# Glazing bars
	draw_line(Vector2(731, 114), Vector2(731, 290), frame, 5.0)
	draw_line(Vector2(664, 200), Vector2(798, 200), frame, 5.0)
	# Gingham curtains tied back
	var curtain := Color(0.55, 0.22, 0.2)
	_polygon([Vector2(650, 100), Vector2(680, 100), Vector2(664, 200), Vector2(672, 282), Vector2(654, 282), Vector2(650, 200)], curtain)
	_polygon([Vector2(782, 100), Vector2(812, 100), Vector2(812, 200), Vector2(808, 282), Vector2(790, 282), Vector2(798, 200)], curtain)
	for fold_x: float in [658.0, 804.0]:
		draw_line(Vector2(fold_x, 104), Vector2(fold_x, 278), curtain.darkened(0.25), 2.0)
	draw_line(Vector2(644, 100), Vector2(818, 100), PlaceholderArt.WOOD_DARK, 4.0)
	# Stone sill (the lake pebble sits on its right end)
	draw_rect(Rect2(646, 294, 170, 10), STONE)
	draw_rect(Rect2(646, 294, 170, 2), STONE.lightened(0.2))
	draw_rect(Rect2(646, 304, 170, 3), Color(0.15, 0.12, 0.1))
	# A potted herb and a puddle of lake water on the sill
	draw_rect(Rect2(676, 276, 18, 18), Color(0.55, 0.3, 0.2))
	for leaf in range(5):
		_ellipse(Vector2(678 + leaf * 4, 268 - (leaf % 2) * 5), Vector2(4, 7), PlaceholderArt.GREEN)
	_ellipse(Vector2(782, 294), Vector2(20, 2), Color(0.55, 0.65, 0.75, 0.35))


func _draw_sink() -> void:
	# Brass tap coming out of the wall
	draw_line(Vector2(726, 310), Vector2(726, 322), BRASS, 4.0)
	draw_line(Vector2(726, 312), Vector2(740, 312), BRASS, 3.0)
	# Shallow stone sink on brick piers
	draw_rect(Rect2(640, 324, 186, 30), STONE)
	draw_rect(Rect2(640, 324, 186, 4), STONE.lightened(0.18))
	draw_rect(Rect2(654, 328, 158, 8), STONE_DARK)
	draw_line(Vector2(640, 354), Vector2(826, 354), Color(0.15, 0.12, 0.1), 3.0)
	# Cupboard under the sink: open, dark inside, with a curtain on a rod
	draw_rect(Rect2(648, 356, 170, 164), Color(0.09, 0.07, 0.05))
	_vertical_gradient(Rect2(648, 356, 170, 40), Color(0, 0, 0, 0.6), Color(0, 0, 0, 0))
	draw_rect(Rect2(648, 506, 170, 14), Color(0.2, 0.15, 0.1))
	draw_line(Vector2(648, 506), Vector2(818, 506), Color(0.3, 0.22, 0.15), 2.0)
	draw_rect(Rect2(640, 356, 10, 164), STONE_DARK)
	draw_rect(Rect2(816, 356, 10, 164), STONE_DARK)
	# A bucket, a scrubbing brush and a soap jar under there
	_polygon([Vector2(770, 456), Vector2(806, 456), Vector2(800, 504), Vector2(776, 504)], Color(0.32, 0.32, 0.33))
	_ellipse(Vector2(788, 456), Vector2(18, 4), Color(0.18, 0.18, 0.19))
	draw_arc(Vector2(788, 456), 16, PI, TAU, 10, Color(0.4, 0.4, 0.42), 1.5, true)
	draw_rect(Rect2(690, 496, 26, 8), Color(0.42, 0.3, 0.2))
	for bristle in range(6):
		draw_line(Vector2(692 + bristle * 4, 504), Vector2(692 + bristle * 4, 506), Color(0.6, 0.5, 0.35), 1.5)
	draw_rect(Rect2(752, 484, 12, 20), Color(0.42, 0.38, 0.3))


func _draw_counter() -> void:
	var wood := Color(0.4, 0.28, 0.18)
	_ellipse(Vector2(930, 522), Vector2(110, 7), Color(0, 0, 0, 0.45))
	# Wall shelf on brackets with jars (the egg timer stands at its right end)
	draw_rect(Rect2(838, 250, 164, 8), wood)
	draw_rect(Rect2(838, 250, 164, 2), PlaceholderArt.WOOD_LIGHT)
	for bracket_x: float in [850.0, 988.0]:
		_polygon([Vector2(bracket_x - 3, 258), Vector2(bracket_x + 3, 258), Vector2(bracket_x + 3, 278)], PlaceholderArt.WOOD_DARK)
	_draw_jar(Vector2(856, 236), 9.0, 28.0, Color(0.6, 0.42, 0.18, 0.95))
	_draw_jar(Vector2(882, 240), 9.0, 20.0, Color(0.45, 0.18, 0.15, 0.95))
	_draw_jar(Vector2(910, 234), 10.0, 32.0, Color(0.5, 0.48, 0.38, 0.95))
	# A small brown coffee grinder next to where the egg timer stands
	draw_rect(Rect2(926, 232, 14, 18), PlaceholderArt.WOOD_DARK)
	draw_line(Vector2(933, 232), Vector2(941, 224), IRON_LIGHT, 1.5)
	# Counter top and cupboards (they run on behind the objective list)
	draw_rect(Rect2(828, 378, 230, 14), Color(0.55, 0.42, 0.28))
	draw_rect(Rect2(828, 378, 230, 3), Color(0.68, 0.54, 0.38))
	draw_rect(Rect2(834, 392, 220, 128), wood.darkened(0.25))
	for door in range(3):
		var door_rect := Rect2(842 + door * 72, 402, 64, 110)
		draw_rect(door_rect, wood)
		draw_rect(door_rect.grow(-6), wood.lightened(0.06), false, 2.0)
		draw_circle(Vector2(door_rect.position.x + 52, 456), 2.5, PlaceholderArt.BEIGE_DARK)
	# A chopping board and a knife leaning at the back of the counter
	draw_rect(Rect2(948, 344, 40, 34), Color(0.62, 0.48, 0.32))
	draw_circle(Vector2(968, 350), 3, Color(0.2, 0.15, 0.1))
	draw_line(Vector2(944, 376), Vector2(940, 350), STONE.lightened(0.2), 2.0)


func _draw_servants_door() -> void:
	# Plank door in the corner; its lower half shows under the objective list.
	var paint := Color(0.25, 0.3, 0.26)
	draw_rect(Rect2(1062, 150, 160, 370), Color(0.12, 0.1, 0.08))
	draw_rect(Rect2(1070, 158, 144, 362), paint)
	for plank_x in range(1070, 1214, 24):
		draw_line(Vector2(plank_x, 158), Vector2(plank_x, 520), Color(0, 0, 0, 0.25), 2.0)
	draw_rect(Rect2(1070, 452, 144, 10), paint.darkened(0.25))
	draw_line(Vector2(1074, 456), Vector2(1210, 300), paint.darkened(0.25), 8.0)
	# Iron lock box with an empty keyhole, and light under the door
	draw_rect(Rect2(1086, 470, 30, 24), IRON)
	_polygon([Vector2(1099, 478), Vector2(1103, 478), Vector2(1104, 490), Vector2(1098, 490)], Color(0.02, 0.02, 0.02))
	draw_circle(Vector2(1101, 478), 3, Color(0.02, 0.02, 0.02))
	draw_line(Vector2(1070, 519), Vector2(1214, 519), Color(1, 0.8, 0.5, 0.25), 2.0)
	# Mat in front of it
	_polygon([Vector2(1060, 530), Vector2(1226, 530), Vector2(1246, 566), Vector2(1044, 566)], Color(0.38, 0.3, 0.2))


func _draw_table() -> void:
	var top := Color(0.66, 0.54, 0.38)
	var leg := Color(0.4, 0.28, 0.18)
	_ellipse(Vector2(560, 706), Vector2(260, 14), Color(0, 0, 0, 0.45))
	# Legs, apron and the scrubbed pale top
	for leg_x: float in [368.0, 744.0]:
		draw_rect(Rect2(leg_x, 610, 18, 100), leg)
		draw_rect(Rect2(leg_x, 610, 4, 100), leg.lightened(0.1))
	_polygon([Vector2(386, 548), Vector2(736, 548), Vector2(770, 598), Vector2(350, 598)], top)
	draw_line(Vector2(386, 548), Vector2(736, 548), top.lightened(0.15), 2.0)
	for grain in range(4):
		var grain_y := 556.0 + grain * 11.0
		draw_line(Vector2(380 - grain * 6, grain_y), Vector2(744 + grain * 6, grain_y), Color(0.45, 0.35, 0.22, 0.35), 1.0)
	draw_rect(Rect2(350, 598, 420, 16), leg)
	draw_rect(Rect2(350, 598, 420, 3), top.darkened(0.2))
	# Oil lamp: brass base, glass chimney, flame
	_ellipse(LAMP_POS + Vector2(4, 76), Vector2(22, 4), Color(0, 0, 0, 0.35))
	_ellipse(LAMP_POS + Vector2(0, 66), Vector2(16, 8), BRASS.darkened(0.2))
	_ellipse(LAMP_POS + Vector2(0, 54), Vector2(18, 12), BRASS)
	draw_rect(Rect2(LAMP_POS.x - 4, LAMP_POS.y + 38, 8, 10), BRASS.darkened(0.25))
	_ellipse(LAMP_POS + Vector2(0, 16), Vector2(12, 18), Color(0.95, 0.9, 0.8, 0.25))
	draw_rect(Rect2(LAMP_POS.x - 6, LAMP_POS.y - 16, 12, 18), Color(0.95, 0.9, 0.8, 0.22))
	_ellipse(LAMP_POS + Vector2(0, 22), Vector2(4, 9), Color(1, 0.75, 0.35))
	_ellipse(LAMP_POS + Vector2(0, 24), Vector2(2, 5), Color(1, 0.95, 0.8))
	# Mixing bowl, rolling pin and a dusting of flour
	_ellipse(Vector2(664, 574), Vector2(64, 10), Color(0.95, 0.94, 0.9, 0.3))
	_polygon([Vector2(632, 552), Vector2(700, 552), Vector2(690, 574), Vector2(642, 574)], Color(0.82, 0.78, 0.68))
	_ellipse(Vector2(666, 552), Vector2(34, 6), Color(0.66, 0.62, 0.52))
	draw_line(Vector2(632, 558), Vector2(700, 558), Color(0.4, 0.5, 0.65), 2.0)
	draw_line(Vector2(470, 586), Vector2(530, 580), Color(0.7, 0.56, 0.38), 7.0)
	draw_line(Vector2(462, 587), Vector2(470, 586), leg, 4.0)
	draw_line(Vector2(530, 580), Vector2(538, 579), leg, 4.0)


func _draw_light() -> void:
	# Warm firelight spilling out from the range, and the lamp's glow.
	_glow(FIRE_POS, 40, 9, 26, Color(FIRE, 0.025))
	_glow(LAMP_POS + Vector2(0, 22), 20, 8, 22, Color(1, 0.75, 0.4, 0.03))
	_polygon([Vector2(56, 520), Vector2(200, 520), Vector2(330, 720), Vector2(0, 720)], Color(1, 0.55, 0.2, 0.05))


# ---------------------------------------------------------------------------

func _draw_jar(center: Vector2, half_width: float, height: float, color: Color) -> void:
	var bottom := center.y + height / 2.0
	_ellipse(Vector2(center.x + 2, bottom), Vector2(half_width + 2, 2.5), Color(0, 0, 0, 0.35))
	draw_rect(Rect2(center.x - half_width, center.y - height / 2.0, half_width * 2.0, height), color)
	draw_rect(Rect2(center.x - half_width + 2, center.y - height / 2.0 + 3, 2, height - 6), Color(1, 1, 1, 0.18))
	draw_rect(Rect2(center.x - half_width - 1, center.y - height / 2.0 - 4, half_width * 2.0 + 2, 5), Color(0.75, 0.7, 0.6))


func _draw_herbs(nail: Vector2) -> void:
	draw_circle(nail, 2, IRON_LIGHT)
	draw_line(nail, nail + Vector2(0, 8), Color(0.75, 0.68, 0.5), 1.5)
	var stems := Color(0.35, 0.3, 0.18)
	for i in range(5):
		var tip := nail + Vector2(-8 + i * 4, 44 + (i % 2) * 6)
		draw_line(nail + Vector2(0, 8), tip, stems, 1.5)
		for leaf in range(3):
			var at := (nail + Vector2(0, 8)).lerp(tip, 0.4 + leaf * 0.22)
			_ellipse(at + Vector2(-2 if leaf % 2 == 0 else 2, 0), Vector2(3, 2), Color(0.4, 0.45, 0.26))
	draw_rect(Rect2(nail.x - 3, nail.y + 7, 6, 4), Color(0.6, 0.25, 0.2))


func _draw_sink_curtain() -> void:
	# Faded gingham curtain under the sink, drawn mostly back to the left.
	var cloth := Color(0.45, 0.25, 0.22)
	draw_line(Vector2(648, 362), Vector2(818, 362), BRASS.darkened(0.3), 3.0)
	_polygon([Vector2(650, 362), Vector2(712, 362), Vector2(716, 410), Vector2(724, 470), Vector2(732, 504),
		Vector2(700, 506), Vector2(668, 504), Vector2(650, 506)], cloth)
	for fold_x: float in [664.0, 682.0, 700.0]:
		draw_line(Vector2(fold_x, 364), Vector2(fold_x + 8, 504), cloth.darkened(0.25), 2.0)
	for check_y in range(372, 504, 16):
		draw_line(Vector2(650, check_y), Vector2(712 + (check_y - 362) * 0.13, check_y), Color(0.85, 0.75, 0.65, 0.12), 3.0)
	# The right half is pushed all the way back
	_polygon([Vector2(800, 362), Vector2(818, 362), Vector2(818, 506), Vector2(806, 506)], cloth.darkened(0.1))
