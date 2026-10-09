@tool
class_name WorkshopObjects
extends RefCounted
## Placeholder drawings for the hidden objects of House Two, Chapter Four (The Workshop).
## Same rules as placeholder_art.gd: every drawing is centred on (0, 0) and
## fits inside get_size(). PlaceholderArt finds this file by its path.

const BRASS := Color(0.8, 0.62, 0.3)
const BRASS_DARK := Color(0.52, 0.38, 0.16)
const IRON := Color(0.36, 0.35, 0.35)
const IRON_DARK := Color(0.2, 0.19, 0.19)
const STEEL := Color(0.66, 0.68, 0.7)
const BEECH := Color(0.72, 0.55, 0.34)
const BEECH_DARK := Color(0.5, 0.36, 0.2)
const OAK := Color(0.55, 0.38, 0.22)
const PAPER := Color(0.9, 0.87, 0.76)
const BLUEPRINT := Color(0.78, 0.84, 0.9)
const PENCIL := Color(0.25, 0.27, 0.35)
const RED_INK := Color(0.78, 0.15, 0.12)
const INK := Color(0.16, 0.14, 0.2)
const SHADOW := Color(0, 0, 0, 0.35)

## Size of the hull plan drawing. TornPieces uses it to fit the four torn pieces together.
const HULL_PLAN_SIZE := Vector2(64, 46)


## Size of the drawing, or Vector2.ZERO if `style` is not one of this chapter's objects.
static func get_size(style: int) -> Vector2:
	match style:
		HiddenObjectData.PlaceholderStyle.HAND_DRILL:
			return Vector2(62, 34)
		HiddenObjectData.PlaceholderStyle.WOODEN_BUNG:
			return Vector2(28, 24)
		HiddenObjectData.PlaceholderStyle.OIL_CAN:
			return Vector2(40, 40)
		HiddenObjectData.PlaceholderStyle.WOOD_PLANE:
			return Vector2(56, 28)
		HiddenObjectData.PlaceholderStyle.PAINT_TIN:
			return Vector2(34, 36)
		HiddenObjectData.PlaceholderStyle.LETTER_STENCIL:
			return Vector2(54, 30)
		HiddenObjectData.PlaceholderStyle.WORK_GLOVE:
			return Vector2(38, 44)
		HiddenObjectData.PlaceholderStyle.JOB_BOOK:
			return Vector2(52, 38)
		HiddenObjectData.PlaceholderStyle.HULL_PLAN:
			return HULL_PLAN_SIZE
		HiddenObjectData.PlaceholderStyle.CUPBOARD_KEY:
			return Vector2(46, 18)
		HiddenObjectData.PlaceholderStyle.BOAT_MODEL:
			return Vector2(62, 42)
		HiddenObjectData.PlaceholderStyle.MALLET:
			return Vector2(56, 30)
		HiddenObjectData.PlaceholderStyle.DIVING_LAMP:
			return Vector2(38, 50)
	return Vector2.ZERO


## Draws `style` and returns true, or returns false if it is not one of this chapter's objects.
static func draw(c: CanvasItem, style: int) -> bool:
	match style:
		HiddenObjectData.PlaceholderStyle.HAND_DRILL:
			_draw_hand_drill(c)
		HiddenObjectData.PlaceholderStyle.WOODEN_BUNG:
			_draw_wooden_bung(c)
		HiddenObjectData.PlaceholderStyle.OIL_CAN:
			_draw_oil_can(c)
		HiddenObjectData.PlaceholderStyle.WOOD_PLANE:
			_draw_wood_plane(c)
		HiddenObjectData.PlaceholderStyle.PAINT_TIN:
			_draw_paint_tin(c)
		HiddenObjectData.PlaceholderStyle.LETTER_STENCIL:
			_draw_letter_stencil(c)
		HiddenObjectData.PlaceholderStyle.WORK_GLOVE:
			_draw_work_glove(c)
		HiddenObjectData.PlaceholderStyle.JOB_BOOK:
			_draw_job_book(c)
		HiddenObjectData.PlaceholderStyle.HULL_PLAN:
			_draw_hull_plan(c)
		HiddenObjectData.PlaceholderStyle.CUPBOARD_KEY:
			_draw_cupboard_key(c)
		HiddenObjectData.PlaceholderStyle.BOAT_MODEL:
			_draw_boat_model(c)
		HiddenObjectData.PlaceholderStyle.MALLET:
			_draw_mallet(c)
		HiddenObjectData.PlaceholderStyle.DIVING_LAMP:
			_draw_diving_lamp(c)
		_:
			return false
	return true


## An old-fashioned wheel brace (a hand drill): crank wheel, handle and a long bit.
static func _draw_hand_drill(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 14), 28, 3, SHADOW)
	# The long steel shaft and the drill bit, with fresh wood dust on the tip
	c.draw_line(Vector2(-26, 0), Vector2(18, 0), IRON, 4.0)
	c.draw_line(Vector2(-26, -1), Vector2(18, -1), Color(STEEL, 0.6), 1.0)
	c.draw_line(Vector2(18, 0), Vector2(30, 0), STEEL, 2.0)
	for i in range(4):
		c.draw_line(Vector2(19 + i * 3, -2), Vector2(21 + i * 3, 2), IRON_DARK, 1.0)
	c.draw_circle(Vector2(29, 1), 1.8, Color(0.85, 0.72, 0.5))
	# The chuck
	c.draw_rect(Rect2(12, -4, 7, 8), IRON_DARK)
	# The big gear wheel and its crank handle
	c.draw_circle(Vector2(-2, -2), 11, IRON_DARK)
	c.draw_circle(Vector2(-2, -2), 9, IRON)
	for i in range(10):
		var direction := Vector2.from_angle(TAU * i / 10.0)
		c.draw_line(Vector2(-2, -2) + direction * 9.0, Vector2(-2, -2) + direction * 12.0, IRON_DARK, 2.0)
	c.draw_circle(Vector2(-2, -2), 3, STEEL)
	c.draw_line(Vector2(-2, -2), Vector2(5, -12), IRON, 2.5)
	c.draw_rect(Rect2(3, -16, 5, 7), BEECH)
	# The wooden end handle (pressed against the chest while drilling)
	PlaceholderArt.draw_ellipse(c, Vector2(-26, 0), 5, 8, BEECH_DARK)
	PlaceholderArt.draw_ellipse(c, Vector2(-25, -1), 3.5, 6, BEECH)
	# A side handle
	c.draw_rect(Rect2(-17, 2, 5, 11), BEECH)
	c.draw_line(Vector2(-16, 3), Vector2(-16, 12), Color(1, 1, 1, 0.3), 1.0)


## A tapered wooden plug, the size of a thumb, with a pencilled number.
static func _draw_wooden_bung(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 9), 13, 2.5, SHADOW)
	# Tapered body seen from the side, lying down
	c.draw_colored_polygon(PackedVector2Array([Vector2(-12, -8), Vector2(6, -5), Vector2(6, 5), Vector2(-12, 8)]), OAK)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-12, -8), Vector2(6, -5), Vector2(6, -2), Vector2(-12, -3)]), BEECH)
	# The wide end: wood grain rings
	PlaceholderArt.draw_ellipse(c, Vector2(-12, 0), 3.5, 8, BEECH)
	c.draw_arc(Vector2(-12, 0), 2, 0, TAU, 8, BEECH_DARK, 1.0)
	c.draw_arc(Vector2(-12, 0), 4, -PI / 2, PI / 2, 8, BEECH_DARK, 0.8)
	# The narrow end, dark with lake water and grease
	PlaceholderArt.draw_ellipse(c, Vector2(6, 0), 2.5, 5, Color(0.24, 0.18, 0.12))
	# A pencilled number and a pull-loop of wire
	c.draw_line(Vector2(-6, -1), Vector2(-6, 4), PENCIL, 1.0)
	c.draw_arc(Vector2(-16, 0), 4, PI * 0.5, PI * 1.5, 8, STEEL, 1.4)


## A pump oil can with a long thin spout.
static func _draw_oil_can(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(-4, 18), 14, 2.5, SHADOW)
	# Round squat body
	PlaceholderArt.draw_ellipse(c, Vector2(-4, 8), 13, 9, Color(0.25, 0.38, 0.3))
	PlaceholderArt.draw_ellipse(c, Vector2(-7, 5), 6, 4, Color(0.4, 0.55, 0.45))
	c.draw_rect(Rect2(-17, 8, 26, 9), Color(0.25, 0.38, 0.3))
	c.draw_line(Vector2(-17, 16), Vector2(9, 16), Color(0.15, 0.24, 0.19), 2.0)
	# Brass pump top and thumb lever
	c.draw_rect(Rect2(-8, -4, 8, 6), BRASS_DARK)
	c.draw_rect(Rect2(-7, -4, 3, 6), BRASS)
	c.draw_line(Vector2(-10, -5), Vector2(-2, -9), BRASS, 2.0)
	# The long spout, with a drip of oil on the end
	c.draw_line(Vector2(-1, -3), Vector2(18, -18), BRASS_DARK, 3.0)
	c.draw_line(Vector2(-1, -4), Vector2(18, -19), BRASS, 1.0)
	c.draw_circle(Vector2(19, -16), 1.6, Color(0.35, 0.27, 0.05))


## A wooden smoothing plane with a steel blade and a curl of shaving.
static func _draw_wood_plane(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 12), 27, 2.5, SHADOW)
	# Body
	c.draw_colored_polygon(PackedVector2Array([Vector2(-26, 2), Vector2(-22, -4), Vector2(22, -4), Vector2(26, 2),
		Vector2(26, 10), Vector2(-26, 10)]), BEECH_DARK)
	c.draw_rect(Rect2(-24, -3, 48, 4), BEECH)
	# Blade and wedge sticking up out of the middle
	c.draw_colored_polygon(PackedVector2Array([Vector2(-2, -4), Vector2(4, -4), Vector2(0, -14), Vector2(-5, -14)]), STEEL)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-8, -4), Vector2(-2, -4), Vector2(-6, -11), Vector2(-11, -11)]), OAK)
	# Front knob and the rear tote
	c.draw_circle(Vector2(17, -6), 4, OAK)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-22, -4), Vector2(-14, -4), Vector2(-17, -12), Vector2(-23, -12)]), OAK)
	# A curl of pale shaving caught in the mouth
	c.draw_arc(Vector2(9, -7), 4, PI * 0.9, PI * 2.4, 10, Color(0.92, 0.82, 0.62), 2.0)


## A tin of white boat paint, lid off, a drip down the side and a wet rim.
static func _draw_paint_tin(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 16), 15, 2.5, SHADOW)
	c.draw_rect(Rect2(-13, -10, 26, 25), Color(0.55, 0.58, 0.6))
	c.draw_rect(Rect2(-13, -10, 6, 25), Color(0.72, 0.75, 0.77))
	PlaceholderArt.draw_ellipse(c, Vector2(0, 15), 13, 3, Color(0.42, 0.44, 0.46))
	# Paper label
	c.draw_rect(Rect2(-13, -2, 26, 11), Color(0.8, 0.25, 0.18))
	c.draw_line(Vector2(-8, 3), Vector2(8, 3), Color(0.95, 0.9, 0.8), 2.0)
	# The open top, full of white paint
	PlaceholderArt.draw_ellipse(c, Vector2(0, -10), 13, 4, Color(0.4, 0.42, 0.44))
	PlaceholderArt.draw_ellipse(c, Vector2(0, -10), 11, 3, Color(0.96, 0.95, 0.92))
	# Fresh drips down the side
	c.draw_line(Vector2(6, -8), Vector2(6, 4), Color(0.96, 0.95, 0.92), 2.5)
	c.draw_circle(Vector2(6, 5), 1.8, Color(0.96, 0.95, 0.92))
	c.draw_line(Vector2(-3, -8), Vector2(-3, -3), Color(0.96, 0.95, 0.92), 2.0)
	# The wire handle
	c.draw_arc(Vector2(0, -8), 15, PI * 1.05, PI * 1.95, 12, IRON_DARK, 1.2)


## A brass letter stencil plate with cut-out letters, smeared with wet white paint.
static func _draw_letter_stencil(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-24, -11, 52, 26), SHADOW)
	c.draw_rect(Rect2(-27, -14, 54, 26), BRASS_DARK)
	c.draw_rect(Rect2(-26, -13, 52, 24), BRASS)
	c.draw_line(Vector2(-26, -13), Vector2(26, -13), Color(1, 0.95, 0.75, 0.6), 1.0)
	# Cut-out letters: you can see the dark bench through them
	var hole := Color(0.18, 0.12, 0.08)
	c.draw_string(ThemeDB.fallback_font, Vector2(-20, 6), "SWAN", HORIZONTAL_ALIGNMENT_LEFT, 46, 15, hole)
	# The little bridges that hold the middles of the letters in
	c.draw_line(Vector2(-23, -2), Vector2(26, -2), BRASS, 1.0)
	# Wet white paint smeared across one end
	PlaceholderArt.draw_ellipse(c, Vector2(15, 4), 9, 5, Color(0.96, 0.95, 0.92, 0.85))
	c.draw_line(Vector2(10, 9), Vector2(10, 13), Color(0.96, 0.95, 0.92, 0.85), 2.0)
	# Hanging hole
	c.draw_circle(Vector2(-22, -9), 1.6, hole)


## A leather work glove, dark and soaked with lake water, a puddle under it.
static func _draw_work_glove(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 18), 17, 4, Color(0.3, 0.38, 0.45, 0.45))
	var leather := Color(0.42, 0.3, 0.2)
	var wet := Color(0.28, 0.2, 0.14)
	# Cuff
	c.draw_colored_polygon(PackedVector2Array([Vector2(-10, 8), Vector2(10, 8), Vector2(12, 21), Vector2(-12, 21)]), Color(0.5, 0.4, 0.3))
	c.draw_line(Vector2(-11, 12), Vector2(11, 12), Color(0.36, 0.28, 0.2), 1.0)
	# Palm and four fingers
	c.draw_colored_polygon(PackedVector2Array([Vector2(-11, 9), Vector2(11, 9), Vector2(12, -6), Vector2(-10, -6)]), leather)
	for i in range(4):
		var x := -8.5 + i * 6.0
		var top := -19.0 + absf(i - 1.5) * 2.5
		c.draw_rect(Rect2(x - 2.6, top, 5.2, -6.0 - top), leather)
		c.draw_circle(Vector2(x, top), 2.6, leather)
	# Thumb sticking out to the side
	c.draw_colored_polygon(PackedVector2Array([Vector2(-10, 4), Vector2(-10, -4), Vector2(-17, -10), Vector2(-20, -7),
		Vector2(-14, 3)]), leather)
	# Dark wet patches and drops of water
	PlaceholderArt.draw_ellipse(c, Vector2(2, 0), 7, 6, wet)
	PlaceholderArt.draw_ellipse(c, Vector2(-5, -12), 2.5, 4, wet)
	for drop: Vector2 in [Vector2(13, 14), Vector2(-14, 16), Vector2(6, 19)]:
		c.draw_circle(drop, 1.4, Color(0.75, 0.85, 0.95, 0.85))


## Greaves's job book: a cloth-bound ledger, open, with a bookmark ribbon.
static func _draw_job_book(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-23, -14, 50, 34), SHADOW)
	# Cover (green cloth) behind the open pages
	c.draw_rect(Rect2(-26, -17, 52, 34), Color(0.22, 0.32, 0.24))
	# Two pages
	c.draw_rect(Rect2(-24, -15, 23, 30), PAPER)
	c.draw_rect(Rect2(1, -15, 23, 30), Color(0.94, 0.91, 0.8))
	c.draw_line(Vector2(0, -15), Vector2(0, 15), Color(0.6, 0.55, 0.45), 1.5)
	# Ruled columns and lines of handwriting
	for page_x: float in [-22.0, 3.0]:
		c.draw_line(Vector2(page_x + 5, -13), Vector2(page_x + 5, 13), Color(0.75, 0.3, 0.3, 0.6), 0.8)
		for row in range(6):
			var length := 13.0 if (row + int(page_x)) % 3 else 9.0
			c.draw_line(Vector2(page_x + 7, -10 + row * 4.2), Vector2(page_x + 7 + length, -10 + row * 4.2), INK, 0.9)
	# A heavy ink cross against one entry
	c.draw_line(Vector2(6, 2), Vector2(20, 8), RED_INK, 1.2)
	# Red bookmark ribbon
	c.draw_line(Vector2(1, 15), Vector2(4, 21), Color(0.7, 0.12, 0.12), 2.0)


## The torn hull plan, put back together: four pieces with jagged tears and strips
## of tape, a pencilled side view of a boat with five red crosses below the waterline.
static func _draw_hull_plan(c: CanvasItem) -> void:
	var half := HULL_PLAN_SIZE / 2.0
	c.draw_rect(Rect2(-half.x + 3, -half.y + 3, HULL_PLAN_SIZE.x, HULL_PLAN_SIZE.y), SHADOW)
	for quarter in range(4):
		draw_hull_plan_piece(c, quarter, piece_offset(quarter))
	# Strips of brown tape over the tears
	c.draw_rect(Rect2(-4, -half.y + 2, 8, 9), Color(0.75, 0.6, 0.35, 0.7))
	c.draw_rect(Rect2(-half.x + 6, -3, 9, 6), Color(0.75, 0.6, 0.35, 0.7))
	c.draw_rect(Rect2(half.x - 15, -3, 9, 6), Color(0.75, 0.6, 0.35, 0.7))


## Where the centre of each torn quarter sits inside the whole plan (0 top-left,
## 1 top-right, 2 bottom-left, 3 bottom-right).
static func piece_offset(quarter: int) -> Vector2:
	var quarter_size := HULL_PLAN_SIZE / 2.0
	return Vector2((quarter % 2 - 0.5) * quarter_size.x, (int(quarter / 2) - 0.5) * quarter_size.y)


## One torn quarter of the hull plan, centred on `at`. Used by the plan itself
## and by TornPieces (for the scraps lying around the room).
static func draw_hull_plan_piece(c: CanvasItem, quarter: int, at: Vector2) -> void:
	var w := HULL_PLAN_SIZE.x / 2.0
	var h := HULL_PLAN_SIZE.y / 2.0
	var right := quarter % 2 == 1
	var bottom := quarter >= 2
	# The outline: straight outer edges, jagged edges where the paper was torn.
	var points := PackedVector2Array()
	var left_x := -w / 2.0
	var top_y := -h / 2.0
	var corner := Vector2(left_x, top_y)
	var tear_x := w / 2.0 if not right else -w / 2.0
	var tear_y := h / 2.0 if not bottom else -h / 2.0
	# Walk round the rectangle clockwise; the inner edges (towards the middle of the plan) get teeth.
	var corners := [corner, Vector2(-left_x, top_y), Vector2(-left_x, -top_y), Vector2(left_x, -top_y)]
	for side in range(4):
		var from: Vector2 = corners[side]
		var to: Vector2 = corners[(side + 1) % 4]
		points.append(from)
		var torn := false
		if side == 1 and tear_x > 0.0:
			torn = true  # right edge
		elif side == 3 and tear_x < 0.0:
			torn = true  # left edge
		elif side == 2 and tear_y > 0.0:
			torn = true  # bottom edge
		elif side == 0 and tear_y < 0.0:
			torn = true  # top edge
		if torn:
			var normal := (to - from).normalized().orthogonal()
			for i in range(1, 6):
				var tooth := 1.6 if i % 2 == 0 else -1.4
				points.append(from.lerp(to, i / 6.0) + normal * tooth)
	var shifted := PackedVector2Array()
	for point in points:
		shifted.append(point + at)
	c.draw_colored_polygon(shifted, BLUEPRINT)
	shifted.append(shifted[0])
	c.draw_polyline(shifted, Color(0.55, 0.62, 0.72), 1.0)
	# The pencil drawing on this quarter: part of the boat's side view.
	var origin := at - piece_offset(quarter)  # the centre of the whole plan
	var hull := PackedVector2Array([origin + Vector2(-26, -8), origin + Vector2(26, -12), origin + Vector2(22, 4),
		origin + Vector2(10, 12), origin + Vector2(-20, 12), origin + Vector2(-26, 2), origin + Vector2(-26, -8)])
	var clip := Rect2(at - Vector2(w, h) / 2.0, Vector2(w, h)).grow(-1.5)
	_draw_clipped_polyline(c, hull, clip, PENCIL, 1.0)
	_draw_clipped_polyline(c, PackedVector2Array([origin + Vector2(-26, 0), origin + Vector2(24, 0)]), clip,
		Color(0.25, 0.4, 0.75), 1.0)  # the waterline
	# The five holes, marked with red crosses below the waterline.
	for x: float in [-17.0, -8.0, 0.0, 8.0, 15.0]:
		var spot := origin + Vector2(x, 6)
		if clip.has_point(spot):
			c.draw_line(spot + Vector2(-2, -2), spot + Vector2(2, 2), RED_INK, 1.4)
			c.draw_line(spot + Vector2(-2, 2), spot + Vector2(2, -2), RED_INK, 1.4)
	# Title in the top-left corner, a scale bar bottom-right
	if quarter == 0:
		c.draw_line(origin + Vector2(-28, -18), origin + Vector2(-12, -18), PENCIL, 1.4)
		c.draw_line(origin + Vector2(-28, -15), origin + Vector2(-18, -15), PENCIL, 0.8)
	elif quarter == 3:
		c.draw_line(origin + Vector2(14, 18), origin + Vector2(28, 18), PENCIL, 1.2)
		c.draw_line(origin + Vector2(14, 16), origin + Vector2(14, 20), PENCIL, 1.0)


## Draws only the parts of a polyline whose both ends lie inside `clip` (good
## enough for a tiny pencil sketch split across four torn pieces).
static func _draw_clipped_polyline(c: CanvasItem, points: PackedVector2Array, clip: Rect2, color: Color, width: float) -> void:
	for i in range(points.size() - 1):
		var steps := 8
		for s in range(steps):
			var a := points[i].lerp(points[i + 1], float(s) / steps)
			var b := points[i].lerp(points[i + 1], float(s + 1) / steps)
			if clip.has_point(a) and clip.has_point(b):
				c.draw_line(a, b, color, width)


## A long iron cupboard key with a paper tag.
static func _draw_cupboard_key(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 7), 21, 2, SHADOW)
	c.draw_arc(Vector2(-14, 0), 6, 0, TAU, 14, IRON_DARK, 3.0)
	c.draw_rect(Rect2(-8, -1.5, 26, 3), IRON)
	c.draw_rect(Rect2(13, 1, 3, 5), IRON)
	c.draw_rect(Rect2(17, 1, 3, 4), IRON)
	c.draw_line(Vector2(-8, -1), Vector2(16, -1), Color(1, 1, 1, 0.3), 0.8)
	# A brown paper tag on string: "TOOL CUPBD."
	c.draw_line(Vector2(-19, 2), Vector2(-21, 6), Color(0.85, 0.82, 0.7), 1.0)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-23, 5), Vector2(-15, 5), Vector2(-15, 9), Vector2(-23, 9)]), Color(0.78, 0.66, 0.45))
	c.draw_line(Vector2(-22, 7), Vector2(-16, 7), INK, 0.8)


## A painted model of the Lady Margaret on a little stand: dark blue hull, white cabin, red boot-top.
static func _draw_boat_model(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 19), 28, 2.5, SHADOW)
	# Stand
	c.draw_rect(Rect2(-20, 14, 40, 5), OAK)
	c.draw_line(Vector2(-12, 14), Vector2(-10, 6), BRASS_DARK, 2.0)
	c.draw_line(Vector2(12, 14), Vector2(10, 6), BRASS_DARK, 2.0)
	# Hull
	c.draw_colored_polygon(PackedVector2Array([Vector2(-29, -4), Vector2(30, -8), Vector2(22, 4), Vector2(14, 9),
		Vector2(-24, 9), Vector2(-29, 2)]), Color(0.14, 0.2, 0.36))
	c.draw_colored_polygon(PackedVector2Array([Vector2(-28, 4), Vector2(18, 4), Vector2(14, 9), Vector2(-24, 9)]), Color(0.6, 0.16, 0.12))
	c.draw_line(Vector2(-29, -4), Vector2(30, -8), Color(0.9, 0.88, 0.8), 1.5)
	# Name on the bow, too small to read without zooming
	c.draw_line(Vector2(10, -3), Vector2(22, -4), Color(0.9, 0.85, 0.6), 1.0)
	# Cabin and wheelhouse
	c.draw_rect(Rect2(-14, -15, 22, 10), Color(0.92, 0.9, 0.84))
	c.draw_rect(Rect2(-8, -21, 10, 7), Color(0.92, 0.9, 0.84))
	for i in range(3):
		c.draw_circle(Vector2(-10 + i * 6, -10), 1.6, Color(0.3, 0.45, 0.6))
	c.draw_rect(Rect2(-7, -20, 8, 3), Color(0.3, 0.45, 0.6))
	# Funnel / mast
	c.draw_line(Vector2(12, -6), Vector2(12, -20), OAK, 1.5)
	c.draw_line(Vector2(12, -20), Vector2(-24, -6), Color(0.8, 0.8, 0.8, 0.5), 0.6)


## A carpenter's mallet: square beech head on a short handle.
static func _draw_mallet(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 12), 26, 2.5, SHADOW)
	# Handle
	c.draw_line(Vector2(-6, 0), Vector2(27, 4), OAK, 5.0)
	c.draw_line(Vector2(-6, -1.5), Vector2(27, 2.5), Color(1, 1, 1, 0.2), 1.0)
	# Head, with dented faces
	c.draw_colored_polygon(PackedVector2Array([Vector2(-27, -9), Vector2(-7, -11), Vector2(-5, 11), Vector2(-25, 13)]), BEECH)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-27, -9), Vector2(-21, -10), Vector2(-19, 12), Vector2(-25, 13)]), BEECH_DARK)
	c.draw_line(Vector2(-16, -10), Vector2(-14, 12), Color(0.6, 0.45, 0.28), 1.0)
	c.draw_circle(Vector2(-6, 3), 1.5, Color(0.4, 0.28, 0.16))
	# Splinters of fresh wood stuck to one face
	c.draw_line(Vector2(-27, -2), Vector2(-30, -4), Color(0.9, 0.78, 0.55), 1.2)


## A heavy brass diving lamp: a caged glass globe with a carry handle.
static func _draw_diving_lamp(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 23), 16, 3, SHADOW)
	# Base
	c.draw_rect(Rect2(-13, 12, 26, 10), BRASS_DARK)
	c.draw_rect(Rect2(-13, 12, 26, 3), BRASS)
	# Glass globe with a warm glint
	c.draw_circle(Vector2(0, 0), 13, Color(0.75, 0.85, 0.9, 0.85))
	c.draw_circle(Vector2(0, 2), 6, Color(0.98, 0.92, 0.65, 0.7))
	c.draw_arc(Vector2(-4, -4), 6, PI * 1.0, PI * 1.5, 6, Color(1, 1, 1, 0.9), 2.0)
	# The protective brass cage
	for x: float in [-9.0, 0.0, 9.0]:
		c.draw_line(Vector2(x * 1.0, -13 + absf(x) * 0.4), Vector2(x * 1.1, 12), BRASS_DARK, 2.0)
	c.draw_arc(Vector2(0, 0), 13, 0, TAU, 20, BRASS_DARK, 2.0)
	c.draw_line(Vector2(-13, 0), Vector2(13, 0), BRASS_DARK, 1.5)
	# Top cap and handle
	c.draw_rect(Rect2(-7, -17, 14, 5), BRASS)
	c.draw_arc(Vector2(0, -18), 8, PI, TAU, 10, IRON_DARK, 2.5)
	# A screw-on switch at the side
	c.draw_rect(Rect2(13, 14, 4, 5), IRON)
