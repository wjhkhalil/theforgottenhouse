@tool
class_name LampRoomArt
extends RoomArt
## Placeholder drawing of House Two, Chapter Eight: the lamp room at the top of
## Agnes Hale's lighthouse. See room_art.gd for how to replace it with a real image.
##
## Layout: storm windows run all the way round the room. Outside, rain lashes
## the iron gallery rail and lightning flickers over the sea. The top-left pane
## is smashed (the wind blows in there - WindGusts draws the gusts). In the
## middle the huge glass Fresnel lens glows warm on its pedestal and turns
## slowly. Left: Agnes's desk with her writing box, papers and radio set.
## Right: the ferry board, the fog bell, a basket of rope and the oil locker.
##
## The background is redrawn every frame so the lens can turn and the
## lightning can flash.

const SILL_Y := 352.0
const FLOOR_Y := 505.0
const TRANSOM_Y := 200.0
const HORIZON_Y := 250.0
const MULLION_SPACING := 180.0
## The smashed pane (the same rectangle is used by WindGusts).
const BROKEN_PANE := Rect2(14, 62, 150, 134)
const LENS_CENTER := Vector2(600, 246)
const LENS_HALF_WIDTH := 122.0
const LENS_TOP := 112.0
const LENS_BOTTOM := 380.0
const DESK_TOP := Rect2(96, 455, 320, 16)
const BELL_POS := Vector2(912, 262)
const BOARD_RECT := Rect2(752, 368, 116, 62)
const IRON_GREEN := Color(0.16, 0.24, 0.22)
const IRON_GREEN_LIGHT := Color(0.27, 0.38, 0.35)
const BRASS := Color(0.8, 0.62, 0.3)
const BRASS_DARK := Color(0.5, 0.37, 0.17)
const AMBER := Color(1.0, 0.78, 0.4)
const WALL := Color(0.78, 0.74, 0.64)
const WALL_DARK := Color(0.58, 0.54, 0.46)
const WOOD := Color(0.42, 0.28, 0.17)
const WOOD_DARK := Color(0.24, 0.16, 0.1)
const SKY_TOP := Color(0.1, 0.12, 0.18)
const SKY_LOW := Color(0.24, 0.28, 0.34)

## Seconds since the room appeared (drives the turning lens and the lightning).
var _time: float = 0.0


func _process(delta: float) -> void:
	if layer != Layer.BACKGROUND:
		return
	_time += delta
	queue_redraw()


func _draw_background() -> void:
	_draw_storm_outside()
	_draw_gallery_rail()
	_draw_windows()
	_draw_ceiling()
	_draw_parapet()
	_draw_floor()
	_draw_lens_light_on_floor()
	_draw_pedestal()
	_draw_lens()
	_draw_ferry_board()
	_draw_desk()
	_draw_fog_bell()
	_draw_right_side()


func _draw_foreground() -> void:
	# A puddle of rain blown in under the broken pane.
	_ellipse(Vector2(150, 540), Vector2(70, 9), Color(0.55, 0.65, 0.75, 0.22))
	_ellipse(Vector2(130, 538), Vector2(26, 3), Color(0.85, 0.9, 1.0, 0.25))
	# The brass guard rail round the foot of the lens pedestal.
	for x: float in [492.0, 548.0, 652.0, 708.0]:
		draw_rect(Rect2(x - 2.5, 548, 5, 52), BRASS_DARK)
		draw_circle(Vector2(x, 548), 4.5, BRASS)
	draw_line(Vector2(488, 556), Vector2(712, 556), BRASS, 4.0)
	draw_line(Vector2(488, 554), Vector2(712, 554), Color(1, 0.9, 0.65, 0.7), 1.0)
	draw_line(Vector2(488, 582), Vector2(712, 582), BRASS_DARK, 3.0)
	# The bell rope hanging down from the fog bell.
	draw_polyline(PackedVector2Array([BELL_POS + Vector2(0, 60), BELL_POS + Vector2(-8, 120), BELL_POS + Vector2(-18, 180),
		BELL_POS + Vector2(-16, 222)]), Color(0.66, 0.56, 0.38), 3.0, true)
	_draw_vignette()


# ---------------------------------------------------------------------------

## 0 most of the time, close to 1 for a split second when the lightning strikes.
func _lightning_flash() -> float:
	var t := fmod(_time + 3.0, 8.5)
	if t < 0.08:
		return 1.0
	if t > 0.18 and t < 0.3:
		return 0.6
	return 0.0


## The night sky, the stormy sea, lightning and rain behind all the glass.
func _draw_storm_outside() -> void:
	var flash := _lightning_flash()
	var top := SKY_TOP.lerp(Color(0.62, 0.66, 0.8), flash * 0.6)
	var low := SKY_LOW.lerp(Color(0.8, 0.82, 0.92), flash * 0.6)
	_vertical_gradient(Rect2(0, 40, room_size.x, HORIZON_Y - 40), top, low)
	# Heavy clouds
	for cloud: Vector3 in [Vector3(120, 96, 90), Vector3(400, 80, 120), Vector3(760, 104, 110), Vector3(1100, 86, 130)]:
		_ellipse(Vector2(cloud.x + sin(_time * 0.05 + cloud.x) * 20.0, cloud.y), Vector2(cloud.z, 26),
			Color(0.06, 0.07, 0.1, 0.55))
	# The sea, with white crests rolling in
	_vertical_gradient(Rect2(0, HORIZON_Y, room_size.x, SILL_Y - HORIZON_Y), Color(0.12, 0.17, 0.2), Color(0.05, 0.08, 0.1))
	for i in range(18):
		var crest_x := fmod(i * 131.0 + _time * 14.0, room_size.x + 60.0) - 30.0
		var crest_y := HORIZON_Y + 8.0 + (i % 5) * 16.0
		draw_line(Vector2(crest_x, crest_y), Vector2(crest_x + 24.0 + (i % 3) * 8.0, crest_y - 2.0), Color(0.8, 0.85, 0.9, 0.35), 1.5)
	# The island far away, with a pin-prick of light in its chapel
	_polygon([Vector2(660, HORIZON_Y), Vector2(700, HORIZON_Y - 10), Vector2(740, HORIZON_Y - 14), Vector2(790, HORIZON_Y)],
		Color(0.06, 0.08, 0.1))
	draw_rect(Rect2(731, HORIZON_Y - 22, 6, 9), Color(0.07, 0.09, 0.11))
	draw_circle(Vector2(734, HORIZON_Y - 10), 1.5, Color(1, 0.85, 0.5, 0.8))
	# Lightning: a forked bolt in a different window each time.
	if flash > 0.0:
		var strike := int((_time + 3.0) / 8.5)
		var rng := RandomNumberGenerator.new()
		rng.seed = strike * 7 + 3
		var x: float = [330.0, 860.0, 1140.0, 470.0][strike % 4]
		var point := Vector2(x, 40)
		var bolt := PackedVector2Array([point])
		while point.y < HORIZON_Y:
			point += Vector2(rng.randf_range(-22, 22), rng.randf_range(18, 30))
			bolt.append(point)
		draw_polyline(bolt, Color(0.85, 0.9, 1.0, flash * 0.5), 6.0)
		draw_polyline(bolt, Color(1, 1, 1, flash), 2.0)
		var fork: Vector2 = bolt[3] if bolt.size() > 3 else bolt[0]
		draw_polyline(PackedVector2Array([fork, fork + Vector2(26, 22), fork + Vector2(34, 50)]), Color(1, 1, 1, flash * 0.8), 1.5)
	# Rain driving sideways past the glass
	for i in range(90):
		var rain_x := fmod(i * 47.0 + _time * 160.0, room_size.x + 80.0) - 40.0
		var rain_y := 40.0 + fmod(i * 73.0 + _time * 520.0, SILL_Y - 40.0)
		draw_line(Vector2(rain_x, rain_y), Vector2(rain_x - 7, rain_y + 18), Color(0.75, 0.8, 0.9, 0.3), 1.0)


## The iron gallery rail running round the outside of the lamp room.
func _draw_gallery_rail() -> void:
	var rail := Color(0.05, 0.07, 0.07)
	for y: float in [282.0, 306.0, 330.0]:
		draw_rect(Rect2(0, y, room_size.x, 4 if y > 282.0 else 6), rail)
	for i in range(23):
		var x := 20.0 + i * 58.0
		draw_rect(Rect2(x, 282, 5, SILL_Y - 282), rail)
	# The gallery floor just below the sill
	draw_rect(Rect2(0, 340, room_size.x, 12), Color(0.08, 0.09, 0.1))


## Storm glass all round, held in green-painted iron frames. One pane is smashed.
func _draw_windows() -> void:
	# A faint warm reflection of the lens on the glass, and rain running down it.
	draw_rect(Rect2(0, 40, room_size.x, SILL_Y - 40), Color(0.6, 0.7, 0.75, 0.06))
	var rng := RandomNumberGenerator.new()
	rng.seed = 808
	for i in range(40):
		var x := rng.randf_range(0, room_size.x)
		var length := rng.randf_range(10, 40)
		var y := 60.0 + fmod(rng.randf_range(0, 280) + _time * rng.randf_range(10, 30), 280.0)
		if BROKEN_PANE.has_point(Vector2(x, y)):
			continue
		draw_line(Vector2(x, y), Vector2(x + 1, y + length), Color(0.85, 0.9, 1.0, 0.18), 1.5)
		draw_circle(Vector2(x + 1, y + length), 1.6, Color(0.9, 0.95, 1.0, 0.3))
	_draw_broken_pane()
	# Iron frames: upright mullions, the transom bar and the sill.
	var x := -10.0
	while x < room_size.x + 10.0:
		draw_rect(Rect2(x - 8, 40, 16, SILL_Y - 40), IRON_GREEN)
		draw_line(Vector2(x - 6, 40), Vector2(x - 6, SILL_Y), IRON_GREEN_LIGHT, 2.0)
		x += MULLION_SPACING
	draw_rect(Rect2(0, TRANSOM_Y - 6, room_size.x, 12), IRON_GREEN)
	draw_line(Vector2(0, TRANSOM_Y - 5), Vector2(room_size.x, TRANSOM_Y - 5), IRON_GREEN_LIGHT, 1.5)
	# Rivets
	x = -10.0
	while x < room_size.x + 10.0:
		for y: float in [TRANSOM_Y, 70.0, 330.0]:
			draw_circle(Vector2(x, y), 2.5, Color(0.1, 0.15, 0.14))
		x += MULLION_SPACING


## The smashed pane: a jagged hole with sharp edges, the storm pouring through.
func _draw_broken_pane() -> void:
	var p := BROKEN_PANE
	# Glass that is still in the frame, round the edges of the hole
	var shard_color := Color(0.75, 0.85, 0.9, 0.35)
	_polygon([p.position, Vector2(p.end.x, p.position.y), Vector2(p.end.x - 30, p.position.y + 20),
		Vector2(p.position.x + 70, p.position.y + 34), Vector2(p.position.x + 26, p.position.y + 22)], shard_color)
	_polygon([Vector2(p.end.x, p.position.y + 40), p.end, Vector2(p.end.x - 50, p.end.y), Vector2(p.end.x - 24, p.end.y - 30),
		Vector2(p.end.x - 12, p.position.y + 70)], shard_color)
	_polygon([Vector2(p.position.x, p.end.y - 40), Vector2(p.position.x + 40, p.end.y), Vector2(p.position.x, p.end.y)], shard_color)
	# Bright cracked edges
	for edge in [[Vector2(p.position.x + 26, p.position.y + 22), Vector2(p.position.x + 70, p.position.y + 34),
			Vector2(p.end.x - 30, p.position.y + 20)],
			[Vector2(p.end.x - 12, p.position.y + 70), Vector2(p.end.x - 24, p.end.y - 30), Vector2(p.end.x - 50, p.end.y)],
			[Vector2(p.position.x, p.end.y - 40), Vector2(p.position.x + 40, p.end.y)]]:
		draw_polyline(PackedVector2Array(edge), Color(0.95, 0.98, 1.0, 0.85), 1.5)
	# Cracks spreading through the glass that's left
	draw_line(Vector2(p.end.x - 30, p.position.y + 20), Vector2(p.end.x - 6, p.position.y + 6), Color(1, 1, 1, 0.5), 1.0)
	draw_line(Vector2(p.end.x - 24, p.end.y - 30), Vector2(p.end.x - 4, p.end.y - 12), Color(1, 1, 1, 0.5), 1.0)


## The dark copper roof inside, mostly hidden under the top bar.
func _draw_ceiling() -> void:
	_vertical_gradient(Rect2(0, 0, room_size.x, 44), Color(0.16, 0.11, 0.08), Color(0.3, 0.2, 0.13))
	draw_rect(Rect2(0, 40, room_size.x, 8), IRON_GREEN)
	# The brass ventilator above the lens
	_polygon([LENS_CENTER + Vector2(-46, -LENS_CENTER.y + 48), LENS_CENTER + Vector2(46, -LENS_CENTER.y + 48),
		LENS_CENTER + Vector2(26, -LENS_CENTER.y + 80), LENS_CENTER + Vector2(-26, -LENS_CENTER.y + 80)], BRASS_DARK)
	draw_rect(Rect2(LENS_CENTER.x - 14, 78, 28, LENS_TOP - 78), BRASS_DARK)


## The low, cream-painted wall under the windows, with a wooden sill.
func _draw_parapet() -> void:
	_vertical_gradient(Rect2(0, SILL_Y, room_size.x, FLOOR_Y - SILL_Y), WALL, WALL_DARK)
	# Iron plates bolted together
	var x := 80.0
	while x < room_size.x:
		draw_line(Vector2(x, SILL_Y + 8), Vector2(x, FLOOR_Y), Color(0.5, 0.46, 0.38), 2.0)
		for y in range(int(SILL_Y) + 20, int(FLOOR_Y), 26):
			draw_circle(Vector2(x - 6, y), 1.8, Color(0.46, 0.42, 0.35))
			draw_circle(Vector2(x + 6, y), 1.8, Color(0.46, 0.42, 0.35))
		x += 180.0
	# Wooden sill along the top
	draw_rect(Rect2(0, SILL_Y - 4, room_size.x, 12), WOOD)
	draw_line(Vector2(0, SILL_Y - 4), Vector2(room_size.x, SILL_Y - 4), Color(0.6, 0.44, 0.28), 2.0)
	draw_rect(Rect2(0, SILL_Y + 8, room_size.x, 3), Color(0, 0, 0, 0.2))
	# The nail Agnes hung her wind gauge on
	draw_line(Vector2(116, 376), Vector2(120, 388), Color(0.4, 0.36, 0.3), 1.0)
	draw_line(Vector2(124, 376), Vector2(120, 388), Color(0.4, 0.36, 0.3), 1.0)
	draw_circle(Vector2(120, 375), 2.0, Color(0.3, 0.28, 0.26))
	# Rain stains running down below the broken pane
	for i in range(5):
		var stain_x := 30.0 + i * 26.0
		_polygon([Vector2(stain_x, SILL_Y + 8), Vector2(stain_x + 10, SILL_Y + 8), Vector2(stain_x + 6, SILL_Y + 70 + i * 12),
			Vector2(stain_x + 3, SILL_Y + 70 + i * 12)], Color(0.35, 0.36, 0.34, 0.3))


## Red-painted iron floor plates.
func _draw_floor() -> void:
	_vertical_gradient(Rect2(0, FLOOR_Y, room_size.x, room_size.y - FLOOR_Y), Color(0.34, 0.16, 0.12), Color(0.46, 0.22, 0.16))
	var vanish := Vector2(600, 300)
	for i in range(-10, 11):
		var bottom := Vector2(600 + i * 120.0, room_size.y)
		var top := vanish.lerp(bottom, (FLOOR_Y - vanish.y) / (room_size.y - vanish.y))
		draw_line(top, bottom, Color(0.22, 0.1, 0.08), 2.0)
	for y: float in [560.0, 628.0]:
		draw_line(Vector2(0, y), Vector2(room_size.x, y), Color(0.22, 0.1, 0.08), 2.0)
	# Chequer-plate pattern, worn away along the path round the lens
	var rng := RandomNumberGenerator.new()
	rng.seed = 45
	for i in range(160):
		var at := Vector2(rng.randf_range(0, room_size.x), rng.randf_range(FLOOR_Y + 8, room_size.y))
		draw_line(at, at + Vector2(4, -2), Color(0.55, 0.3, 0.22, 0.5), 1.5)
	draw_rect(Rect2(0, FLOOR_Y - 3, room_size.x, 6), Color(0.2, 0.1, 0.07))


## The warm light from the lens pooling on the floor, sweeping round as it turns.
func _draw_lens_light_on_floor() -> void:
	_ellipse(Vector2(600, 600), Vector2(330, 70), Color(AMBER, 0.08))
	_ellipse(Vector2(600, 600), Vector2(200, 40), Color(AMBER, 0.08))
	var sweep := sin(_time * 0.6)
	_ellipse(Vector2(600 + sweep * 380.0, 650), Vector2(90, 26), Color(AMBER, 0.1 * (1.0 - absf(sweep) * 0.5)))


## The iron pedestal and the clockwork that turns the lens.
func _draw_pedestal() -> void:
	_ellipse(Vector2(600, 598), Vector2(118, 14), Color(0, 0, 0, 0.35))
	# Stepped base
	draw_rect(Rect2(500, 560, 200, 34), IRON_GREEN)
	draw_rect(Rect2(500, 560, 200, 5), IRON_GREEN_LIGHT)
	draw_rect(Rect2(520, 530, 160, 32), IRON_GREEN.darkened(0.15))
	draw_rect(Rect2(520, 530, 160, 4), IRON_GREEN_LIGHT)
	# Column
	draw_rect(Rect2(570, LENS_BOTTOM, 60, 152), IRON_GREEN)
	draw_rect(Rect2(574, LENS_BOTTOM, 10, 152), IRON_GREEN_LIGHT)
	# The clockwork box with a brass winding handle
	draw_rect(Rect2(542, 430, 116, 70), Color(0.12, 0.18, 0.17))
	draw_rect(Rect2(546, 434, 108, 62), IRON_GREEN)
	var gear_angle := _time * 0.8
	for gear: Vector3 in [Vector3(574, 464, 16), Vector3(612, 458, 11)]:
		draw_circle(Vector2(gear.x, gear.y), gear.z, BRASS_DARK)
		for tooth in range(8):
			var direction := Vector2.from_angle(gear_angle * (1.0 if gear.z > 12.0 else -1.5) + tooth * TAU / 8.0)
			draw_line(Vector2(gear.x, gear.y) + direction * (gear.z - 4.0), Vector2(gear.x, gear.y) + direction * (gear.z + 2.0), BRASS, 3.0)
		draw_circle(Vector2(gear.x, gear.y), 3.0, BRASS)
	draw_line(Vector2(650, 470), Vector2(672, 470), BRASS, 4.0)
	draw_circle(Vector2(674, 470), 4.0, BRASS)
	draw_rect(Rect2(636, 482, 14, 8), Color(0.88, 0.85, 0.75))  # a small maker's plate


## Half the width of the lens at height y (a barrel, wider in the middle).
func _lens_half_width(y: float) -> float:
	var t := (y - LENS_CENTER.y) / ((LENS_BOTTOM - LENS_TOP) * 0.5)
	return LENS_HALF_WIDTH * sqrt(clampf(1.0 - t * t * 0.72, 0.05, 1.0))


## The great glass Fresnel lens: rings of prisms round a glowing lamp, turning slowly.
func _draw_lens() -> void:
	var flash := _lightning_flash()
	# The warm halo
	_glow(LENS_CENTER, 120, 7, 22, Color(1, 0.78, 0.42, 0.035))
	# Brass frame top and bottom
	draw_rect(Rect2(LENS_CENTER.x - 70, LENS_TOP - 8, 140, 10), BRASS_DARK)
	draw_rect(Rect2(LENS_CENTER.x - 100, LENS_BOTTOM - 4, 200, 12), BRASS_DARK)
	# Horizontal bands of glass prisms
	var band_height := 14.0
	var y := LENS_TOP
	while y < LENS_BOTTOM - 1.0:
		var top_width := _lens_half_width(y)
		var bottom_width := _lens_half_width(y + band_height)
		var in_belt := absf(y + band_height * 0.5 - LENS_CENTER.y) < 52.0
		var glow := 1.0 - absf(y + band_height * 0.5 - LENS_CENTER.y) / 160.0
		var edge := Color(0.55, 0.4, 0.22, 0.85)
		var middle := Color(1.0, 0.86, 0.55).lerp(Color(1, 0.97, 0.88), glow * 0.6)
		if in_belt:
			middle = Color(1.0, 0.9, 0.62)
		var points := PackedVector2Array([Vector2(LENS_CENTER.x - top_width, y), Vector2(LENS_CENTER.x, y),
			Vector2(LENS_CENTER.x + top_width, y), Vector2(LENS_CENTER.x + bottom_width, y + band_height),
			Vector2(LENS_CENTER.x, y + band_height), Vector2(LENS_CENTER.x - bottom_width, y + band_height)])
		draw_polygon(points, PackedColorArray([edge, middle, edge, edge, middle, edge]))
		# A bright line along each prism
		draw_line(Vector2(LENS_CENTER.x - top_width * 0.92, y + 3), Vector2(LENS_CENTER.x + top_width * 0.92, y + 3),
			Color(1, 1, 0.95, 0.35 + flash * 0.4), 1.0)
		draw_line(Vector2(LENS_CENTER.x - bottom_width, y + band_height), Vector2(LENS_CENTER.x + bottom_width, y + band_height),
			Color(0.45, 0.32, 0.16, 0.8), 1.0)
		y += band_height
	# The bright lamp burning inside
	_ellipse(LENS_CENTER, Vector2(40, 48), Color(1, 0.95, 0.75, 0.35))
	_ellipse(LENS_CENTER, Vector2(22, 30), Color(1, 0.98, 0.85, 0.55))
	# The lens turns: its brass frame bars and bull's-eye panels slide round.
	var turn := _time * 0.35
	for i in range(8):
		var angle := turn + i * TAU / 8.0
		var facing := cos(angle)
		if facing <= 0.0:
			continue
		var points := PackedVector2Array()
		var bar_y := LENS_TOP
		while bar_y <= LENS_BOTTOM:
			points.append(Vector2(LENS_CENTER.x + sin(angle) * _lens_half_width(bar_y), bar_y))
			bar_y += 12.0
		draw_polyline(points, Color(0.42, 0.3, 0.14, 0.4 + facing * 0.5), 2.0 + facing * 2.0, true)
		# Bull's-eye in the middle of each panel
		var panel_angle := angle + TAU / 16.0
		var panel_facing := cos(panel_angle)
		if panel_facing > 0.15:
			var eye := Vector2(LENS_CENTER.x + sin(panel_angle) * LENS_HALF_WIDTH * 0.95, LENS_CENTER.y)
			for ring in range(4):
				var radius := 30.0 - ring * 7.0
				_ellipse(eye, Vector2(radius * panel_facing, radius), Color(1, 0.95, 0.75, 0.1 + ring * 0.06))
				draw_arc(eye, radius, 0, TAU, 24, Color(0.6, 0.45, 0.22, 0.4), 1.0)
			# The glint: brightest when a panel faces us head on
			var shine := pow(panel_facing, 8.0)
			_glow(eye, 6, 5, 7, Color(1, 1, 0.9, 0.12 * shine))
			draw_circle(eye, 4.0 + shine * 5.0, Color(1, 1, 1, 0.4 + shine * 0.6))
	# Little sparkles chasing round the prism rings
	for i in range(6):
		var angle := _time * 0.35 + i * 1.3
		var sparkle_y := LENS_TOP + 20.0 + i * 44.0
		if cos(angle) > 0.4:
			var at := Vector2(LENS_CENTER.x + sin(angle) * _lens_half_width(sparkle_y), sparkle_y)
			draw_line(at - Vector2(6, 0), at + Vector2(6, 0), Color(1, 1, 1, 0.8), 1.5)
			draw_line(at - Vector2(0, 6), at + Vector2(0, 6), Color(1, 1, 1, 0.8), 1.5)


## A painted ferry notice on the wall: the code for Agnes's writing box.
func _draw_ferry_board() -> void:
	draw_rect(BOARD_RECT.grow(3), WOOD_DARK)
	draw_rect(BOARD_RECT, Color(0.18, 0.28, 0.4))
	draw_rect(BOARD_RECT.grow(-3), Color(0.9, 0.86, 0.72), false, 1.0)
	var font := ThemeDB.fallback_font
	var cream := Color(0.95, 0.92, 0.8)
	draw_string(font, BOARD_RECT.position + Vector2(8, 16), "ISLAND FERRY", HORIZONTAL_ALIGNMENT_LEFT, -1, 12, cream)
	draw_string(font, BOARD_RECT.position + Vector2(8, 32), "One sailing daily", HORIZONTAL_ALIGNMENT_LEFT, -1, 10, cream)
	draw_string(font, BOARD_RECT.position + Vector2(24, 54), "06:40", HORIZONTAL_ALIGNMENT_LEFT, -1, 18, Color(1, 0.85, 0.45))
	# Two screws
	for x: float in [BOARD_RECT.position.x + 4, BOARD_RECT.end.x - 4]:
		draw_circle(Vector2(x, BOARD_RECT.position.y + 4), 1.5, Color(0.6, 0.58, 0.5))


## Agnes's desk: papers, an inkwell, a little lamp and the top of her radio set.
func _draw_desk() -> void:
	_ellipse(Vector2(256, 640), Vector2(170, 12), Color(0, 0, 0, 0.3))
	# Legs and the front panel
	for x: float in [104.0, 396.0]:
		draw_rect(Rect2(x, DESK_TOP.end.y, 14, 168), WOOD_DARK)
		draw_rect(Rect2(x + 2, DESK_TOP.end.y, 4, 168), WOOD)
	draw_rect(Rect2(DESK_TOP.position.x + 6, DESK_TOP.end.y, DESK_TOP.size.x - 12, 36), WOOD)
	draw_rect(Rect2(DESK_TOP.position.x + 6, DESK_TOP.end.y + 34, DESK_TOP.size.x - 12, 3), WOOD_DARK)
	# The top
	draw_rect(DESK_TOP, Color(0.5, 0.34, 0.2))
	draw_line(DESK_TOP.position, Vector2(DESK_TOP.end.x, DESK_TOP.position.y), Color(0.66, 0.48, 0.3), 2.0)
	# A neat pile of logbooks and loose papers
	draw_rect(Rect2(214, 443, 34, 12), Color(0.3, 0.2, 0.32))
	draw_rect(Rect2(216, 435, 30, 8), Color(0.22, 0.3, 0.24))
	draw_rect(Rect2(218, 431, 26, 4), Color(0.88, 0.84, 0.72))
	# Inkwell and pen
	draw_rect(Rect2(300, 443, 12, 12), Color(0.12, 0.12, 0.16))
	draw_rect(Rect2(302, 439, 8, 4), Color(0.25, 0.25, 0.3))
	draw_line(Vector2(306, 440), Vector2(318, 422), Color(0.15, 0.12, 0.1), 1.5)
	# The radio set: speaker grille and tuning dial above its cabinet (the RadioCabinet container).
	var radio := Rect2(322, 362, 76, 52)
	draw_rect(radio.grow(2), Color(0.15, 0.1, 0.06))
	draw_rect(radio, Color(0.36, 0.22, 0.12))
	draw_circle(Vector2(343, 386), 15, Color(0.22, 0.14, 0.08))
	for i in range(5):
		draw_line(Vector2(331, 378 + i * 4), Vector2(355, 378 + i * 4), Color(0.48, 0.36, 0.22), 1.0)
	draw_rect(Rect2(364, 372, 28, 16), Color(0.95, 0.85, 0.55))
	draw_line(Vector2(377, 374), Vector2(380, 386), Color(0.7, 0.1, 0.1), 1.0)
	for knob: float in [368.0, 386.0]:
		draw_circle(Vector2(knob, 402), 4, Color(0.12, 0.1, 0.08))
	draw_line(Vector2(390, 362), Vector2(408, 300), Color(0.5, 0.5, 0.52), 1.5)  # aerial wire
	draw_string(ThemeDB.fallback_font, Vector2(326, 412), "MARINE", HORIZONTAL_ALIGNMENT_LEFT, -1, 7, Color(0.85, 0.7, 0.4))


## The brass fog bell hanging from an iron bracket.
func _draw_fog_bell() -> void:
	# Bracket from the window frame
	draw_rect(Rect2(BELL_POS.x - 4, 40, 8, BELL_POS.y - 70), IRON_GREEN)
	draw_rect(Rect2(BELL_POS.x - 26, BELL_POS.y - 34, 52, 8), IRON_GREEN)
	draw_rect(Rect2(BELL_POS.x - 6, BELL_POS.y - 28, 12, 8), IRON_GREEN.darkened(0.3))
	# The bell itself
	_polygon([BELL_POS + Vector2(-20, -20), BELL_POS + Vector2(20, -20), BELL_POS + Vector2(28, 28),
		BELL_POS + Vector2(40, 52), BELL_POS + Vector2(-40, 52), BELL_POS + Vector2(-28, 28)], BRASS)
	_polygon([BELL_POS + Vector2(-20, -20), BELL_POS + Vector2(-8, -20), BELL_POS + Vector2(-14, 28),
		BELL_POS + Vector2(-26, 52), BELL_POS + Vector2(-40, 52), BELL_POS + Vector2(-28, 28)], Color(0.98, 0.84, 0.5))
	_ellipse(BELL_POS + Vector2(0, -20), Vector2(20, 6), BRASS_DARK)
	_ellipse(BELL_POS + Vector2(0, 52), Vector2(40, 8), BRASS_DARK)
	_ellipse(BELL_POS + Vector2(0, 52), Vector2(32, 5), Color(0.15, 0.1, 0.05))
	draw_line(BELL_POS + Vector2(-34, 44), BELL_POS + Vector2(34, 44), BRASS_DARK, 2.0)
	# The warm lens light catching its side
	draw_line(BELL_POS + Vector2(-16, -12), BELL_POS + Vector2(-30, 44), Color(1, 0.95, 0.8, 0.6), 2.0)


## Behind the list on the right: the door to the gallery and a paraffin tank.
func _draw_right_side() -> void:
	# The door out to the gallery
	draw_rect(Rect2(1046, 140, 120, FLOOR_Y - 136), IRON_GREEN)
	draw_rect(Rect2(1056, 150, 100, 150), Color(0.12, 0.16, 0.2))
	draw_rect(Rect2(1056, 310, 100, FLOOR_Y - 316), IRON_GREEN.darkened(0.15))
	draw_circle(Vector2(1146, 330), 5, BRASS)
	# A tall paraffin tank with a tap
	draw_rect(Rect2(1180, 360, 70, 200), Color(0.5, 0.18, 0.14))
	draw_rect(Rect2(1180, 360, 12, 200), Color(0.62, 0.26, 0.2))
	_ellipse(Vector2(1215, 360), Vector2(35, 8), Color(0.42, 0.14, 0.1))
	draw_rect(Rect2(1170, 520, 14, 6), BRASS)
	draw_string(ThemeDB.fallback_font, Vector2(1190, 450), "PARAFFIN", HORIZONTAL_ALIGNMENT_LEFT, -1, 9, Color(0.92, 0.86, 0.7))
	# A coil of rope on the floor
	for ring in range(4):
		draw_arc(Vector2(1100, 640), 40 - ring * 8, 0, TAU, 24, Color(0.62, 0.52, 0.34), 4.0)
