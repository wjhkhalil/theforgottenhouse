@tool
class_name StudyArt
extends RoomArt
## Placeholder drawing of the Chapter Eight study (the finale).
## See room_art.gd for how to replace it with a real image.
##
## Layout (left to right): a tall bookcase (one shelf hides a secret
## compartment), a curtained window, Greaves's portrait and the wall safe set
## into the panelling, framed certificates, the big partners' desk with its
## green lamp and leather chair, a globe and a side table with the humidor.
## The room is lit only by the desk lamp, so the edges fall into shadow.

const FLOOR_Y := 480.0
const PANEL := Color(0.2, 0.12, 0.075)
const PANEL_DARK := Color(0.12, 0.07, 0.045)
const PANEL_LIGHT := Color(0.29, 0.18, 0.11)
const MAHOGANY := Color(0.3, 0.14, 0.09)
const MAHOGANY_DARK := Color(0.18, 0.08, 0.05)
const LEATHER := Color(0.3, 0.12, 0.09)
const LEATHER_DARK := Color(0.17, 0.06, 0.05)
const LAMP_GREEN := Color(0.1, 0.38, 0.22)
const BRASS := Color(0.7, 0.55, 0.28)
const LAMP_LIGHT := Color(1.0, 0.85, 0.55)
const VELVET := Color(0.22, 0.07, 0.07)
const VELVET_DARK := Color(0.12, 0.035, 0.04)
const LAMP_CENTER := Vector2(478, 400)


func _draw_background() -> void:
	_draw_panelled_wall()
	_draw_floor()
	_draw_rug()
	_draw_bookcase()
	_draw_window()
	_draw_painting()
	_draw_safe_recess()
	_draw_certificates()
	_draw_chair()
	_draw_desk()
	_draw_lamp()
	_draw_globe()
	_draw_side_table()
	_draw_lamp_light()


func _draw_foreground() -> void:
	# A book leaning against the shelf end hides the magnifier's handle.
	_polygon([Vector2(128, 410), Vector2(140, 410), Vector2(156, 360), Vector2(144, 357)], Color(0.2, 0.28, 0.22))
	draw_line(Vector2(131, 405), Vector2(146, 362), Color(0.75, 0.62, 0.35, 0.7), 1.5)
	# A pile of books on the floor covers a corner of the calendar page.
	_ellipse(Vector2(186, 626), Vector2(38, 6), PlaceholderArt.SHADOW)
	draw_rect(Rect2(152, 608, 66, 15), Color(0.32, 0.12, 0.1))
	draw_rect(Rect2(152, 608, 66, 3), Color(0.45, 0.2, 0.16))
	draw_rect(Rect2(158, 596, 54, 13), Color(0.18, 0.24, 0.3))
	draw_rect(Rect2(158, 596, 54, 2), Color(0.3, 0.38, 0.45))
	draw_rect(Rect2(208, 599, 4, 9), Color(0.82, 0.77, 0.64))
	# The globe stand's curved foot reaches over the tip of the fountain pen.
	draw_polyline(PackedVector2Array([Vector2(990, 600), Vector2(960, 626), Vector2(930, 644), Vector2(914, 648)]),
		MAHOGANY_DARK, 7.0, true)
	draw_circle(Vector2(914, 649), 5, MAHOGANY)
	_draw_vignette()


# ---------------------------------------------------------------------------

func _draw_panelled_wall() -> void:
	_vertical_gradient(Rect2(0, 0, room_size.x, FLOOR_Y), Color(0.07, 0.04, 0.03), Color(0.16, 0.1, 0.065))
	# Raised wooden panels with slightly different shades (fixed seed = same every time)
	var rng := RandomNumberGenerator.new()
	rng.seed = 808
	var x := 0.0
	while x < room_size.x:
		var width := rng.randf_range(96.0, 118.0)
		var shade := rng.randf_range(-0.02, 0.02)
		var upper := Rect2(x + 10, 70, width - 20, 230)
		var lower := Rect2(x + 10, 330, width - 20, 120)
		for panel in [upper, lower]:
			draw_rect(panel, Color(PANEL.r + shade, PANEL.g + shade, PANEL.b + shade, 0.55))
			draw_rect(panel, PANEL_DARK, false, 2.0)
			draw_line(panel.position + Vector2(2, 2), Vector2(panel.end.x - 2, panel.position.y + 2), Color(PANEL_LIGHT, 0.5), 1.0)
		# Wood grain streaks
		for i in range(4):
			var grain_x := x + rng.randf_range(16.0, width - 16.0)
			draw_line(Vector2(grain_x, 76), Vector2(grain_x + rng.randf_range(-4.0, 4.0), 294), Color(0, 0, 0, 0.08), 1.0)
		draw_line(Vector2(x, 56), Vector2(x, FLOOR_Y), Color(0, 0, 0, 0.3), 2.0)
		x += width
	# Picture rail, dado rail and skirting board
	draw_rect(Rect2(0, 56, room_size.x, 10), PANEL_DARK)
	draw_rect(Rect2(0, 312, room_size.x, 9), PANEL_LIGHT)
	draw_rect(Rect2(0, 319, room_size.x, 3), PANEL_DARK)
	draw_rect(Rect2(0, 460, room_size.x, 20), PANEL_DARK)
	draw_rect(Rect2(0, 460, room_size.x, 3), PANEL_LIGHT)


func _draw_floor() -> void:
	_vertical_gradient(Rect2(0, FLOOR_Y, room_size.x, room_size.y - FLOOR_Y), Color(0.1, 0.06, 0.04), Color(0.2, 0.12, 0.08))
	# Parquet boards converging toward the back wall
	for i in range(-8, 26):
		var back_x := 640.0 + (i - 9) * 48.0
		var front_x := 640.0 + (i - 9) * 86.0
		draw_line(Vector2(back_x, FLOOR_Y), Vector2(front_x, room_size.y), Color(0, 0, 0, 0.28), 2.0)
	for row_y: float in [520.0, 575.0, 640.0, 710.0]:
		draw_line(Vector2(0, row_y), Vector2(room_size.x, row_y), Color(0, 0, 0, 0.12), 1.0)


func _draw_rug() -> void:
	# A deep red Persian rug under the desk
	var outer: Array[Vector2] = [Vector2(250, 540), Vector2(1080, 540), Vector2(1170, 715), Vector2(160, 715)]
	_polygon(outer, Color(0.3, 0.08, 0.07))
	_polygon([Vector2(272, 552), Vector2(1058, 552), Vector2(1136, 704), Vector2(194, 704)], Color(0.14, 0.08, 0.12))
	_polygon([Vector2(290, 562), Vector2(1040, 562), Vector2(1110, 694), Vector2(220, 694)], Color(0.36, 0.1, 0.08))
	# Medallion and border pattern
	_ellipse(Vector2(665, 628), Vector2(150, 44), Color(0.16, 0.09, 0.14))
	_ellipse(Vector2(665, 628), Vector2(110, 30), Color(0.52, 0.34, 0.16, 0.6))
	_ellipse(Vector2(665, 628), Vector2(60, 16), Color(0.3, 0.08, 0.07))
	for i in range(18):
		var t := (i + 0.5) / 18.0
		var dot := Vector2(lerpf(262.0, 1068.0, t), 546)
		draw_circle(dot, 2.5, Color(0.6, 0.45, 0.2, 0.6))
		var bottom := Vector2(lerpf(178.0, 1152.0, t), 709)
		draw_circle(bottom, 3, Color(0.6, 0.45, 0.2, 0.6))
	# Fringe along the front edge
	for i in range(60):
		var fringe_x := 165.0 + i * 16.8
		draw_line(Vector2(fringe_x, 715), Vector2(fringe_x - 2, 720), Color(0.75, 0.68, 0.55, 0.5), 1.5)


func _draw_bookcase() -> void:
	_ellipse(Vector2(175, 482), Vector2(150, 10), PlaceholderArt.SHADOW)
	draw_rect(Rect2(40, 62, 270, 420), MAHOGANY_DARK)
	draw_rect(Rect2(54, 80, 242, 390), Color(0.07, 0.04, 0.03))
	# Books on five shelves (fixed seed). Shelf boards sit at these y values.
	var shelves: Array[float] = [130.0, 200.0, 270.0, 340.0, 410.0, 470.0]
	var colours: Array[Color] = [Color(0.4, 0.13, 0.1), Color(0.18, 0.26, 0.2), Color(0.35, 0.2, 0.12),
		Color(0.15, 0.18, 0.28), Color(0.45, 0.32, 0.18), Color(0.25, 0.1, 0.12), Color(0.36, 0.2, 0.13)]
	var rng := RandomNumberGenerator.new()
	rng.seed = 4417
	var top := 80.0
	for shelf_y in shelves:
		var x := 56.0
		while x < 292.0:
			var width := rng.randf_range(8.0, 15.0)
			var height := rng.randf_range(shelf_y - top - 26.0, shelf_y - top - 6.0)
			var book := Rect2(x, shelf_y - height, minf(width, 294.0 - x), height)
			var colour: Color = colours[rng.randi_range(0, colours.size() - 1)]
			if rng.randf() < 0.08:
				# A book leaning on its neighbour
				_polygon([Vector2(x, shelf_y), Vector2(x + width, shelf_y), Vector2(x + width + 8, shelf_y - height + 4),
					Vector2(x + 8, shelf_y - height + 2)], colour)
				x += width + 10.0
				continue
			draw_rect(book, colour)
			draw_line(book.position + Vector2(1, 0), Vector2(book.position.x + 1, shelf_y), Color(1, 1, 1, 0.08), 1.0)
			draw_rect(Rect2(book.position.x, book.position.y + 6, book.size.x, 2), Color(0.72, 0.58, 0.3, 0.5))
			draw_rect(Rect2(book.position.x, shelf_y - 10, book.size.x, 2), Color(0.72, 0.58, 0.3, 0.35))
			x += width + 0.5
		draw_rect(Rect2(50, shelf_y, 250, 8), MAHOGANY)
		draw_rect(Rect2(50, shelf_y, 250, 2), Color(0.42, 0.22, 0.14))
		top = shelf_y + 8.0
	# Cornice, sides and plinth
	draw_rect(Rect2(30, 56, 290, 16), MAHOGANY)
	draw_rect(Rect2(30, 70, 290, 3), MAHOGANY_DARK)
	draw_rect(Rect2(40, 62, 14, 420), MAHOGANY)
	draw_rect(Rect2(296, 62, 14, 420), MAHOGANY)
	draw_rect(Rect2(40, 470, 270, 12), MAHOGANY_DARK)
	# A brass library ladder rail along the top
	draw_line(Vector2(36, 76), Vector2(314, 76), Color(BRASS, 0.6), 2.0)


func _draw_window() -> void:
	# Night outside, mostly hidden behind heavy velvet curtains.
	var frame := Rect2(342, 96, 128, 220)
	draw_rect(frame.grow(8), PANEL_DARK)
	_vertical_gradient(frame, Color(0.04, 0.06, 0.12), Color(0.09, 0.12, 0.2))
	draw_circle(Vector2(430, 136), 9, Color(PlaceholderArt.MOON, 0.7))
	draw_circle(Vector2(434, 133), 8, Color(0.06, 0.08, 0.14))
	# Treeline and a glint of the lake
	_polygon([Vector2(342, 280), Vector2(370, 262), Vector2(400, 272), Vector2(430, 256), Vector2(470, 270),
		Vector2(470, 316), Vector2(342, 316)], Color(0.02, 0.03, 0.04))
	draw_line(Vector2(360, 300), Vector2(420, 300), Color(0.5, 0.6, 0.8, 0.25), 1.5)
	draw_line(Vector2(406, 96), Vector2(406, 316), PANEL_DARK, 5.0)
	draw_line(Vector2(342, 190), Vector2(470, 190), PANEL_DARK, 5.0)
	draw_rect(Rect2(332, 316, 148, 10), PANEL_LIGHT)
	# Curtains (folds drawn as darker stripes) and a pelmet
	for side in range(2):
		var left := 318.0 if side == 0 else 446.0
		_polygon([Vector2(left, 80), Vector2(left + 48, 80), Vector2(left + 40 + side * 8.0, 300),
			Vector2(left + 52 - side * 20.0, 470), Vector2(left - 4 + side * 6.0, 470)], VELVET)
		for fold in range(3):
			var fold_x := left + 8 + fold * 13.0
			draw_line(Vector2(fold_x, 84), Vector2(fold_x + (2 - side * 4) * 1.5, 468), VELVET_DARK, 4.0)
	# Tie-backs
	draw_line(Vector2(320, 300), Vector2(362, 296), Color(0.65, 0.5, 0.25), 3.0)
	draw_line(Vector2(452, 296), Vector2(494, 300), Color(0.65, 0.5, 0.25), 3.0)
	draw_rect(Rect2(310, 72, 194, 20), MAHOGANY)
	draw_rect(Rect2(310, 88, 194, 4), MAHOGANY_DARK)


func _draw_painting() -> void:
	# Greaves's own portrait, smug in a gilt frame.
	var frame := Rect2(528, 92, 140, 168)
	draw_rect(Rect2(frame.position + Vector2(5, 6), frame.size), Color(0, 0, 0, 0.4))
	draw_rect(frame, Color(0.55, 0.42, 0.2))
	draw_rect(frame.grow(-4), Color(0.72, 0.58, 0.3), false, 2.0)
	var canvas := frame.grow(-12)
	_vertical_gradient(canvas, Color(0.14, 0.12, 0.09), Color(0.08, 0.07, 0.05))
	# A dark-suited man with grey hair and a high collar
	_polygon([Vector2(560, 248), Vector2(572, 200), Vector2(598, 190), Vector2(624, 200), Vector2(636, 248)], Color(0.07, 0.07, 0.08))
	_polygon([Vector2(590, 192), Vector2(598, 214), Vector2(606, 192)], Color(0.82, 0.8, 0.74))
	_ellipse(Vector2(598, 160), Vector2(17, 22), Color(0.72, 0.58, 0.48))
	_ellipse(Vector2(598, 144), Vector2(18, 10), Color(0.6, 0.6, 0.6))
	draw_line(Vector2(590, 158), Vector2(594, 158), Color(0.2, 0.15, 0.12), 1.5)
	draw_line(Vector2(602, 158), Vector2(606, 158), Color(0.2, 0.15, 0.12), 1.5)
	draw_line(Vector2(592, 172), Vector2(604, 170), Color(0.4, 0.22, 0.2), 1.5)
	# Brass picture light above the frame
	draw_rect(Rect2(578, 80, 40, 7), BRASS)
	_polygon([Vector2(578, 87), Vector2(618, 87), Vector2(640, 110), Vector2(556, 110)], Color(1.0, 0.85, 0.55, 0.05))


func _draw_safe_recess() -> void:
	# A square hole cut into the panelling, with a hinged panel swung aside.
	var recess := Rect2(712, 127, 106, 106)
	draw_rect(recess, Color(0.04, 0.03, 0.025))
	draw_rect(recess, PANEL_DARK, false, 3.0)
	draw_line(recess.position + Vector2(0, recess.size.y), recess.end, PANEL_LIGHT, 2.0)
	# The secret panel that normally covers it
	_polygon([Vector2(818, 127), Vector2(842, 136), Vector2(842, 226), Vector2(818, 233)], PANEL_LIGHT)
	_polygon([Vector2(822, 133), Vector2(838, 140), Vector2(838, 222), Vector2(822, 227)], PANEL)
	draw_circle(Vector2(818, 140), 2, BRASS)
	draw_circle(Vector2(818, 220), 2, BRASS)


func _draw_certificates() -> void:
	# Framed diplomas and a "Solicitor" certificate, very proud of himself.
	var frames: Array[Rect2] = [Rect2(864, 100, 58, 76), Rect2(930, 118, 52, 66), Rect2(870, 196, 106, 64)]
	for frame in frames:
		draw_rect(Rect2(frame.position + Vector2(3, 4), frame.size), Color(0, 0, 0, 0.35))
		draw_rect(frame, Color(0.08, 0.06, 0.05))
		var paper := frame.grow(-5)
		draw_rect(paper, Color(0.72, 0.68, 0.56))
		draw_rect(Rect2(paper.position.x + 6, paper.position.y + 5, paper.size.x - 12, 4), Color(PlaceholderArt.INK, 0.7))
		for line in range(3):
			var y := paper.position.y + 15 + line * 7
			if y < paper.end.y - 12:
				draw_line(Vector2(paper.position.x + 5, y), Vector2(paper.end.x - 5, y), Color(PlaceholderArt.INK, 0.4), 1.0)
		# Red seal in the corner
		draw_circle(Vector2(paper.end.x - 9, paper.end.y - 8), 4, Color(0.62, 0.14, 0.12))


func _draw_chair() -> void:
	# A buttoned leather chair behind the desk.
	_rounded_rect(Rect2(592, 300, 156, 130), LEATHER_DARK, 26)
	_rounded_rect(Rect2(600, 306, 140, 118), LEATHER, 22)
	for row in range(3):
		for column in range(4):
			var button := Vector2(622 + column * 32 + (row % 2) * 16, 328 + row * 28)
			if button.x < 728:
				draw_circle(button, 2.5, LEATHER_DARK)
				draw_line(button, button + Vector2(10, 10), Color(0, 0, 0, 0.2), 1.0)
	draw_line(Vector2(608, 316), Vector2(730, 316), Color(1, 0.8, 0.6, 0.15), 2.0)
	# Rolled arms peeking out at both sides
	_rounded_rect(Rect2(574, 380, 34, 44), LEATHER_DARK, 12)
	_rounded_rect(Rect2(732, 380, 34, 44), LEATHER_DARK, 12)


func _draw_desk() -> void:
	_ellipse(Vector2(670, 612), Vector2(300, 18), Color(0, 0, 0, 0.45))
	# Desk top seen from slightly above
	_polygon([Vector2(428, 418), Vector2(912, 418), Vector2(938, 470), Vector2(402, 470)], MAHOGANY)
	_polygon([Vector2(440, 424), Vector2(900, 424), Vector2(920, 462), Vector2(420, 462)], Color(0.12, 0.22, 0.15))
	draw_line(Vector2(402, 470), Vector2(938, 470), Color(0.45, 0.24, 0.15), 3.0)
	# Leather blotter with its brass corners, a stack of letters and a book
	_polygon([Vector2(592, 426), Vector2(752, 426), Vector2(758, 462), Vector2(586, 462)], Color(0.2, 0.12, 0.08))
	_polygon([Vector2(592, 426), Vector2(604, 426), Vector2(600, 462), Vector2(586, 462)], Color(0.36, 0.2, 0.12))
	_polygon([Vector2(740, 426), Vector2(752, 426), Vector2(758, 462), Vector2(744, 462)], Color(0.36, 0.2, 0.12))
	draw_rect(Rect2(700, 432, 30, 18), Color(0.8, 0.76, 0.66))
	draw_rect(Rect2(704, 430, 30, 18), Color(0.86, 0.82, 0.72))
	draw_line(Vector2(708, 436), Vector2(728, 436), Color(PlaceholderArt.INK, 0.5), 1.0)
	draw_rect(Rect2(540, 438, 34, 18), Color(0.32, 0.12, 0.1))
	draw_rect(Rect2(540, 436, 34, 3), Color(0.82, 0.77, 0.64))
	# Brass inkwell stand with two glass bottles
	draw_rect(Rect2(806, 446, 52, 8), BRASS)
	draw_rect(Rect2(806, 452, 52, 3), Color(0.45, 0.34, 0.16))
	for bottle_x: float in [818.0, 846.0]:
		_rounded_rect(Rect2(bottle_x - 8, 430, 16, 17), Color(0.1, 0.12, 0.16), 4)
		draw_rect(Rect2(bottle_x - 4, 425, 8, 6), BRASS)
		draw_line(Vector2(bottle_x - 5, 434), Vector2(bottle_x - 5, 444), Color(1, 1, 1, 0.25), 1.5)
	# Front of the desk: two pedestals of drawers and a central kneehole drawer
	draw_rect(Rect2(402, 470, 536, 134), MAHOGANY_DARK)
	draw_rect(Rect2(402, 470, 536, 6), MAHOGANY)
	for pedestal_x: float in [414.0, 788.0]:
		for drawer in range(3):
			var front := Rect2(pedestal_x, 482 + drawer * 38, 138, 32)
			draw_rect(front, MAHOGANY)
			draw_rect(front.grow(-4), Color(0.36, 0.18, 0.11), false, 1.5)
			draw_rect(Rect2(front.position.x + 59, front.position.y + 14, 20, 4), BRASS)
	draw_rect(Rect2(564, 512, 212, 92), Color(0.05, 0.03, 0.02))
	draw_rect(Rect2(564, 476, 212, 36), MAHOGANY)
	# Plinth and bun feet
	draw_rect(Rect2(396, 600, 548, 10), MAHOGANY)
	for foot_x: float in [410.0, 548.0, 790.0, 928.0]:
		_ellipse(Vector2(foot_x, 612), Vector2(10, 5), MAHOGANY_DARK)


func _draw_lamp() -> void:
	# Brass banker's lamp with the classic green glass shade.
	_ellipse(Vector2(478, 448), Vector2(24, 5), Color(0, 0, 0, 0.4))
	_ellipse(Vector2(478, 444), Vector2(20, 6), BRASS)
	draw_rect(Rect2(475, 392, 6, 52), BRASS)
	draw_line(Vector2(476, 394), Vector2(476, 442), Color(1, 0.95, 0.75, 0.5), 1.0)
	draw_line(Vector2(490, 410), Vector2(490, 428), Color(0.6, 0.48, 0.22), 1.5)
	draw_circle(Vector2(490, 430), 2, BRASS)
	# Shade: dark green on top, glowing at the rim
	_polygon([Vector2(438, 394), Vector2(452, 368), Vector2(504, 368), Vector2(518, 394)], LAMP_GREEN)
	_polygon([Vector2(452, 368), Vector2(504, 368), Vector2(500, 376), Vector2(456, 376)], Color(0.2, 0.55, 0.34))
	draw_line(Vector2(438, 394), Vector2(518, 394), Color(0.85, 0.7, 0.35), 3.0)
	draw_line(Vector2(450, 380), Vector2(486, 372), Color(1, 1, 1, 0.2), 2.0)
	# The bright bulb seen under the rim
	_ellipse(Vector2(478, 397), Vector2(30, 3), Color(1.0, 0.95, 0.75, 0.9))


func _draw_globe() -> void:
	_ellipse(Vector2(1000, 640), Vector2(52, 8), PlaceholderArt.SHADOW)
	# Tripod stand (the front foot is in the foreground layer)
	draw_line(Vector2(1000, 560), Vector2(1000, 600), MAHOGANY_DARK, 8.0)
	draw_line(Vector2(1000, 600), Vector2(1046, 640), MAHOGANY_DARK, 6.0)
	draw_line(Vector2(1000, 600), Vector2(1020, 630), MAHOGANY, 5.0)
	# Sphere: ocean, a few continents, and the brass meridian
	draw_circle(Vector2(1000, 510), 46, Color(0.38, 0.34, 0.24))
	draw_circle(Vector2(1006, 504), 38, Color(0.5, 0.45, 0.3))
	_polygon([Vector2(976, 488), Vector2(996, 478), Vector2(1004, 496), Vector2(990, 520), Vector2(978, 512)], Color(0.3, 0.24, 0.14))
	_polygon([Vector2(1012, 500), Vector2(1030, 494), Vector2(1036, 520), Vector2(1020, 540), Vector2(1010, 524)], Color(0.3, 0.24, 0.14))
	draw_arc(Vector2(1000, 510), 52, -PI * 0.85, PI * 0.85, 30, BRASS, 3.0, true)
	draw_rect(Rect2(974, 460, 54, 6), MAHOGANY)
	draw_arc(Vector2(992, 496), 30, PI * 1.05, PI * 1.4, 8, Color(1, 1, 1, 0.12), 4.0, true)


func _draw_side_table() -> void:
	_ellipse(Vector2(1160, 690), Vector2(80, 9), PlaceholderArt.SHADOW)
	# Round-topped table with turned legs
	for leg_x: float in [1104.0, 1216.0]:
		draw_line(Vector2(leg_x, 566), Vector2(leg_x + (leg_x - 1160.0) * 0.12, 688), MAHOGANY_DARK, 7.0)
	draw_line(Vector2(1110, 640), Vector2(1210, 640), MAHOGANY_DARK, 4.0)
	_ellipse(Vector2(1160, 560), Vector2(82, 14), MAHOGANY)
	_ellipse(Vector2(1160, 557), Vector2(78, 11), Color(0.36, 0.17, 0.11))
	# A whisky decanter and a glass next to the humidor
	_rounded_rect(Rect2(1206, 516, 22, 36), Color(0.55, 0.32, 0.12, 0.85), 6)
	draw_rect(Rect2(1213, 504, 8, 14), Color(0.7, 0.72, 0.75, 0.6))
	draw_circle(Vector2(1217, 502), 5, Color(0.75, 0.78, 0.8, 0.7))
	draw_line(Vector2(1210, 522), Vector2(1210, 546), Color(1, 1, 1, 0.3), 1.5)
	draw_rect(Rect2(1100, 538, 14, 16), Color(0.75, 0.78, 0.8, 0.35))
	draw_rect(Rect2(1101, 546, 12, 8), Color(0.55, 0.32, 0.12, 0.6))


func _draw_lamp_light() -> void:
	# A warm pool of light from the green lamp spreading over the desk...
	_glow(LAMP_CENTER + Vector2(40, 50), 40, 10, 34, Color(LAMP_LIGHT, 0.022))
	# ...and a soft cone falling down from the shade onto the desk top.
	_polygon([Vector2(440, 396), Vector2(516, 396), Vector2(640, 470), Vector2(330, 470)], Color(LAMP_LIGHT, 0.06))
	# Darkness gathering in the far corners of the room
	_horizontal_gradient(Rect2(0, 0, 260, room_size.y), Color(0, 0, 0, 0.3), Color(0, 0, 0, 0))
	_horizontal_gradient(Rect2(room_size.x - 260, 0, 260, room_size.y), Color(0, 0, 0, 0), Color(0, 0, 0, 0.3))
