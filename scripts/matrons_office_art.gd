@tool
class_name MatronsOfficeArt
extends RoomArt
## Placeholder drawing of House Three, Chapter Six: the matron's private office
## in Hollowmere Sanatorium, late at night. See room_art.gd for how to replace
## it with a real image.
##
## Layout, left to right: the tall swing mirror (WallMirror paints the
## reflection over its glass and puts the tilt arrows above and below it), the
## hat stand with the carpet bag at its foot, the filing cabinet against the
## wall, the fireplace (the grate below, the jewel case on the mantelpiece),
## a low bookcase with the bible box on top, the wall safe, and the grey door
## to the ward stair. The big desk stands forward of the bookcase and the safe:
## telephone, inkstand, green lamp and bell on top, a drawer in each pedestal,
## the waste basket beside it. In front, on the carpet: the side table with the
## tea caddy (under the mirror) and the sewing table with its pin cushion.
## Nothing to find is placed under the objective list on the right, where a
## curtained window and a roped tea chest show that she is packing to leave.

const FLOOR_Y := 540.0
const DADO_Y := 330.0
const GLASS_RECT := Rect2(120, 150, 170, 290)
const PIVOT_Y := 295.0
const DOOR_RECT := Rect2(875, 327, 100, 210)
const MANTEL_RECT := Rect2(462, 372, 156, 10)
const HEARTH_RECT := Rect2(474, 382, 132, 158)
const BOOKCASE_RECT := Rect2(616, 380, 100, 160)
const SAFE_RECT := Rect2(757, 259, 66, 62)
const DESK_TOP_RECT := Rect2(608, 478, 264, 12)
const DESK_FRONT_RECT := Rect2(618, 490, 244, 118)
const WOOD := Color(0.36, 0.23, 0.14)
const WOOD_DARK := Color(0.17, 0.1, 0.07)
const PANEL := Color(0.23, 0.15, 0.1)
const PAPER_WALL := Color(0.16, 0.2, 0.19)
const BRASS := Color(0.78, 0.6, 0.3)
const GREY_PAINT := Color(0.3, 0.33, 0.36)
const MARBLE := Color(0.2, 0.2, 0.23)
const CARPET := Color(0.33, 0.1, 0.12)
const CARPET_GOLD := Color(0.72, 0.56, 0.3, 0.55)
const INK := Color(0.12, 0.12, 0.16)


func _draw_background() -> void:
	_draw_walls()
	_draw_carpet()
	_draw_ward_door()
	_draw_fireplace()
	_draw_bookcase()
	_draw_safe_surround()
	_draw_cabinet_place()
	_draw_hat_stand()
	_draw_swing_mirror()
	_draw_desk()
	_draw_side_table()
	_draw_sewing_table()
	_draw_packing()


func _draw_foreground() -> void:
	_draw_vignette()


# ---------------------------------------------------------------------------

## Dark green paper above a dado rail, dark oak panelling below.
func _draw_walls() -> void:
	_vertical_gradient(Rect2(0, 0, room_size.x, DADO_Y), PAPER_WALL.darkened(0.3), PAPER_WALL)
	draw_rect(Rect2(0, 92, room_size.x, 6), WOOD_DARK)
	draw_rect(Rect2(0, DADO_Y, room_size.x, FLOOR_Y - DADO_Y), PANEL)
	# Sunk panels (left plain behind the mirror, so nothing distracts from it)
	var x := 12.0
	while x < room_size.x:
		if x < 60.0 or x > 320.0:
			draw_rect(Rect2(x, DADO_Y + 18, 84, 168), PANEL.darkened(0.25), false, 2.0)
			draw_rect(Rect2(x + 6, DADO_Y + 24, 72, 156), PANEL.lightened(0.04))
		x += 100.0
	draw_rect(Rect2(0, DADO_Y - 5, room_size.x, 9), WOOD_DARK)
	draw_line(Vector2(0, DADO_Y - 5), Vector2(room_size.x, DADO_Y - 5), WOOD, 1.0)
	draw_rect(Rect2(0, FLOOR_Y - 12, room_size.x, 12), WOOD_DARK)
	# Paler squares of paper where her pictures hung until this evening
	for patch: Rect2 in [Rect2(398, 150, 60, 80), Rect2(500, 176, 80, 104)]:
		draw_rect(patch, PAPER_WALL.lightened(0.07))
		draw_circle(Vector2(patch.get_center().x, patch.position.y - 8), 1.5, BRASS.darkened(0.3))


## Bare boards round the edge and a patterned Turkey carpet in the middle.
func _draw_carpet() -> void:
	draw_rect(Rect2(0, FLOOR_Y, room_size.x, room_size.y - FLOOR_Y), Color(0.12, 0.085, 0.06))
	for board_y: float in [556.0, 580.0, 612.0, 654.0]:
		draw_line(Vector2(0, board_y), Vector2(room_size.x, board_y), Color(0, 0, 0, 0.35), 1.0)
	_polygon([Vector2(30, 552), Vector2(1070, 552), Vector2(1150, 714), Vector2(-50, 714)], CARPET)
	draw_polyline(PackedVector2Array([Vector2(44, 560), Vector2(1056, 560), Vector2(1128, 706), Vector2(-28, 706),
		Vector2(44, 560)]), CARPET_GOLD, 2.0, true)
	draw_polyline(PackedVector2Array([Vector2(60, 566), Vector2(1040, 566), Vector2(1104, 698), Vector2(-4, 698),
		Vector2(60, 566)]), Color(0.1, 0.14, 0.3, 0.6), 3.0, true)
	# Rows of diamonds, larger towards the front
	var row_ys: Array[float] = [584.0, 626.0, 676.0]
	for row in range(row_ys.size()):
		var half := 10.0 + row * 4.0
		var spacing := 88.0 + row * 22.0
		var row_y := row_ys[row]
		var diamond_x := 80.0 + (row % 2) * spacing * 0.5
		while diamond_x < 1040.0:
			_polygon([Vector2(diamond_x, row_y - half * 0.55), Vector2(diamond_x + half, row_y),
				Vector2(diamond_x, row_y + half * 0.55), Vector2(diamond_x - half, row_y)], CARPET_GOLD)
			draw_circle(Vector2(diamond_x, row_y), 2.0, Color(0.1, 0.14, 0.3, 0.8))
			diamond_x += spacing


## The frame of the grey door to the ward stair, and the notice above it.
func _draw_ward_door() -> void:
	var frame := DOOR_RECT.grow(10)
	draw_rect(frame, GREY_PAINT.darkened(0.35))
	draw_rect(frame, Color(0.08, 0.09, 0.1), false, 2.0)
	draw_rect(DOOR_RECT, Color(0.04, 0.04, 0.05))
	var plate := Rect2(872, 288, 106, 22)
	draw_rect(plate, Color(0.88, 0.88, 0.82))
	draw_rect(plate, INK, false, 1.5)
	draw_string(ThemeDB.fallback_font, plate.position + Vector2(5, 15), "WARD 7 - MATRON ONLY", HORIZONTAL_ALIGNMENT_LEFT, -1, 8, INK)
	# A line of light under the door: someone is awake up there
	draw_rect(Rect2(DOOR_RECT.position.x, FLOOR_Y - 4, DOOR_RECT.size.x, 4), Color(0.9, 0.8, 0.5, 0.35))


## The black marble fireplace: a dying fire below, a clock and a candlestick on the mantelpiece.
func _draw_fireplace() -> void:
	draw_rect(HEARTH_RECT, MARBLE)
	draw_rect(HEARTH_RECT, Color(0.32, 0.32, 0.36), false, 2.0)
	var opening := Rect2(492, 420, 96, 120)
	draw_rect(opening.grow(5), Color(0.3, 0.24, 0.14))
	draw_rect(opening, Color(0.03, 0.02, 0.02))
	# Embers glowing behind the grate
	_glow(Vector2(540, 520), 14.0, 4, 12.0, Color(0.95, 0.35, 0.1, 0.07))
	_ellipse(Vector2(540, 532), Vector2(36, 6), Color(0.8, 0.25, 0.08, 0.6))
	# The hearth stone
	_polygon([Vector2(466, 540), Vector2(614, 540), Vector2(626, 558), Vector2(454, 558)], Color(0.27, 0.27, 0.3))
	_ellipse(Vector2(540, 550), Vector2(50, 5), Color(0.9, 0.4, 0.1, 0.12))
	# Mantel shelf
	draw_rect(MANTEL_RECT, MARBLE.lightened(0.12))
	draw_rect(Rect2(MANTEL_RECT.position.x, MANTEL_RECT.end.y - 3, MANTEL_RECT.size.x, 3), Color(0.08, 0.08, 0.1))
	# A brass candlestick at one end
	draw_rect(Rect2(476, 366, 14, 6), BRASS.darkened(0.2))
	draw_rect(Rect2(481, 346, 4, 20), BRASS)
	draw_rect(Rect2(480, 332, 6, 14), Color(0.9, 0.88, 0.78))
	# A black slate clock at the other, stopped at twenty to one
	draw_rect(Rect2(582, 342, 30, 30), Color(0.07, 0.07, 0.08))
	draw_circle(Vector2(597, 356), 10.0, Color(0.9, 0.88, 0.78))
	draw_line(Vector2(597, 356), Vector2(600, 349), INK, 1.5)
	draw_line(Vector2(597, 356), Vector2(590, 360), INK, 1.0)


## A low bookcase, half emptied. The bible box stands on its top.
func _draw_bookcase() -> void:
	draw_rect(BOOKCASE_RECT, WOOD_DARK)
	draw_rect(Rect2(BOOKCASE_RECT.position.x - 4, BOOKCASE_RECT.position.y, BOOKCASE_RECT.size.x + 8, 6), WOOD)
	for shelf_y: float in [386.0, 434.0, 482.0]:
		draw_rect(Rect2(BOOKCASE_RECT.position.x + 6, shelf_y, BOOKCASE_RECT.size.x - 12, 42), Color(0.07, 0.045, 0.03))
	# A few books left on the top shelf; the rest are already in the tea chest
	var spines: Array[Color] = [Color(0.4, 0.14, 0.12), Color(0.16, 0.24, 0.34), Color(0.3, 0.28, 0.14), Color(0.2, 0.2, 0.22)]
	for i in range(spines.size()):
		draw_rect(Rect2(626 + i * 11.0, 394 + (i % 2) * 4.0, 9, 34 - (i % 2) * 4.0), spines[i])
		draw_line(Vector2(627 + i * 11.0, 402), Vector2(634 + i * 11.0, 402), CARPET_GOLD, 1.0)
	_polygon([Vector2(674, 428), Vector2(686, 396), Vector2(694, 399), Vector2(683, 428)], Color(0.36, 0.3, 0.2))


## The hole in the wall where the safe sits, and the picture that used to hide it.
func _draw_safe_surround() -> void:
	draw_rect(SAFE_RECT.grow(5), Color(0.06, 0.06, 0.07))
	draw_rect(SAFE_RECT.grow(5), PAPER_WALL.lightened(0.1), false, 1.5)
	# The little landscape that covered it, swung aside on its hinge
	_polygon([Vector2(830, 250), Vector2(846, 244), Vector2(846, 330), Vector2(830, 326)], Color(0.5, 0.38, 0.18))
	_polygon([Vector2(833, 256), Vector2(843, 252), Vector2(843, 322), Vector2(833, 320)], Color(0.24, 0.3, 0.26))


## The shadow and plinth of the filing cabinet, and the box files stacked on top of it.
func _draw_cabinet_place() -> void:
	draw_rect(Rect2(388, 386, 80, 154), Color(0, 0, 0, 0.35))
	draw_rect(Rect2(388, 534, 80, 8), Color(0.1, 0.11, 0.11))
	_ellipse(Vector2(428, FLOOR_Y + 5), Vector2(46, 5), Color(0, 0, 0, 0.4))
	# Two box files tied up with tape, ready to go
	draw_rect(Rect2(398, 376, 60, 14), Color(0.3, 0.32, 0.26))
	draw_rect(Rect2(402, 362, 52, 14), Color(0.38, 0.34, 0.24))
	draw_line(Vector2(428, 362), Vector2(428, 390), Color(0.8, 0.74, 0.6), 1.5)
	draw_line(Vector2(398, 376), Vector2(458, 376), Color(0.12, 0.1, 0.08), 1.0)


## A bentwood hat stand with her felt hat and an umbrella. The carpet bag sits at its foot.
func _draw_hat_stand() -> void:
	_ellipse(Vector2(356, FLOOR_Y + 6), Vector2(30, 5), Color(0, 0, 0, 0.4))
	draw_rect(Rect2(353, 176, 6, 366), WOOD_DARK)
	draw_line(Vector2(354, 176), Vector2(354, 542), WOOD, 1.5)
	draw_circle(Vector2(356, 174), 5.0, WOOD)
	# Curved hooks at the top and feet at the bottom
	draw_arc(Vector2(342, 196), 12.0, 0.0, PI, 10, WOOD_DARK, 3.0, true)
	draw_arc(Vector2(370, 196), 12.0, 0.0, PI, 10, WOOD_DARK, 3.0, true)
	draw_arc(Vector2(342, 548), 14.0, PI, TAU, 10, WOOD_DARK, 4.0, true)
	draw_arc(Vector2(370, 548), 14.0, PI, TAU, 10, WOOD_DARK, 4.0, true)
	# A dark felt hat with a ribbon
	_ellipse(Vector2(334, 204), Vector2(18, 5), Color(0.1, 0.1, 0.14))
	_rounded_rect(Rect2(324, 188, 20, 16), Color(0.12, 0.12, 0.17), 6)
	draw_rect(Rect2(324, 199, 20, 3), Color(0.4, 0.12, 0.14))
	# A rolled umbrella hooked on the other side
	draw_arc(Vector2(378, 214), 5.0, PI, TAU, 8, WOOD, 2.5, true)
	draw_line(Vector2(373, 214), Vector2(371, 330), Color(0.07, 0.07, 0.09), 5.0)
	draw_line(Vector2(371, 330), Vector2(370, 344), BRASS.darkened(0.3), 2.0)
	# Shadow where the carpet bag stands
	_ellipse(Vector2(350, 640), Vector2(46, 5), Color(0, 0, 0, 0.4))


## The cheval glass: two posts, pivot knobs, feet, and the frame round the glass.
func _draw_swing_mirror() -> void:
	_ellipse(Vector2(205, FLOOR_Y + 10), Vector2(128, 7), Color(0, 0, 0, 0.4))
	# The stretcher that joins the two posts, low down
	draw_rect(Rect2(112, 504, 186, 8), WOOD_DARK)
	draw_line(Vector2(112, 505), Vector2(298, 505), WOOD, 1.0)
	for post_x: float in [100.0, 298.0]:
		draw_rect(Rect2(post_x, 182, 12, 360), WOOD_DARK)
		draw_rect(Rect2(post_x + 2, 182, 3, 360), WOOD)
		draw_circle(Vector2(post_x + 6, 178), 7.0, WOOD)
		draw_circle(Vector2(post_x + 4, 176), 2.0, WOOD.lightened(0.3))
		# Splayed foot standing on the floor
		_polygon([Vector2(post_x - 16, 554), Vector2(post_x + 28, 554), Vector2(post_x + 14, 536), Vector2(post_x - 2, 536)], WOOD_DARK)
		draw_line(Vector2(post_x - 14, 553), Vector2(post_x + 26, 553), WOOD, 1.0)
	# The frame and the glass (WallMirror paints the reflection over the glass)
	var frame := GLASS_RECT.grow(8)
	draw_rect(frame, WOOD)
	draw_rect(frame, WOOD_DARK, false, 2.0)
	draw_rect(GLASS_RECT.grow(2), BRASS.darkened(0.45))
	draw_rect(GLASS_RECT, Color(0.07, 0.09, 0.12))
	# Brass pivot knobs at mid-height
	for knob_x: float in [106.0, 304.0]:
		draw_circle(Vector2(knob_x, PIVOT_Y), 8.0, BRASS.darkened(0.4))
		draw_circle(Vector2(knob_x, PIVOT_Y), 6.0, BRASS)
		draw_circle(Vector2(knob_x - 2, PIVOT_Y - 2), 1.8, Color(1, 0.95, 0.8, 0.8))


## The big pedestal desk: telephone (receiver off), green lamp, and a drawer in each pedestal.
func _draw_desk() -> void:
	_ellipse(Vector2(DESK_FRONT_RECT.get_center().x, DESK_FRONT_RECT.end.y + 4), Vector2(140, 9), Color(0, 0, 0, 0.45))
	_ellipse(Vector2(900, 632), Vector2(30, 5), Color(0, 0, 0, 0.4))  # under the waste basket
	draw_rect(DESK_FRONT_RECT, WOOD)
	# The two pedestals with their lower drawers, and the kneehole between them
	for pedestal_x: float in [624.0, 760.0]:
		draw_rect(Rect2(pedestal_x, 496, 96, 108), WOOD_DARK, false, 2.0)
		for drawer_y: float in [534.0, 570.0]:
			draw_rect(Rect2(pedestal_x + 10, drawer_y, 76, 26), WOOD.darkened(0.2))
			draw_rect(Rect2(pedestal_x + 10, drawer_y, 76, 26), WOOD_DARK, false, 1.5)
			draw_circle(Vector2(pedestal_x + 48, drawer_y + 13), 3.0, BRASS)
	draw_rect(Rect2(724, 528, 32, 80), Color(0.05, 0.035, 0.025))
	draw_rect(DESK_TOP_RECT, WOOD.lightened(0.14))
	draw_rect(Rect2(DESK_TOP_RECT.position.x, DESK_TOP_RECT.end.y - 3, DESK_TOP_RECT.size.x, 3), WOOD_DARK)
	# The telephone: black base, dial, and an empty cradle. Its cord runs to the receiver.
	_polygon([Vector2(632, 478), Vector2(678, 478), Vector2(671, 456), Vector2(639, 456)], Color(0.06, 0.06, 0.07))
	draw_rect(Rect2(638, 446, 7, 11), Color(0.06, 0.06, 0.07))
	draw_rect(Rect2(665, 446, 7, 11), Color(0.06, 0.06, 0.07))
	draw_circle(Vector2(655, 467), 8.0, Color(0.8, 0.8, 0.76))
	draw_circle(Vector2(655, 467), 3.5, Color(0.06, 0.06, 0.07))
	draw_line(Vector2(640, 458), Vector2(670, 458), Color(1, 1, 1, 0.2), 1.0)
	draw_polyline(PackedVector2Array([Vector2(676, 474), Vector2(682, 477), Vector2(688, 474), Vector2(694, 477)]),
		Color(0.06, 0.06, 0.07), 1.5, true)
	# The green-shaded lamp and its pool of light
	_glow(Vector2(812, 452), 22.0, 4, 16.0, Color(0.95, 0.9, 0.55, 0.035))
	_polygon([Vector2(740, 478), Vector2(870, 478), Vector2(836, 448), Vector2(790, 448)], Color(1.0, 0.92, 0.6, 0.08))
	_ellipse(Vector2(812, 476), Vector2(13, 3), BRASS.darkened(0.2))
	draw_line(Vector2(812, 476), Vector2(812, 446), BRASS, 3.0)
	_polygon([Vector2(790, 446), Vector2(834, 446), Vector2(826, 428), Vector2(798, 428)], Color(0.1, 0.42, 0.26))
	draw_line(Vector2(800, 431), Vector2(824, 431), Color(0.5, 0.8, 0.6, 0.6), 1.5)
	draw_rect(Rect2(792, 446, 40, 2), Color(1.0, 0.95, 0.7))


## A small side table in front of the mirror. The tea caddy stands on it.
func _draw_side_table() -> void:
	_ellipse(Vector2(190, 694), Vector2(52, 5), Color(0, 0, 0, 0.4))
	for leg_x: float in [152.0, 222.0]:
		draw_rect(Rect2(leg_x, 617, 6, 76), WOOD_DARK)
	draw_rect(Rect2(156, 660, 68, 5), WOOD_DARK)
	draw_rect(Rect2(144, 610, 92, 7), WOOD.lightened(0.1))
	draw_rect(Rect2(144, 615, 92, 2), WOOD_DARK)
	# A lace mat under the caddy
	_ellipse(Vector2(190, 610), Vector2(36, 3), Color(0.9, 0.88, 0.8, 0.8))


## The little sewing table: one drawer, and a pin cushion, scissors and a reel on top.
func _draw_sewing_table() -> void:
	_ellipse(Vector2(500, 698), Vector2(54, 5), Color(0, 0, 0, 0.4))
	for leg_x: float in [460.0, 534.0]:
		draw_rect(Rect2(leg_x, 655, 6, 42), WOOD_DARK)
	draw_rect(Rect2(458, 625, 84, 30), WOOD)
	draw_rect(Rect2(458, 625, 84, 30), WOOD_DARK, false, 1.5)
	draw_rect(Rect2(450, 618, 100, 7), WOOD.lightened(0.14))
	draw_rect(Rect2(450, 623, 100, 2), WOOD_DARK)
	# The velvet pin cushion the hat pin is stuck in
	_ellipse(Vector2(500, 614), Vector2(13, 6), Color(0.5, 0.1, 0.14))
	_ellipse(Vector2(498, 612), Vector2(7, 2.5), Color(0.68, 0.2, 0.22))
	for pin_x: float in [491.0, 508.0]:
		draw_line(Vector2(pin_x, 612), Vector2(pin_x - 1, 605), Color(0.8, 0.8, 0.84), 1.0)
		draw_circle(Vector2(pin_x - 1, 605), 1.2, Color(0.9, 0.9, 0.92))
	# A cotton reel and a pair of scissors
	draw_rect(Rect2(460, 608, 10, 10), Color(0.85, 0.85, 0.8))
	draw_rect(Rect2(459, 610, 12, 6), Color(0.2, 0.25, 0.5))
	draw_line(Vector2(524, 616), Vector2(544, 612), Color(0.7, 0.72, 0.75), 1.5)
	draw_line(Vector2(524, 612), Vector2(544, 616), Color(0.7, 0.72, 0.75), 1.5)
	draw_arc(Vector2(522, 611), 2.5, 0.0, TAU, 8, Color(0.1, 0.1, 0.12), 1.2, true)
	draw_arc(Vector2(522, 617), 2.5, 0.0, TAU, 8, Color(0.1, 0.1, 0.12), 1.2, true)


## Under the objective list: a curtained window and a roped tea chest, half packed.
func _draw_packing() -> void:
	# The window, with the night and the moor outside
	draw_rect(Rect2(1066, 104, 132, 214), WOOD_DARK)
	draw_rect(Rect2(1074, 112, 116, 198), Color(0.03, 0.04, 0.08))
	draw_line(Vector2(1132, 112), Vector2(1132, 310), WOOD_DARK, 3.0)
	draw_line(Vector2(1074, 210), Vector2(1190, 210), WOOD_DARK, 3.0)
	draw_circle(Vector2(1160, 150), 7.0, Color(0.8, 0.82, 0.7, 0.5))
	for curtain_x: float in [1050.0, 1178.0]:
		draw_rect(Rect2(curtain_x, 98, 38, 240), Color(0.26, 0.09, 0.1))
		draw_line(Vector2(curtain_x + 12, 100), Vector2(curtain_x + 12, 336), Color(0.16, 0.05, 0.06), 2.0)
		draw_line(Vector2(curtain_x + 26, 100), Vector2(curtain_x + 26, 336), Color(0.16, 0.05, 0.06), 2.0)
	draw_rect(Rect2(1044, 94, 178, 6), BRASS.darkened(0.3))
	# The tea chest, roped, with the books from the bookcase in it
	_ellipse(Vector2(1110, 572), Vector2(80, 7), Color(0, 0, 0, 0.4))
	draw_rect(Rect2(1040, 478, 140, 92), Color(0.5, 0.4, 0.26))
	draw_rect(Rect2(1040, 478, 140, 92), Color(0.6, 0.62, 0.64), false, 3.0)
	draw_line(Vector2(1086, 478), Vector2(1086, 570), Color(0.8, 0.72, 0.5), 2.0)
	draw_line(Vector2(1134, 478), Vector2(1134, 570), Color(0.8, 0.72, 0.5), 2.0)
	draw_string(ThemeDB.fallback_font, Vector2(1090, 530), "E.V.", HORIZONTAL_ALIGNMENT_LEFT, -1, 16, INK)
	draw_rect(Rect2(1052, 466, 40, 12), Color(0.4, 0.14, 0.12))
	draw_rect(Rect2(1096, 462, 50, 16), Color(0.16, 0.24, 0.34))
