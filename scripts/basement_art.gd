@tool
class_name BasementArt
extends RoomArt
## Placeholder drawing of the Chapter Two basement.
## See room_art.gd for how to replace it with a real image.
##
## Layout (left to right): wooden stairs with a dark space underneath,
## a coat on a hook, a photo darkroom bench with a drying line, shelves of
## jars, and an old iron furnace with a coal pile.

const FLOOR_Y := 470.0
const JAR_COLORS: Array[Color] = [
	Color(0.6, 0.42, 0.18, 0.95), Color(0.3, 0.4, 0.25, 0.95), Color(0.36, 0.31, 0.25, 0.95),
	Color(0.45, 0.18, 0.15, 0.95), Color(0.5, 0.48, 0.38, 0.95),
]


func _draw_background() -> void:
	_draw_walls()
	_draw_floor()
	_draw_high_window()
	_draw_ceiling()
	_draw_stairs()
	_draw_coat_and_hooks()
	_draw_darkroom_bench()
	_draw_jar_shelves()
	_draw_furnace()
	_draw_floor_details()


func _draw_foreground() -> void:
	# The stair post hides part of the boots; a jar hides part of the music box.
	draw_rect(Rect2(196, 282, 12, 276), PlaceholderArt.WOOD_DARK)
	draw_rect(Rect2(196, 282, 3, 276), PlaceholderArt.WOOD)
	_draw_jar(Vector2(822, 340), 18.0, 30.0, JAR_COLORS[0])
	_draw_vignette()


# ---------------------------------------------------------------------------

func _draw_walls() -> void:
	_vertical_gradient(Rect2(0, 0, room_size.x, FLOOR_Y), Color(0.06, 0.065, 0.08), Color(0.14, 0.15, 0.17))
	# Stone bricks with slightly different shades (fixed seed = same every time).
	var rng := RandomNumberGenerator.new()
	rng.seed = 77
	var row := 0
	var y := 84.0
	while y < FLOOR_Y:
		var x := -30.0 if row % 2 == 1 else 0.0
		while x < room_size.x:
			var shade := rng.randf_range(-0.03, 0.03)
			var brick := Color(0.2 + shade, 0.21 + shade, 0.24 + shade, 0.55)
			draw_rect(Rect2(x + 2, y + 2, 58, 22), brick)
			x += 62.0
		y += 26.0
		row += 1
	# Damp stains running down the wall
	_ellipse(Vector2(640, 250), Vector2(40, 90), Color(0.05, 0.07, 0.06, 0.25))
	_ellipse(Vector2(1100, 330), Vector2(50, 110), Color(0.05, 0.07, 0.06, 0.25))


func _draw_floor() -> void:
	_vertical_gradient(Rect2(0, FLOOR_Y, room_size.x, room_size.y - FLOOR_Y), Color(0.12, 0.12, 0.13), Color(0.22, 0.21, 0.2))
	# Uneven stone slabs
	var rows: Array[float] = [470.0, 498.0, 534.0, 580.0, 640.0, 720.0]
	var seam := Color(0.05, 0.05, 0.06, 0.8)
	for i in range(rows.size() - 1):
		draw_line(Vector2(0, rows[i + 1]), Vector2(room_size.x, rows[i + 1]), seam, 2.0)
		var slab_width := 120.0 + i * 40.0
		var x := -fmod(i * 71.0, slab_width)
		while x < room_size.x:
			draw_line(Vector2(x, rows[i]), Vector2(x + 6, rows[i + 1]), seam, 2.0)
			x += slab_width
	# Dark space under the stairs
	_polygon([Vector2(20, 112), Vector2(412, 496), Vector2(412, 566), Vector2(20, 566)], Color(0, 0, 0, 0.45))


func _draw_high_window() -> void:
	draw_rect(Rect2(556, 92, 138, 52), Color(0.1, 0.09, 0.08))
	_vertical_gradient(Rect2(562, 98, 126, 40), Color(0.08, 0.11, 0.2), Color(0.16, 0.2, 0.3))
	draw_circle(Vector2(660, 112), 7, Color(PlaceholderArt.MOON, 0.8))
	for bar_x in range(574, 690, 18):
		draw_rect(Rect2(bar_x, 98, 4, 40), Color(0.12, 0.12, 0.13))
	# Faint shaft of moonlight
	_polygon([Vector2(566, 140), Vector2(686, 140), Vector2(780, 720), Vector2(470, 720)], Color(0.7, 0.8, 1.0, 0.035))


func _draw_ceiling() -> void:
	draw_rect(Rect2(0, 56, room_size.x, 28), Color(0.13, 0.09, 0.07))
	for beam_x in range(40, int(room_size.x), 180):
		draw_rect(Rect2(beam_x, 56, 26, 34), Color(0.2, 0.14, 0.1))
	# Pipes with joints
	var pipe := Color(0.3, 0.31, 0.32)
	draw_rect(Rect2(0, 92, 556, 8), pipe)
	draw_rect(Rect2(694, 92, room_size.x - 694, 8), pipe)
	for joint_x in [150, 380, 760, 1000, 1180]:
		draw_rect(Rect2(joint_x, 89, 10, 14), Color(0.22, 0.23, 0.24))
	# Cobweb in the top-left corner
	var web := Color(0.85, 0.85, 0.9, 0.16)
	for i in range(5):
		draw_line(Vector2(0, 84), Vector2(0, 84) + Vector2.from_angle(PI * 0.5 * i / 4.0) * 80.0, web, 1.0)
	for radius: float in [25.0, 50.0, 75.0]:
		draw_arc(Vector2(0, 84), radius, 0.0, PI * 0.5, 12, web, 1.0, true)


func _draw_stairs() -> void:
	# Side view of the staircase: a saw-tooth of steps on a diagonal stringer.
	var points: Array[Vector2] = []
	for i in range(14):
		var step_x := 20.0 + i * 28.0
		var step_y := 76.0 + i * 30.0
		points.append(Vector2(step_x, step_y))
		points.append(Vector2(step_x + 28.0, step_y))
	# Underside of the stairs (kept below every step so the shape never crosses itself).
	points.append(Vector2(412, 496))
	points.append(Vector2(20, 112))
	_polygon(points, PlaceholderArt.WOOD)
	for i in range(14):
		var step_x := 20.0 + i * 28.0
		var step_y := 76.0 + i * 30.0
		draw_line(Vector2(step_x, step_y + 1), Vector2(step_x + 28.0, step_y + 1), PlaceholderArt.WOOD_LIGHT, 3.0)
	draw_line(Vector2(20, 112), Vector2(412, 496), PlaceholderArt.WOOD_DARK, 4.0)
	# Handrail and balusters
	var rail_start := Vector2(30, 40)
	var rail_end := Vector2(424, 420)
	for i in range(0, 14, 2):
		var post_x := 34.0 + i * 28.0
		var rail_y := rail_start.y + (post_x - rail_start.x) * (rail_end.y - rail_start.y) / (rail_end.x - rail_start.x)
		draw_line(Vector2(post_x, rail_y), Vector2(post_x, 76.0 + i * 30.0), PlaceholderArt.WOOD_DARK, 3.0)
	draw_line(rail_start, rail_end, PlaceholderArt.WOOD_LIGHT, 5.0)


func _draw_coat_and_hooks() -> void:
	# Small hook where the wristband hangs
	draw_line(Vector2(404, 196), Vector2(410, 199), Color(0.35, 0.33, 0.3), 3.0)
	# Old coat on a second hook
	draw_circle(Vector2(468, 150), 3, Color(0.35, 0.33, 0.3))
	_polygon([Vector2(458, 152), Vector2(478, 152), Vector2(500, 176), Vector2(504, 300),
		Vector2(436, 300), Vector2(438, 176)], Color(0.2, 0.23, 0.28))
	draw_line(Vector2(470, 160), Vector2(470, 298), Color(0, 0, 0, 0.3), 2.0)
	draw_rect(Rect2(446, 236, 18, 14), Color(0, 0, 0, 0.18), false, 1.5)
	# Broom leaning on the wall
	draw_line(Vector2(522, 330), Vector2(512, 548), PlaceholderArt.WOOD_LIGHT, 4.0)
	_polygon([Vector2(500, 536), Vector2(524, 536), Vector2(530, 566), Vector2(494, 566)], Color(0.55, 0.47, 0.3))


func _draw_darkroom_bench() -> void:
	_ellipse(Vector2(590, 566), Vector2(120, 10), PlaceholderArt.SHADOW)
	# Red safelight hanging from the ceiling
	draw_line(Vector2(592, 100), Vector2(592, 236), Color(0.1, 0.1, 0.1), 2.0)
	_glow(Vector2(592, 246), 14, 6, 14, Color(0.9, 0.2, 0.15, 0.035))
	draw_circle(Vector2(592, 246), 9, Color(0.62, 0.13, 0.1))
	draw_rect(Rect2(586, 232, 12, 6), Color(0.15, 0.15, 0.15))
	# Drying line with prints (the film negatives hang among them)
	draw_polyline(PackedVector2Array([Vector2(486, 300), Vector2(593, 308), Vector2(700, 300)]), Color(0.75, 0.72, 0.65, 0.7), 1.5)
	for print_x: float in [506.0, 616.0, 668.0]:
		var line_y := 300.0 + 8.0 * (1.0 - absf(print_x - 593.0) / 107.0)
		draw_rect(Rect2(print_x - 11, line_y + 4, 22, 30), Color(0.55, 0.55, 0.52))
		draw_rect(Rect2(print_x - 8, line_y + 7, 16, 18), Color(0.3, 0.3, 0.3))
		draw_rect(Rect2(print_x - 2, line_y - 3, 4, 9), Color(0.62, 0.5, 0.34))
	# Bench
	_polygon([Vector2(484, 396), Vector2(696, 396), Vector2(702, 416), Vector2(478, 416)], PlaceholderArt.WOOD_LIGHT)
	draw_rect(Rect2(478, 416, 224, 10), PlaceholderArt.WOOD)
	draw_rect(Rect2(484, 426, 12, 134), PlaceholderArt.WOOD_DARK)
	draw_rect(Rect2(686, 426, 12, 134), PlaceholderArt.WOOD_DARK)
	draw_rect(Rect2(484, 500, 214, 8), PlaceholderArt.WOOD)
	# Developing trays and chemical bottles
	for tray in range(3):
		var tray_x := 494.0 + tray * 62.0
		draw_rect(Rect2(tray_x, 390, 54, 12), Color(0.25, 0.25, 0.27))
		draw_rect(Rect2(tray_x + 3, 392, 48, 5), Color(0.4, 0.45, 0.4, 0.8))
	for bottle in range(4):
		var bottle_x := 510.0 + bottle * 44.0
		draw_rect(Rect2(bottle_x, 474, 14, 26), Color(0.32, 0.2, 0.1, 0.95))
		draw_rect(Rect2(bottle_x + 4, 466, 6, 8), Color(0.15, 0.15, 0.15))
		draw_rect(Rect2(bottle_x + 2, 482, 10, 8), Color(0.82, 0.78, 0.68))


func _draw_jar_shelves() -> void:
	draw_rect(Rect2(726, 156, 140, 392), Color(0, 0, 0, 0.3))
	draw_rect(Rect2(716, 150, 10, 396), PlaceholderArt.WOOD_DARK)
	draw_rect(Rect2(856, 150, 10, 396), PlaceholderArt.WOOD_DARK)
	var rng := RandomNumberGenerator.new()
	rng.seed = 31
	for shelf_y: float in [250.0, 340.0, 430.0, 520.0]:
		draw_rect(Rect2(716, shelf_y, 150, 8), PlaceholderArt.WOOD)
		draw_rect(Rect2(716, shelf_y + 8, 150, 3), Color(0, 0, 0, 0.3))
		var x := 732.0
		while x < 850.0:
			# Leave room for the music box on the second shelf.
			if shelf_y == 340.0 and x > 774.0 and x < 832.0:
				x = 836.0
				continue
			var width := rng.randf_range(14.0, 22.0)
			var height := rng.randf_range(24.0, 44.0)
			_draw_jar(Vector2(x + width / 2.0, shelf_y), width, height, JAR_COLORS[rng.randi_range(0, JAR_COLORS.size() - 1)])
			x += width + 4.0
	# Cobweb between the shelf top and the wall
	draw_line(Vector2(866, 150), Vector2(900, 120), Color(0.85, 0.85, 0.9, 0.16), 1.0)
	draw_line(Vector2(866, 170), Vector2(910, 128), Color(0.85, 0.85, 0.9, 0.16), 1.0)


## A glass jar standing on `base` (bottom centre).
func _draw_jar(base: Vector2, width: float, height: float, color: Color) -> void:
	_rounded_rect(Rect2(base.x - width / 2.0, base.y - height, width, height), color, 4)
	draw_rect(Rect2(base.x - width / 2.0 + 2, base.y - height - 5, width - 4, 6), Color(0.4, 0.38, 0.34))
	draw_line(Vector2(base.x - width / 2.0 + 3, base.y - height + 4), Vector2(base.x - width / 2.0 + 3, base.y - 4), Color(1, 1, 1, 0.18), 2.0)


func _draw_furnace() -> void:
	var iron := Color(0.17, 0.17, 0.19)
	var iron_light := Color(0.27, 0.27, 0.29)
	# Flue pipe up to the ceiling
	draw_rect(Rect2(926, 96, 18, 200), Color(0.24, 0.24, 0.25))
	_ellipse(Vector2(938, 572), Vector2(80, 10), PlaceholderArt.SHADOW)
	_rounded_rect(Rect2(880, 290, 118, 278), iron, 20)
	draw_rect(Rect2(886, 300, 106, 6), iron_light)
	for rivet_y in range(320, 560, 30):
		draw_circle(Vector2(890, rivet_y), 2.5, iron_light)
		draw_circle(Vector2(988, rivet_y), 2.5, iron_light)
	# Fire door with a faint glow through the grate
	draw_rect(Rect2(902, 430, 74, 62), Color(0.1, 0.1, 0.11))
	for slot in range(4):
		draw_rect(Rect2(910 + slot * 16, 448, 9, 28), Color(0.85, 0.4, 0.12, 0.55))
	_glow(Vector2(939, 520), 30, 5, 18, Color(1.0, 0.45, 0.15, 0.03))
	# Coal pile
	var rng := RandomNumberGenerator.new()
	rng.seed = 5
	for i in range(26):
		var lump := Vector2(rng.randf_range(940, 1004), rng.randf_range(578, 610))
		draw_circle(lump, rng.randf_range(4, 8), Color(0.07, 0.07, 0.08))
		draw_circle(lump + Vector2(-1, -2), 1.5, Color(1, 1, 1, 0.08))


func _draw_floor_details() -> void:
	# Puddle reflecting the moonlight
	_ellipse(Vector2(760, 650), Vector2(62, 12), Color(0.08, 0.1, 0.16, 0.9))
	draw_line(Vector2(726, 648), Vector2(780, 646), Color(PlaceholderArt.MOON, 0.25), 2.0)
	# Wet footprints leading from the stairs to the space underneath them
	for i in range(6):
		var step := Vector2(440 - i * 44, 520 + i * 6)
		var side := 7.0 if i % 2 == 0 else -7.0
		_ellipse(step + Vector2(0, side), Vector2(10, 4), Color(0.1, 0.13, 0.2, 0.45))
	# Old boxes in the far corner (behind the objective list)
	draw_rect(Rect2(1030, 470, 100, 90), Color(0.38, 0.3, 0.2))
	draw_rect(Rect2(1140, 440, 110, 120), Color(0.32, 0.25, 0.17))
	draw_line(Vector2(1030, 470), Vector2(1130, 560), Color(0, 0, 0, 0.25), 3.0)
	draw_line(Vector2(1130, 470), Vector2(1030, 560), Color(0, 0, 0, 0.25), 3.0)
