@tool
class_name LivingRoomArt
extends RoomArt
## Placeholder drawing of the Chapter Six living room.
## See room_art.gd for how to replace it with a real image.
##
## Layout (left to right): a curtained window and a standard lamp, the
## fireplace with a clock on the mantel, a red armchair, the gramophone on its
## side table, an upright piano with its bench, and a writing desk in the
## right corner. A sofa and a round smoking table stand in the front.
## Unlike the darker rooms this one is LIT (lamps, sconces, fire) - the power
## cuts (power_cuts.gd) are what make it dark.

const FLOOR_Y := 470.0
const WALLPAPER_TOP := Color(0.2, 0.1, 0.09)
const WALLPAPER_BOTTOM := Color(0.36, 0.2, 0.15)
const PANEL := Color(0.3, 0.19, 0.12)
const PANEL_DARK := Color(0.19, 0.12, 0.08)
const VELVET := Color(0.5, 0.14, 0.15)
const VELVET_DARK := Color(0.32, 0.08, 0.1)
const POLISHED := Color(0.17, 0.09, 0.06)
const POLISHED_LIGHT := Color(0.3, 0.17, 0.11)
const LAMP_LIGHT := Color(1.0, 0.78, 0.45)
const STONE := Color(0.52, 0.47, 0.42)
const STONE_DARK := Color(0.36, 0.32, 0.29)


func _draw_background() -> void:
	_draw_wall()
	_draw_window()
	_draw_paintings()
	_draw_sconces()
	_draw_floor()
	_draw_rug()
	_draw_fireplace()
	_draw_standard_lamp()
	_draw_piano()
	_draw_gramophone()
	_draw_armchair()
	_draw_writing_desk()
	_draw_smoking_table()
	_draw_sofa()


func _draw_foreground() -> void:
	# The fire-iron stand passes in front of the pipe's stem.
	draw_line(Vector2(421, 404), Vector2(421, 492), Color(0.12, 0.11, 0.1), 3.0)
	draw_line(Vector2(410, 492), Vector2(432, 492), Color(0.12, 0.11, 0.1), 4.0)
	draw_circle(Vector2(421, 402), 3.5, PlaceholderArt.BEIGE_DARK)
	# The armchair's tasselled fringe hangs over the corner of the crossword.
	draw_line(Vector2(472, 527), Vector2(502, 527), VELVET_DARK, 3.0)
	for i in range(7):
		var tassel_x := 474.0 + i * 4.5
		draw_line(Vector2(tassel_x, 527), Vector2(tassel_x, 535), Color(0.72, 0.56, 0.28), 1.5)
	# A book lying on the desk covers the end of the matchbox.
	draw_rect(Rect2(1219, 494, 32, 12), Color(0.2, 0.26, 0.2))
	draw_rect(Rect2(1219, 504, 32, 3), PlaceholderArt.BEIGE_DARK)
	draw_rect(Rect2(1219, 494, 32, 2), Color(1, 1, 1, 0.1))
	_draw_vignette()


# ---------------------------------------------------------------------------

func _draw_wall() -> void:
	_vertical_gradient(Rect2(0, 0, room_size.x, FLOOR_Y), WALLPAPER_TOP, WALLPAPER_BOTTOM)
	# Damask wallpaper: rows of small diamond motifs (fixed seed = same every time)
	var rng := RandomNumberGenerator.new()
	rng.seed = 61
	for row in range(9):
		for column in range(27):
			var center := Vector2(column * 48.0 + (24.0 if row % 2 == 1 else 0.0), 84.0 + row * 36.0)
			var fade := rng.randf_range(0.04, 0.09)
			_polygon([center + Vector2(0, -9), center + Vector2(6, 0), center + Vector2(0, 9), center + Vector2(-6, 0)],
				Color(0.85, 0.6, 0.35, fade))
			draw_circle(center + Vector2(0, 18), 1.5, Color(0.85, 0.6, 0.35, fade))
	# Faded patches where pictures used to hang, and a damp stain
	draw_rect(Rect2(1060, 160, 80, 100), Color(0.5, 0.35, 0.25, 0.08))
	_ellipse(Vector2(760, 90), Vector2(70, 26), Color(0.05, 0.03, 0.02, 0.15))
	# Crown moulding and picture rail
	draw_rect(Rect2(0, 52, room_size.x, 14), PANEL)
	draw_rect(Rect2(0, 64, room_size.x, 3), PANEL_DARK)
	draw_rect(Rect2(0, 118, room_size.x, 5), PANEL)
	# Wood wainscot with raised panels
	draw_rect(Rect2(0, 372, room_size.x, FLOOR_Y - 372), PANEL)
	draw_rect(Rect2(0, 372, room_size.x, 6), POLISHED_LIGHT)
	var panel_x := 8.0
	while panel_x < room_size.x:
		draw_rect(Rect2(panel_x, 388, 64, 66), PANEL_DARK)
		draw_rect(Rect2(panel_x + 3, 391, 58, 60), Color(0.33, 0.21, 0.14))
		draw_line(Vector2(panel_x + 3, 391), Vector2(panel_x + 61, 391), Color(1, 0.85, 0.6, 0.12), 1.0)
		panel_x += 74.0
	draw_rect(Rect2(0, FLOOR_Y - 10, room_size.x, 10), PANEL_DARK)


func _draw_window() -> void:
	# Tall window with the dark lake garden outside.
	draw_rect(Rect2(36, 120, 112, 250), PANEL_DARK)
	_vertical_gradient(Rect2(44, 128, 96, 236), Color(0.05, 0.07, 0.13), Color(0.1, 0.13, 0.2))
	draw_circle(Vector2(112, 160), 8, Color(PlaceholderArt.MOON, 0.7))
	_polygon([Vector2(44, 300), Vector2(80, 280), Vector2(120, 296), Vector2(140, 288), Vector2(140, 364), Vector2(44, 364)], Color(0.04, 0.06, 0.08))
	draw_line(Vector2(92, 128), Vector2(92, 364), PANEL_DARK, 4.0)
	draw_line(Vector2(44, 246), Vector2(140, 246), PANEL_DARK, 4.0)
	draw_rect(Rect2(30, 366, 124, 8), POLISHED_LIGHT)
	# Heavy velvet curtains, tied back with gold cords
	draw_rect(Rect2(20, 92, 144, 10), PlaceholderArt.BEIGE_DARK)
	for side: float in [-1.0, 1.0]:
		var edge := 92.0 + side * 72.0
		var inner := 92.0 + side * 34.0
		_polygon([Vector2(edge, 100), Vector2(inner, 100), Vector2(edge + side * -10.0, 250),
			Vector2(inner + side * 4.0, 400), Vector2(edge, 400)], VELVET)
		for fold in range(3):
			var fold_x := edge - side * (8.0 + fold * 9.0)
			draw_line(Vector2(fold_x, 104), Vector2(fold_x + side * 4.0, 398), VELVET_DARK, 2.5)
		draw_line(Vector2(edge - side * 30.0, 246), Vector2(edge, 252), Color(0.8, 0.62, 0.3), 3.0)
		draw_circle(Vector2(edge - side * 30.0, 252), 4, Color(0.8, 0.62, 0.3))


func _draw_paintings() -> void:
	# Above the mantel: the lake at dusk, in a gilt frame.
	draw_rect(Rect2(282, 138, 136, 102), Color(0.62, 0.48, 0.22))
	draw_rect(Rect2(290, 146, 120, 86), Color(0.42, 0.3, 0.14))
	_vertical_gradient(Rect2(294, 150, 112, 78), Color(0.45, 0.32, 0.3), Color(0.2, 0.25, 0.3))
	_polygon([Vector2(294, 196), Vector2(330, 178), Vector2(360, 192), Vector2(406, 180), Vector2(406, 206), Vector2(294, 206)], Color(0.14, 0.17, 0.15))
	draw_rect(Rect2(294, 206, 112, 22), Color(0.26, 0.33, 0.4))
	draw_rect(Rect2(372, 194, 16, 12), Color(0.2, 0.15, 0.12))  # the boathouse
	draw_line(Vector2(300, 216), Vector2(396, 216), Color(1, 0.9, 0.7, 0.15), 1.0)
	# A portrait of the Ashworth sisters between the armchair and gramophone
	draw_line(Vector2(560, 123), Vector2(536, 152), Color(0.6, 0.5, 0.3), 1.0)
	draw_line(Vector2(560, 123), Vector2(584, 152), Color(0.6, 0.5, 0.3), 1.0)
	draw_rect(Rect2(522, 150, 76, 96), Color(0.55, 0.42, 0.2))
	draw_rect(Rect2(528, 156, 64, 84), Color(0.16, 0.14, 0.12))
	for face: Vector2 in [Vector2(548, 186), Vector2(572, 190)]:
		_ellipse(face, Vector2(8, 10), Color(0.72, 0.6, 0.5))
		_polygon([face + Vector2(-12, 14), face + Vector2(12, 14), face + Vector2(15, 50), face + Vector2(-15, 50)], Color(0.28, 0.22, 0.28))
	# A small seascape between the piano and the desk
	draw_rect(Rect2(830, 140, 92, 66), Color(0.5, 0.38, 0.2))
	_vertical_gradient(Rect2(836, 146, 80, 54), Color(0.5, 0.45, 0.4), Color(0.22, 0.3, 0.32))
	_polygon([Vector2(860, 186), Vector2(872, 164), Vector2(874, 186)], Color(0.85, 0.8, 0.7))


func _draw_sconces() -> void:
	# Wall lamps with bare bulbs; their light pools on the wallpaper.
	for x: float in [230.0, 470.0, 700.0, 1000.0]:
		var bulb := Vector2(x, 226)
		_glow(bulb, 14, 5, 13, Color(LAMP_LIGHT, 0.035))
		draw_rect(Rect2(x - 7, 244, 14, 20), Color(0.6, 0.47, 0.24))
		draw_line(Vector2(x, 244), Vector2(x, 234), Color(0.6, 0.47, 0.24), 3.0)
		draw_circle(bulb, 7, Color(1.0, 0.92, 0.7))
		draw_circle(bulb + Vector2(-2, -2), 2.5, Color(1, 1, 1, 0.9))
		# Little tulip shade
		_polygon([bulb + Vector2(-10, -4), bulb + Vector2(10, -4), bulb + Vector2(6, 6), bulb + Vector2(-6, 6)], Color(0.95, 0.75, 0.5, 0.35))


func _draw_floor() -> void:
	_vertical_gradient(Rect2(0, FLOOR_Y, room_size.x, room_size.y - FLOOR_Y), Color(0.18, 0.1, 0.07), Color(0.3, 0.18, 0.11))
	# Parquet boards running toward the back wall
	for i in range(-8, 26):
		var back_x := 640.0 + (i - 9) * 46.0
		var front_x := 640.0 + (i - 9) * 84.0
		draw_line(Vector2(back_x, FLOOR_Y), Vector2(front_x, room_size.y), Color(0, 0, 0, 0.25), 2.0)
	for seam_y: float in [500.0, 545.0, 605.0, 680.0]:
		draw_line(Vector2(0, seam_y), Vector2(room_size.x, seam_y), Color(0, 0, 0, 0.1), 1.0)
	# Firelight spilling across the boards
	_ellipse(Vector2(350, 520), Vector2(220, 50), Color(1.0, 0.55, 0.2, 0.05))


func _draw_rug() -> void:
	var points: Array[Vector2] = [Vector2(470, 560), Vector2(940, 560), Vector2(1010, 700), Vector2(400, 700)]
	_polygon(points, Color(0.36, 0.13, 0.12))
	_polygon([Vector2(488, 570), Vector2(924, 570), Vector2(984, 690), Vector2(424, 690)], Color(0.24, 0.12, 0.16))
	_polygon([Vector2(520, 586), Vector2(894, 586), Vector2(940, 674), Vector2(470, 674)], Color(0.42, 0.18, 0.14))
	# Medallion pattern in the middle
	_ellipse(Vector2(712, 630), Vector2(90, 26), Color(0.62, 0.45, 0.25, 0.55))
	_ellipse(Vector2(712, 630), Vector2(60, 16), Color(0.2, 0.14, 0.22))
	_ellipse(Vector2(712, 630), Vector2(22, 6), Color(0.7, 0.55, 0.3, 0.6))
	# Fringe along the front edge
	for i in range(40):
		var fringe_x := 402.0 + i * 15.2
		draw_line(Vector2(fringe_x, 700), Vector2(fringe_x - 2, 710), Color(0.8, 0.7, 0.5, 0.6), 1.5)


func _draw_fireplace() -> void:
	# Marble surround, mantel shelf, and a low fire in the grate.
	_ellipse(Vector2(350, 488), Vector2(130, 10), PlaceholderArt.SHADOW)
	draw_rect(Rect2(256, 300, 188, 172), STONE)
	draw_rect(Rect2(256, 300, 22, 172), STONE_DARK)
	draw_rect(Rect2(422, 300, 22, 172), STONE_DARK)
	# Veins in the marble
	draw_polyline(PackedVector2Array([Vector2(282, 310), Vector2(300, 330), Vector2(296, 352)]), Color(1, 1, 1, 0.15), 1.0)
	draw_polyline(PackedVector2Array([Vector2(400, 314), Vector2(412, 340), Vector2(404, 358)]), Color(1, 1, 1, 0.15), 1.0)
	# Firebox (rounded arch)
	draw_rect(Rect2(296, 360, 108, 110), Color(0.06, 0.04, 0.03))
	draw_circle(Vector2(350, 362), 54, Color(0.06, 0.04, 0.03))
	draw_rect(Rect2(256, 300, 188, 40), STONE)
	draw_arc(Vector2(350, 362), 54, PI, TAU, 20, STONE_DARK, 3.0, true)
	draw_line(Vector2(296, 362), Vector2(296, 470), STONE_DARK, 3.0)
	draw_line(Vector2(404, 362), Vector2(404, 470), STONE_DARK, 3.0)
	# Fire: glow, logs and flames
	_glow(Vector2(350, 448), 10, 6, 10, Color(1.0, 0.5, 0.15, 0.06))
	draw_line(Vector2(316, 456), Vector2(384, 450), Color(0.25, 0.14, 0.08), 9.0)
	draw_line(Vector2(322, 448), Vector2(378, 458), Color(0.2, 0.11, 0.06), 8.0)
	for flame: Array in [[Vector2(334, 448), 18.0], [Vector2(352, 444), 28.0], [Vector2(368, 448), 20.0]]:
		var base: Vector2 = flame[0]
		var height: float = flame[1]
		_polygon([base + Vector2(-9, 0), base + Vector2(0, -height), base + Vector2(9, 0)], Color(1.0, 0.5, 0.12, 0.85))
		_polygon([base + Vector2(-4, 0), base + Vector2(0, -height * 0.6), base + Vector2(4, 0)], Color(1.0, 0.85, 0.4))
	draw_rect(Rect2(306, 458, 88, 6), Color(0.15, 0.14, 0.14))  # grate
	# Mantel shelf
	draw_rect(Rect2(238, 288, 224, 14), POLISHED_LIGHT)
	draw_rect(Rect2(238, 288, 224, 3), Color(1, 0.85, 0.6, 0.18))
	draw_rect(Rect2(244, 302, 212, 4), POLISHED)
	# Hearth stone in front
	_polygon([Vector2(244, 470), Vector2(456, 470), Vector2(466, 494), Vector2(234, 494)], STONE_DARK)
	draw_line(Vector2(244, 470), Vector2(456, 470), STONE, 2.0)
	# Fire irons hanging on the stand (the pole is drawn in the foreground)
	for tool_x: float in [414.0, 428.0]:
		draw_line(Vector2(tool_x, 406), Vector2(tool_x, 460), Color(0.2, 0.19, 0.18), 2.0)
	_polygon([Vector2(410, 458), Vector2(418, 458), Vector2(420, 470), Vector2(408, 470)], Color(0.2, 0.19, 0.18))
	# Mantel clock, candlesticks and a china dog
	_draw_mantel_clock(Vector2(350, 260))
	for candle_x: float in [262.0, 438.0]:
		draw_rect(Rect2(candle_x - 6, 282, 12, 6), Color(0.6, 0.47, 0.24))
		draw_rect(Rect2(candle_x - 2, 256, 4, 26), Color(0.6, 0.47, 0.24))
		draw_rect(Rect2(candle_x - 3, 236, 6, 20), PlaceholderArt.BEIGE)
		draw_circle(Vector2(candle_x, 232), 2.5, Color(1.0, 0.8, 0.4))
		_glow(Vector2(candle_x, 232), 4, 3, 5, Color(LAMP_LIGHT, 0.06))
	_ellipse(Vector2(298, 280), Vector2(10, 8), Color(0.86, 0.84, 0.8))
	draw_circle(Vector2(306, 272), 5, Color(0.86, 0.84, 0.8))
	draw_circle(Vector2(308, 271), 1.2, Color(0.1, 0.1, 0.1))


func _draw_mantel_clock(center: Vector2) -> void:
	_polygon([center + Vector2(-26, 28), center + Vector2(-22, -4), center + Vector2(0, -26),
		center + Vector2(22, -4), center + Vector2(26, 28)], POLISHED)
	draw_rect(Rect2(center + Vector2(-30, 22), Vector2(60, 6)), POLISHED_LIGHT)
	draw_circle(center + Vector2(0, 2), 14, Color(0.6, 0.47, 0.24))
	draw_circle(center + Vector2(0, 2), 11.5, Color(0.92, 0.88, 0.78))
	# Stopped at ten to twelve
	draw_line(center + Vector2(0, 2), center + Vector2(-5, -5), Color(0.1, 0.1, 0.1), 1.5)
	draw_line(center + Vector2(0, 2), center + Vector2(0, -8), Color(0.1, 0.1, 0.1), 1.2)


func _draw_standard_lamp() -> void:
	# Floor lamp with a fringed silk shade - the brightest light in the room.
	_glow(Vector2(196, 210), 30, 6, 18, Color(LAMP_LIGHT, 0.04))
	_ellipse(Vector2(196, 512), Vector2(30, 6), PlaceholderArt.SHADOW)
	_ellipse(Vector2(196, 506), Vector2(20, 6), Color(0.45, 0.35, 0.18))
	draw_line(Vector2(196, 506), Vector2(196, 230), Color(0.5, 0.4, 0.2), 4.0)
	draw_circle(Vector2(196, 360), 4, Color(0.6, 0.48, 0.25))
	_polygon([Vector2(170, 180), Vector2(222, 180), Vector2(240, 232), Vector2(152, 232)], Color(0.95, 0.75, 0.45))
	_polygon([Vector2(170, 180), Vector2(184, 180), Vector2(172, 232), Vector2(152, 232)], Color(0.85, 0.6, 0.35))
	draw_line(Vector2(152, 232), Vector2(240, 232), Color(0.75, 0.5, 0.25), 2.0)
	for i in range(12):
		var fringe_x := 154.0 + i * 7.6
		draw_line(Vector2(fringe_x, 232), Vector2(fringe_x, 240), Color(0.8, 0.55, 0.28), 1.5)
	# Light falling from under the shade
	_polygon([Vector2(156, 236), Vector2(236, 236), Vector2(280, 330), Vector2(112, 330)], Color(LAMP_LIGHT, 0.05))


func _draw_piano() -> void:
	# Upright piano against the wall, lid closed, candle holders on its front.
	_ellipse(Vector2(890, 478), Vector2(116, 9), PlaceholderArt.SHADOW)
	draw_rect(Rect2(796, 258, 188, 214), POLISHED)
	draw_rect(Rect2(788, 246, 204, 14), POLISHED_LIGHT)
	draw_rect(Rect2(788, 246, 204, 3), Color(1, 0.85, 0.6, 0.2))
	# Carved upper panel with fretwork and the music stand
	draw_rect(Rect2(812, 272, 156, 80), Color(0.13, 0.07, 0.05))
	draw_rect(Rect2(820, 280, 140, 64), Color(0.38, 0.2, 0.18, 0.5))
	for i in range(6):
		draw_arc(Vector2(840 + i * 20, 312), 9, 0, TAU, 12, Color(0.3, 0.17, 0.11), 1.5, true)
	draw_rect(Rect2(846, 300, 30, 40), Color(0.86, 0.82, 0.7))  # sheet music
	draw_rect(Rect2(878, 302, 30, 38), Color(0.82, 0.78, 0.66))
	for i in range(4):
		draw_line(Vector2(850, 308 + i * 8), Vector2(904, 310 + i * 8), Color(PlaceholderArt.INK, 0.5), 1.0)
	draw_rect(Rect2(840, 340, 100, 4), Color(0.6, 0.47, 0.24))
	# Keyboard ledge
	draw_rect(Rect2(782, 360, 216, 10), POLISHED_LIGHT)
	draw_rect(Rect2(788, 370, 204, 16), Color(0.92, 0.9, 0.82))
	for i in range(30):
		draw_line(Vector2(791 + i * 6.8, 370), Vector2(791 + i * 6.8, 386), Color(0.5, 0.48, 0.44), 1.0)
	for i in range(29):
		if i % 7 == 2 or i % 7 == 6:
			continue
		draw_rect(Rect2(795 + i * 6.8, 370, 4, 9), Color(0.08, 0.07, 0.07))
	draw_rect(Rect2(782, 386, 216, 6), POLISHED)
	# Lower panel, legs and brass pedals
	draw_rect(Rect2(812, 400, 156, 60), Color(0.13, 0.07, 0.05))
	draw_rect(Rect2(784, 392, 14, 80), POLISHED_LIGHT)
	draw_rect(Rect2(982, 392, 14, 80), POLISHED_LIGHT)
	for pedal_x: float in [878.0, 902.0]:
		draw_rect(Rect2(pedal_x, 462, 12, 4), Color(0.75, 0.6, 0.3))
	# Candle holders, a lamp with a green shade and photographs on top
	for holder_x: float in [800.0, 980.0]:
		draw_circle(Vector2(holder_x, 300), 4, Color(0.6, 0.47, 0.24))
	draw_rect(Rect2(810, 226, 18, 20), Color(0.6, 0.47, 0.24))
	draw_rect(Rect2(834, 230, 14, 16), Color(0.55, 0.5, 0.42))
	_ellipse(Vector2(950, 240), Vector2(14, 6), Color(0.45, 0.4, 0.36))
	draw_rect(Rect2(946, 214, 8, 26), Color(0.45, 0.4, 0.36))
	_polygon([Vector2(934, 196), Vector2(966, 196), Vector2(972, 216), Vector2(928, 216)], Color(0.2, 0.42, 0.3))
	_glow(Vector2(950, 222), 8, 3, 10, Color(LAMP_LIGHT, 0.05))
	# Legs of the piano bench (the clickable seat box sits on top of them)
	_ellipse(Vector2(880, 562), Vector2(56, 6), PlaceholderArt.SHADOW)
	for leg_x: float in [840.0, 916.0]:
		draw_rect(Rect2(leg_x, 518, 7, 42), POLISHED)
		draw_rect(Rect2(leg_x, 518, 2, 42), POLISHED_LIGHT)
	draw_rect(Rect2(840, 540, 83, 4), POLISHED)


func _draw_gramophone() -> void:
	# Side table with a lower shelf, carrying the gramophone.
	_ellipse(Vector2(700, 486), Vector2(66, 7), PlaceholderArt.SHADOW)
	draw_rect(Rect2(652, 408, 96, 46), Color(0.08, 0.05, 0.04, 0.45))
	for leg_x: float in [650.0, 744.0]:
		draw_rect(Rect2(leg_x, 406, 7, 78), PlaceholderArt.WOOD_DARK)
	draw_rect(Rect2(640, 398, 120, 10), PlaceholderArt.WOOD)
	draw_rect(Rect2(640, 398, 120, 2), Color(1, 0.85, 0.6, 0.2))
	draw_rect(Rect2(646, 454, 108, 7), PlaceholderArt.WOOD)
	draw_rect(Rect2(646, 461, 108, 3), PlaceholderArt.WOOD_DARK)
	# Other records stacked on the shelf, in paper sleeves
	draw_rect(Rect2(716, 430, 30, 24), Color(0.55, 0.45, 0.3))
	draw_rect(Rect2(722, 426, 28, 28), Color(0.42, 0.32, 0.22))
	draw_circle(Vector2(736, 440), 5, Color(0.1, 0.08, 0.07))
	# Gramophone cabinet and turntable (with no record on it)
	draw_rect(Rect2(662, 370, 76, 28), POLISHED_LIGHT)
	draw_rect(Rect2(666, 374, 68, 20), Color(0.4, 0.23, 0.14))
	draw_rect(Rect2(728, 380, 12, 3), Color(0.6, 0.6, 0.6))  # crank
	_ellipse(Vector2(694, 368), Vector2(28, 5), Color(0.22, 0.28, 0.22))
	draw_circle(Vector2(694, 367), 2, Color(0.75, 0.7, 0.6))
	# Tone arm and the big brass horn
	draw_line(Vector2(726, 366), Vector2(714, 352), Color(0.7, 0.58, 0.3), 3.0)
	_polygon([Vector2(712, 354), Vector2(718, 350), Vector2(752, 316), Vector2(742, 306)], Color(0.62, 0.48, 0.22))
	_polygon([Vector2(742, 306), Vector2(752, 316), Vector2(800, 330), Vector2(762, 244)], Color(0.72, 0.56, 0.26))
	_ellipse(Vector2(782, 286), Vector2(20, 46), Color(0.78, 0.62, 0.3))
	_ellipse(Vector2(784, 286), Vector2(13, 36), Color(0.3, 0.22, 0.1))
	draw_line(Vector2(748, 312), Vector2(774, 252), Color(1, 0.9, 0.6, 0.35), 2.0)


func _draw_armchair() -> void:
	# A wing armchair in worn red velvet, angled toward the fire.
	_ellipse(Vector2(548, 532), Vector2(84, 9), PlaceholderArt.SHADOW)
	_polygon([Vector2(494, 360), Vector2(602, 360), Vector2(612, 380), Vector2(606, 452), Vector2(490, 452), Vector2(484, 380)], VELVET)
	_polygon([Vector2(494, 360), Vector2(602, 360), Vector2(598, 372), Vector2(498, 372)], Color(0.6, 0.2, 0.2))
	for button: Vector2 in [Vector2(520, 396), Vector2(548, 400), Vector2(576, 396), Vector2(534, 424), Vector2(562, 424)]:
		draw_circle(button, 2, VELVET_DARK)
	# Seat cushion and front
	draw_rect(Rect2(494, 446, 108, 30), Color(0.56, 0.17, 0.18))
	draw_rect(Rect2(494, 474, 108, 50), VELVET_DARK)
	draw_line(Vector2(494, 476), Vector2(602, 476), Color(0.25, 0.05, 0.07), 2.0)
	# Rolled arms
	for arm_x: float in [472.0, 596.0]:
		draw_rect(Rect2(arm_x, 432, 28, 92), VELVET)
		_ellipse(Vector2(arm_x + 14, 432), Vector2(16, 9), Color(0.58, 0.18, 0.19))
		draw_line(Vector2(arm_x + 4, 442), Vector2(arm_x + 4, 520), VELVET_DARK, 2.0)
	# Short turned legs
	for leg_x: float in [478.0, 614.0]:
		draw_rect(Rect2(leg_x, 524, 6, 8), POLISHED)
	# A wicker basket of old newspapers by the armchair, a few pages spilled out
	_polygon([Vector2(446, 500), Vector2(474, 500), Vector2(471, 524), Vector2(449, 524)], Color(0.5, 0.38, 0.2))
	for weave_y: float in [506.0, 512.0, 518.0]:
		draw_line(Vector2(448, weave_y), Vector2(472, weave_y), Color(0.34, 0.24, 0.12), 1.0)
	_polygon([Vector2(450, 500), Vector2(454, 486), Vector2(470, 490), Vector2(468, 500)], Color(0.76, 0.74, 0.66))
	draw_line(Vector2(455, 492), Vector2(466, 494), Color(PlaceholderArt.INK, 0.5), 1.0)
	_polygon([Vector2(416, 552), Vector2(440, 546), Vector2(446, 562), Vector2(420, 568)], Color(0.7, 0.68, 0.6))
	for i in range(3):
		draw_line(Vector2(421, 553 + i * 4), Vector2(439, 549 + i * 4), Color(PlaceholderArt.INK, 0.4), 1.0)


func _draw_writing_desk() -> void:
	# Writing desk with a pigeonhole top (the drawer is the clickable container).
	_ellipse(Vector2(1130, 690), Vector2(128, 10), PlaceholderArt.SHADOW)
	# Pigeonhole cabinet standing on the desk, against the wall
	draw_rect(Rect2(1026, 404, 208, 92), POLISHED)
	draw_rect(Rect2(1020, 396, 220, 10), POLISHED_LIGHT)
	for i in range(5):
		var hole := Rect2(1034 + i * 40, 414, 34, 34)
		draw_rect(hole, Color(0.08, 0.05, 0.04))
		draw_rect(Rect2(hole.position.x + 4, hole.position.y + 10, 24, 24), Color(0.8, 0.75, 0.62, 0.6 - i * 0.08))
	draw_rect(Rect2(1034, 456, 194, 32), Color(0.1, 0.06, 0.05))
	# Desk top with an inkwell, a blotter and a small lamp
	_polygon([Vector2(1014, 492), Vector2(1246, 492), Vector2(1256, 512), Vector2(1004, 512)], POLISHED_LIGHT)
	draw_line(Vector2(1004, 512), Vector2(1256, 512), Color(1, 0.85, 0.6, 0.2), 1.5)
	_polygon([Vector2(1100, 496), Vector2(1170, 496), Vector2(1174, 508), Vector2(1096, 508)], Color(0.2, 0.3, 0.24))
	draw_rect(Rect2(1048, 488, 12, 10), Color(0.1, 0.12, 0.2))
	draw_line(Vector2(1056, 488), Vector2(1066, 470), Color(0.85, 0.8, 0.7), 1.5)  # quill
	# Apron and legs
	draw_rect(Rect2(1010, 512, 240, 78), POLISHED)
	draw_rect(Rect2(1018, 520, 62, 60), Color(0.13, 0.07, 0.05))
	draw_rect(Rect2(1180, 520, 62, 60), Color(0.13, 0.07, 0.05))
	for leg_x: float in [1014.0, 1236.0]:
		draw_rect(Rect2(leg_x, 590, 10, 98), POLISHED)
		draw_rect(Rect2(leg_x, 590, 3, 98), POLISHED_LIGHT)


func _draw_smoking_table() -> void:
	# Round pedestal table in front of the hearth, with an ashtray.
	_ellipse(Vector2(650, 690), Vector2(54, 7), PlaceholderArt.SHADOW)
	draw_rect(Rect2(644, 620, 12, 62), PlaceholderArt.WOOD_DARK)
	_polygon([Vector2(616, 690), Vector2(644, 676), Vector2(656, 676), Vector2(684, 690)], PlaceholderArt.WOOD_DARK)
	_ellipse(Vector2(650, 620), Vector2(64, 8), PlaceholderArt.WOOD_DARK)
	_ellipse(Vector2(650, 614), Vector2(64, 16), PlaceholderArt.WOOD)
	_ellipse(Vector2(646, 612), Vector2(50, 10), Color(1, 0.85, 0.6, 0.06))
	# Ashtray with a resting cigar
	_ellipse(Vector2(694, 614), Vector2(11, 4), Color(0.6, 0.6, 0.62))
	_ellipse(Vector2(694, 613), Vector2(7, 2.5), Color(0.2, 0.2, 0.2))
	draw_line(Vector2(690, 612), Vector2(710, 606), Color(0.4, 0.25, 0.14), 3.0)


func _draw_sofa() -> void:
	# Chesterfield sofa in the front left, seen from behind its arm.
	var leather := Color(0.24, 0.14, 0.1)
	var leather_light := Color(0.34, 0.2, 0.14)
	_ellipse(Vector2(210, 712), Vector2(190, 12), PlaceholderArt.SHADOW)
	_rounded_rect(Rect2(40, 566, 340, 96), leather, 18)
	draw_rect(Rect2(52, 570, 316, 3), Color(1, 0.85, 0.6, 0.1))
	for i in range(6):
		for j in range(2):
			draw_circle(Vector2(70 + i * 56 + j * 28, 592 + j * 26), 2.5, Color(0.12, 0.07, 0.05))
	draw_rect(Rect2(40, 640, 340, 80), leather_light)
	draw_line(Vector2(40, 642), Vector2(380, 642), Color(0.12, 0.07, 0.05), 3.0)
	for seam_x: float in [154.0, 266.0]:
		draw_line(Vector2(seam_x, 644), Vector2(seam_x, 720), Color(0.12, 0.07, 0.05), 2.0)
	draw_rect(Rect2(40, 644, 340, 4), Color(1, 0.85, 0.6, 0.08))
	for arm_x: float in [24.0, 352.0]:
		_rounded_rect(Rect2(arm_x, 600, 44, 120), leather, 14)
		draw_line(Vector2(arm_x + 8, 610), Vector2(arm_x + 8, 716), leather_light, 2.0)
	# A tartan throw over the back
	_polygon([Vector2(220, 566), Vector2(300, 566), Vector2(310, 628), Vector2(214, 620)], Color(0.2, 0.3, 0.26))
	draw_line(Vector2(240, 566), Vector2(236, 622), Color(0.6, 0.2, 0.18), 2.0)
	draw_line(Vector2(280, 566), Vector2(286, 626), Color(0.6, 0.2, 0.18), 2.0)
	draw_line(Vector2(218, 590), Vector2(304, 594), Color(0.6, 0.2, 0.18), 2.0)
