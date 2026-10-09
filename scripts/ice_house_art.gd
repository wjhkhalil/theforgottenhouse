@tool
class_name IceHouseArt
extends RoomArt
## Placeholder drawing of House Two, Chapter Six: the old ice house on the far
## shore of Blackwater Lake, where Mara sheltered on the night of 2 October 1988.
## See room_art.gd for how to replace it with a real image.
##
## Layout: we stand inside a round brick ice house and look at the back wall.
## The domed brick roof curves over the top, and cold pale-blue daylight falls
## through an iron grating at the top of the dome. Left: the heavy door, its
## bar broken, with the ice company's name painted above it. Middle: straw
## bales where Mara lay, a row of tool pegs, the cutters' tool locker and a
## drain in the floor. Right: wooden shelves stacked with blocks of lake ice.

const FLOOR_Y := 548.0
## The back wall is the inside of an arch: centre and radii of that arch.
const ARCH_CENTRE := Vector2(640, 580)
const ARCH_RADIUS := Vector2(620, 440)
const GRATING := Vector2(640, 92)
const DOOR_RECT := Rect2(170, 340, 130, 208)
const DRAIN := Vector2(600, 664)
const SHELF_LEFT := 770.0
const SHELF_RIGHT := 1250.0
const SHELF_LEVELS: Array[float] = [300.0, 420.0]
const BRICK := Color(0.42, 0.34, 0.33)
const BRICK_DARK := Color(0.26, 0.22, 0.24)
const MORTAR := Color(0.56, 0.56, 0.6)
const WOOD := Color(0.4, 0.3, 0.21)
const WOOD_DARK := Color(0.24, 0.18, 0.13)
const WOOD_LIGHT := Color(0.52, 0.41, 0.3)
const IRON := Color(0.24, 0.25, 0.28)
const STRAW := Color(0.78, 0.66, 0.38)
const STRAW_DARK := Color(0.56, 0.46, 0.26)
const SKY_LIGHT := Color(0.78, 0.88, 1.0)
const ICE := Color(0.7, 0.85, 0.95, 0.75)
const ICE_EDGE := Color(0.45, 0.62, 0.76, 0.9)
const FROST := Color(0.92, 0.96, 1.0)


func _draw_background() -> void:
	_draw_dome()
	_draw_back_wall()
	_draw_grating()
	_draw_floor()
	_draw_drain()
	_draw_light_shaft()
	_draw_door()
	_draw_tool_pegs()
	_draw_straw_bed()
	_draw_shelves()
	_draw_wall_frost()


func _draw_foreground() -> void:
	# Icicles hanging from the rim of the grating and the arch.
	var rng := RandomNumberGenerator.new()
	rng.seed = 310
	for i in range(14):
		var x := rng.randf_range(560, 720)
		var top := GRATING.y + 14.0 + absf(x - GRATING.x) * 0.06
		var length := rng.randf_range(8, 22)
		_triangle(Vector2(x - 2.5, top), Vector2(x + 2.5, top), Vector2(x, top + length), Color(0.85, 0.94, 1.0, 0.85))
	# The broken half of the door bar lying on the floor in front of the door.
	_polygon([Vector2(196, 600), Vector2(296, 590), Vector2(298, 600), Vector2(198, 611)], WOOD_DARK)
	_polygon([Vector2(198, 600), Vector2(294, 591), Vector2(295, 595), Vector2(199, 604)], WOOD)
	for i in range(5):
		draw_line(Vector2(296, 590 + i * 2.5), Vector2(304, 588 + i * 3.5), WOOD_LIGHT, 1.2)
	# Loose straw and sawdust scattered over the front of the floor.
	rng.seed = 1988
	for i in range(90):
		var start := Vector2(rng.randf_range(90, 1220), rng.randf_range(FLOOR_Y + 60, room_size.y))
		var direction := Vector2.from_angle(rng.randf_range(-0.6, 0.6) + (PI if rng.randf() < 0.5 else 0.0))
		draw_line(start, start + direction * rng.randf_range(8, 18), STRAW if i % 3 else STRAW_DARK, 1.2)
	# A tuft of straw in front of the bales, half over the floor.
	for i in range(18):
		var root := Vector2(rng.randf_range(300, 420), 702)
		draw_line(root, root + Vector2(rng.randf_range(-14, 14), rng.randf_range(-24, -10)), STRAW, 1.4)
	# A frosted bottom corner on the right, under the shelves.
	_ellipse(Vector2(1210, 712), Vector2(120, 34), Color(FROST, 0.35))
	_draw_vignette()


# ---------------------------------------------------------------------------

## Draws a triangle with draw_primitive (safe even if it is very thin).
func _triangle(a: Vector2, b: Vector2, c: Vector2, color: Color) -> void:
	draw_primitive(PackedVector2Array([a, b, c]), PackedColorArray([color, color, color]), PackedVector2Array())


## The y of the arch (where the back wall meets the dome) at a given x.
func _arch_y(x: float) -> float:
	var t := clampf((x - ARCH_CENTRE.x) / ARCH_RADIUS.x, -1.0, 1.0)
	return ARCH_CENTRE.y - ARCH_RADIUS.y * sqrt(1.0 - t * t)


## The domed roof: rings of brick curving over the top of the room.
func _draw_dome() -> void:
	_vertical_gradient(Rect2(0, 0, room_size.x, FLOOR_Y), Color(0.24, 0.22, 0.26), Color(0.17, 0.15, 0.18))
	# Brick courses follow the curve of the dome, getting wider towards us.
	for ring in range(1, 9):
		var radius := ARCH_RADIUS + Vector2(ring * 36.0, ring * 34.0)
		var points := PackedVector2Array()
		for i in range(41):
			var angle := PI + i * PI / 40.0
			points.append(ARCH_CENTRE + Vector2(cos(angle) * radius.x, sin(angle) * radius.y))
		draw_polyline(points, Color(MORTAR, 0.35), 1.5, true)
		# Short joints between the bricks of this course
		for i in range(0, 40, 2):
			var angle := PI + (i + (ring % 2)) * PI / 40.0
			var inner := ARCH_CENTRE + Vector2(cos(angle) * (radius.x - 36.0), sin(angle) * (radius.y - 34.0))
			var outer := ARCH_CENTRE + Vector2(cos(angle) * radius.x, sin(angle) * radius.y)
			draw_line(inner, outer, Color(MORTAR, 0.25), 1.0)
	# A ring of light around the grating, where the daylight hits the bricks.
	_ellipse(GRATING, Vector2(200, 70), Color(SKY_LIGHT, 0.08))
	_ellipse(GRATING, Vector2(130, 44), Color(SKY_LIGHT, 0.1))


## The back wall inside the arch, built of rows of bricks.
func _draw_back_wall() -> void:
	var outline := PackedVector2Array()
	for i in range(61):
		var x := ARCH_CENTRE.x - ARCH_RADIUS.x + i * ARCH_RADIUS.x * 2.0 / 60.0
		outline.append(Vector2(x, minf(_arch_y(x), FLOOR_Y)))
	draw_colored_polygon(outline, BRICK_DARK)
	var rng := RandomNumberGenerator.new()
	rng.seed = 1896
	var row := 0
	var y := FLOOR_Y - 18.0
	while y > 130.0:
		var x := 20.0 + (row % 2) * 17.0
		while x < 1260.0:
			var top := _arch_y(x + 16.0)
			if y > top + 2.0:
				var shade := rng.randf_range(-0.05, 0.05)
				var colour := Color(BRICK.r + shade, BRICK.g + shade * 0.8, BRICK.b + shade * 0.6)
				# Bricks lower down are a little bluer from the cold.
				colour = colour.lerp(Color(0.38, 0.38, 0.44), clampf((y - 300.0) / 400.0, 0.0, 0.4))
				draw_rect(Rect2(x, y, 32, 16), colour)
			x += 35.0
		y -= 18.0
		row += 1
	# The rim of the arch
	var rim := PackedVector2Array()
	for i in range(41):
		var x := ARCH_CENTRE.x - ARCH_RADIUS.x + i * ARCH_RADIUS.x * 2.0 / 40.0
		rim.append(Vector2(x, _arch_y(x)))
	draw_polyline(rim, BRICK_DARK, 6.0, true)
	draw_polyline(rim, Color(FROST, 0.4), 1.5, true)


## The iron grating at the top of the dome, with pale winter sky behind it.
func _draw_grating() -> void:
	_ellipse(GRATING, Vector2(66, 20), IRON)
	_ellipse(GRATING, Vector2(58, 15), Color(0.82, 0.9, 1.0))
	_ellipse(GRATING + Vector2(-12, -3), Vector2(30, 7), Color(0.95, 0.98, 1.0))
	for i in range(-5, 6):
		var x := GRATING.x + i * 10.0
		var half := 15.0 * sqrt(maxf(1.0 - pow(i * 10.0 / 58.0, 2.0), 0.0))
		draw_line(Vector2(x, GRATING.y - half), Vector2(x, GRATING.y + half), IRON, 2.5)
	draw_line(GRATING + Vector2(-58, 0), GRATING + Vector2(58, 0), IRON, 2.5)
	# Snow lying along the lower edge of the grating
	draw_arc(GRATING, 60, PI * 0.15, PI * 0.85, 14, FROST, 3.0)


## The floor: trodden earth covered in straw and sawdust.
func _draw_floor() -> void:
	_vertical_gradient(Rect2(0, FLOOR_Y, room_size.x, room_size.y - FLOOR_Y), Color(0.36, 0.31, 0.26), Color(0.46, 0.39, 0.31))
	# Patches of pale sawdust
	for patch in [[Vector2(300, 600), Vector2(160, 30)], [Vector2(880, 610), Vector2(200, 34)],
			[Vector2(600, 700), Vector2(260, 24)], [Vector2(1100, 660), Vector2(150, 30)]]:
		_ellipse(patch[0], patch[1], Color(0.7, 0.6, 0.45, 0.3))
	var rng := RandomNumberGenerator.new()
	rng.seed = 21088
	for i in range(160):
		var start := Vector2(rng.randf_range(0, room_size.x), rng.randf_range(FLOOR_Y + 4, room_size.y))
		draw_line(start, start + Vector2(rng.randf_range(-10, 10), rng.randf_range(-2, 2)), Color(STRAW, 0.55), 1.0)
	for i in range(120):
		draw_circle(Vector2(rng.randf_range(0, room_size.x), rng.randf_range(FLOOR_Y + 4, room_size.y)), 1.0,
			Color(0.8, 0.7, 0.52, 0.5))
	# The foot of the wall
	draw_rect(Rect2(0, FLOOR_Y - 3, room_size.x, 6), BRICK_DARK)


## A round iron drain in the middle of the floor, with a frozen puddle around it.
func _draw_drain() -> void:
	_ellipse(DRAIN, Vector2(110, 26), Color(0.62, 0.76, 0.86, 0.45))
	_ellipse(DRAIN + Vector2(-30, -6), Vector2(40, 6), Color(1, 1, 1, 0.25))
	_ellipse(DRAIN, Vector2(72, 18), IRON)
	_ellipse(DRAIN, Vector2(64, 14), Color(0.07, 0.07, 0.09))
	for i in range(-5, 6):
		var x := DRAIN.x + i * 11.0
		var half := 14.0 * sqrt(maxf(1.0 - pow(i * 11.0 / 64.0, 2.0), 0.0))
		draw_line(Vector2(x, DRAIN.y - half), Vector2(x, DRAIN.y + half), IRON.lightened(0.15), 2.5)


## Cold pale-blue light falling from the grating down to the floor.
func _draw_light_shaft() -> void:
	var shaft := PackedVector2Array([GRATING + Vector2(-56, 6), GRATING + Vector2(56, 6), Vector2(790, 700), Vector2(470, 700)])
	draw_polygon(shaft, PackedColorArray([Color(SKY_LIGHT, 0.2), Color(SKY_LIGHT, 0.2), Color(SKY_LIGHT, 0.05), Color(SKY_LIGHT, 0.05)]))
	_ellipse(Vector2(630, 690), Vector2(170, 30), Color(SKY_LIGHT, 0.1))
	# Specks of frost drifting in the light
	var rng := RandomNumberGenerator.new()
	rng.seed = 3101988
	for i in range(30):
		var t := rng.randf()
		var y := lerpf(GRATING.y + 20, 680, t)
		var half := lerpf(50, 150, t)
		draw_circle(Vector2(rng.randf_range(640 - half, 640 + half), y), 1.0, Color(1, 1, 1, 0.45))


## The heavy door with iron straps. Its bar has been broken in two.
func _draw_door() -> void:
	# Frame and the painted company sign above it
	draw_rect(DOOR_RECT.grow(8), WOOD_DARK)
	draw_rect(Rect2(DOOR_RECT.position.x - 14, DOOR_RECT.position.y - 42, DOOR_RECT.size.x + 28, 30), Color(0.2, 0.24, 0.3))
	draw_rect(Rect2(DOOR_RECT.position.x - 14, DOOR_RECT.position.y - 42, DOOR_RECT.size.x + 28, 30), Color(0.6, 0.62, 0.66), false, 1.5)
	var font := ThemeDB.fallback_font
	draw_string(font, Vector2(DOOR_RECT.position.x - 10, DOOR_RECT.position.y - 29), "BLACKWATER ICE Co.",
		HORIZONTAL_ALIGNMENT_CENTER, DOOR_RECT.size.x + 20, 11, Color(0.93, 0.9, 0.8))
	draw_string(font, Vector2(DOOR_RECT.position.x - 10, DOOR_RECT.position.y - 16), "EST. 1896",
		HORIZONTAL_ALIGNMENT_CENTER, DOOR_RECT.size.x + 20, 11, Color(0.93, 0.9, 0.8))
	# Vertical planks
	var plank := DOOR_RECT.size.x / 5.0
	for i in range(5):
		var shade := 0.03 * (i % 2)
		draw_rect(Rect2(DOOR_RECT.position.x + i * plank, DOOR_RECT.position.y, plank - 2, DOOR_RECT.size.y),
			Color(WOOD.r + shade, WOOD.g + shade, WOOD.b + shade))
	# Iron straps and big rivets
	for y: float in [DOOR_RECT.position.y + 30, DOOR_RECT.end.y - 40]:
		draw_rect(Rect2(DOOR_RECT.position.x, y, DOOR_RECT.size.x, 10), IRON)
		for x in range(int(DOOR_RECT.position.x) + 10, int(DOOR_RECT.end.x), 26):
			draw_circle(Vector2(x, y + 5), 2.5, IRON.lightened(0.3))
	# Frost creeping up the bottom of the door
	_vertical_gradient(Rect2(DOOR_RECT.position.x, DOOR_RECT.end.y - 40, DOOR_RECT.size.x, 40), Color(FROST, 0.0), Color(FROST, 0.4))
	# The bar brackets, and what is left of the bar: snapped off, hanging from one bracket.
	for x: float in [DOOR_RECT.position.x - 4, DOOR_RECT.end.x - 10]:
		draw_rect(Rect2(x, DOOR_RECT.position.y + 94, 14, 18), IRON)
	_polygon([Vector2(DOOR_RECT.position.x - 2, DOOR_RECT.position.y + 96), Vector2(DOOR_RECT.position.x + 70, DOOR_RECT.position.y + 112),
		Vector2(DOOR_RECT.position.x + 66, DOOR_RECT.position.y + 124), Vector2(DOOR_RECT.position.x - 4, DOOR_RECT.position.y + 108)], WOOD_LIGHT)
	for i in range(4):
		var tip := Vector2(DOOR_RECT.position.x + 68, DOOR_RECT.position.y + 112 + i * 3.5)
		draw_line(tip, tip + Vector2(9, -2 + i * 2), WOOD_LIGHT, 1.5)
	# A rope latch and a nail on the wall beside the door
	draw_circle(Vector2(124, 380), 2.5, IRON)


## A row of wooden pegs on the wall for the cutters' tools, and an old coil of rope.
func _draw_tool_pegs() -> void:
	draw_rect(Rect2(330, 300, 220, 12), WOOD)
	draw_rect(Rect2(330, 300, 220, 3), WOOD_LIGHT)
	for x: float in [350.0, 380.0, 440.0, 500.0, 530.0]:
		draw_rect(Rect2(x - 3, 306, 6, 12), WOOD_DARK)
	# A coil of rope on one peg
	for i in range(4):
		draw_arc(Vector2(440, 336), 16 - i * 2, 0, TAU, 18, Color(0.62, 0.54, 0.38), 2.5)
	# An empty peg's outline where a saw used to hang
	draw_rect(Rect2(470, 318, 74, 18), Color(0.3, 0.25, 0.25, 0.5), false, 1.0)


## Two straw bales by the wall where Mara lay down, and a hollow in the straw.
func _draw_straw_bed() -> void:
	_ellipse(Vector2(450, 570), Vector2(150, 14), Color(0, 0, 0, 0.3))
	for bale in [Rect2(330, 470, 130, 92), Rect2(452, 494, 120, 70)]:
		draw_rect(bale, STRAW_DARK)
		draw_rect(bale.grow(-3), STRAW)
		var rng := RandomNumberGenerator.new()
		rng.seed = int(bale.position.x)
		for i in range(40):
			var start := Vector2(rng.randf_range(bale.position.x + 3, bale.end.x - 3), rng.randf_range(bale.position.y + 3, bale.end.y - 3))
			draw_line(start, start + Vector2(rng.randf_range(-8, 8), rng.randf_range(-3, 3)), STRAW_DARK, 1.0)
		# Twine around each bale
		for x: float in [bale.position.x + bale.size.x * 0.3, bale.position.x + bale.size.x * 0.7]:
			draw_line(Vector2(x, bale.position.y), Vector2(x, bale.end.y), Color(0.4, 0.3, 0.2), 1.5)
	# Loose straw heaped in front, with a hollow where someone curled up
	_ellipse(Vector2(420, 580), Vector2(120, 24), STRAW_DARK)
	_ellipse(Vector2(420, 576), Vector2(110, 20), STRAW)
	_ellipse(Vector2(440, 576), Vector2(54, 9), STRAW_DARK)


## Wooden shelves on the right, stacked with blocks of lake ice packed in straw.
func _draw_shelves() -> void:
	for x: float in [SHELF_LEFT, 1010.0, SHELF_RIGHT - 12]:
		draw_rect(Rect2(x, 220, 12, FLOOR_Y - 220 + 6), WOOD_DARK)
		draw_rect(Rect2(x, 220, 3, FLOOR_Y - 220 + 6), WOOD)
	for level in SHELF_LEVELS:
		draw_rect(Rect2(SHELF_LEFT - 6, level, SHELF_RIGHT - SHELF_LEFT + 12, 10), WOOD)
		draw_rect(Rect2(SHELF_LEFT - 6, level, SHELF_RIGHT - SHELF_LEFT + 12, 3), WOOD_LIGHT)
		draw_rect(Rect2(SHELF_LEFT - 6, level + 10, SHELF_RIGHT - SHELF_LEFT + 12, 3), Color(0, 0, 0, 0.3))
	# Blocks of ice (scenery). The containers sit among them.
	var blocks: Array[Rect2] = [
		Rect2(782, 252, 46, 48), Rect2(960, 258, 40, 42), Rect2(1024, 246, 70, 54), Rect2(1100, 256, 56, 44),
		Rect2(1162, 244, 70, 56), Rect2(1032, 210, 52, 36),
		Rect2(782, 372, 66, 48), Rect2(856, 380, 48, 40), Rect2(1024, 366, 64, 54), Rect2(1094, 376, 60, 44),
		Rect2(1160, 362, 72, 58),
		Rect2(830, 494, 70, 54), Rect2(1020, 486, 80, 62), Rect2(1110, 500, 60, 48), Rect2(1176, 480, 62, 68),
		Rect2(1040, 452, 48, 34),
	]
	for block in blocks:
		draw_rect(block, ICE_EDGE)
		draw_rect(block.grow(-3), ICE)
		draw_line(block.position + Vector2(5, 5), Vector2(block.position.x + 5, block.end.y - 8), Color(1, 1, 1, 0.55), 2.0)
		draw_line(block.position + Vector2(8, 3), Vector2(block.end.x - 6, block.position.y + 3), Color(1, 1, 1, 0.4), 1.0)
		# Straw packed between the blocks
		for i in range(4):
			var root := Vector2(block.end.x - 2, block.end.y - 4 - i * 6)
			draw_line(root, root + Vector2(6, -2 + i), STRAW, 1.2)
	# Meltwater frozen in drips off the shelf edges
	for x in range(790, 1240, 38):
		for level in SHELF_LEVELS:
			_triangle(Vector2(x - 2, level + 12), Vector2(x + 2, level + 12), Vector2(x, level + 20 + (x % 7)), Color(0.85, 0.94, 1.0, 0.8))


## White frost growing over the brick walls, thickest low down and near the door.
func _draw_wall_frost() -> void:
	var rng := RandomNumberGenerator.new()
	rng.seed = 288
	for patch in [Rect2(40, 360, 120, 180), Rect2(306, 330, 30, 210), Rect2(580, 380, 120, 160), Rect2(1180, 120, 100, 140),
			Rect2(0, 200, 90, 160), Rect2(720, 160, 90, 80)]:
		for i in range(26):
			var at := Vector2(rng.randf_range(patch.position.x, patch.end.x), rng.randf_range(patch.position.y, patch.end.y))
			_ellipse(at, Vector2(rng.randf_range(6, 16), rng.randf_range(3, 8)), Color(FROST, 0.12))
		for i in range(6):
			var at := Vector2(rng.randf_range(patch.position.x, patch.end.x), rng.randf_range(patch.position.y, patch.end.y))
			for spoke in range(3):
				var direction := Vector2.from_angle(spoke * PI / 3.0) * 3.5
				draw_line(at - direction, at + direction, Color(FROST, 0.5), 1.0)
	# A band of frost along the foot of the wall
	_vertical_gradient(Rect2(0, FLOOR_Y - 40, room_size.x, 40), Color(FROST, 0.0), Color(FROST, 0.18))
