@tool
class_name WashroomArt
extends RoomArt
## Placeholder drawing of the Chapter Five washroom.
## See room_art.gd for how to replace it with a real image.
##
## A bright, clean washroom under thick steam. Layout (left to right):
## a bathrobe on a hook, a claw-foot bathtub with running brass taps under a
## frosted window, a pedestal basin with a fogged mirror and two wall lamps,
## the medicine cabinet, a shelf of bottles over a towel rail, a laundry
## basket and the door (behind the objective list).

const FLOOR_Y := 470.0
const TILE := Color(0.94, 0.95, 0.91)
const GROUT := Color(0.76, 0.79, 0.75)
const GREEN_TILE := Color(0.56, 0.74, 0.64)
const GREEN_DARK := Color(0.38, 0.55, 0.46)
const PORCELAIN := Color(0.97, 0.97, 0.94)
const PORCELAIN_SHADE := Color(0.8, 0.82, 0.8)
const BATH_PAINT := Color(0.3, 0.46, 0.4)
const BRASS := Color(0.84, 0.67, 0.3)
const BRASS_DARK := Color(0.56, 0.42, 0.17)
const LAMP_GLOW := Color(1.0, 0.9, 0.65, 0.035)
const BATH_RIM_CENTER := Vector2(290, 392)
const BATH_RIM_RADIUS := Vector2(182, 16)


func _draw_background() -> void:
	_draw_wall()
	_draw_window()
	_draw_door()
	_draw_floor()
	_draw_bathrobe()
	_draw_bathtub()
	_draw_bath_mat()
	_draw_mirror()
	_draw_wall_lamps()
	_draw_basin()
	_draw_cabinet_wall()
	_draw_bottle_shelf()
	_draw_towel_rail()
	_draw_basket_corner()


func _draw_foreground() -> void:
	# The front of the bath's rolled rim hides the bottom of the duck.
	var rim: Array[Vector2] = [Vector2(BATH_RIM_CENTER.x + BATH_RIM_RADIUS.x, BATH_RIM_CENTER.y)]
	for i in range(9):
		var angle := i / 8.0 * 0.62
		rim.append(BATH_RIM_CENTER + Vector2(cos(angle) * BATH_RIM_RADIUS.x, sin(angle) * BATH_RIM_RADIUS.y))
	rim.append(Vector2(rim[rim.size() - 1].x, BATH_RIM_CENTER.y + 3))
	_polygon(rim, PORCELAIN)
	# The soap dish's wire lip in front of the tiny key.
	_polygon([Vector2(700, 397), Vector2(734, 397), Vector2(730, 403), Vector2(704, 403)], BRASS)
	draw_line(Vector2(700, 397), Vector2(734, 397), Color(1, 0.95, 0.75), 1.0)
	draw_line(Vector2(704, 403), Vector2(730, 403), BRASS_DARK, 1.5)
	# A little cobalt bottle stands in front of the perfume.
	_draw_bottle(Rect2(896, 334, 12, 16), Color(0.18, 0.3, 0.62, 0.95))
	# Wisps of steam rising from the bath
	for wisp: Vector2 in [Vector2(200, 360), Vector2(260, 340), Vector2(330, 352)]:
		_ellipse(wisp, Vector2(40, 14), Color(1, 1, 1, 0.08))
	_draw_vignette()


# ---------------------------------------------------------------------------

func _draw_wall() -> void:
	draw_rect(Rect2(0, 0, room_size.x, FLOOR_Y), GROUT)
	var rng := RandomNumberGenerator.new()
	rng.seed = 55
	# Upper wall: small square white tiles
	var tile := 32.0
	for row in range(8):
		for column in range(int(room_size.x / tile) + 1):
			var shade := rng.randf_range(-0.035, 0.015)
			var rect := Rect2(column * tile + 1, row * tile + 1, tile - 2, tile - 2)
			draw_rect(rect, Color(TILE.r + shade, TILE.g + shade, TILE.b + shade))
			draw_line(rect.position + Vector2(2, 2), rect.position + Vector2(tile - 6, 2), Color(1, 1, 1, 0.5), 1.0)
	# A green border and green metro tiles below it
	draw_rect(Rect2(0, 256, room_size.x, 14), GREEN_DARK)
	draw_rect(Rect2(0, 258, room_size.x, 3), Color(0.62, 0.78, 0.68))
	for row in range(10):
		var offset := 20.0 if row % 2 == 1 else 0.0
		var x := -offset
		while x < room_size.x:
			var shade := rng.randf_range(-0.03, 0.03)
			var rect := Rect2(x + 1, 271 + row * 20, 38, 18)
			draw_rect(rect, Color(GREEN_TILE.r + shade, GREEN_TILE.g + shade, GREEN_TILE.b + shade))
			draw_line(rect.position + Vector2(2, 2), rect.position + Vector2(34, 2), Color(1, 1, 1, 0.3), 1.0)
			x += 40.0
	# A couple of cracked tiles
	draw_polyline(PackedVector2Array([Vector2(482, 96), Vector2(490, 110), Vector2(486, 124)]), Color(0.5, 0.52, 0.5), 1.0)
	draw_polyline(PackedVector2Array([Vector2(1004, 300), Vector2(996, 318), Vector2(1002, 330)]), Color(0.25, 0.35, 0.3), 1.0)
	# Skirting
	draw_rect(Rect2(0, FLOOR_Y - 8, room_size.x, 8), GREEN_DARK)
	# Soft ceiling light from above
	_glow(Vector2(640, 0), 60, 10, 40, Color(1, 0.96, 0.85, 0.03))


func _draw_window() -> void:
	# Small frosted window above the bath, running with condensation.
	draw_rect(Rect2(244, 92, 128, 152), Color(0.86, 0.86, 0.82))
	draw_rect(Rect2(244, 92, 128, 152), Color(0.6, 0.62, 0.6), false, 2.0)
	_vertical_gradient(Rect2(254, 102, 108, 132), Color(0.66, 0.74, 0.82), Color(0.8, 0.85, 0.88))
	draw_line(Vector2(308, 102), Vector2(308, 234), Color(0.86, 0.86, 0.82), 6.0)
	draw_line(Vector2(254, 168), Vector2(362, 168), Color(0.86, 0.86, 0.82), 6.0)
	var rng := RandomNumberGenerator.new()
	rng.seed = 7
	for i in range(14):
		var top := Vector2(rng.randf_range(258, 358), rng.randf_range(106, 200))
		draw_line(top, top + Vector2(0, rng.randf_range(8, 30)), Color(1, 1, 1, 0.35), 1.5)
	# Sill
	draw_rect(Rect2(236, 244, 144, 8), Color(0.95, 0.95, 0.92))
	draw_rect(Rect2(236, 250, 144, 2), Color(0, 0, 0, 0.15))


func _draw_door() -> void:
	# The door to the landing (mostly behind the objective list).
	draw_rect(Rect2(1096, 104, 140, FLOOR_Y - 104), Color(0.9, 0.9, 0.86))
	draw_rect(Rect2(1104, 112, 124, FLOOR_Y - 112), Color(0.82, 0.83, 0.79))
	for panel: Rect2 in [Rect2(1116, 126, 100, 130), Rect2(1116, 278, 100, 170)]:
		draw_rect(panel, Color(0.88, 0.88, 0.84))
		draw_rect(panel, Color(0.7, 0.71, 0.68), false, 2.0)
	draw_circle(Vector2(1120, 300), 6, BRASS)
	draw_rect(Rect2(1116, 314, 8, 12), BRASS_DARK)


func _draw_floor() -> void:
	draw_rect(Rect2(0, FLOOR_Y, room_size.x, room_size.y - FLOOR_Y), Color(0.93, 0.93, 0.9))
	# Chequered tiles in gentle perspective
	var rows: Array[float] = [470.0, 492.0, 518.0, 548.0, 582.0, 620.0, 662.0, 708.0, 760.0]
	var width := 64.0
	for row in range(rows.size() - 1):
		var top := rows[row]
		var bottom := rows[row + 1]
		var top_scale := (top - 100.0) / (FLOOR_Y - 100.0)
		var bottom_scale := (bottom - 100.0) / (FLOOR_Y - 100.0)
		for column in range(-12, 12):
			if posmod(row + column, 2) == 0:
				continue
			_polygon([Vector2(640 + column * width * top_scale, top), Vector2(640 + (column + 1) * width * top_scale, top),
				Vector2(640 + (column + 1) * width * bottom_scale, bottom), Vector2(640 + column * width * bottom_scale, bottom)],
				Color(0.4, 0.56, 0.48))
	_vertical_gradient(Rect2(0, FLOOR_Y, room_size.x, 24), Color(0, 0, 0, 0.18), Color(0, 0, 0, 0))
	# Wet patches and the lamp reflected in the polished floor
	_ellipse(Vector2(640, 540), Vector2(70, 12), Color(1, 1, 1, 0.12))
	_ellipse(Vector2(470, 600), Vector2(36, 9), Color(0.75, 0.88, 0.95, 0.35))
	_ellipse(Vector2(560, 650), Vector2(22, 6), Color(0.75, 0.88, 0.95, 0.3))
	for sud: Vector2 in [Vector2(446, 586), Vector2(452, 592), Vector2(508, 606), Vector2(500, 612)]:
		draw_circle(sud, 2.5, Color(1, 1, 1, 0.7))


func _draw_bathrobe() -> void:
	# A towelling robe on a brass hook by the window.
	draw_circle(Vector2(74, 140), 5, BRASS)
	var robe := Color(0.86, 0.9, 0.86)
	_polygon([Vector2(60, 140), Vector2(90, 140), Vector2(112, 200), Vector2(118, 380),
		Vector2(34, 380), Vector2(40, 200)], robe)
	_polygon([Vector2(60, 140), Vector2(74, 146), Vector2(66, 260), Vector2(44, 210)], Color(0.74, 0.8, 0.75))
	draw_line(Vector2(42, 262), Vector2(112, 262), Color(0.7, 0.76, 0.7), 5.0)
	draw_line(Vector2(96, 262), Vector2(104, 312), Color(0.7, 0.76, 0.7), 4.0)
	for x: float in [56.0, 80.0, 102.0]:
		draw_line(Vector2(x, 270), Vector2(x + 2, 376), Color(0, 0, 0, 0.06), 3.0)


func _draw_bathtub() -> void:
	_ellipse(Vector2(290, 550), Vector2(205, 12), Color(0, 0, 0, 0.22))
	# Brass claw feet
	for foot_x: float in [162.0, 418.0]:
		_polygon([Vector2(foot_x - 14, 498), Vector2(foot_x + 14, 498), Vector2(foot_x + 18, 538),
			Vector2(foot_x + 8, 546), Vector2(foot_x - 8, 546), Vector2(foot_x - 18, 538)], BRASS_DARK)
		draw_line(Vector2(foot_x - 7, 502), Vector2(foot_x - 10, 536), BRASS, 3.0)
		for toe: float in [-12.0, 0.0, 12.0]:
			draw_circle(Vector2(foot_x + toe, 544), 4.5, BRASS)
	# Painted outside of the tub
	_polygon([Vector2(110, 392), Vector2(470, 392), Vector2(464, 432), Vector2(448, 478),
		Vector2(420, 508), Vector2(160, 508), Vector2(132, 478), Vector2(116, 432)], BATH_PAINT)
	_polygon([Vector2(110, 392), Vector2(160, 392), Vector2(170, 508), Vector2(160, 508), Vector2(132, 478), Vector2(116, 432)],
		BATH_PAINT.darkened(0.2))
	draw_polyline(PackedVector2Array([Vector2(130, 412), Vector2(140, 462), Vector2(170, 494),
		Vector2(410, 494), Vector2(440, 462), Vector2(450, 412)]), BRASS, 1.5)
	draw_line(Vector2(380, 404), Vector2(436, 412), Color(1, 1, 1, 0.12), 6.0)
	# Rolled rim, hot water and a few bubbles
	_ellipse(BATH_RIM_CENTER + Vector2(0, 2), BATH_RIM_RADIUS, PORCELAIN_SHADE)
	_ellipse(BATH_RIM_CENTER, BATH_RIM_RADIUS, PORCELAIN)
	_ellipse(BATH_RIM_CENTER + Vector2(0, -1), Vector2(168, 10), Color(0.62, 0.78, 0.82))
	_ellipse(BATH_RIM_CENTER + Vector2(10, 0), Vector2(140, 6), Color(0.72, 0.86, 0.9))
	for bubble: Vector2 in [Vector2(200, 392), Vector2(214, 389), Vector2(330, 393), Vector2(346, 390)]:
		draw_circle(bubble, 3.0, Color(1, 1, 1, 0.7))
	# A yellow sponge on the rim, next to where the duck sits
	_ellipse(Vector2(404, 388), Vector2(13, 7), Color(0.86, 0.68, 0.24))
	_ellipse(Vector2(403, 386), Vector2(11, 5), Color(0.95, 0.8, 0.36))
	for hole: Vector2 in [Vector2(398, 385), Vector2(406, 387), Vector2(410, 384)]:
		draw_circle(hole, 1.2, Color(0.78, 0.58, 0.18))
	# Brass pillar taps and a gooseneck spout with hot water running
	for tap_x: float in [124.0, 150.0]:
		draw_rect(Rect2(tap_x - 4, 366, 8, 26), BRASS)
		draw_rect(Rect2(tap_x - 4, 366, 2, 26), Color(1, 0.92, 0.7))
		draw_line(Vector2(tap_x - 9, 364), Vector2(tap_x + 9, 364), BRASS_DARK, 3.0)
		draw_circle(Vector2(tap_x, 364), 3.0, Color(0.85, 0.2, 0.2) if tap_x < 140.0 else Color(0.25, 0.4, 0.8))
	draw_polyline(PackedVector2Array([Vector2(137, 392), Vector2(137, 350), Vector2(145, 341),
		Vector2(160, 341), Vector2(168, 349), Vector2(168, 358)]), BRASS, 5.0)
	draw_line(Vector2(168, 360), Vector2(168, 388), Color(0.85, 0.94, 1, 0.75), 3.0)
	_ellipse(Vector2(168, 389), Vector2(9, 3), Color(1, 1, 1, 0.6))


func _draw_bath_mat() -> void:
	_polygon([Vector2(196, 572), Vector2(392, 572), Vector2(402, 622), Vector2(186, 622)], Color(0.88, 0.74, 0.7))
	_polygon([Vector2(204, 578), Vector2(384, 578), Vector2(392, 616), Vector2(196, 616)], Color(0.93, 0.82, 0.78))
	for i in range(14):
		var x := 192.0 + i * 15.0
		draw_line(Vector2(x, 622), Vector2(x - 1, 630), Color(0.88, 0.74, 0.7), 2.0)


func _draw_mirror() -> void:
	# Brass-framed mirror above the basin, fogged over by the steam.
	draw_rect(Rect2(578, 140, 124, 176), BRASS_DARK)
	draw_rect(Rect2(582, 144, 116, 168), BRASS)
	_vertical_gradient(Rect2(588, 150, 104, 156), Color(0.82, 0.85, 0.86), Color(0.74, 0.78, 0.8))
	# A streak wiped clear shows the dim reflection behind
	_polygon([Vector2(596, 236), Vector2(684, 214), Vector2(686, 238), Vector2(598, 262)], Color(0.48, 0.55, 0.58, 0.7))
	# A letter written in the steam
	draw_polyline(PackedVector2Array([Vector2(618, 200), Vector2(624, 172), Vector2(636, 192),
		Vector2(648, 172), Vector2(654, 200)]), Color(0.55, 0.6, 0.63, 0.8), 3.0)
	for drip: Vector2 in [Vector2(618, 200), Vector2(654, 200), Vector2(640, 250)]:
		draw_line(drip, drip + Vector2(0, 16), Color(0.55, 0.6, 0.63, 0.6), 1.5)
	# Glass shelf with a tooth mug
	draw_rect(Rect2(586, 322, 108, 5), Color(0.75, 0.88, 0.9, 0.85))
	draw_rect(Rect2(586, 327, 108, 2), Color(0, 0, 0, 0.15))
	for bracket_x: float in [592.0, 688.0]:
		draw_line(Vector2(bracket_x, 327), Vector2(bracket_x, 340), BRASS_DARK, 3.0)
	draw_rect(Rect2(600, 300, 14, 22), Color(0.82, 0.9, 0.92, 0.85))
	draw_line(Vector2(605, 304), Vector2(602, 288), Color(0.85, 0.35, 0.35), 2.5)
	draw_line(Vector2(610, 304), Vector2(614, 290), Color(0.35, 0.55, 0.8), 2.5)


func _draw_wall_lamps() -> void:
	for lamp: Vector2 in [Vector2(556, 192), Vector2(724, 192)]:
		_glow(lamp, 10, 9, 11, LAMP_GLOW)
		draw_line(lamp + Vector2(0, 26), lamp + Vector2(0, 8), BRASS_DARK, 3.0)
		draw_rect(Rect2(lamp.x - 6, lamp.y + 24, 12, 6), BRASS)
		# Frosted tulip shade
		_polygon([lamp + Vector2(-10, -12), lamp + Vector2(10, -12), lamp + Vector2(7, 8), lamp + Vector2(-7, 8)],
			Color(1, 0.97, 0.86))
		_ellipse(lamp + Vector2(0, -12), Vector2(10, 3), Color(1, 1, 0.94))
		draw_circle(lamp + Vector2(0, -2), 4, Color(1, 0.93, 0.7))


func _draw_basin() -> void:
	_ellipse(Vector2(640, 480), Vector2(44, 6), Color(0, 0, 0, 0.2))
	# Pedestal
	_polygon([Vector2(626, 412), Vector2(654, 412), Vector2(664, 474), Vector2(674, 480),
		Vector2(606, 480), Vector2(616, 474)], PORCELAIN)
	_polygon([Vector2(644, 412), Vector2(654, 412), Vector2(664, 474), Vector2(674, 480), Vector2(650, 480)], PORCELAIN_SHADE)
	# Bowl and rim
	_polygon([Vector2(564, 392), Vector2(716, 392), Vector2(708, 406), Vector2(682, 422),
		Vector2(598, 422), Vector2(572, 406)], PORCELAIN)
	_polygon([Vector2(682, 422), Vector2(708, 406), Vector2(716, 392), Vector2(690, 404)], PORCELAIN_SHADE)
	_ellipse(Vector2(640, 392), Vector2(78, 10), PORCELAIN)
	_ellipse(Vector2(640, 393), Vector2(62, 6), Color(0.84, 0.86, 0.85))
	draw_circle(Vector2(640, 394), 2.5, Color(0.5, 0.5, 0.48))
	# Brass taps
	for tap_x: float in [620.0, 660.0]:
		draw_rect(Rect2(tap_x - 3, 374, 6, 12), BRASS)
		draw_line(Vector2(tap_x - 7, 373), Vector2(tap_x + 7, 373), BRASS_DARK, 3.0)
	draw_polyline(PackedVector2Array([Vector2(640, 386), Vector2(640, 376), Vector2(646, 378)]), BRASS, 4.0)
	# Brass soap dish hooked over the right of the rim (the key lies in it)
	draw_line(Vector2(712, 386), Vector2(716, 396), BRASS_DARK, 2.0)
	_ellipse(Vector2(717, 397), Vector2(18, 6), BRASS_DARK)
	_ellipse(Vector2(717, 395), Vector2(15, 4), Color(0.88, 0.9, 0.8))


func _draw_cabinet_wall() -> void:
	# A brass name plate and hooks around the medicine cabinet
	draw_rect(Rect2(782, 286, 36, 8), BRASS)
	draw_rect(Rect2(784, 288, 32, 4), BRASS_DARK)


func _draw_bottle_shelf() -> void:
	# Painted shelf on two brackets, crowded with bottles
	draw_rect(Rect2(844, 350, 146, 7), Color(0.92, 0.92, 0.88))
	draw_rect(Rect2(844, 357, 146, 3), Color(0, 0, 0, 0.18))
	for bracket_x: float in [856.0, 976.0]:
		_polygon([Vector2(bracket_x - 3, 360), Vector2(bracket_x + 3, 360), Vector2(bracket_x + 3, 384)], Color(0.8, 0.8, 0.76))
	_draw_bottle(Rect2(852, 306, 16, 44), Color(0.5, 0.3, 0.14, 0.95))
	_draw_bottle(Rect2(872, 318, 14, 32), Color(0.92, 0.68, 0.78, 0.9))
	_draw_bottle(Rect2(928, 300, 16, 50), Color(0.3, 0.52, 0.36, 0.95))
	_draw_bottle(Rect2(948, 322, 20, 28), Color(0.88, 0.9, 0.92, 0.85))
	_draw_bottle(Rect2(970, 330, 12, 20), Color(0.86, 0.62, 0.72, 0.9))


func _draw_bottle(rect: Rect2, color: Color) -> void:
	var neck := rect.size.x * 0.3
	draw_rect(Rect2(rect.position.x, rect.position.y + rect.size.y * 0.3, rect.size.x, rect.size.y * 0.7), color)
	_polygon([Vector2(rect.position.x, rect.position.y + rect.size.y * 0.3 + 1),
		Vector2(rect.position.x + rect.size.x * 0.5 - neck * 0.5, rect.position.y + rect.size.y * 0.16),
		Vector2(rect.position.x + rect.size.x * 0.5 + neck * 0.5, rect.position.y + rect.size.y * 0.16),
		Vector2(rect.end.x, rect.position.y + rect.size.y * 0.3 + 1)], color)
	draw_rect(Rect2(rect.position.x + rect.size.x * 0.5 - neck * 0.5, rect.position.y, neck, rect.size.y * 0.17),
		Color(0.55, 0.4, 0.25))
	draw_line(Vector2(rect.position.x + 2.5, rect.position.y + rect.size.y * 0.35),
		Vector2(rect.position.x + 2.5, rect.end.y - 2), Color(1, 1, 1, 0.4), 1.5)


func _draw_towel_rail() -> void:
	# Brass rail with two towels hanging from it
	for end_x: float in [860.0, 988.0]:
		draw_circle(Vector2(end_x, 410), 4, BRASS_DARK)
	_polygon([Vector2(870, 408), Vector2(920, 408), Vector2(918, 462), Vector2(872, 462)], Color(0.96, 0.96, 0.93))
	_polygon([Vector2(926, 408), Vector2(980, 408), Vector2(978, 458), Vector2(928, 458)], Color(0.86, 0.7, 0.66))
	for stripe_y: float in [446.0, 452.0]:
		draw_line(Vector2(872, stripe_y), Vector2(918, stripe_y), GREEN_DARK, 2.0)
		draw_line(Vector2(928, stripe_y - 4), Vector2(978, stripe_y - 4), Color(0.96, 0.92, 0.86), 2.0)
	draw_line(Vector2(860, 410), Vector2(988, 410), BRASS, 4.0)
	draw_line(Vector2(860, 409), Vector2(988, 409), Color(1, 0.92, 0.7), 1.0)


func _draw_basket_corner() -> void:
	# A damp towel dropped on the floor beside the laundry basket
	_ellipse(Vector2(1080, 600), Vector2(56, 8), Color(0, 0, 0, 0.12))
	_polygon([Vector2(1140, 610), Vector2(1196, 596), Vector2(1232, 614), Vector2(1214, 636), Vector2(1150, 632)],
		Color(0.96, 0.96, 0.93))
	draw_polyline(PackedVector2Array([Vector2(1150, 620), Vector2(1190, 610), Vector2(1222, 622)]), Color(0.8, 0.82, 0.8), 2.0)
