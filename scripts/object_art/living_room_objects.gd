@tool
class_name LivingRoomObjects
extends RefCounted
## Placeholder drawings for the hidden objects of Chapter Six (The Living Room).
## Same rules as placeholder_art.gd: every drawing is centred on (0, 0) and
## fits inside get_size(). PlaceholderArt calls these functions.

const BRASS := Color(0.78, 0.63, 0.3)
const BRASS_DARK := Color(0.5, 0.39, 0.17)
const PAPER := Color(0.88, 0.84, 0.72)


## Size of the drawing, or Vector2.ZERO if `style` is not one of this chapter's objects.
static func get_size(style: int) -> Vector2:
	match style:
		HiddenObjectData.PlaceholderStyle.RECORD:
			return Vector2(46, 46)
		HiddenObjectData.PlaceholderStyle.PIPE:
			return Vector2(50, 28)
		HiddenObjectData.PlaceholderStyle.MATCHBOX:
			return Vector2(38, 26)
		HiddenObjectData.PlaceholderStyle.SCARF:
			return Vector2(44, 56)
		HiddenObjectData.PlaceholderStyle.CROSSWORD:
			return Vector2(50, 38)
		HiddenObjectData.PlaceholderStyle.POLICY:
			return Vector2(42, 52)
		HiddenObjectData.PlaceholderStyle.DESK_KEY:
			return Vector2(42, 20)
		HiddenObjectData.PlaceholderStyle.KEY_BUNCH:
			return Vector2(46, 44)
	return Vector2.ZERO


## Draws `style` and returns true, or returns false if it is not one of this chapter's objects.
static func draw(c: CanvasItem, style: int) -> bool:
	match style:
		HiddenObjectData.PlaceholderStyle.RECORD:
			_draw_record(c)
		HiddenObjectData.PlaceholderStyle.PIPE:
			_draw_pipe(c)
		HiddenObjectData.PlaceholderStyle.MATCHBOX:
			_draw_matchbox(c)
		HiddenObjectData.PlaceholderStyle.SCARF:
			_draw_scarf(c)
		HiddenObjectData.PlaceholderStyle.CROSSWORD:
			_draw_crossword(c)
		HiddenObjectData.PlaceholderStyle.POLICY:
			_draw_policy(c)
		HiddenObjectData.PlaceholderStyle.DESK_KEY:
			_draw_desk_key(c)
		HiddenObjectData.PlaceholderStyle.KEY_BUNCH:
			_draw_key_bunch(c)
		_:
			return false
	return true


## Black shellac record with grooves and a red "Lake Song" label.
static func _draw_record(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(2, 3), 21, 21, Color(0, 0, 0, 0.35))
	c.draw_circle(Vector2.ZERO, 21, Color(0.06, 0.06, 0.07))
	for radius: float in [18.0, 15.5, 13.0, 10.5]:
		c.draw_arc(Vector2.ZERO, radius, 0, TAU, 32, Color(0.2, 0.2, 0.22), 1.0, true)
	# Shine across the grooves
	c.draw_arc(Vector2.ZERO, 17, PI * 1.1, PI * 1.4, 8, Color(1, 1, 1, 0.35), 2.0, true)
	c.draw_arc(Vector2.ZERO, 14, PI * 0.1, PI * 0.35, 8, Color(1, 1, 1, 0.2), 1.5, true)
	# Label and spindle hole
	c.draw_circle(Vector2.ZERO, 7.5, Color(0.5, 0.13, 0.1))
	c.draw_line(Vector2(-5, -2), Vector2(5, -2), Color(0.95, 0.85, 0.6), 1.0)
	c.draw_line(Vector2(-4, 2), Vector2(4, 2), Color(0.95, 0.85, 0.6, 0.7), 1.0)
	c.draw_circle(Vector2.ZERO, 1.6, Color(0.05, 0.05, 0.05))


## Curved briar pipe with a thin wisp of smoke (it is still warm).
static func _draw_pipe(c: CanvasItem) -> void:
	var briar := Color(0.45, 0.24, 0.13)
	var briar_dark := Color(0.28, 0.14, 0.08)
	PlaceholderArt.draw_ellipse(c, Vector2(0, 11), 23, 3, Color(0, 0, 0, 0.35))
	# Stem curving down from the mouthpiece to the bowl
	c.draw_polyline(PackedVector2Array([Vector2(-23, -2), Vector2(-12, 1), Vector2(0, 4), Vector2(8, 4)]), Color(0.1, 0.09, 0.08), 3.5, true)
	c.draw_polyline(PackedVector2Array([Vector2(-6, 3), Vector2(0, 4.5), Vector2(8, 4.5)]), briar_dark, 4.0, true)
	# Bowl
	c.draw_colored_polygon(PackedVector2Array([Vector2(6, -6), Vector2(20, -6), Vector2(19, 6),
		Vector2(15, 10), Vector2(10, 10), Vector2(6, 5)]), briar)
	c.draw_rect(Rect2(6, -8, 14, 3), briar_dark)
	PlaceholderArt.draw_ellipse(c, Vector2(13, -7), 5, 1.2, Color(0.08, 0.05, 0.04))
	c.draw_circle(Vector2(13, -7), 1.4, Color(1.0, 0.45, 0.15, 0.8))
	c.draw_line(Vector2(8, -3), Vector2(8, 5), Color(0.65, 0.4, 0.25, 0.7), 1.5)
	# Smoke
	c.draw_polyline(PackedVector2Array([Vector2(13, -9), Vector2(11, -12), Vector2(14, -14)]), Color(0.85, 0.85, 0.85, 0.45), 1.2, true)


## Small sliding matchbox from the Blackwater Inn, three matches peeking out.
static func _draw_matchbox(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(1, 10), 18, 3, Color(0, 0, 0, 0.35))
	# Tray pushed out to the right, with three match heads
	c.draw_rect(Rect2(2, -8, 15, 15), Color(0.72, 0.62, 0.45))
	for i in range(3):
		var y := -5.0 + i * 4.5
		c.draw_line(Vector2(4, y), Vector2(13, y), Color(0.85, 0.75, 0.55), 2.0)
		c.draw_circle(Vector2(14, y), 1.8, Color(0.62, 0.12, 0.1))
	# Sleeve with a dark blue label and the striker strip
	c.draw_rect(Rect2(-17, -9, 26, 17), Color(0.16, 0.22, 0.38))
	c.draw_rect(Rect2(-17, 6, 26, 3), Color(0.32, 0.2, 0.14))
	c.draw_rect(Rect2(-14, -6, 20, 9), Color(0.85, 0.78, 0.55))
	# A tiny lake and the inn's name
	PlaceholderArt.draw_ellipse(c, Vector2(-4, 0), 7, 2, Color(0.25, 0.4, 0.6))
	c.draw_line(Vector2(-12, -4), Vector2(4, -4), Color(0.5, 0.12, 0.1), 1.0)


## A half-knitted mustard striped scarf hanging over a chair arm, needles still in it.
static func _draw_scarf(c: CanvasItem) -> void:
	var wool := Color(0.74, 0.56, 0.24)
	var wool_dark := Color(0.52, 0.37, 0.14)
	var stripe := Color(0.55, 0.16, 0.16)
	PlaceholderArt.draw_ellipse(c, Vector2(1, 25), 16, 3, Color(0, 0, 0, 0.3))
	# The fold over the arm (top) and the two hanging ends
	c.draw_colored_polygon(PackedVector2Array([Vector2(-18, -20), Vector2(14, -20), Vector2(18, -12),
		Vector2(-20, -12)]), wool_dark)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-20, -13), Vector2(-6, -13), Vector2(-5, 22), Vector2(-17, 24)]), wool)
	c.draw_colored_polygon(PackedVector2Array([Vector2(3, -13), Vector2(17, -13), Vector2(19, 10), Vector2(6, 12)]), wool)
	# Stripes and knit texture
	for y: float in [-4.0, 10.0]:
		c.draw_line(Vector2(-19, y), Vector2(-5, y), stripe, 2.0)
	c.draw_line(Vector2(4, 0), Vector2(18, 0), stripe, 2.0)
	for i in range(4):
		c.draw_line(Vector2(-16 + i * 3.5, -12), Vector2(-15 + i * 3.5, 21), Color(wool_dark, 0.6), 1.0)
	# Fringe on the finished end
	for i in range(4):
		c.draw_line(Vector2(-16 + i * 3.5, 23), Vector2(-16 + i * 3.5, 27), wool, 1.5)
	# The stitched 'E' in the corner
	c.draw_string(ThemeDB.fallback_font, Vector2(-16, 20), "E", HORIZONTAL_ALIGNMENT_LEFT, -1, 9, stripe)
	# Unfinished end: knitting needles crossed through it
	c.draw_line(Vector2(2, 14), Vector2(22, 4), Color(0.75, 0.72, 0.66), 1.6)
	c.draw_line(Vector2(4, 4), Vector2(21, 16), Color(0.75, 0.72, 0.66), 1.6)
	c.draw_circle(Vector2(2, 14), 1.8, wool_dark)
	c.draw_circle(Vector2(4, 4), 1.8, wool_dark)


## A folded newspaper page with a pencilled-in crossword grid.
static func _draw_crossword(c: CanvasItem) -> void:
	var news := Color(0.8, 0.78, 0.7)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-20, -14), Vector2(26, -12), Vector2(24, 19), Vector2(-22, 17)]), Color(0, 0, 0, 0.35))
	c.draw_colored_polygon(PackedVector2Array([Vector2(-23, -17), Vector2(23, -15), Vector2(21, 16), Vector2(-25, 14)]), news)
	# Fold line and the folded-back flap
	c.draw_line(Vector2(-1, -16), Vector2(-3, 15), Color(0.6, 0.58, 0.5), 1.0)
	# Column of print on the left half
	for i in range(6):
		c.draw_line(Vector2(-20, -11 + i * 4.5), Vector2(-6, -11 + i * 4.5), Color(PlaceholderArt.INK, 0.5), 1.0)
	c.draw_rect(Rect2(-20, -15, 15, 2.5), Color(PlaceholderArt.INK, 0.85))
	# The crossword grid on the right half
	var grid := Rect2(2, -11, 18, 20)
	c.draw_rect(grid, Color(0.95, 0.94, 0.9))
	for i in range(5):
		c.draw_line(Vector2(grid.position.x + i * 4.5, grid.position.y), Vector2(grid.position.x + i * 4.5, grid.end.y), Color(0.15, 0.15, 0.15), 0.8)
		c.draw_line(Vector2(grid.position.x, grid.position.y + i * 5.0), Vector2(grid.end.x, grid.position.y + i * 5.0), Color(0.15, 0.15, 0.15), 0.8)
	for cell: Vector2 in [Vector2(1, 0), Vector2(3, 2), Vector2(0, 3)]:
		c.draw_rect(Rect2(grid.position + cell * Vector2(4.5, 5.0), Vector2(4.5, 5.0)), Color(0.12, 0.12, 0.12))
	# A pencil lying across it
	c.draw_line(Vector2(6, 16), Vector2(24, 4), Color(0.85, 0.65, 0.2), 2.5)
	c.draw_line(Vector2(22, 5.5), Vector2(25, 3.5), Color(0.25, 0.22, 0.2), 2.5)


## An official insurance policy: crest, typed heading and a red stamp.
static func _draw_policy(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-16, -22, 36, 48), Color(0, 0, 0, 0.35))
	c.draw_rect(Rect2(-19, -25, 36, 48), PAPER)
	c.draw_rect(Rect2(-19, -25, 36, 48), Color(0.45, 0.4, 0.3), false, 1.0)
	# Blue crest and heading
	c.draw_circle(Vector2(-1, -18), 4, Color(0.2, 0.28, 0.5))
	c.draw_circle(Vector2(-1, -18), 2, Color(0.75, 0.68, 0.4))
	c.draw_rect(Rect2(-13, -11, 24, 3), Color(0.2, 0.28, 0.5))
	for i in range(5):
		c.draw_line(Vector2(-15, -4 + i * 4.5), Vector2(12.0 - (i % 2) * 6.0, -4 + i * 4.5), Color(PlaceholderArt.INK, 0.6), 1.0)
	# "PAID" stamp, tilted
	c.draw_rect(Rect2(-14, 13, 14, 7), Color(0.7, 0.15, 0.12, 0.8), false, 1.3)
	c.draw_line(Vector2(-12, 16.5), Vector2(-2, 16.5), Color(0.7, 0.15, 0.12, 0.8), 1.2)
	c.draw_polyline(PackedVector2Array([Vector2(3, 18), Vector2(6, 14), Vector2(9, 19), Vector2(13, 15)]), Color(PlaceholderArt.INK, 0.85), 1.1)


## A small brass desk key with a round bow.
static func _draw_desk_key(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(1, 7), 19, 2.5, Color(0, 0, 0, 0.35))
	c.draw_arc(Vector2(-13, 0), 6, 0, TAU, 18, BRASS_DARK, 3.5, true)
	c.draw_arc(Vector2(-13, 0), 6, PI, PI * 1.6, 8, Color(1, 0.95, 0.7, 0.7), 1.2, true)
	c.draw_rect(Rect2(-7, -2, 3, 4), BRASS_DARK)
	c.draw_rect(Rect2(-4, -1.5, 22, 3), BRASS)
	c.draw_line(Vector2(-4, -1.5), Vector2(18, -1.5), Color(1, 0.95, 0.75, 0.6), 1.0)
	c.draw_rect(Rect2(12, 1, 3, 5), BRASS_DARK)
	c.draw_rect(Rect2(16, 1, 2, 3.5), BRASS_DARK)


## An iron ring with five labelled keys, one empty label hook.
static func _draw_key_bunch(c: CanvasItem) -> void:
	var iron := Color(0.45, 0.45, 0.47)
	PlaceholderArt.draw_ellipse(c, Vector2(1, 18), 21, 3.5, Color(0, 0, 0, 0.35))
	c.draw_arc(Vector2(0, -12), 9, 0, TAU, 24, iron, 2.5, true)
	var colors: Array[Color] = [BRASS, Color(0.6, 0.6, 0.62), BRASS_DARK, Color(0.62, 0.38, 0.22), BRASS]
	for i in range(5):
		var angle := PI * 0.18 + PI * 0.64 * i / 4.0
		var start := Vector2(0, -12) + Vector2.from_angle(angle) * 9.0
		var tip := start + Vector2.from_angle(angle) * 17.0
		var key_color: Color = colors[i]
		c.draw_circle(start + Vector2.from_angle(angle) * 3.0, 3.0, key_color)
		c.draw_line(start + Vector2.from_angle(angle) * 3.0, tip, key_color, 2.2)
		c.draw_line(tip, tip + Vector2.from_angle(angle + PI * 0.5) * 4.0, key_color, 2.0)
	# Paper labels on strings, one hanging empty
	c.draw_line(Vector2(-8, -16), Vector2(-17, -14), Color(0.8, 0.78, 0.7), 1.0)
	c.draw_rect(Rect2(-23, -16, 7, 9), PAPER)
	c.draw_line(Vector2(-22, -12), Vector2(-18, -12), Color(PlaceholderArt.INK, 0.7), 1.0)
	c.draw_line(Vector2(8, -16), Vector2(16, -15), Color(0.8, 0.78, 0.7), 1.0)
	c.draw_rect(Rect2(15, -18, 7, 9), PAPER)
