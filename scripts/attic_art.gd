@tool
class_name AtticArt
extends RoomArt
## Placeholder drawing of the Chapter Three attic.
## See room_art.gd for how to replace it with a real image.
##
## Layout (left to right): an open trapdoor and a sheet-covered armchair,
## a roof post with a child's drawing, a dressmaker's dummy, a dresser with a
## tall mirror under the round window, a stack of hat boxes, a rocking chair,
## and old crates in the far corner.

const FLOOR_Y := 500.0
const BOARD := Color(0.24, 0.17, 0.12)
const BOARD_DARK := Color(0.15, 0.1, 0.075)
const SHEET := Color(0.62, 0.62, 0.6)
const SHEET_SHADE := Color(0.46, 0.46, 0.46)


func _draw_background() -> void:
	_draw_back_wall()
	_draw_roof()
	_draw_round_window()
	_draw_floor()
	_draw_trapdoor()
	_draw_covered_chair()
	_draw_roof_post()
	_draw_dummy()
	_draw_dresser()
	_draw_hat_boxes()
	_draw_rocking_chair()
	_draw_crates()
	_draw_book_pile()


func _draw_foreground() -> void:
	# The sheet's hem hides the bottom of the will; one book covers part of the ledger.
	_polygon([Vector2(112, 548), Vector2(304, 548), Vector2(310, 566), Vector2(270, 562),
		Vector2(236, 568), Vector2(196, 561), Vector2(150, 567), Vector2(106, 562)], SHEET_SHADE)
	draw_rect(Rect2(512, 624, 32, 11), Color(0.42, 0.18, 0.15))
	draw_rect(Rect2(512, 624, 32, 3), Color(0.55, 0.28, 0.22))
	# The rocking chair's arm passes in front of the seat.
	draw_line(Vector2(912, 478), Vector2(1008, 478), PlaceholderArt.WOOD_DARK, 6.0)
	_draw_vignette()


# ---------------------------------------------------------------------------

func _draw_back_wall() -> void:
	_vertical_gradient(Rect2(0, 0, room_size.x, FLOOR_Y), Color(0.09, 0.07, 0.06), Color(0.2, 0.15, 0.11))
	# Vertical wall boards with uneven gaps (fixed seed = same every time)
	var rng := RandomNumberGenerator.new()
	rng.seed = 12
	var x := 0.0
	while x < room_size.x:
		var width := rng.randf_range(34.0, 52.0)
		var shade := rng.randf_range(-0.025, 0.025)
		draw_rect(Rect2(x + 1, 56, width - 2, FLOOR_Y - 56), Color(0.2 + shade, 0.15 + shade, 0.11 + shade, 0.6))
		draw_line(Vector2(x, 56), Vector2(x, FLOOR_Y), Color(0, 0, 0, 0.35), 2.0)
		x += width


func _draw_roof() -> void:
	# The roof slopes down on both sides, meeting the floor wall at y 330.
	_polygon([Vector2(0, 0), Vector2(470, 0), Vector2(0, 330)], BOARD_DARK)
	_polygon([Vector2(810, 0), Vector2(room_size.x, 0), Vector2(room_size.x, 330)], BOARD_DARK)
	# Rafters running down the slopes
	for i in range(5):
		var t := (i + 1) / 6.0
		draw_line(Vector2(470 * t, 0), Vector2(0, 330 * t), BOARD, 7.0)
		draw_line(Vector2(room_size.x - 470 * t, 0), Vector2(room_size.x, 330 * t), BOARD, 7.0)
	draw_line(Vector2(470, 0), Vector2(0, 330), PlaceholderArt.WOOD, 10.0)
	draw_line(Vector2(810, 0), Vector2(room_size.x, 330), PlaceholderArt.WOOD, 10.0)
	# Cross beam and a cobweb in the corner it makes
	draw_rect(Rect2(0, 248, room_size.x, 14), PlaceholderArt.WOOD_DARK)
	draw_rect(Rect2(0, 248, room_size.x, 3), PlaceholderArt.WOOD)
	var web := Color(0.85, 0.85, 0.9, 0.15)
	for i in range(5):
		draw_line(Vector2(352, 248), Vector2(352, 248) + Vector2.from_angle(PI + PI * 0.5 * i / 4.0) * 70.0, web, 1.0)
	for radius: float in [22.0, 44.0, 66.0]:
		draw_arc(Vector2(352, 248), radius, PI, PI * 1.5, 12, web, 1.0, true)


func _draw_round_window() -> void:
	var center := Vector2(640, 166)
	draw_circle(center, 60, BOARD_DARK)
	draw_circle(center, 52, Color(0.1, 0.14, 0.24))
	draw_circle(center + Vector2(18, -16), 9, Color(PlaceholderArt.MOON, 0.85))
	draw_line(center + Vector2(-52, 0), center + Vector2(52, 0), BOARD_DARK, 5.0)
	draw_line(center + Vector2(0, -52), center + Vector2(0, 52), BOARD_DARK, 5.0)
	# A cracked pane and the sill where the brass key lies
	draw_line(center + Vector2(-34, -30), center + Vector2(-12, -6), Color(1, 1, 1, 0.25), 1.0)
	draw_rect(Rect2(574, 224, 132, 10), PlaceholderArt.WOOD)
	draw_rect(Rect2(574, 232, 132, 4), BOARD_DARK)
	# Moonlight falling across the floor
	_polygon([Vector2(600, 236), Vector2(680, 236), Vector2(860, 720), Vector2(520, 720)], Color(0.7, 0.8, 1.0, 0.04))


func _draw_floor() -> void:
	_vertical_gradient(Rect2(0, FLOOR_Y, room_size.x, room_size.y - FLOOR_Y), Color(0.17, 0.12, 0.09), Color(0.3, 0.22, 0.15))
	# Floorboards converge slightly toward the back wall
	for i in range(-6, 22):
		var back_x := 640.0 + (i - 8) * 52.0
		var front_x := 640.0 + (i - 8) * 92.0
		draw_line(Vector2(back_x, FLOOR_Y), Vector2(front_x, room_size.y), Color(0, 0, 0, 0.3), 2.0)
	for nail_y: float in [540.0, 620.0, 700.0]:
		draw_line(Vector2(0, nail_y), Vector2(room_size.x, nail_y), Color(0, 0, 0, 0.12), 1.0)
	# Dust on the floor, with a trail of footprints toward the dresser
	_ellipse(Vector2(640, 610), Vector2(380, 80), Color(0.6, 0.55, 0.48, 0.05))
	for i in range(5):
		var step := Vector2(330 + i * 58, 640 - i * 18)
		_ellipse(step + Vector2(0, 6.0 if i % 2 == 0 else -6.0), Vector2(11, 4), Color(0, 0, 0, 0.2))


func _draw_trapdoor() -> void:
	# The open hatch you climbed through, with lamplight from below.
	_polygon([Vector2(168, 610), Vector2(318, 610), Vector2(334, 690), Vector2(152, 690)], Color(0.05, 0.035, 0.025))
	_glow(Vector2(243, 660), 10, 4, 12, Color(1.0, 0.7, 0.35, 0.05))
	for rung_y: float in [630.0, 652.0, 674.0]:
		draw_line(Vector2(206, rung_y), Vector2(282, rung_y), PlaceholderArt.WOOD_LIGHT, 4.0)
	draw_line(Vector2(206, 616), Vector2(200, 690), PlaceholderArt.WOOD, 5.0)
	draw_line(Vector2(282, 616), Vector2(288, 690), PlaceholderArt.WOOD, 5.0)
	# The hatch lid tipped back
	_polygon([Vector2(168, 610), Vector2(318, 610), Vector2(310, 586), Vector2(176, 586)], PlaceholderArt.WOOD)
	draw_rect(Rect2(232, 592, 22, 8), Color(0.3, 0.3, 0.32))


func _draw_covered_chair() -> void:
	_ellipse(Vector2(208, 562), Vector2(110, 10), PlaceholderArt.SHADOW)
	# A dust sheet thrown over an armchair
	_polygon([Vector2(150, 380), Vector2(260, 372), Vector2(282, 420), Vector2(306, 440),
		Vector2(304, 552), Vector2(112, 552), Vector2(110, 440), Vector2(134, 420)], SHEET)
	_polygon([Vector2(134, 420), Vector2(160, 430), Vector2(150, 552), Vector2(112, 552), Vector2(110, 440)], SHEET_SHADE)
	draw_line(Vector2(200, 380), Vector2(214, 548), Color(0, 0, 0, 0.12), 3.0)
	draw_line(Vector2(260, 430), Vector2(276, 548), Color(0, 0, 0, 0.12), 3.0)


func _draw_roof_post() -> void:
	draw_rect(Rect2(410, 56, 22, FLOOR_Y - 56), PlaceholderArt.WOOD)
	draw_rect(Rect2(410, 56, 5, FLOOR_Y - 56), PlaceholderArt.WOOD_LIGHT)
	draw_rect(Rect2(428, 56, 4, FLOOR_Y - 56), BOARD_DARK)


func _draw_dummy() -> void:
	# Dressmaker's dummy with a half-finished dress pinned to it
	_ellipse(Vector2(520, 504), Vector2(34, 6), PlaceholderArt.SHADOW)
	draw_line(Vector2(520, 440), Vector2(520, 500), Color(0.15, 0.13, 0.12), 4.0)
	draw_line(Vector2(496, 504), Vector2(544, 504), Color(0.15, 0.13, 0.12), 4.0)
	_polygon([Vector2(496, 300), Vector2(544, 300), Vector2(552, 340), Vector2(538, 372),
		Vector2(560, 446), Vector2(480, 446), Vector2(502, 372), Vector2(488, 340)], Color(0.38, 0.33, 0.4))
	_polygon([Vector2(502, 372), Vector2(538, 372), Vector2(560, 446), Vector2(480, 446)], Color(0.3, 0.26, 0.34))
	draw_rect(Rect2(514, 288, 12, 12), Color(0.15, 0.13, 0.12))
	for pin: Vector2 in [Vector2(508, 330), Vector2(532, 344), Vector2(520, 398)]:
		draw_circle(pin, 1.8, Color(0.85, 0.85, 0.85))


func _draw_dresser() -> void:
	_ellipse(Vector2(670, 566), Vector2(110, 9), PlaceholderArt.SHADOW)
	# Tall mirror behind the dresser, covered in dust
	draw_rect(Rect2(624, 262, 92, 168), PlaceholderArt.WOOD_DARK)
	_vertical_gradient(Rect2(632, 270, 76, 160), Color(0.32, 0.36, 0.42, 0.9), Color(0.18, 0.2, 0.24, 0.9))
	draw_line(Vector2(642, 284), Vector2(676, 330), Color(1, 1, 1, 0.12), 6.0)
	draw_line(Vector2(690, 300), Vector2(660, 410), Color(0.1, 0.1, 0.1, 0.5), 1.0)  # crack
	# Dresser with three drawers
	draw_rect(Rect2(584, 428, 176, 14), PlaceholderArt.WOOD_LIGHT)
	draw_rect(Rect2(590, 442, 164, 118), PlaceholderArt.WOOD)
	for drawer in range(3):
		var drawer_y := 448.0 + drawer * 38.0
		draw_rect(Rect2(598, drawer_y, 148, 32), PlaceholderArt.WOOD_DARK)
		draw_rect(Rect2(600, drawer_y + 2, 144, 28), Color(0.36, 0.25, 0.17))
		draw_circle(Vector2(640, drawer_y + 16), 3, PlaceholderArt.BEIGE_DARK)
		draw_circle(Vector2(704, drawer_y + 16), 3, PlaceholderArt.BEIGE_DARK)
	# Candle stub and a hairbrush on top
	draw_rect(Rect2(600, 410, 9, 18), PlaceholderArt.BEIGE)
	draw_line(Vector2(604, 410), Vector2(604, 405), Color(0.1, 0.1, 0.1), 1.5)
	_ellipse(Vector2(742, 424), Vector2(12, 4), Color(0.3, 0.22, 0.18))


func _draw_hat_boxes() -> void:
	# Two hat boxes stacked on a crate; the third (clickable) one is on the floor.
	draw_rect(Rect2(790, 480, 120, 52), Color(0.3, 0.23, 0.16))
	draw_line(Vector2(790, 480), Vector2(910, 532), Color(0, 0, 0, 0.25), 3.0)
	for box: Array in [[Vector2(850, 452), 52.0, Color(0.36, 0.4, 0.44)], [Vector2(846, 410), 40.0, Color(0.5, 0.36, 0.38)]]:
		var center: Vector2 = box[0]
		var radius: float = box[1]
		var color: Color = box[2]
		draw_rect(Rect2(center.x - radius, center.y - 18, radius * 2.0, 28), color)
		_ellipse(center + Vector2(0, 10), Vector2(radius, 6), color)
		_ellipse(center + Vector2(0, -18), Vector2(radius + 2, 7), color.lightened(0.15))


func _draw_rocking_chair() -> void:
	var wood := PlaceholderArt.WOOD_DARK
	_ellipse(Vector2(962, 566), Vector2(58, 7), PlaceholderArt.SHADOW)
	# Back with slats
	draw_line(Vector2(924, 380), Vector2(916, 496), wood, 6.0)
	draw_line(Vector2(1000, 380), Vector2(1008, 496), wood, 6.0)
	draw_line(Vector2(924, 382), Vector2(1000, 382), wood, 8.0)
	for slat_x: float in [944.0, 962.0, 980.0]:
		draw_line(Vector2(slat_x, 386), Vector2(slat_x, 494), wood, 3.0)
	# Seat, legs and curved rockers
	draw_rect(Rect2(910, 496, 104, 9), PlaceholderArt.WOOD)
	draw_line(Vector2(918, 505), Vector2(914, 552), wood, 5.0)
	draw_line(Vector2(1006, 505), Vector2(1010, 552), wood, 5.0)
	draw_arc(Vector2(962, 430), 128, PI * 0.36, PI * 0.64, 16, wood, 5.0, true)


func _draw_crates() -> void:
	# Old crates in the far corner (behind the objective list)
	draw_rect(Rect2(1040, 430, 110, 130), Color(0.33, 0.25, 0.17))
	draw_rect(Rect2(1156, 470, 110, 90), Color(0.28, 0.21, 0.14))
	for crate: Rect2 in [Rect2(1040, 430, 110, 130), Rect2(1156, 470, 110, 90)]:
		draw_line(crate.position, crate.end, Color(0, 0, 0, 0.25), 3.0)
		draw_line(Vector2(crate.end.x, crate.position.y), Vector2(crate.position.x, crate.end.y), Color(0, 0, 0, 0.25), 3.0)


func _draw_book_pile() -> void:
	# Books dumped on the floor; the ledger lies among them.
	_ellipse(Vector2(474, 640), Vector2(70, 8), PlaceholderArt.SHADOW)
	var colors: Array[Color] = [Color(0.3, 0.22, 0.32), Color(0.4, 0.33, 0.2), Color(0.22, 0.26, 0.34)]
	for i in range(3):
		draw_rect(Rect2(416 + i * 8, 630 - i * 10, 64 - i * 6, 10), colors[i])
		draw_rect(Rect2(416 + i * 8, 630 - i * 10, 64 - i * 6, 2), Color(1, 1, 1, 0.08))
