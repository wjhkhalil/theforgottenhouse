@tool
class_name LoftArt
extends RoomArt
## Placeholder drawing of House Two, Chapter Three: the loft above the boat shed,
## where Mara was kept. See room_art.gd for how to replace it with a real image.
##
## Layout: we look at the gable end of the loft. The roof slopes down on both
## sides, a round window in the gable lets the moonlight in, and a long tie
## beam crosses the loft (the bats sleep under it - BatColony draws them).
## Left: the open floor hatch with the top of the ladder, and the wooden post
## where Mara scratched one mark for every day. Middle: her straw mattress
## in the moonlight. Right: a shelf, a stool and a stack of crates.

const FLOOR_Y := 560.0
const RIDGE := Vector2(640, 40)
const EAVE_Y := 330.0
const WINDOW := Vector2(640, 250)
const WINDOW_RADIUS := 46.0
const BEAM_RECT := Rect2(110, 84, 1060, 18)
const POST_RECT := Rect2(404, 102, 32, 516)
const HATCH_RECT := Rect2(100, 618, 150, 70)
const WOOD := Color(0.3, 0.23, 0.17)
const WOOD_DARK := Color(0.16, 0.12, 0.09)
const WOOD_LIGHT := Color(0.42, 0.33, 0.24)
const MOON := Color(0.72, 0.8, 0.95)


func _draw_background() -> void:
	_draw_roof()
	_draw_gable_wall()
	_draw_window()
	_draw_floor()
	_draw_moonbeam()
	_draw_hatch()
	_draw_mattress()
	_draw_post()
	_draw_tie_beam()
	_draw_right_side()


func _draw_foreground() -> void:
	# The top of the ladder sticking up out of the hatch.
	for x: float in [HATCH_RECT.position.x + 34, HATCH_RECT.end.x - 34]:
		draw_rect(Rect2(x - 5, HATCH_RECT.position.y - 70, 10, 110), Color(0.36, 0.27, 0.18))
		draw_line(Vector2(x - 5, HATCH_RECT.position.y - 70), Vector2(x - 5, HATCH_RECT.position.y + 40), Color(0.5, 0.4, 0.28), 1.5)
	for y in [HATCH_RECT.position.y - 40, HATCH_RECT.position.y - 4]:
		draw_rect(Rect2(HATCH_RECT.position.x + 34, y, HATCH_RECT.size.x - 68, 7), Color(0.3, 0.22, 0.15))
	# Cobwebs in the top corners where the roof meets the beam.
	for corner in [Vector2(110, 102), Vector2(1170, 102)]:
		var direction := 1.0 if corner.x < 640 else -1.0
		for i in range(5):
			var angle := 0.15 + i * 0.32
			draw_line(corner, corner + Vector2(cos(angle) * direction, sin(angle)) * 90.0, Color(0.85, 0.85, 0.9, 0.18), 1.0)
		for ring in range(1, 5):
			var points := PackedVector2Array()
			for i in range(5):
				var angle := 0.15 + i * 0.32
				points.append(corner + Vector2(cos(angle) * direction, sin(angle)) * ring * 20.0)
			draw_polyline(points, Color(0.85, 0.85, 0.9, 0.14), 1.0)
	# A dust sheet thrown over the end of the crates, hanging in front of them.
	_polygon([Vector2(1180, 460), Vector2(1280, 448), Vector2(1280, 720), Vector2(1214, 720), Vector2(1196, 640),
		Vector2(1172, 600)], Color(0.62, 0.6, 0.56))
	draw_polyline(PackedVector2Array([Vector2(1200, 480), Vector2(1206, 560), Vector2(1230, 650), Vector2(1240, 720)]),
		Color(0.48, 0.46, 0.42), 2.0)
	_draw_vignette()


# ---------------------------------------------------------------------------

## The underside of the roof on both sides, with rafters running down to the eaves.
func _draw_roof() -> void:
	_vertical_gradient(Rect2(0, 0, room_size.x, FLOOR_Y), Color(0.07, 0.055, 0.05), Color(0.13, 0.1, 0.08))
	for side in [-1.0, 1.0]:
		for i in range(7):
			var top := RIDGE + Vector2(side * (10 + i * 28), i * 15)
			var bottom := Vector2(640 + side * (180 + i * 85), EAVE_Y + 30 + i * 4)
			draw_line(top, bottom, Color(0.2, 0.15, 0.11), 9.0)
			draw_line(top + Vector2(0, -3), bottom + Vector2(0, -3), Color(0.27, 0.21, 0.15), 1.5)
	# A few slates missing: slivers of night sky
	for gap in [Rect2(196, 160, 30, 6), Rect2(1032, 196, 24, 5), Rect2(890, 120, 18, 4)]:
		draw_rect(gap, Color(0.12, 0.16, 0.28))


## The gable wall at the back, made of vertical boards.
func _draw_gable_wall() -> void:
	var outline: Array[Vector2] = [Vector2(170, EAVE_Y), RIDGE + Vector2(0, 30), Vector2(1110, EAVE_Y),
		Vector2(1110, FLOOR_Y), Vector2(170, FLOOR_Y)]
	_polygon(outline, Color(0.2, 0.155, 0.12))
	var rng := RandomNumberGenerator.new()
	rng.seed = 1405
	var x := 170.0
	while x < 1110.0:
		var width := rng.randf_range(28.0, 36.0)
		var top_y := _gable_top(x + width / 2.0)
		var shade := rng.randf_range(-0.025, 0.025)
		draw_rect(Rect2(x + 1, top_y, width - 2, FLOOR_Y - top_y), Color(0.23 + shade, 0.18 + shade, 0.13 + shade))
		draw_line(Vector2(x, _gable_top(x)), Vector2(x, FLOOR_Y), Color(0.11, 0.08, 0.06), 2.0)
		x += width
	# The roof edge along the top of the gable
	draw_polyline(PackedVector2Array([Vector2(150, EAVE_Y + 6), RIDGE + Vector2(0, 26), Vector2(1130, EAVE_Y + 6)]), WOOD_DARK, 12.0)
	# Damp stains
	_ellipse(Vector2(300, 470), Vector2(40, 60), Color(0.08, 0.07, 0.06, 0.35))
	_ellipse(Vector2(1000, 380), Vector2(30, 45), Color(0.08, 0.07, 0.06, 0.3))


func _gable_top(x: float) -> float:
	var ridge_y := RIDGE.y + 30.0
	if x < 640.0:
		return lerpf(EAVE_Y, ridge_y, clampf((x - 170.0) / (640.0 - 170.0), 0.0, 1.0))
	return lerpf(ridge_y, EAVE_Y, clampf((x - 640.0) / (1110.0 - 640.0), 0.0, 1.0))


## The round window, with the moon and the lake far below.
func _draw_window() -> void:
	draw_circle(WINDOW, WINDOW_RADIUS + 9, WOOD_DARK)
	draw_circle(WINDOW, WINDOW_RADIUS, Color(0.06, 0.08, 0.16))
	draw_circle(WINDOW + Vector2(16, -16), 13, Color(0.92, 0.94, 1.0))
	draw_circle(WINDOW + Vector2(20, -19), 11, Color(0.06, 0.08, 0.16))  # crescent moon
	draw_rect(Rect2(WINDOW.x - WINDOW_RADIUS + 4, WINDOW.y + 14, WINDOW_RADIUS * 2 - 8, 6), Color(0.04, 0.05, 0.07))
	for i in range(4):
		draw_line(WINDOW + Vector2(-26 + i * 6, 26 + i * 3), WINDOW + Vector2(8 - i * 3, 26 + i * 3), Color(MOON, 0.3), 1.5)
	# Cross-shaped glazing bars, one pane broken
	draw_line(WINDOW + Vector2(-WINDOW_RADIUS, 0), WINDOW + Vector2(WINDOW_RADIUS, 0), WOOD_DARK, 5.0)
	draw_line(WINDOW + Vector2(0, -WINDOW_RADIUS), WINDOW + Vector2(0, WINDOW_RADIUS), WOOD_DARK, 5.0)
	_polygon([WINDOW + Vector2(-38, -20), WINDOW + Vector2(-20, -6), WINDOW + Vector2(-30, -2)], Color(0.02, 0.02, 0.04))
	# The sill and the latch the bedsheet rope is tied to
	draw_rect(Rect2(WINDOW.x - 66, WINDOW.y + WINDOW_RADIUS + 6, 132, 10), WOOD_LIGHT)
	draw_rect(Rect2(WINDOW.x + 40, WINDOW.y + 34, 10, 8), Color(0.45, 0.42, 0.38))


## Floorboards running away from us towards the gable wall.
func _draw_floor() -> void:
	_vertical_gradient(Rect2(0, FLOOR_Y, room_size.x, room_size.y - FLOOR_Y), Color(0.2, 0.15, 0.11), Color(0.29, 0.22, 0.16))
	var vanish := Vector2(640, 280)
	for i in range(-12, 13):
		var bottom := Vector2(640 + i * 92.0, room_size.y)
		var top := vanish.lerp(bottom, (FLOOR_Y - vanish.y) / (room_size.y - vanish.y))
		draw_line(top, bottom, Color(0.12, 0.09, 0.07), 2.0)
	for y: float in [588.0, 628.0, 680.0]:
		draw_line(Vector2(0, y), Vector2(room_size.x, y), Color(0.12, 0.09, 0.07, 0.4), 1.0)
	# The skirting where the floor meets the wall
	draw_rect(Rect2(0, FLOOR_Y - 4, room_size.x, 8), WOOD_DARK)


## Moonlight falling from the window across the floor.
func _draw_moonbeam() -> void:
	var beam := PackedVector2Array([WINDOW + Vector2(-34, 30), WINDOW + Vector2(34, -10), Vector2(820, 700), Vector2(560, 700)])
	draw_polygon(beam, PackedColorArray([Color(MOON, 0.16), Color(MOON, 0.16), Color(MOON, 0.03), Color(MOON, 0.03)]))
	_ellipse(Vector2(690, 670), Vector2(150, 34), Color(MOON, 0.07))


## The open hatch in the floor, with the boat shed lamp glowing below.
func _draw_hatch() -> void:
	draw_rect(HATCH_RECT.grow(6), WOOD_DARK)
	_vertical_gradient(HATCH_RECT, Color(0.03, 0.02, 0.02), Color(0.2, 0.14, 0.08))
	_ellipse(HATCH_RECT.get_center() + Vector2(0, 26), Vector2(50, 10), Color(1.0, 0.75, 0.4, 0.25))
	# The trapdoor itself, thrown back on its hinges
	_polygon([HATCH_RECT.position + Vector2(-6, -6), HATCH_RECT.position + Vector2(HATCH_RECT.size.x + 6, -6),
		HATCH_RECT.position + Vector2(HATCH_RECT.size.x - 4, -46), HATCH_RECT.position + Vector2(4, -46)], WOOD)
	draw_line(HATCH_RECT.position + Vector2(10, -26), HATCH_RECT.position + Vector2(HATCH_RECT.size.x - 10, -26), WOOD_DARK, 2.0)
	# The bolt is on the outside: the hatch was locked from below.
	draw_rect(Rect2(HATCH_RECT.position.x + 60, HATCH_RECT.position.y - 40, 30, 7), Color(0.4, 0.38, 0.36))


## Mara's straw mattress and a thin grey blanket.
func _draw_mattress() -> void:
	_ellipse(Vector2(555, 640), Vector2(120, 10), Color(0, 0, 0, 0.35))
	_polygon([Vector2(458, 588), Vector2(650, 588), Vector2(672, 640), Vector2(440, 640)], Color(0.6, 0.52, 0.34))
	_polygon([Vector2(440, 640), Vector2(672, 640), Vector2(672, 650), Vector2(440, 650)], Color(0.45, 0.38, 0.24))
	# Straw poking out
	var rng := RandomNumberGenerator.new()
	rng.seed = 88
	for i in range(14):
		var start := Vector2(rng.randf_range(450, 660), rng.randf_range(636, 648))
		draw_line(start, start + Vector2(rng.randf_range(-6, 6), rng.randf_range(4, 10)), Color(0.78, 0.68, 0.38), 1.0)
	# Blanket, and a hollow in the pillow
	_polygon([Vector2(520, 592), Vector2(652, 592), Vector2(672, 640), Vector2(540, 640)], Color(0.38, 0.38, 0.4))
	draw_line(Vector2(536, 606), Vector2(656, 606), Color(0.3, 0.3, 0.32), 1.5)
	_ellipse(Vector2(484, 604), Vector2(26, 10), Color(0.72, 0.68, 0.6))


## The wooden post: one scratched mark for every day Mara spent up here.
func _draw_post() -> void:
	draw_rect(POST_RECT, WOOD)
	draw_rect(Rect2(POST_RECT.position, Vector2(6, POST_RECT.size.y)), WOOD_LIGHT)
	draw_rect(Rect2(POST_RECT.end.x - 6, POST_RECT.position.y, 6, POST_RECT.size.y), WOOD_DARK)
	var scratch := Color(0.72, 0.62, 0.48)
	# The date she came, carved at the top: 14.5.87
	_draw_carved_text(Vector2(POST_RECT.position.x + 2, 234), "14.5.87", scratch, 1.3)
	# Rows of tally marks, five to a group
	for row in range(14):
		var y := 262.0 + row * 12.0
		for group in range(2):
			var x := POST_RECT.position.x + 6 + group * 12
			for mark in range(4):
				draw_line(Vector2(x + mark * 2.2, y), Vector2(x + mark * 2.2, y + 8), scratch, 1.0)
			draw_line(Vector2(x - 1, y + 7), Vector2(x + 9, y + 1), scratch, 1.0)


## Very small scratched digits, drawn with lines so they work without a font.
func _draw_carved_text(at: Vector2, text: String, color: Color, text_scale: float = 1.0) -> void:
	var segments := {
		"0": [[0, 0, 4, 0], [4, 0, 4, 8], [4, 8, 0, 8], [0, 8, 0, 0]],
		"1": [[2, 0, 2, 8], [1, 1, 2, 0]],
		"4": [[0, 0, 0, 4], [0, 4, 4, 4], [3, 0, 3, 8]],
		"5": [[4, 0, 0, 0], [0, 0, 0, 4], [0, 4, 4, 4], [4, 4, 4, 8], [4, 8, 0, 8]],
		"7": [[0, 0, 4, 0], [4, 0, 1, 8]],
		"8": [[0, 0, 4, 0], [4, 0, 4, 8], [4, 8, 0, 8], [0, 8, 0, 0], [0, 4, 4, 4]],
		".": [[1, 7, 1.5, 8]],
	}
	var x := at.x
	for character in text:
		for line: Array in segments.get(character, []):
			draw_line(Vector2(x + line[0] * text_scale, at.y + line[1] * text_scale),
				Vector2(x + line[2] * text_scale, at.y + line[3] * text_scale), color, 1.2)
		x += (2.5 if character == "." else 3.6) * text_scale


## The long tie beam across the loft: the bats hang underneath it.
func _draw_tie_beam() -> void:
	draw_rect(BEAM_RECT.grow_individual(0, 0, 0, 4), WOOD_DARK)
	draw_rect(BEAM_RECT, Color(0.26, 0.2, 0.15))
	draw_line(BEAM_RECT.position, Vector2(BEAM_RECT.end.x, BEAM_RECT.position.y), WOOD_LIGHT, 1.5)
	# Droppings streaked down the gable wall under the colony
	for x: float in [235.0, 505.0, 775.0, 1040.0]:
		_ellipse(Vector2(x, FLOOR_Y + 8), Vector2(26, 5), Color(0.12, 0.11, 0.1, 0.5))


## The shelf, the stool and the crates on the right.
func _draw_right_side() -> void:
	# Shelf on brackets
	draw_rect(Rect2(820, 400, 150, 9), WOOD_LIGHT)
	for x: float in [834.0, 952.0]:
		_polygon([Vector2(x, 409), Vector2(x + 6, 409), Vector2(x + 6, 432), Vector2(x, 420)], WOOD_DARK)
	# A row of empty jars beside the tin
	for i in range(2):
		draw_rect(Rect2(918 + i * 20, 384, 14, 16), Color(0.6, 0.7, 0.75, 0.35))
	# A three-legged stool
	_polygon([Vector2(764, 582), Vector2(836, 582), Vector2(832, 592), Vector2(768, 592)], WOOD_LIGHT)
	for leg in [[772.0, 760.0], [800.0, 800.0], [828.0, 840.0]]:
		draw_line(Vector2(leg[0], 592), Vector2(leg[1], 652), WOOD_DARK, 5.0)
	# Stacked crates
	for crate in [Rect2(1030, 500, 140, 112), Rect2(1050, 462, 96, 40)]:
		draw_rect(crate, Color(0.34, 0.26, 0.17))
		draw_rect(crate.grow(-4), Color(0.2, 0.15, 0.1), false, 2.0)
		draw_line(crate.position + Vector2(4, 4), crate.end - Vector2(4, 4), Color(0.2, 0.15, 0.1), 2.0)
	# Stencil on the big crate
	draw_rect(Rect2(1062, 556, 40, 4), Color(0.12, 0.09, 0.06, 0.6))
