@tool
class_name WorkshopArt
extends RoomArt
## Placeholder drawing of House Two, Chapter Four: Greaves's boat workshop at
## night. See room_art.gd for how to replace it with a real image.
##
## Layout: a plank wall at the back, lit warm by a hanging work lamp and the
## glow of the stove. Left: the iron stove (with half-burnt papers inside), a
## wall calendar from October 1988 and a window looking out on the lake. Middle:
## a wall cupboard and the long workbench with its vice. Right: the tool wall
## (painted outlines show where each tool belongs) and a boat hull up on
## trestles. Far right (behind the HUD panel): the open doors to the lake.

const FLOOR_Y := 470.0
const STOVE_RECT := Rect2(84, 330, 116, 128)
const FIRE_RECT := Rect2(102, 372, 80, 50)
const CALENDAR_RECT := Rect2(212, 262, 76, 112)
const WINDOW_RECT := Rect2(300, 96, 170, 124)
const LAMP := Vector2(610, 124)
const TOOL_WALL := Rect2(650, 84, 320, 206)
const BENCH_TOP := Rect2(226, 438, 344, 20)
const SHELF_Y := 598.0
const WOOD := Color(0.36, 0.26, 0.18)
const WOOD_DARK := Color(0.19, 0.13, 0.09)
const WOOD_LIGHT := Color(0.52, 0.39, 0.26)
const WARM := Color(1.0, 0.78, 0.45)
const FIRE := Color(1.0, 0.55, 0.18)
const CHALK := Color(0.92, 0.9, 0.84)
const NIGHT := Color(0.06, 0.08, 0.16)


func _draw_background() -> void:
	_draw_wall()
	_draw_floor()
	_draw_window()
	_draw_stove()
	_draw_calendar()
	_draw_stencil_rack()
	_draw_tool_wall()
	_draw_lake_doors()
	_draw_hull()
	_draw_workbench()
	_draw_boot_prints()
	_draw_lamp()


func _draw_foreground() -> void:
	# A heap of curly wood shavings swept up under the bench end (a torn scrap is half under it).
	var rng := RandomNumberGenerator.new()
	rng.seed = 1988
	_ellipse(Vector2(440, 706), Vector2(74, 14), Color(0.62, 0.48, 0.3, 0.9))
	for i in range(34):
		var at := Vector2(rng.randf_range(374, 506), rng.randf_range(690, 716))
		# Keep a gap over the middle so the scrap underneath still shows.
		if at.x > 455 and at.x < 482 and at.y < 700:
			continue
		var radius := rng.randf_range(3.0, 6.5)
		var start := rng.randf_range(0.0, TAU)
		draw_arc(at, radius, start, start + PI * 1.4, 8, Color(0.88, 0.74, 0.5), 2.0)
		draw_arc(at, radius - 1.5, start, start + PI * 1.2, 6, Color(0.7, 0.55, 0.34), 1.0)
	# The near trestle leg in front of the hull's bow.
	draw_line(Vector2(958, 540), Vector2(976, 700), WOOD_DARK, 9.0)
	draw_line(Vector2(955, 540), Vector2(973, 700), WOOD_LIGHT, 1.5)
	# A coil of rope lying on the floor at the far right.
	for i in range(4):
		draw_arc(Vector2(1120, 690), 46.0 - i * 9.0, 0, TAU, 28, Color(0.6, 0.5, 0.34), 5.0)
	# The work lamp's warm pool of light over the bench (drawn on top, very faint).
	var cone := PackedVector2Array([LAMP + Vector2(-20, 14), LAMP + Vector2(20, 14), Vector2(840, 720), Vector2(360, 720)])
	draw_polygon(cone, PackedColorArray([Color(WARM, 0.12), Color(WARM, 0.12), Color(WARM, 0.0), Color(WARM, 0.0)]))
	# Smoke from the stove drifting under the ceiling.
	for i in range(5):
		_ellipse(Vector2(150 + i * 70, 34 + sin(i * 1.3) * 8), Vector2(60, 14), Color(0.55, 0.52, 0.5, 0.08))
	_draw_vignette()


# ---------------------------------------------------------------------------

## The back wall of wide planks, warmer near the lamp and the stove, with roof beams above.
func _draw_wall() -> void:
	_vertical_gradient(Rect2(0, 0, room_size.x, FLOOR_Y), Color(0.16, 0.11, 0.08), Color(0.3, 0.21, 0.14))
	var rng := RandomNumberGenerator.new()
	rng.seed = 410
	var y := 40.0
	while y < FLOOR_Y:
		var height := rng.randf_range(26.0, 34.0)
		var shade := rng.randf_range(-0.02, 0.02)
		draw_rect(Rect2(0, y + 1, room_size.x, height - 2), Color(0.27 + shade, 0.19 + shade, 0.13 + shade, 0.55))
		draw_line(Vector2(0, y), Vector2(room_size.x, y), Color(0.1, 0.07, 0.05), 2.0)
		y += height
	# Upright posts holding up the roof
	for x: float in [40.0, 630.0, 1000.0]:
		draw_rect(Rect2(x, 30, 20, FLOOR_Y - 30), WOOD)
		draw_line(Vector2(x + 2, 30), Vector2(x + 2, FLOOR_Y), WOOD_LIGHT, 1.5)
	# The roof beam along the top
	draw_rect(Rect2(0, 0, room_size.x, 34), WOOD_DARK)
	draw_rect(Rect2(0, 28, room_size.x, 8), WOOD)
	# Warm light from the lamp and the stove spreading over the wall
	_glow(LAMP + Vector2(0, 40), 60.0, 6, 34.0, Color(WARM, 0.035))
	_glow(FIRE_RECT.get_center(), 40.0, 5, 30.0, Color(FIRE, 0.04))


## Wide floorboards, scattered sawdust and a dark patch of lake water by the doors.
func _draw_floor() -> void:
	_vertical_gradient(Rect2(0, FLOOR_Y, room_size.x, room_size.y - FLOOR_Y), Color(0.25, 0.18, 0.12), Color(0.34, 0.25, 0.17))
	var vanish := Vector2(640, 220)
	for i in range(-12, 13):
		var bottom := Vector2(640 + i * 96.0, room_size.y)
		var top := vanish.lerp(bottom, (FLOOR_Y - vanish.y) / (room_size.y - vanish.y))
		draw_line(top, bottom, Color(0.15, 0.1, 0.07), 2.0)
	for y: float in [500.0, 548.0, 616.0, 690.0]:
		draw_line(Vector2(0, y), Vector2(room_size.x, y), Color(0.15, 0.1, 0.07, 0.35), 1.0)
	# Sawdust
	var rng := RandomNumberGenerator.new()
	rng.seed = 77
	for i in range(80):
		var at := Vector2(rng.randf_range(220, 980), rng.randf_range(FLOOR_Y + 10, room_size.y))
		draw_circle(at, rng.randf_range(0.8, 1.8), Color(0.78, 0.64, 0.42, 0.5))
	# Skirting where the floor meets the wall
	draw_rect(Rect2(0, FLOOR_Y - 4, room_size.x, 8), WOOD_DARK)
	# Lake water puddled in front of the doors
	_ellipse(Vector2(1080, 600), Vector2(170, 34), Color(0.12, 0.2, 0.26, 0.6))


## The window: the dark lake, the far shore, and a tiny lamp moving away across the water.
func _draw_window() -> void:
	var frame := WINDOW_RECT.grow(8)
	draw_rect(frame, WOOD_DARK)
	_vertical_gradient(WINDOW_RECT, Color(0.05, 0.07, 0.15), Color(0.1, 0.13, 0.22))
	# Moon behind thin cloud
	draw_circle(WINDOW_RECT.position + Vector2(132, 28), 12, Color(0.88, 0.9, 0.96))
	_ellipse(WINDOW_RECT.position + Vector2(120, 34), Vector2(30, 5), Color(0.3, 0.33, 0.42, 0.8))
	# The far shore, a black line of trees
	var shore := WINDOW_RECT.position.y + 74
	_polygon([Vector2(WINDOW_RECT.position.x, shore), Vector2(WINDOW_RECT.position.x + 40, shore - 10),
		Vector2(WINDOW_RECT.position.x + 70, shore - 4), Vector2(WINDOW_RECT.position.x + 110, shore - 14),
		Vector2(WINDOW_RECT.end.x, shore - 6), Vector2(WINDOW_RECT.end.x, shore + 4), Vector2(WINDOW_RECT.position.x, shore + 4)],
		Color(0.02, 0.03, 0.05))
	# The lake, with moonlight rippling on it
	draw_rect(Rect2(WINDOW_RECT.position.x, shore + 4, WINDOW_RECT.size.x, WINDOW_RECT.end.y - shore - 4), Color(0.04, 0.06, 0.12))
	for i in range(5):
		var ripple_y := shore + 10 + i * 8
		draw_line(Vector2(WINDOW_RECT.position.x + 116 - i * 4, ripple_y), Vector2(WINDOW_RECT.position.x + 146 + i * 3, ripple_y),
			Color(0.75, 0.8, 0.92, 0.35), 1.2)
	# A rowing boat's lamp, far out on the water, heading for the dark shore.
	var boat_lamp := WINDOW_RECT.position + Vector2(52, 90)
	_glow(boat_lamp, 3.0, 3, 3.0, Color(1.0, 0.8, 0.45, 0.18))
	draw_circle(boat_lamp, 1.8, Color(1.0, 0.88, 0.6))
	draw_line(boat_lamp + Vector2(0, 3), boat_lamp + Vector2(0, 14), Color(1.0, 0.8, 0.45, 0.35), 1.0)
	# Glazing bars and a sill
	draw_line(Vector2(WINDOW_RECT.get_center().x, WINDOW_RECT.position.y), Vector2(WINDOW_RECT.get_center().x, WINDOW_RECT.end.y), WOOD_DARK, 5.0)
	draw_line(Vector2(WINDOW_RECT.position.x, WINDOW_RECT.get_center().y), Vector2(WINDOW_RECT.end.x, WINDOW_RECT.get_center().y), WOOD_DARK, 5.0)
	draw_rect(Rect2(WINDOW_RECT.position.x - 14, WINDOW_RECT.end.y + 6, WINDOW_RECT.size.x + 28, 9), WOOD_LIGHT)
	# Rain streaks on the glass
	for i in range(9):
		var x := WINDOW_RECT.position.x + 10 + i * 18
		draw_line(Vector2(x, WINDOW_RECT.position.y + 6 + (i % 3) * 14), Vector2(x - 3, WINDOW_RECT.position.y + 30 + (i % 3) * 14),
			Color(0.7, 0.75, 0.85, 0.25), 1.0)


## The iron stove. Its door hangs open: papers are still burning inside.
func _draw_stove() -> void:
	# Stove pipe up through the roof
	draw_rect(Rect2(128, 0, 24, STOVE_RECT.position.y), Color(0.13, 0.12, 0.12))
	draw_line(Vector2(131, 0), Vector2(131, STOVE_RECT.position.y), Color(0.32, 0.3, 0.3), 2.0)
	for y: float in [90.0, 200.0]:
		draw_rect(Rect2(124, y, 32, 6), Color(0.1, 0.1, 0.1))
	# Warm glow on the wall and the floor around it
	_glow(FIRE_RECT.get_center(), 30.0, 6, 16.0, Color(FIRE, 0.05))
	_ellipse(Vector2(150, 488), Vector2(110, 22), Color(FIRE, 0.12))
	# Body, top plate and legs
	_rounded_rect(STOVE_RECT, Color(0.16, 0.15, 0.15), 8)
	draw_rect(Rect2(STOVE_RECT.position.x - 6, STOVE_RECT.position.y - 8, STOVE_RECT.size.x + 12, 10), Color(0.22, 0.21, 0.21))
	draw_line(STOVE_RECT.position + Vector2(4, 4), Vector2(STOVE_RECT.position.x + 4, STOVE_RECT.end.y - 6), Color(0.36, 0.34, 0.34), 2.0)
	for x: float in [STOVE_RECT.position.x + 8, STOVE_RECT.end.x - 16]:
		draw_rect(Rect2(x, STOVE_RECT.end.y, 8, 22), Color(0.12, 0.11, 0.11))
	# The fire behind the open door
	draw_rect(FIRE_RECT, Color(0.2, 0.06, 0.02))
	_ellipse(FIRE_RECT.get_center() + Vector2(0, 10), Vector2(36, 16), Color(0.95, 0.4, 0.1))
	_ellipse(FIRE_RECT.get_center() + Vector2(-4, 12), Vector2(22, 9), Color(1.0, 0.78, 0.35))
	# Curling, half-burnt papers in the flames
	var paper := Color(0.88, 0.84, 0.72)
	_polygon([FIRE_RECT.position + Vector2(14, 22), FIRE_RECT.position + Vector2(34, 16), FIRE_RECT.position + Vector2(38, 32),
		FIRE_RECT.position + Vector2(18, 36)], paper)
	draw_polyline(PackedVector2Array([FIRE_RECT.position + Vector2(14, 22), FIRE_RECT.position + Vector2(18, 36),
		FIRE_RECT.position + Vector2(38, 32)]), Color(0.15, 0.08, 0.04), 2.5)
	_polygon([FIRE_RECT.position + Vector2(46, 20), FIRE_RECT.position + Vector2(64, 24), FIRE_RECT.position + Vector2(58, 38),
		FIRE_RECT.position + Vector2(44, 34)], Color(0.7, 0.66, 0.56))
	for i in range(4):
		draw_line(FIRE_RECT.position + Vector2(20, 24 + i * 3), FIRE_RECT.position + Vector2(32, 22 + i * 3), Color(0.2, 0.2, 0.25, 0.6), 0.8)
	# Flames licking up
	for i in range(5):
		var base := FIRE_RECT.position + Vector2(12 + i * 14, 44)
		draw_primitive(PackedVector2Array([base + Vector2(-6, 0), base + Vector2(6, 0), base + Vector2(1, -18 - (i % 2) * 8)]),
			PackedColorArray([FIRE, FIRE, Color(1.0, 0.9, 0.5)]), PackedVector2Array())
	# The open door swung out to the right
	_polygon([Vector2(FIRE_RECT.end.x, FIRE_RECT.position.y - 2), Vector2(FIRE_RECT.end.x + 26, FIRE_RECT.position.y + 6),
		Vector2(FIRE_RECT.end.x + 26, FIRE_RECT.end.y - 4), Vector2(FIRE_RECT.end.x, FIRE_RECT.end.y + 2)], Color(0.2, 0.19, 0.19))
	draw_circle(Vector2(FIRE_RECT.end.x + 20, FIRE_RECT.get_center().y), 3, Color(0.5, 0.48, 0.46))


## Greaves's old wall calendar, still on October 1988. The 1st is circled in red.
func _draw_calendar() -> void:
	var font := ThemeDB.fallback_font
	var r := CALENDAR_RECT
	draw_line(Vector2(r.get_center().x, r.position.y - 10), r.position + Vector2(10, 0), Color(0.3, 0.3, 0.3), 1.0)
	draw_line(Vector2(r.get_center().x, r.position.y - 10), Vector2(r.end.x - 10, r.position.y), Color(0.3, 0.3, 0.3), 1.0)
	draw_circle(Vector2(r.get_center().x, r.position.y - 10), 2, Color(0.5, 0.5, 0.5))
	draw_rect(Rect2(r.position + Vector2(3, 3), r.size), Color(0, 0, 0, 0.35))
	draw_rect(r, Color(0.92, 0.89, 0.8))
	# A faded picture of a boat at the top
	draw_rect(Rect2(r.position + Vector2(4, 4), Vector2(r.size.x - 8, 24)), Color(0.5, 0.62, 0.7))
	_polygon([r.position + Vector2(20, 22), r.position + Vector2(56, 22), r.position + Vector2(50, 27), r.position + Vector2(24, 27)],
		Color(0.2, 0.22, 0.3))
	draw_line(r.position + Vector2(38, 8), r.position + Vector2(38, 22), Color(0.2, 0.22, 0.3), 1.0)
	draw_string(font, r.position + Vector2(5, 38), "OCTOBER 1988", HORIZONTAL_ALIGNMENT_LEFT, r.size.x - 8, 9, Color(0.15, 0.12, 0.12))
	# The day grid. October 1988 started on a Saturday.
	var cell := Vector2((r.size.x - 8) / 7.0, 9.0)
	var grid_top := r.position + Vector2(4, 42)
	for day in range(1, 32):
		# Weeks start on Monday, so the 1st (a Saturday) sits in the 6th column.
		var column := (day + 4) % 7
		var row := int((day + 4) / 7)
		var at := grid_top + Vector2(column * cell.x + 1, row * cell.y + 8)
		draw_string(font, at, str(day), HORIZONTAL_ALIGNMENT_LEFT, -1, 6, Color(0.25, 0.22, 0.22))
		if day == 1:
			draw_arc(at + Vector2(2.5, -2.5), 5.5, 0, TAU, 14, Color(0.8, 0.12, 0.1), 1.4)
	# Greaves's red pencil note beside it
	draw_string(font, r.position + Vector2(5, r.size.y - 4), "1st: LADY M - last job", HORIZONTAL_ALIGNMENT_LEFT, r.size.x - 6, 6,
		Color(0.75, 0.12, 0.1))


## A rail under the window with letter stencils hanging from nails.
func _draw_stencil_rack() -> void:
	draw_rect(Rect2(306, 250, 160, 7), WOOD_LIGHT)
	var font := ThemeDB.fallback_font
	var letters := ["A", "R", "G", "E", "T"]
	for i in range(letters.size()):
		var x := 314.0 + i * 30.0
		var swing := (i % 2) * 2.0 - 1.0
		draw_circle(Vector2(x + 10, 256), 1.5, Color(0.6, 0.6, 0.6))
		var plate := Rect2(x, 260 + swing, 22, 30)
		draw_rect(plate, Color(0.62, 0.48, 0.24) if i % 2 == 0 else Color(0.55, 0.55, 0.52))
		draw_string(font, plate.position + Vector2(4, 24), letters[i], HORIZONTAL_ALIGNMENT_LEFT, -1, 20, Color(0.14, 0.1, 0.07))
	# The nail at the end is empty: one stencil is missing from the rack.
	draw_circle(Vector2(464, 256), 1.5, Color(0.6, 0.6, 0.6))
	draw_rect(Rect2(456, 262, 20, 28), Color(0.2, 0.14, 0.1, 0.4))


## The tool wall: a painted board with white outlines showing where each tool belongs.
## Three outlines are empty: the brace drill, the mallet and the plane.
func _draw_tool_wall() -> void:
	var r := TOOL_WALL
	draw_rect(r.grow(5), WOOD_DARK)
	draw_rect(r, Color(0.24, 0.32, 0.27))
	var outline := Color(CHALK, 0.75)
	var steel := Color(0.62, 0.64, 0.66)
	var handle := Color(0.55, 0.38, 0.22)
	# A saw hanging in its outline
	var saw := [r.position + Vector2(20, 30), r.position + Vector2(100, 22), r.position + Vector2(100, 46), r.position + Vector2(20, 54)]
	draw_polyline(PackedVector2Array(saw + [saw[0]]), outline, 1.5)
	_polygon([r.position + Vector2(22, 32), r.position + Vector2(84, 26), r.position + Vector2(84, 46), r.position + Vector2(22, 52)], steel)
	_rounded_rect(Rect2(r.position + Vector2(82, 24), Vector2(18, 22)), handle, 4)
	# Hammer, in its outline
	draw_rect(Rect2(r.position + Vector2(126, 20), Vector2(10, 56)), outline, false, 1.5)
	draw_rect(Rect2(r.position + Vector2(116, 16), Vector2(30, 12)), outline, false, 1.5)
	draw_rect(Rect2(r.position + Vector2(128, 26), Vector2(6, 48)), handle)
	draw_rect(Rect2(r.position + Vector2(118, 18), Vector2(26, 9)), Color(0.3, 0.3, 0.32))
	# EMPTY outline of the brace drill (Vane took it down)
	var drill := r.position + Vector2(200, 46)
	draw_line(drill + Vector2(-34, 0), drill + Vector2(34, 0), outline, 1.5)
	draw_arc(drill, 12, 0, TAU, 20, outline, 1.5)
	draw_arc(drill + Vector2(-34, 0), 6, 0, TAU, 12, outline, 1.5)
	draw_rect(Rect2(drill + Vector2(6, -22), Vector2(6, 10)), outline, false, 1.5)
	# A row of chisels
	for i in range(5):
		var x := r.position.x + 24 + i * 16
		draw_rect(Rect2(x - 3, r.position.y + 86, 6, 18), outline, false, 1.0)
		draw_rect(Rect2(x - 2, r.position.y + 86, 4, 16), handle)
		draw_line(Vector2(x, r.position.y + 102), Vector2(x, r.position.y + 124), steel, 3.0)
	# EMPTY outline of the mallet
	var mallet := r.position + Vector2(150, 110)
	draw_rect(Rect2(mallet + Vector2(-14, -12), Vector2(26, 24)), outline, false, 1.5)
	draw_rect(Rect2(mallet + Vector2(12, -3), Vector2(36, 6)), outline, false, 1.5)
	# A carpenter's square, hanging in place
	draw_polyline(PackedVector2Array([r.position + Vector2(240, 80), r.position + Vector2(240, 150), r.position + Vector2(300, 150)]), outline, 6.0)
	draw_polyline(PackedVector2Array([r.position + Vector2(240, 80), r.position + Vector2(240, 150), r.position + Vector2(300, 150)]), steel, 4.0)
	# EMPTY outline of the plane
	draw_rect(Rect2(r.position + Vector2(40, 150), Vector2(66, 22)), outline, false, 1.5)
	draw_circle(r.position + Vector2(98, 146), 5, outline)
	draw_circle(r.position + Vector2(98, 146), 3.5, Color(0.24, 0.32, 0.27))
	# Pliers and a coil of copper wire
	draw_line(r.position + Vector2(140, 150), r.position + Vector2(170, 190), Color(0.4, 0.2, 0.15), 3.0)
	draw_line(r.position + Vector2(150, 150), r.position + Vector2(160, 192), Color(0.4, 0.2, 0.15), 3.0)
	for i in range(3):
		draw_arc(r.position + Vector2(206, 176), 8.0 + i * 3.0, 0, TAU, 16, Color(0.75, 0.45, 0.25), 1.5)
	# Painted words at the top
	draw_string(ThemeDB.fallback_font, r.position + Vector2(200, 16), "T.G. - PUT IT BACK", HORIZONTAL_ALIGNMENT_LEFT, -1, 9, Color(CHALK, 0.7))
	# The shelf under the board, with jars of screws
	draw_rect(Rect2(r.position.x - 6, r.end.y + 8, r.size.x + 12, 8), WOOD_LIGHT)
	for i in range(4):
		var jar := Rect2(r.position.x + 10 + i * 26, r.end.y - 10, 18, 18)
		draw_rect(jar, Color(0.6, 0.7, 0.72, 0.4))
		draw_rect(Rect2(jar.position.x, jar.position.y - 3, 18, 4), Color(0.5, 0.42, 0.3))
		draw_rect(Rect2(jar.position.x + 3, jar.position.y + 8, 12, 8), Color(0.5, 0.48, 0.44, 0.7))


## The big doors at the far right stand open on the lake (behind the HUD panel).
func _draw_lake_doors() -> void:
	var opening := Rect2(1030, 120, 250, FLOOR_Y - 120 + 10)
	_vertical_gradient(opening, Color(0.05, 0.07, 0.14), NIGHT)
	draw_rect(Rect2(opening.position.x, 340, opening.size.x, opening.end.y - 340), Color(0.03, 0.05, 0.1))
	for i in range(4):
		draw_line(Vector2(1060 + i * 20, 360 + i * 22), Vector2(1140 + i * 24, 360 + i * 22), Color(0.6, 0.66, 0.8, 0.25), 1.0)
	# The slipway running down into the water
	_polygon([Vector2(1040, FLOOR_Y), Vector2(1280, FLOOR_Y), Vector2(1280, FLOOR_Y - 40), Vector2(1100, FLOOR_Y - 40)], WOOD_DARK)
	# One door swung right back against the wall
	_polygon([Vector2(1030, 110), Vector2(1070, 124), Vector2(1070, FLOOR_Y + 6), Vector2(1030, FLOOR_Y + 14)], WOOD)
	draw_rect(Rect2(1020, 100, 260, 14), WOOD_DARK)


## A wooden boat hull up on two trestles, half repaired: one plank is missing.
func _draw_hull() -> void:
	# Trestles (the near legs are drawn in the foreground)
	for x: float in [690.0, 930.0]:
		draw_rect(Rect2(x - 40, 528, 80, 10), WOOD_LIGHT)
		draw_line(Vector2(x - 30, 538), Vector2(x - 44, 664), WOOD_DARK, 7.0)
		draw_line(Vector2(x + 30, 538), Vector2(x + 44, 664), WOOD_DARK, 7.0)
	_ellipse(Vector2(800, 668), Vector2(200, 12), Color(0, 0, 0, 0.3))
	# The hull side seen from the side: flat transom on the left, pointed bow on the right
	var hull: Array[Vector2] = [Vector2(612, 396), Vector2(760, 402), Vector2(900, 392), Vector2(986, 372), Vector2(966, 440),
		Vector2(920, 504), Vector2(840, 528), Vector2(680, 528), Vector2(630, 508), Vector2(612, 470)]
	_polygon(hull, Color(0.3, 0.38, 0.42))
	# Plank lines following the curve of the hull
	for i in range(1, 6):
		var t := i / 6.0
		var points := PackedVector2Array()
		for step in range(9):
			var u := step / 8.0
			var top := Vector2(lerpf(612, 986, u), lerpf(398, 374, u * u) + sin(u * PI) * 4)
			var keel := Vector2(lerpf(620, 950, u), 518 - pow(u, 3) * 110)
			points.append(top.lerp(keel, t))
		draw_polyline(points, Color(0.18, 0.23, 0.26), 1.5)
	# The missing plank: you can see the ribs inside
	_polygon([Vector2(720, 446), Vector2(820, 444), Vector2(820, 460), Vector2(720, 462)], Color(0.1, 0.08, 0.07))
	for x: float in [736.0, 760.0, 784.0, 808.0]:
		draw_line(Vector2(x, 446), Vector2(x, 461), Color(0.4, 0.3, 0.2), 4.0)
	# Gunwale rail, waterline and a fresh coat of red below it on the stern half
	draw_polyline(PackedVector2Array([Vector2(612, 396), Vector2(760, 402), Vector2(900, 392), Vector2(986, 372)]), WOOD_LIGHT, 5.0)
	draw_polyline(PackedVector2Array([Vector2(616, 474), Vector2(760, 478), Vector2(900, 470), Vector2(950, 458)]), Color(0.85, 0.85, 0.8), 2.0)
	_polygon([Vector2(632, 478), Vector2(700, 480), Vector2(700, 526), Vector2(680, 526), Vector2(632, 508)], Color(0.55, 0.16, 0.12, 0.7))


## The long workbench with a vice on its left end and a shelf underneath.
func _draw_workbench() -> void:
	_ellipse(Vector2(400, 660), Vector2(190, 12), Color(0, 0, 0, 0.3))
	# Legs and the lower shelf
	for x: float in [BENCH_TOP.position.x + 10, BENCH_TOP.end.x - 24]:
		draw_rect(Rect2(x, BENCH_TOP.end.y, 14, 196), WOOD_DARK)
	draw_rect(Rect2(BENCH_TOP.position.x + 10, SHELF_Y, BENCH_TOP.size.x - 20, 10), WOOD)
	draw_line(Vector2(BENCH_TOP.position.x + 10, SHELF_Y), Vector2(BENCH_TOP.end.x - 10, SHELF_Y), WOOD_LIGHT, 1.5)
	# Old paint tins along the shelf (one real one is hidden among them)
	var tins := [[260.0, Color(0.3, 0.42, 0.55)], [292.0, Color(0.6, 0.6, 0.58)], [322.0, Color(0.25, 0.4, 0.3)],
		[412.0, Color(0.55, 0.5, 0.3)]]
	for tin: Array in tins:
		var x: float = tin[0]
		draw_rect(Rect2(x - 12, SHELF_Y - 26, 24, 26), Color(0.5, 0.52, 0.54))
		draw_rect(Rect2(x - 12, SHELF_Y - 18, 24, 11), tin[1])
		_ellipse(Vector2(x, SHELF_Y - 26), Vector2(12, 3), Color(0.38, 0.4, 0.42))
	# Front apron under the top
	draw_rect(Rect2(BENCH_TOP.position.x, BENCH_TOP.end.y, BENCH_TOP.size.x, 34), WOOD)
	draw_line(Vector2(BENCH_TOP.position.x, BENCH_TOP.end.y + 34), Vector2(BENCH_TOP.end.x, BENCH_TOP.end.y + 34), WOOD_DARK, 2.0)
	# The thick top, scarred and stained
	draw_rect(BENCH_TOP, WOOD_LIGHT)
	draw_line(BENCH_TOP.position, Vector2(BENCH_TOP.end.x, BENCH_TOP.position.y), Color(0.7, 0.55, 0.38), 2.0)
	for x: float in [300.0, 390.0, 470.0]:
		draw_line(Vector2(x, BENCH_TOP.position.y + 6), Vector2(x + 30, BENCH_TOP.position.y + 10), Color(0.35, 0.25, 0.16), 1.0)
	_ellipse(Vector2(450, BENCH_TOP.position.y + 6), Vector2(16, 3), Color(0.2, 0.14, 0.1, 0.5))
	# Shavings scattered on the bench
	for x: float in [400.0, 432.0, 540.0]:
		draw_arc(Vector2(x, BENCH_TOP.position.y - 2), 4, PI, TAU * 1.1, 8, Color(0.88, 0.74, 0.5), 2.0)
	# The iron vice, its jaws wound shut on a scrap of wood
	var vice := Vector2(BENCH_TOP.position.x - 4, BENCH_TOP.position.y)
	draw_rect(Rect2(vice + Vector2(-14, -18), Vector2(40, 20)), Color(0.28, 0.32, 0.36))
	draw_rect(Rect2(vice + Vector2(-14, 2), Vector2(18, 30)), Color(0.22, 0.25, 0.28))
	draw_rect(Rect2(vice + Vector2(-6, -26), Vector2(8, 10)), Color(0.75, 0.6, 0.4))
	draw_line(vice + Vector2(-26, 14), vice + Vector2(2, 14), Color(0.5, 0.52, 0.55), 3.0)
	draw_circle(vice + Vector2(-26, 14), 3, Color(0.5, 0.52, 0.55))


## Wet boot prints from the back stairs, past the bench, out through the lake doors.
func _draw_boot_prints() -> void:
	var water := Color(0.1, 0.12, 0.14, 0.45)
	for i in range(11):
		var t := i / 10.0
		var at := Vector2(lerpf(250, 1080, t), lerpf(700, 520, t) + (6.0 if i % 2 == 0 else -6.0))
		_ellipse(at, Vector2(8, 4), water)
		_ellipse(at + Vector2(10, 0), Vector2(4, 3), water)


## The hanging work lamp: a green enamel shade on a long flex.
func _draw_lamp() -> void:
	draw_line(Vector2(LAMP.x, 30), LAMP + Vector2(0, -12), Color(0.08, 0.08, 0.08), 2.0)
	_glow(LAMP + Vector2(0, 14), 14.0, 5, 10.0, Color(WARM, 0.07))
	_polygon([LAMP + Vector2(-8, -12), LAMP + Vector2(8, -12), LAMP + Vector2(26, 12), LAMP + Vector2(-26, 12)], Color(0.2, 0.35, 0.28))
	draw_line(LAMP + Vector2(-26, 12), LAMP + Vector2(26, 12), Color(0.85, 0.85, 0.8), 2.0)
	_ellipse(LAMP + Vector2(0, 14), Vector2(10, 5), Color(1.0, 0.95, 0.75))
