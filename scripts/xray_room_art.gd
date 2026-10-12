@tool
class_name XrayRoomArt
extends RoomArt
## Placeholder drawing of House Three, Chapter Two: the X-ray room of
## Hollowmere Sanatorium. See room_art.gd for how to replace it with a real image.
##
## Layout, left to right: the steel door of Ward 7, the X-ray table under its
## tube arm (a plaster cast and a pillow lie on it, the film cabinet is under
## it) with the light box on the wall above, a crutch leaning on the wall, the
## exposure chart (its CHEST row is the code of the drug safe), the control
## cabinet, a patched square of plaster, the desk and a lead apron on a hook.
## Nothing to find is placed under the objective list on the right. On the
## floor: the laundry hamper, an old suitcase, the instrument case, the
## developer tank, the waste bin and one boot.
##
## Six things here have something sealed INSIDE them (the cast, the pillow,
## the suitcase, the crutch, the boot heel and the plaster patch). They are
## drawn in the background, so the hidden objects only show through XRayScreen.

const FLOOR_Y := 540.0
const TILE_Y := 380.0
const DOOR_RECT := Rect2(72, 327, 100, 210)
const TABLE_TOP_RECT := Rect2(250, 436, 320, 12)
const CHART_RECT := Rect2(640, 108, 156, 132)
const PATCH_RECT := Rect2(830, 224, 72, 64)
const DESK_TOP_RECT := Rect2(770, 430, 222, 12)
const DESK_FRONT_RECT := Rect2(780, 442, 202, 98)
const KNEEHOLE_RECT := Rect2(876, 458, 90, 82)
const STEEL := Color(0.6, 0.64, 0.66)
const STEEL_DARK := Color(0.3, 0.33, 0.36)
const ENAMEL := Color(0.86, 0.88, 0.84)
const WOOD := Color(0.34, 0.23, 0.14)
const WOOD_DARK := Color(0.19, 0.12, 0.08)
const PLASTER := Color(0.9, 0.89, 0.84)
const INK := Color(0.14, 0.14, 0.2)


func _draw_background() -> void:
	_draw_walls()
	_draw_floor()
	_draw_steel_door()
	_draw_light_box_mount()
	_draw_xray_table()
	_draw_crutch()
	_draw_exposure_chart()
	_draw_cabinet_plinths()
	_draw_plaster_patch()
	_draw_desk()
	_draw_lead_apron()
	_draw_floor_things()


func _draw_foreground() -> void:
	_draw_vignette()


# ---------------------------------------------------------------------------

## Pale green distemper above, white glazed tiles below.
func _draw_walls() -> void:
	_vertical_gradient(Rect2(0, 0, room_size.x, TILE_Y), Color(0.22, 0.3, 0.27), Color(0.34, 0.44, 0.39))
	draw_rect(Rect2(0, TILE_Y, room_size.x, FLOOR_Y - TILE_Y), Color(0.7, 0.74, 0.7))
	var x := 0.0
	while x < room_size.x:
		draw_line(Vector2(x, TILE_Y), Vector2(x, FLOOR_Y), Color(0.5, 0.55, 0.52), 1.0)
		x += 40.0
	for y: float in [TILE_Y, TILE_Y + 40.0, TILE_Y + 80.0, TILE_Y + 120.0]:
		draw_line(Vector2(0, y), Vector2(room_size.x, y), Color(0.5, 0.55, 0.52), 1.0)
	draw_rect(Rect2(0, TILE_Y - 6, room_size.x, 8), Color(0.12, 0.3, 0.24))
	# A black-out blind pulled down over the only window, top left
	draw_rect(Rect2(196, 60, 120, 150), STEEL_DARK)
	draw_rect(Rect2(202, 66, 108, 138), Color(0.05, 0.05, 0.06))
	draw_line(Vector2(256, 204), Vector2(256, 226), Color(0.6, 0.55, 0.4), 1.0)
	draw_circle(Vector2(256, 228), 3.0, Color(0.6, 0.55, 0.4))
	# The ceiling lamp, switched off
	draw_line(Vector2(640, 0), Vector2(640, 40), STEEL_DARK, 2.0)
	_polygon([Vector2(612, 62), Vector2(668, 62), Vector2(654, 40), Vector2(626, 40)], ENAMEL.darkened(0.3))


## Chequered linoleum, seen in perspective.
func _draw_floor() -> void:
	draw_rect(Rect2(0, FLOOR_Y, room_size.x, room_size.y - FLOOR_Y), Color(0.3, 0.33, 0.31))
	var rows: Array[float] = [540.0, 562.0, 592.0, 632.0, 684.0, 750.0]
	for row in range(rows.size() - 1):
		var width := 70.0 + row * 22.0
		var column := 0
		var x := 640.0 - ceilf(640.0 / width) * width
		while x < room_size.x:
			if (row + column) % 2 == 0:
				draw_rect(Rect2(x, rows[row], width, rows[row + 1] - rows[row]), Color(0.2, 0.22, 0.21))
			x += width
			column += 1
	draw_rect(Rect2(0, FLOOR_Y - 8, room_size.x, 8), Color(0.1, 0.24, 0.19))


## The frame of the steel door to Ward 7, with its number painted above.
func _draw_steel_door() -> void:
	var frame := DOOR_RECT.grow(10)
	draw_rect(frame, STEEL_DARK)
	draw_rect(DOOR_RECT, Color(0.04, 0.04, 0.05))
	for rivet_y in range(int(frame.position.y) + 12, int(frame.end.y), 30):
		draw_circle(Vector2(frame.position.x + 5, rivet_y), 2.0, STEEL)
		draw_circle(Vector2(frame.end.x - 5, rivet_y), 2.0, STEEL)
	var plate := Rect2(DOOR_RECT.get_center().x - 22, frame.position.y - 50, 44, 40)
	draw_rect(plate, ENAMEL)
	draw_rect(plate, INK, false, 2.0)
	draw_string(ThemeDB.fallback_font, plate.position + Vector2(13, 32), "7", HORIZONTAL_ALIGNMENT_LEFT, -1, 32, INK)
	# A gap of darkness under the door
	draw_rect(Rect2(DOOR_RECT.position.x, FLOOR_Y - 5, DOOR_RECT.size.x, 5), Color(0, 0, 0, 0.8))


## The bracket the light box hangs on, and its flex.
func _draw_light_box_mount() -> void:
	draw_rect(Rect2(358, 162, 132, 92), Color(0, 0, 0, 0.3))
	draw_line(Vector2(484, 240), Vector2(500, 380), Color(0.1, 0.1, 0.1), 2.0)


## The X-ray table and tube arm, with a plaster cast and a pillow lying on it.
func _draw_xray_table() -> void:
	_ellipse(Vector2(410, FLOOR_Y + 6), Vector2(180, 9), Color(0, 0, 0, 0.4))
	# The column and arm that carry the tube head
	draw_rect(Rect2(262, 262, 14, 176), STEEL_DARK)
	draw_rect(Rect2(264, 262, 4, 176), STEEL)
	draw_rect(Rect2(262, 280, 190, 12), STEEL_DARK)
	draw_rect(Rect2(262, 280, 190, 3), STEEL)
	draw_rect(Rect2(408, 292, 56, 34), Color(0.14, 0.15, 0.17))
	_polygon([Vector2(418, 326), Vector2(454, 326), Vector2(462, 350), Vector2(410, 350)], STEEL_DARK)
	draw_rect(Rect2(414, 300, 44, 4), STEEL)
	# The table
	for leg_x: float in [262.0, 548.0]:
		draw_rect(Rect2(leg_x, TABLE_TOP_RECT.end.y, 10, FLOOR_Y - TABLE_TOP_RECT.end.y), STEEL_DARK)
	draw_rect(TABLE_TOP_RECT, Color(0.16, 0.17, 0.19))
	draw_rect(Rect2(TABLE_TOP_RECT.position, Vector2(TABLE_TOP_RECT.size.x, 3)), STEEL)
	# A plaster cast of a child's forearm, sawn off and kept (something is set into it)
	_rounded_rect(Rect2(296, 404, 84, 30), PLASTER.darkened(0.12), 12)
	_rounded_rect(Rect2(296, 404, 84, 24), PLASTER, 12)
	for i in range(5):
		draw_line(Vector2(308 + i * 14.0, 408), Vector2(304 + i * 14.0, 430), Color(0.7, 0.69, 0.64), 1.0)
	_ellipse(Vector2(378, 418), Vector2(6, 12), Color(0.2, 0.19, 0.18))
	# A striped ticking pillow (something is stuffed inside it)
	_rounded_rect(Rect2(462, 402, 90, 34), Color(0.8, 0.8, 0.76), 12)
	for i in range(8):
		draw_line(Vector2(472 + i * 10.0, 404), Vector2(472 + i * 10.0, 434), Color(0.4, 0.46, 0.6, 0.7), 2.0)
	_ellipse(Vector2(506, 414), Vector2(22, 6), Color(0, 0, 0, 0.1))


## A wooden crutch leaning in the corner by the chart (it is hollow).
func _draw_crutch() -> void:
	draw_line(Vector2(590, 262), Vector2(606, 538), WOOD_DARK, 9.0)
	draw_line(Vector2(589, 262), Vector2(604, 538), WOOD, 5.0)
	draw_rect(Rect2(574, 252, 34, 12), Color(0.3, 0.12, 0.1))
	draw_rect(Rect2(586, 380, 24, 8), WOOD_DARK)
	draw_circle(Vector2(606, 538), 5.0, Color(0.1, 0.1, 0.1))


## The exposure chart. Its CHEST row is the code of the drug safe.
func _draw_exposure_chart() -> void:
	draw_rect(CHART_RECT.grow(4), WOOD_DARK)
	draw_rect(CHART_RECT, Color(0.92, 0.9, 0.8))
	var font := ThemeDB.fallback_font
	var at := CHART_RECT.position
	draw_string(font, at + Vector2(8, 18), "EXPOSURE CHART", HORIZONTAL_ALIGNMENT_LEFT, -1, 12, Color(0.5, 0.1, 0.1))
	draw_line(at + Vector2(6, 24), at + Vector2(CHART_RECT.size.x - 6, 24), INK, 1.0)
	var rows: Array[String] = ["HAND      2 s   50 kV", "FOOT      4 s   55 kV", "CHEST   12 s   85 kV", "SKULL   20 s   90 kV"]
	for i in range(rows.size()):
		var row_y := at.y + 44.0 + i * 22.0
		if i == 2:
			# Underlined in red pencil, and thumbed grey from daily use
			draw_rect(Rect2(at.x + 4, row_y - 14, CHART_RECT.size.x - 8, 19), Color(0.75, 0.72, 0.6))
			draw_line(Vector2(at.x + 6, row_y + 4), Vector2(at.x + CHART_RECT.size.x - 6, row_y + 4), Color(0.7, 0.12, 0.1), 1.5)
		draw_string(font, Vector2(at.x + 8, row_y), rows[i], HORIZONTAL_ALIGNMENT_LEFT, -1, 13 if i == 2 else 11, INK)


## The control cabinet stands on a low plinth.
func _draw_cabinet_plinths() -> void:
	draw_rect(Rect2(656, 520, 100, 20), STEEL_DARK)
	_ellipse(Vector2(706, FLOOR_Y + 4), Vector2(56, 6), Color(0, 0, 0, 0.35))
	# A thick cable from the control cabinet to the table
	draw_polyline(PackedVector2Array([Vector2(660, 530), Vector2(620, 548), Vector2(580, 546), Vector2(560, 530)]), Color(0.08, 0.08, 0.09), 4.0, true)


## A square of newer plaster in the wall (something is plastered in behind it).
func _draw_plaster_patch() -> void:
	draw_rect(PATCH_RECT, Color(0.44, 0.52, 0.47))
	draw_rect(PATCH_RECT, Color(0.2, 0.27, 0.24), false, 1.5)
	draw_polyline(PackedVector2Array([PATCH_RECT.position + Vector2(10, 0), PATCH_RECT.position + Vector2(22, 24),
		PATCH_RECT.position + Vector2(16, 44), PATCH_RECT.position + Vector2(30, 64)]), Color(0.2, 0.27, 0.24, 0.7), 1.0)
	# A little heap of mortar dust on the floor beneath it
	_ellipse(Vector2(PATCH_RECT.get_center().x, 382), Vector2(18, 3), Color(0.8, 0.8, 0.74, 0.7))


## The desk, with a kneehole for the drug safe, a blotter and a shaded lamp.
func _draw_desk() -> void:
	_ellipse(Vector2(DESK_FRONT_RECT.get_center().x, FLOOR_Y + 4), Vector2(116, 8), Color(0, 0, 0, 0.4))
	draw_rect(DESK_FRONT_RECT, WOOD)
	draw_rect(Rect2(DESK_FRONT_RECT.position.x + 10, DESK_FRONT_RECT.position.y + 46, 76, 44), WOOD_DARK, false, 2.0)
	draw_rect(KNEEHOLE_RECT, Color(0.05, 0.04, 0.03))
	draw_rect(DESK_TOP_RECT, WOOD.lightened(0.15))
	draw_rect(Rect2(DESK_TOP_RECT.position.x, DESK_TOP_RECT.end.y - 3, DESK_TOP_RECT.size.x, 3), WOOD_DARK)
	# Blotter
	draw_rect(Rect2(916, 424, 66, 6), Color(0.24, 0.4, 0.3))
	# A shaded desk lamp, switched off
	draw_line(Vector2(800, 430), Vector2(800, 398), STEEL_DARK, 3.0)
	_polygon([Vector2(782, 398), Vector2(818, 398), Vector2(810, 380), Vector2(790, 380)], Color(0.14, 0.3, 0.22))
	_ellipse(Vector2(800, 430), Vector2(12, 3), STEEL_DARK)


## A heavy lead apron on a wall hook.
func _draw_lead_apron() -> void:
	draw_arc(Vector2(952, 152), 5.0, 0.0, PI, 8, STEEL_DARK, 3.0, true)
	_polygon([Vector2(934, 160), Vector2(970, 160), Vector2(982, 330), Vector2(924, 330)], Color(0.2, 0.22, 0.26))
	_polygon([Vector2(942, 160), Vector2(962, 160), Vector2(956, 190), Vector2(948, 190)], Color(0.34, 0.44, 0.39))
	draw_line(Vector2(930, 240), Vector2(976, 240), Color(0.12, 0.13, 0.16), 2.0)
	draw_line(Vector2(940, 170), Vector2(932, 320), Color(1, 1, 1, 0.08), 3.0)


## The things on the floor that have something hidden inside them.
func _draw_floor_things() -> void:
	# An old fibre suitcase with leather corners (something is sewn into its lining)
	_ellipse(Vector2(366, 684), Vector2(64, 6), Color(0, 0, 0, 0.4))
	draw_rect(Rect2(308, 622, 116, 60), Color(0.42, 0.3, 0.2))
	draw_rect(Rect2(308, 622, 116, 60), WOOD_DARK, false, 2.0)
	draw_line(Vector2(308, 640), Vector2(424, 640), WOOD_DARK, 1.5)
	for corner: Vector2 in [Vector2(308, 622), Vector2(412, 622), Vector2(308, 670), Vector2(412, 670)]:
		draw_rect(Rect2(corner, Vector2(12, 12)), Color(0.24, 0.15, 0.1))
	draw_arc(Vector2(366, 622), 12.0, PI, TAU, 10, Color(0.24, 0.15, 0.1), 3.0, true)
	for clasp_x: float in [336.0, 396.0]:
		draw_rect(Rect2(clasp_x - 4, 636, 8, 9), Color(0.75, 0.6, 0.32))
	# One worn boot, lying on its side (its heel is hollow)
	_ellipse(Vector2(924, 686), Vector2(40, 5), Color(0, 0, 0, 0.4))
	_polygon([Vector2(892, 612), Vector2(918, 612), Vector2(922, 648), Vector2(962, 656), Vector2(966, 672),
		Vector2(894, 672)], Color(0.16, 0.12, 0.1))
	draw_rect(Rect2(894, 672, 72, 5), Color(0.08, 0.06, 0.05))
	draw_rect(Rect2(912, 672, 36, 12), Color(0.1, 0.08, 0.07))
	for i in range(4):
		draw_line(Vector2(900, 622 + i * 8.0), Vector2(914, 624 + i * 8.0), Color(0.6, 0.55, 0.45, 0.8), 1.0)
