@tool
class_name JettyArt
extends RoomArt
## Placeholder drawing of House Two, Chapter One: the jetty on Blackwater Lake.
## See room_art.gd for how to replace it with a real image.
##
## The room is TWO SCREENS WIDE (2560 x 720) and seen from the side. Left to
## right along the jetty: reeds and the bait bucket, a lamp post, the rowing
## boat tied up below the planks, a mooring post with the tackle box, barrels
## and coiled ropes, the padlocked fish crate, a second lamp, and finally the
## boathouse with its sealed door and the dockmaster's locker.
## Lake water lies behind the jetty (far water) and in front of it (near water);
## floating clues drift on both.

const DECK_TOP := 430.0
const DECK_FRONT := 462.0
const DECK_BOTTOM := 476.0
const SHORE_Y := 300.0
const BOATHOUSE_X := 1900.0
const SKY_TOP := Color(0.02, 0.03, 0.08)
const SKY_BOTTOM := Color(0.09, 0.12, 0.22)
const WATER_TOP := Color(0.05, 0.09, 0.16)
const WATER_BOTTOM := Color(0.02, 0.04, 0.08)
const PLANK := Color(0.4, 0.31, 0.22)
const PLANK_DARK := Color(0.24, 0.18, 0.13)
const PLANK_LIGHT := Color(0.52, 0.41, 0.3)
const POST := Color(0.2, 0.15, 0.11)
const BOARD := Color(0.27, 0.22, 0.18)
const BOARD_DARK := Color(0.16, 0.13, 0.11)
const LAMP := Color(1.0, 0.82, 0.5)
const LAMP_POSITIONS: Array[Vector2] = [Vector2(330, 250), Vector2(1810, 250)]
const MOON_CENTER := Vector2(470, 105)


func _init() -> void:
	room_size = Vector2(2560, 720)


func _draw_background() -> void:
	_draw_sky()
	_draw_far_shore()
	_draw_water()
	_draw_rowing_boat()
	_draw_posts()
	_draw_deck()
	_draw_lamp_posts()
	_draw_mooring_post()
	_draw_barrels()
	_draw_boathouse()
	_draw_lamp_light()


func _draw_foreground() -> void:
	# Tall reeds at the left end hide part of the bait bucket.
	var rng := RandomNumberGenerator.new()
	rng.seed = 2209
	for i in range(26):
		var x := rng.randf_range(0.0, 150.0)
		var top := rng.randf_range(330.0, 420.0)
		var lean := rng.randf_range(-14.0, 14.0)
		var shade := rng.randf_range(0.0, 0.06)
		draw_line(Vector2(x, 720), Vector2(x + lean, top), Color(0.12 + shade, 0.18 + shade, 0.1), 3.0)
		if i % 4 == 0:
			_ellipse(Vector2(x + lean, top - 8), Vector2(3, 10), Color(0.25, 0.17, 0.1))
	# A coil of rope on the deck covers the edge of the compass.
	for i in range(4):
		draw_arc(Vector2(1440, 452), 22.0 - i * 4.0, PI * 1.05, TAU * 0.98, 16, Color(0.6, 0.5, 0.33), 3.0)
	draw_arc(Vector2(1440, 452), 22, PI * 1.05, TAU * 0.98, 16, Color(0.4, 0.32, 0.2), 1.0)
	# Lily pads in the near water.
	for pad in [Vector2(360, 690), Vector2(980, 700), Vector2(1560, 692)]:
		_ellipse(pad, Vector2(26, 7), Color(0.12, 0.25, 0.14))
		draw_line(pad, pad + Vector2(18, -3), Color(0.05, 0.1, 0.07), 2.0)
	_draw_vignette()


# ---------------------------------------------------------------------------

func _draw_sky() -> void:
	_vertical_gradient(Rect2(0, 0, room_size.x, SHORE_Y), SKY_TOP, SKY_BOTTOM)
	var rng := RandomNumberGenerator.new()
	rng.seed = 1987
	for i in range(140):
		var star := Vector2(rng.randf_range(0, room_size.x), rng.randf_range(0, SHORE_Y - 40))
		draw_circle(star, rng.randf_range(0.6, 1.6), Color(1, 1, 1, rng.randf_range(0.25, 0.8)))
	# Moon with a soft halo
	_glow(MOON_CENTER, 34, 6, 10, Color(0.75, 0.8, 0.95, 0.04))
	draw_circle(MOON_CENTER, 30, PlaceholderArt.MOON)
	draw_circle(MOON_CENTER + Vector2(-9, -6), 6, Color(0.7, 0.74, 0.84))
	draw_circle(MOON_CENTER + Vector2(10, 8), 4, Color(0.7, 0.74, 0.84))
	# Thin clouds
	for cloud in [Rect2(700, 70, 260, 14), Rect2(1350, 120, 340, 12), Rect2(2050, 60, 300, 16)]:
		_rounded_rect(cloud, Color(0.25, 0.28, 0.4, 0.35), 7)


func _draw_far_shore() -> void:
	# A ragged line of pine trees across the lake.
	var rng := RandomNumberGenerator.new()
	rng.seed = 417
	var x := -20.0
	while x < room_size.x + 20:
		var height := rng.randf_range(35.0, 80.0)
		var width := rng.randf_range(22.0, 40.0)
		_polygon([Vector2(x, SHORE_Y), Vector2(x + width / 2.0, SHORE_Y - height), Vector2(x + width, SHORE_Y)],
			Color(0.03, 0.05, 0.07))
		x += width * 0.6
	draw_rect(Rect2(0, SHORE_Y - 6, room_size.x, 8), Color(0.03, 0.05, 0.07))
	# One lit window far away on the other shore.
	draw_rect(Rect2(1555, SHORE_Y - 20, 6, 5), Color(1, 0.8, 0.45, 0.8))


func _draw_water() -> void:
	_vertical_gradient(Rect2(0, SHORE_Y, room_size.x, room_size.y - SHORE_Y), WATER_TOP, WATER_BOTTOM)
	# The moon's reflection: broken streaks under the moon
	var rng := RandomNumberGenerator.new()
	rng.seed = 7
	for i in range(18):
		var y := SHORE_Y + 8 + i * 22.0
		var width := rng.randf_range(20.0, 70.0) * (1.0 + i * 0.06)
		draw_line(Vector2(MOON_CENTER.x - width / 2.0, y), Vector2(MOON_CENTER.x + width / 2.0, y),
			Color(0.75, 0.8, 0.95, 0.28 - i * 0.012), 2.0)
	# Gentle ripple lines across the whole lake
	for i in range(90):
		var p := Vector2(rng.randf_range(0, room_size.x), rng.randf_range(SHORE_Y + 10, room_size.y))
		var length := rng.randf_range(12, 40)
		draw_line(p, p + Vector2(length, 0), Color(0.5, 0.6, 0.75, 0.1), 1.0)


func _draw_posts() -> void:
	var x := 40.0
	while x < room_size.x:
		draw_rect(Rect2(x - 7, DECK_BOTTOM - 4, 14, 96), POST)
		draw_rect(Rect2(x - 7, DECK_BOTTOM - 4, 3, 96), Color(0.3, 0.23, 0.16))
		# Ring where the post meets the water
		_ellipse(Vector2(x, DECK_BOTTOM + 92), Vector2(14, 3), Color(0.5, 0.6, 0.75, 0.2))
		x += 170.0
	# Dark water shadow right under the deck
	_vertical_gradient(Rect2(0, DECK_BOTTOM, room_size.x, 40), Color(0, 0, 0, 0.45), Color(0, 0, 0, 0))


func _draw_deck() -> void:
	# Top of the planks (seen slightly from above)...
	draw_rect(Rect2(0, DECK_TOP, room_size.x, DECK_FRONT - DECK_TOP), PLANK)
	var rng := RandomNumberGenerator.new()
	rng.seed = 33
	var x := 0.0
	while x < room_size.x:
		var width := rng.randf_range(26.0, 34.0)
		var shade := rng.randf_range(-0.04, 0.04)
		draw_rect(Rect2(x + 1, DECK_TOP, width - 2, DECK_FRONT - DECK_TOP), Color(PLANK.r + shade, PLANK.g + shade, PLANK.b + shade))
		draw_line(Vector2(x, DECK_TOP), Vector2(x, DECK_FRONT), PLANK_DARK, 1.5)
		if rng.randf() < 0.3:
			draw_circle(Vector2(x + width / 2.0, DECK_TOP + 6), 1.3, Color(0.15, 0.12, 0.1))
		x += width
	draw_line(Vector2(0, DECK_TOP), Vector2(room_size.x, DECK_TOP), PLANK_LIGHT, 2.0)
	# ...and the front beam
	draw_rect(Rect2(0, DECK_FRONT, room_size.x, DECK_BOTTOM - DECK_FRONT), PLANK_DARK)
	draw_line(Vector2(0, DECK_FRONT), Vector2(room_size.x, DECK_FRONT), Color(0.12, 0.09, 0.07), 1.5)


func _draw_rowing_boat() -> void:
	# A small rowing boat tied up in the near water, below the planks.
	var hull: Array[Vector2] = [Vector2(640, 520), Vector2(930, 520), Vector2(900, 566), Vector2(680, 566)]
	_ellipse(Vector2(785, 572), Vector2(160, 8), Color(0, 0, 0, 0.35))
	_polygon(hull, Color(0.32, 0.2, 0.14))
	draw_line(Vector2(640, 520), Vector2(930, 520), Color(0.55, 0.38, 0.26), 4.0)
	draw_line(Vector2(660, 540), Vector2(915, 540), Color(0.22, 0.13, 0.09), 1.5)
	draw_rect(Rect2(640, 526, 290, 6), Color(0.6, 0.62, 0.6))
	# An oar resting across it and the mooring rope up to the deck
	draw_line(Vector2(700, 512), Vector2(880, 528), Color(0.5, 0.38, 0.25), 4.0)
	_ellipse(Vector2(885, 529), Vector2(14, 5), Color(0.5, 0.38, 0.25))
	draw_polyline(PackedVector2Array([Vector2(905, 522), Vector2(925, 500), Vector2(940, 476)]), Color(0.6, 0.5, 0.33), 2.0)


func _draw_lamp_posts() -> void:
	for lamp in LAMP_POSITIONS:
		draw_rect(Rect2(lamp.x - 4, lamp.y, 8, DECK_TOP - lamp.y + 6), Color(0.12, 0.12, 0.14))
		draw_line(Vector2(lamp.x, lamp.y + 4), Vector2(lamp.x + 22, lamp.y + 4), Color(0.12, 0.12, 0.14), 4.0)
		var head := Vector2(lamp.x + 22, lamp.y + 18)
		_polygon([head + Vector2(-9, -12), head + Vector2(9, -12), head + Vector2(7, 10), head + Vector2(-7, 10)],
			Color(0.1, 0.1, 0.12))
		draw_rect(Rect2(head.x - 6, head.y - 9, 12, 17), LAMP)


func _draw_mooring_post() -> void:
	# A squat iron bollard with rope wound round it.
	draw_rect(Rect2(990, 396, 30, 40), Color(0.18, 0.18, 0.2))
	_ellipse(Vector2(1005, 396), Vector2(18, 6), Color(0.26, 0.26, 0.28))
	for i in range(3):
		draw_line(Vector2(988, 408 + i * 8), Vector2(1022, 404 + i * 8), Color(0.6, 0.5, 0.33), 3.0)


func _draw_barrels() -> void:
	for barrel in [Vector2(1320, 384), Vector2(1372, 392), Vector2(1520, 380)]:
		var rect := Rect2(barrel.x - 26, barrel.y, 52, DECK_TOP + 14 - barrel.y)
		_rounded_rect(rect, Color(0.33, 0.22, 0.14), 8)
		for band in [rect.position.y + 8, rect.end.y - 10]:
			draw_line(Vector2(rect.position.x + 2, band), Vector2(rect.end.x - 2, band), Color(0.2, 0.2, 0.22), 3.0)
		draw_line(Vector2(rect.position.x + 9, rect.position.y + 4), Vector2(rect.position.x + 9, rect.end.y - 4), Color(1, 1, 1, 0.07), 3.0)
	# A heap of netting draped over the last barrel
	_polygon([Vector2(1488, 392), Vector2(1556, 386), Vector2(1572, 444), Vector2(1478, 444)], Color(0.2, 0.25, 0.22, 0.8))
	for i in range(6):
		draw_line(Vector2(1484 + i * 15, 392), Vector2(1478 + i * 18, 444), Color(0.35, 0.4, 0.35, 0.6), 1.0)


func _draw_boathouse() -> void:
	var left := BOATHOUSE_X
	var right := room_size.x
	# Walls of dark vertical boards
	draw_rect(Rect2(left, 190, right - left, DECK_TOP - 190 + 4), BOARD)
	var x := left
	while x < right:
		draw_line(Vector2(x, 190), Vector2(x, DECK_TOP + 4), BOARD_DARK, 2.0)
		x += 22.0
	# Pitched roof
	_polygon([Vector2(left - 30, 196), Vector2((left + right) / 2.0, 70), Vector2(right + 30, 196)], Color(0.14, 0.1, 0.09))
	draw_line(Vector2(left - 30, 196), Vector2((left + right) / 2.0, 70), Color(0.3, 0.22, 0.18), 3.0)
	draw_rect(Rect2(left - 30, 192, right - left + 60, 8), Color(0.1, 0.07, 0.06))
	# Sign board above the door
	_rounded_rect(Rect2(1975, 210, 150, 30), Color(0.55, 0.45, 0.32), 4)
	for i in range(9):
		draw_rect(Rect2(1987 + i * 14, 220, 9, 10), Color(0.2, 0.15, 0.1))
	# The door (police tape hangs across it)
	draw_rect(Rect2(2000, 256, 100, DECK_TOP - 256), Color(0.12, 0.09, 0.07))
	draw_rect(Rect2(2006, 262, 88, DECK_TOP - 262), Color(0.2, 0.15, 0.11))
	draw_line(Vector2(2050, 262), Vector2(2050, DECK_TOP), Color(0.12, 0.09, 0.07), 2.0)
	draw_circle(Vector2(2084, 350), 4, Color(0.6, 0.5, 0.3))
	# The door stands slightly open: a sliver of warm light
	draw_rect(Rect2(2094, 262, 6, DECK_TOP - 262), Color(1, 0.75, 0.4, 0.55))
	# Window with a flickering light inside (far right, behind the objective list)
	draw_rect(Rect2(2380, 270, 90, 70), Color(0.1, 0.07, 0.06))
	draw_rect(Rect2(2386, 276, 78, 58), Color(0.95, 0.7, 0.35, 0.65))
	draw_line(Vector2(2425, 276), Vector2(2425, 334), Color(0.1, 0.07, 0.06), 3.0)
	draw_line(Vector2(2386, 305), Vector2(2464, 305), Color(0.1, 0.07, 0.06), 3.0)
	# The big boat doors at the water end, half sunk
	draw_rect(Rect2(2250, DECK_BOTTOM, 310, 90), Color(0.1, 0.08, 0.07))
	# Shadow where the locker hangs
	draw_rect(Rect2(2150, 310, 84, 104), Color(0, 0, 0, 0.3))


func _draw_lamp_light() -> void:
	for lamp in LAMP_POSITIONS:
		var head := Vector2(lamp.x + 22, lamp.y + 18)
		_glow(head, 16, 9, 18, Color(LAMP, 0.035))
		# Light pooling on the planks below
		_ellipse(Vector2(head.x, DECK_TOP + 14), Vector2(120, 16), Color(LAMP, 0.08))
	# Warm spill from the open boathouse door
	_polygon([Vector2(2094, DECK_TOP), Vector2(2100, DECK_TOP), Vector2(2190, DECK_FRONT), Vector2(2060, DECK_FRONT)],
		Color(1, 0.75, 0.4, 0.12))
