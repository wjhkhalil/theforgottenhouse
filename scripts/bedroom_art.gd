@tool
class_name BedroomArt
extends RoomArt
## Placeholder drawing of the Chapter One bedroom (also used behind the main menu).
## See room_art.gd for how to replace it with a real image.

const FLOOR_Y := 500.0
const BOOK_COLORS: Array[Color] = [
	Color(0.4, 0.18, 0.16), Color(0.24, 0.3, 0.22), Color(0.2, 0.24, 0.36),
	Color(0.5, 0.38, 0.22), Color(0.3, 0.22, 0.3), Color(0.55, 0.47, 0.35),
	Color(0.18, 0.26, 0.28),
]


func _draw_background() -> void:
	_draw_wall()
	_draw_floor()
	_draw_window()
	_draw_painting()
	_draw_moonlight()
	_draw_bookshelf()
	_draw_wardrobe()
	_draw_bed()
	_draw_bedside_table()
	_draw_desk()
	_draw_floor_details()
	_draw_cobweb()


func _draw_foreground() -> void:
	_draw_blanket()
	_draw_desk_book_stack()
	_draw_vignette()


# ---------------------------------------------------------------------------
# Background pieces
# ---------------------------------------------------------------------------

func _draw_wall() -> void:
	_vertical_gradient(Rect2(0, 0, room_size.x, FLOOR_Y), PlaceholderArt.WALL_TOP, PlaceholderArt.WALL_BOTTOM)
	# Wallpaper stripes and small diamond pattern
	for x in range(0, int(room_size.x), 48):
		draw_rect(Rect2(x, 0, 2, 420), Color(1, 1, 1, 0.035))
	for row in range(7):
		for column in range(27):
			var center := Vector2(column * 48 + 24, row * 60 + 30)
			_polygon([center + Vector2(0, -5), center + Vector2(4, 0), center + Vector2(0, 5), center + Vector2(-4, 0)], Color(0.85, 0.75, 0.55, 0.07))
	# A lighter patch where a picture frame used to hang
	draw_rect(Rect2(482, 160, 62, 82), Color(1, 1, 1, 0.045))
	draw_circle(Vector2(513, 150), 2.5, PlaceholderArt.WOOD_DARK)
	# Wooden wainscot along the bottom of the wall
	draw_rect(Rect2(0, 420, room_size.x, 80), PlaceholderArt.WOOD_DARK)
	draw_rect(Rect2(0, 414, room_size.x, 8), PlaceholderArt.WOOD_LIGHT)
	for x in range(10, int(room_size.x), 160):
		draw_rect(Rect2(x, 434, 140, 52), Color(0, 0, 0, 0.2), false, 2.0)
	draw_rect(Rect2(0, 490, room_size.x, 12), Color(0.16, 0.11, 0.08))


func _draw_floor() -> void:
	_vertical_gradient(Rect2(0, FLOOR_Y, room_size.x, room_size.y - FLOOR_Y), Color(0.22, 0.16, 0.11), Color(0.36, 0.26, 0.18))
	# Planks get taller towards the bottom of the screen to suggest depth.
	var row_lines: Array[float] = [500.0, 514.0, 531.0, 551.0, 575.0, 603.0, 636.0, 674.0, 720.0]
	var seam := Color(0.11, 0.07, 0.05, 0.7)
	for i in range(row_lines.size() - 1):
		var top := row_lines[i]
		var bottom := row_lines[i + 1]
		draw_line(Vector2(0, bottom), Vector2(room_size.x, bottom), seam, 2.0)
		draw_line(Vector2(0, top + 3), Vector2(room_size.x, top + 3), Color(1, 0.9, 0.7, 0.035), 1.0)
		var plank_length := 150.0 + i * 30.0
		var x := -fmod(i * 97.0, plank_length)
		while x < room_size.x:
			draw_line(Vector2(x, top), Vector2(x, bottom), seam, 2.0)
			x += plank_length
	# Rug
	_ellipse(Vector2(500, 642), Vector2(300, 52), Color(0.31, 0.16, 0.16))
	_ellipse(Vector2(500, 642), Vector2(280, 44), Color(0.4, 0.22, 0.2))
	var ring := PlaceholderArt.ellipse_points(Vector2(500, 642), 255, 36, 48)
	ring.append(ring[0])
	draw_polyline(ring, Color(PlaceholderArt.BEIGE, 0.45), 3.0, true)
	_ellipse(Vector2(500, 642), Vector2(150, 20), Color(0.27, 0.14, 0.14))
	for i in range(10):
		var y := 626.0 + i * 3.5
		draw_line(Vector2(196 - abs(i - 4.5) * 3.0, y), Vector2(184 - abs(i - 4.5) * 3.0, y), Color(PlaceholderArt.BEIGE, 0.4), 1.5)
		draw_line(Vector2(804 + abs(i - 4.5) * 3.0, y), Vector2(816 + abs(i - 4.5) * 3.0, y), Color(PlaceholderArt.BEIGE, 0.4), 1.5)


func _draw_window() -> void:
	draw_rect(Rect2(632, 104, 176, 226), Color(0, 0, 0, 0.3))
	draw_rect(Rect2(636, 106, 168, 218), PlaceholderArt.BEIGE_DARK)
	_vertical_gradient(Rect2(648, 118, 144, 194), Color(0.04, 0.06, 0.13), Color(0.13, 0.18, 0.28))
	for star: Vector2 in [Vector2(665, 140), Vector2(700, 176), Vector2(772, 250), Vector2(684, 252), Vector2(775, 134), Vector2(706, 135)]:
		draw_circle(star, 1.3, Color(1, 1, 1, 0.75))
	# Moon
	_glow(Vector2(752, 165), 20, 4, 6, Color(PlaceholderArt.MOON, 0.05))
	draw_circle(Vector2(752, 165), 17, PlaceholderArt.MOON)
	draw_circle(Vector2(746, 160), 4, Color(0.7, 0.75, 0.85))
	draw_circle(Vector2(758, 172), 3, Color(0.7, 0.75, 0.85))
	# Tree silhouettes outside
	_polygon([Vector2(648, 312), Vector2(648, 282), Vector2(662, 264), Vector2(676, 286), Vector2(694, 270),
		Vector2(714, 292), Vector2(740, 276), Vector2(766, 294), Vector2(792, 272), Vector2(792, 312)], Color(0.03, 0.05, 0.08))
	# Window bars, a crack, a shine and the sill
	draw_rect(Rect2(717, 118, 6, 194), PlaceholderArt.BEIGE_DARK)
	draw_rect(Rect2(648, 212, 144, 6), PlaceholderArt.BEIGE_DARK)
	draw_polyline(PackedVector2Array([Vector2(770, 226), Vector2(778, 240), Vector2(772, 252), Vector2(784, 268)]), Color(1, 1, 1, 0.3), 1.0)
	_polygon([Vector2(656, 126), Vector2(678, 126), Vector2(656, 172)], Color(1, 1, 1, 0.06))
	draw_rect(Rect2(626, 320, 188, 12), PlaceholderArt.BEIGE)
	draw_rect(Rect2(626, 332, 188, 4), Color(0, 0, 0, 0.3))
	# Curtain rod and curtains
	draw_line(Vector2(594, 98), Vector2(846, 98), PlaceholderArt.WOOD_DARK, 5.0)
	draw_circle(Vector2(594, 98), 6, PlaceholderArt.WOOD_LIGHT)
	draw_circle(Vector2(846, 98), 6, PlaceholderArt.WOOD_LIGHT)
	_draw_curtain(606.0, false)
	_draw_curtain(782.0, true)


func _draw_curtain(left_x: float, mirrored: bool) -> void:
	var width := 54.0
	var points: Array[Vector2] = []
	if mirrored:
		points = [Vector2(left_x, 100), Vector2(left_x + width, 100), Vector2(left_x + width + 6, 354), Vector2(left_x + 4, 346), Vector2(left_x + 18, 230)]
	else:
		points = [Vector2(left_x, 100), Vector2(left_x + width, 100), Vector2(left_x + width - 18, 230), Vector2(left_x + width - 4, 346), Vector2(left_x - 6, 354)]
	_polygon(points, PlaceholderArt.GREEN)
	# Folds
	for i in range(1, 4):
		var fold_x := left_x + width * i / 4.0
		draw_line(Vector2(fold_x, 102), Vector2(fold_x + (4.0 if mirrored else -4.0), 340), PlaceholderArt.GREEN_DARK, 3.0)
	# Tie-back band
	var band_x := left_x + 22.0 if mirrored else left_x + width - 24.0
	draw_rect(Rect2(band_x - 4, 224, 26, 8), PlaceholderArt.BEIGE_DARK)


func _draw_painting() -> void:
	draw_line(Vector2(370, 100), Vector2(310, 128), Color(0.1, 0.08, 0.06), 1.5)
	draw_line(Vector2(370, 100), Vector2(430, 128), Color(0.1, 0.08, 0.06), 1.5)
	draw_circle(Vector2(370, 100), 3, PlaceholderArt.WOOD_LIGHT)
	draw_rect(Rect2(298, 132, 148, 106), Color(0, 0, 0, 0.35))
	draw_rect(Rect2(292, 126, 148, 106), Color(0.56, 0.43, 0.24))
	draw_rect(Rect2(300, 134, 132, 90), Color(0.36, 0.27, 0.15))
	_vertical_gradient(Rect2(304, 138, 124, 82), Color(0.16, 0.22, 0.3), Color(0.34, 0.35, 0.3))
	# The painting shows a lonely house on a hill - this house.
	_polygon([Vector2(304, 220), Vector2(304, 196), Vector2(340, 182), Vector2(384, 186), Vector2(428, 200), Vector2(428, 220)], Color(0.2, 0.26, 0.18))
	draw_rect(Rect2(356, 168, 28, 20), Color(0.12, 0.1, 0.1))
	_polygon([Vector2(352, 168), Vector2(370, 154), Vector2(388, 168)], Color(0.1, 0.08, 0.08))
	draw_rect(Rect2(362, 174, 6, 6), PlaceholderArt.WARM)
	draw_circle(Vector2(408, 152), 6, Color(0.85, 0.85, 0.75))


func _draw_moonlight() -> void:
	# A faint beam of moonlight from the window to the floor.
	_polygon([Vector2(650, 320), Vector2(790, 320), Vector2(1000, 720), Vector2(560, 720)], Color(0.7, 0.8, 1.0, 0.04))


func _draw_bookshelf() -> void:
	draw_rect(Rect2(48, 158, 170, 404), Color(0, 0, 0, 0.3))
	draw_rect(Rect2(40, 150, 170, 412), PlaceholderArt.WOOD)
	draw_rect(Rect2(52, 166, 146, 384), Color(0.2, 0.14, 0.1))
	draw_rect(Rect2(34, 142, 182, 12), PlaceholderArt.WOOD_LIGHT)
	for shelf_y: float in [240.0, 340.0, 440.0]:
		draw_rect(Rect2(52, shelf_y, 146, 8), PlaceholderArt.WOOD_LIGHT)
		draw_rect(Rect2(52, shelf_y + 8, 146, 3), Color(0, 0, 0, 0.3))
	draw_rect(Rect2(40, 540, 170, 22), PlaceholderArt.WOOD_DARK)

	# A fixed random seed means the books look the same every time.
	var rng := RandomNumberGenerator.new()
	rng.seed = 1234
	_draw_book_row(rng, 54.0, 150.0, 240.0, 66.0)
	_draw_book_row(rng, 54.0, 158.0, 340.0, 84.0)  # A gap is left here for the diary.
	_draw_book_row(rng, 54.0, 196.0, 440.0, 84.0)
	# Top shelf: small wooden box
	draw_rect(Rect2(156, 212, 38, 28), PlaceholderArt.WOOD_DARK)
	draw_rect(Rect2(156, 212, 38, 5), PlaceholderArt.WOOD_LIGHT)
	draw_circle(Vector2(175, 226), 2, PlaceholderArt.WARM)
	# Bottom shelf: an old box and a pile of papers
	draw_rect(Rect2(60, 494, 70, 46), Color(0.48, 0.38, 0.27))
	draw_rect(Rect2(60, 494, 70, 8), Color(0.56, 0.45, 0.32))
	draw_line(Vector2(95, 494), Vector2(95, 540), Color(0, 0, 0, 0.25), 2.0)
	for i in range(5):
		draw_rect(Rect2(140 + (i % 2) * 3, 534 - i * 5, 52, 4), PlaceholderArt.BEIGE.darkened(i * 0.05))


func _draw_book_row(rng: RandomNumberGenerator, start_x: float, end_x: float, base_y: float, max_height: float) -> void:
	var x := start_x
	while x < end_x - 10.0:
		var width := float(rng.randi_range(10, 17))
		width = minf(width, end_x - x)
		var height := rng.randf_range(0.62, 0.95) * max_height
		var color := BOOK_COLORS[rng.randi_range(0, BOOK_COLORS.size() - 1)]
		draw_rect(Rect2(x, base_y - height, width, height), color)
		draw_rect(Rect2(x, base_y - height + 7, width, 3), Color(0.85, 0.7, 0.45, 0.45))
		draw_rect(Rect2(x, base_y - 12, width, 2), Color(0.85, 0.7, 0.45, 0.3))
		draw_line(Vector2(x, base_y - height), Vector2(x, base_y), Color(0, 0, 0, 0.35), 1.0)
		x += width + 1.0


func _draw_wardrobe() -> void:
	# Mostly behind the objective list - just enough to fill the corner.
	draw_rect(Rect2(1028, 138, 236, 432), Color(0, 0, 0, 0.3))
	draw_rect(Rect2(1020, 130, 236, 432), PlaceholderArt.WOOD_DARK)
	draw_rect(Rect2(1012, 120, 252, 14), PlaceholderArt.WOOD)
	draw_rect(Rect2(1032, 146, 102, 396), Color(0, 0, 0, 0.18), false, 2.0)
	draw_rect(Rect2(1142, 146, 102, 396), Color(0, 0, 0, 0.18), false, 2.0)
	draw_circle(Vector2(1126, 340), 4, PlaceholderArt.WARM.darkened(0.3))
	draw_circle(Vector2(1150, 340), 4, PlaceholderArt.WARM.darkened(0.3))


func _draw_bed() -> void:
	_ellipse(Vector2(416, 566), Vector2(195, 12), PlaceholderArt.SHADOW)
	draw_rect(Rect2(262, 506, 312, 56), Color(0, 0, 0, 0.45))
	# Headboard and footboard
	draw_rect(Rect2(236, 322, 30, 244), PlaceholderArt.WOOD_DARK)
	draw_circle(Vector2(251, 322), 15, PlaceholderArt.WOOD_DARK)
	draw_circle(Vector2(251, 306), 5, PlaceholderArt.WOOD_LIGHT)
	draw_rect(Rect2(242, 350, 18, 70), Color(0, 0, 0, 0.2), false, 2.0)
	draw_rect(Rect2(570, 394, 26, 172), PlaceholderArt.WOOD_DARK)
	draw_circle(Vector2(583, 394), 13, PlaceholderArt.WOOD_DARK)
	draw_circle(Vector2(583, 380), 4, PlaceholderArt.WOOD_LIGHT)
	# Side rail
	draw_rect(Rect2(262, 484, 310, 24), PlaceholderArt.WOOD)
	draw_rect(Rect2(262, 484, 310, 3), PlaceholderArt.WOOD_LIGHT)
	# Mattress with an old stain, and a pillow
	_rounded_rect(Rect2(262, 428, 310, 58), Color(0.7, 0.65, 0.54), 8)
	_ellipse(Vector2(470, 470), Vector2(18, 6), Color(0.45, 0.38, 0.28, 0.3))
	_rounded_rect(Rect2(270, 402, 84, 32), PlaceholderArt.BEIGE, 12)
	draw_line(Vector2(290, 412), Vector2(320, 416), Color(0, 0, 0, 0.12), 2.0)


func _draw_bedside_table() -> void:
	_ellipse(Vector2(650, 574), Vector2(68, 10), PlaceholderArt.SHADOW)
	draw_rect(Rect2(612, 522, 76, 50), Color(0, 0, 0, 0.25))
	draw_rect(Rect2(592, 448, 116, 12), PlaceholderArt.WOOD_LIGHT)
	draw_rect(Rect2(598, 460, 104, 62), PlaceholderArt.WOOD)
	draw_rect(Rect2(608, 470, 84, 40), Color(0, 0, 0, 0.22), false, 2.0)
	draw_circle(Vector2(650, 490), 4, PlaceholderArt.BEIGE_DARK)
	draw_rect(Rect2(602, 522, 10, 50), PlaceholderArt.WOOD_DARK)
	draw_rect(Rect2(688, 522, 10, 50), PlaceholderArt.WOOD_DARK)
	# Lamp with a warm glow
	_glow(Vector2(650, 400), 40, 8, 28, Color(1.0, 0.8, 0.5, 0.022))
	_ellipse(Vector2(650, 446), Vector2(16, 4), Color(0.55, 0.45, 0.25))
	draw_rect(Rect2(647, 410, 6, 36), Color(0.55, 0.45, 0.25))
	_polygon([Vector2(618, 412), Vector2(682, 412), Vector2(668, 374), Vector2(632, 374)], Color(0.86, 0.72, 0.5))
	draw_line(Vector2(618, 412), Vector2(682, 412), Color(1, 0.9, 0.65), 2.0)


func _draw_desk() -> void:
	_ellipse(Vector2(905, 574), Vector2(112, 10), PlaceholderArt.SHADOW)
	# Desk top (seen slightly from above) and front edge
	_polygon([Vector2(812, 416), Vector2(998, 416), Vector2(1006, 440), Vector2(804, 440)], PlaceholderArt.WOOD_LIGHT)
	draw_rect(Rect2(804, 440, 202, 12), PlaceholderArt.WOOD)
	draw_rect(Rect2(810, 452, 14, 118), PlaceholderArt.WOOD_DARK)
	draw_rect(Rect2(824, 452, 78, 110), Color(0, 0, 0, 0.3))
	draw_rect(Rect2(902, 452, 98, 118), PlaceholderArt.WOOD)
	for drawer_y: float in [460.0, 514.0]:
		draw_rect(Rect2(910, drawer_y, 82, 48), Color(0, 0, 0, 0.22), false, 2.0)
		draw_circle(Vector2(951, drawer_y + 24), 4, PlaceholderArt.BEIGE_DARK)
	# Ink pot with a quill
	draw_rect(Rect2(812, 402, 12, 14), Color(0.12, 0.13, 0.2))
	draw_line(Vector2(818, 402), Vector2(836, 372), PlaceholderArt.BEIGE, 2.0)
	# Loose papers under the letter
	_polygon([Vector2(896, 421), Vector2(946, 418), Vector2(950, 437), Vector2(894, 438)], PlaceholderArt.BEIGE_DARK)
	_polygon([Vector2(884, 426), Vector2(924, 423), Vector2(926, 439), Vector2(882, 440)], PlaceholderArt.BEIGE.darkened(0.1))
	# Candle with a small warm glow
	_glow(Vector2(888, 382), 10, 5, 9, Color(1.0, 0.8, 0.45, 0.04))
	_ellipse(Vector2(888, 416), Vector2(12, 4), Color(0.55, 0.45, 0.25))
	draw_rect(Rect2(883, 388, 10, 28), Color(0.9, 0.86, 0.76))
	draw_rect(Rect2(891, 392, 2, 8), Color(0.8, 0.76, 0.66))
	_ellipse(Vector2(888, 381), Vector2(3.5, 7), PlaceholderArt.WARM)
	_ellipse(Vector2(888, 383), Vector2(1.5, 3), Color(1, 0.97, 0.85))


func _draw_floor_details() -> void:
	# Scattered papers and faint footprints in the dust
	_polygon([Vector2(860, 610), Vector2(900, 602), Vector2(906, 628), Vector2(864, 634)], Color(PlaceholderArt.BEIGE_DARK, 0.85))
	_polygon([Vector2(912, 640), Vector2(946, 646), Vector2(940, 668), Vector2(906, 662)], Color(PlaceholderArt.BEIGE_DARK, 0.7))
	for i in range(5):
		var step := Vector2(1010 - i * 70, 690 - i * 22)
		var side := 10.0 if i % 2 == 0 else -10.0
		_ellipse(step + Vector2(0, side), Vector2(11, 5), Color(0, 0, 0, 0.12))


func _draw_cobweb() -> void:
	var corner := Vector2(0, 56)
	var web := Color(0.85, 0.85, 0.9, 0.18)
	for i in range(5):
		var angle := PI * 0.5 * i / 4.0
		draw_line(corner, corner + Vector2.from_angle(angle) * 90.0, web, 1.0)
	for radius: float in [25.0, 45.0, 65.0, 85.0]:
		draw_arc(corner, radius, 0.0, PI * 0.5, 12, web, 1.0, true)


# ---------------------------------------------------------------------------
# Foreground pieces (drawn ON TOP of the hidden objects)
# ---------------------------------------------------------------------------

func _draw_blanket() -> void:
	# The teddy bear sits behind the top edge of this blanket.
	var points: Array[Vector2] = [Vector2(328, 436), Vector2(578, 430), Vector2(586, 500)]
	for i in range(9):
		var x := 588.0 - i * 33.0
		var y := 530.0 + (8.0 if i % 2 == 1 else 0.0)
		points.append(Vector2(x, y))
	points.append(Vector2(322, 500))
	_polygon(points, PlaceholderArt.GREEN)
	for fold: Array in [[Vector2(380, 448), Vector2(372, 526)], [Vector2(452, 446), Vector2(458, 532)], [Vector2(522, 444), Vector2(514, 530)]]:
		draw_line(fold[0], fold[1], PlaceholderArt.GREEN_DARK, 3.0)
	# Faded pattern dots
	for row in range(3):
		for column in range(7):
			draw_circle(Vector2(350 + column * 34 + row * 12, 462 + row * 22), 2.5, Color(PlaceholderArt.BEIGE, 0.18))
	# Turned-down sheet along the top
	_polygon([Vector2(326, 430), Vector2(580, 424), Vector2(580, 440), Vector2(326, 446)], PlaceholderArt.BEIGE)
	draw_line(Vector2(326, 446), Vector2(580, 440), Color(0, 0, 0, 0.2), 2.0)


func _draw_desk_book_stack() -> void:
	# These books lie on top of the missing letter.
	var books: Array[Array] = [
		[Rect2(936, 426, 64, 13), Color(0.36, 0.2, 0.16)],
		[Rect2(940, 414, 56, 12), Color(0.24, 0.3, 0.22)],
		[Rect2(934, 403, 60, 11), Color(0.2, 0.24, 0.36)],
	]
	draw_rect(Rect2(938, 404, 66, 38), Color(0, 0, 0, 0.25))
	for book in books:
		var rect: Rect2 = book[0]
		draw_rect(rect, book[1])
		draw_rect(Rect2(rect.end.x - 5, rect.position.y + 2, 4, rect.size.y - 4), PlaceholderArt.BEIGE)
