@tool
class_name StaircaseObjects
extends RefCounted
## Placeholder drawings for the hidden objects of Chapter Four (The Grand Staircase).
## Same rules as placeholder_art.gd: every drawing is centred on (0, 0) and
## fits inside get_size(). PlaceholderArt calls these functions.

const IRON := Color(0.32, 0.32, 0.35)
const IRON_DARK := Color(0.18, 0.18, 0.2)
const IRON_SHINE := Color(0.6, 0.62, 0.66)
const TAG_PAPER := Color(0.86, 0.8, 0.64)


## Size of the drawing, or Vector2.ZERO if `style` is not one of this chapter's objects.
static func get_size(style: int) -> Vector2:
	match style:
		HiddenObjectData.PlaceholderStyle.PHONE_CORD:
			return Vector2(36, 54)
		HiddenObjectData.PlaceholderStyle.NAMEPLATE:
			return Vector2(48, 20)
		HiddenObjectData.PlaceholderStyle.RIBBON:
			return Vector2(40, 36)
		HiddenObjectData.PlaceholderStyle.KEY_RING:
			return Vector2(44, 44)
		HiddenObjectData.PlaceholderStyle.GLOVE:
			return Vector2(44, 32)
		HiddenObjectData.PlaceholderStyle.IRON_KEY:
			return Vector2(44, 26)
		HiddenObjectData.PlaceholderStyle.MAP:
			return Vector2(48, 40)
	return Vector2.ZERO


## Draws `style` and returns true, or returns false if it is not one of this chapter's objects.
static func draw(c: CanvasItem, style: int) -> bool:
	match style:
		HiddenObjectData.PlaceholderStyle.PHONE_CORD:
			_draw_phone_cord(c)
		HiddenObjectData.PlaceholderStyle.NAMEPLATE:
			_draw_nameplate(c)
		HiddenObjectData.PlaceholderStyle.RIBBON:
			_draw_ribbon(c)
		HiddenObjectData.PlaceholderStyle.KEY_RING:
			_draw_key_ring(c)
		HiddenObjectData.PlaceholderStyle.GLOVE:
			_draw_glove(c)
		HiddenObjectData.PlaceholderStyle.IRON_KEY:
			_draw_iron_key(c)
		HiddenObjectData.PlaceholderStyle.MAP:
			_draw_map(c)
		_:
			return false
	return true


## The points of a coiled cord hanging from `top` down to `bottom_y`.
static func _coil_points(top: Vector2, bottom_y: float, width: float) -> PackedVector2Array:
	var points := PackedVector2Array()
	var steps := 40
	for i in range(steps + 1):
		var t := float(i) / steps
		var y := lerpf(top.y, bottom_y, t)
		points.append(Vector2(top.x + sin(t * TAU * 5.0) * width, y))
	return points


## A curly telephone cord, sliced through, with frayed copper wires.
static func _draw_phone_cord(c: CanvasItem) -> void:
	var cord := Color(0.12, 0.11, 0.11)
	var shine := Color(0.42, 0.4, 0.4)
	# Soft shadow of the whole cord
	c.draw_polyline(_coil_points(Vector2(2, -20), 17, 7.0), Color(0, 0, 0, 0.35), 4.0, true)
	# Wall plug block at the top
	c.draw_rect(Rect2(-6, -27, 12, 7), Color(0.2, 0.18, 0.17))
	c.draw_rect(Rect2(-6, -27, 12, 2), shine)
	# The coil itself, with a thin highlight
	var coil := _coil_points(Vector2(0, -21), 15, 7.0)
	c.draw_polyline(coil, cord, 3.0, true)
	var highlight := PackedVector2Array()
	for point in coil:
		highlight.append(point + Vector2(-0.8, -0.8))
	c.draw_polyline(highlight, Color(shine, 0.6), 1.0, true)
	# Straight piece and the clean cut with frayed wires
	c.draw_line(Vector2(0, 15), Vector2(1, 20), cord, 3.0)
	c.draw_line(Vector2(1, 20), Vector2(-4, 26), Color(0.8, 0.5, 0.25), 1.2)
	c.draw_line(Vector2(1, 20), Vector2(1, 27), Color(0.75, 0.2, 0.15), 1.2)
	c.draw_line(Vector2(1, 20), Vector2(6, 25), Color(0.9, 0.88, 0.8), 1.2)
	c.draw_circle(Vector2(1, 20), 1.8, Color(0.85, 0.55, 0.3))


## The engraved brass plate from the empty frame, one corner bent where it was pried off.
static func _draw_nameplate(c: CanvasItem) -> void:
	var brass := Color(0.78, 0.63, 0.32)
	var brass_dark := Color(0.5, 0.38, 0.17)
	c.draw_rect(Rect2(-20, -5, 44, 15), Color(0, 0, 0, 0.35))
	c.draw_rect(Rect2(-23, -8, 44, 15), brass_dark)
	c.draw_rect(Rect2(-22, -7, 42, 13), brass)
	c.draw_line(Vector2(-21, -6), Vector2(18, -6), Color(1, 0.95, 0.75, 0.7), 1.0)
	# Engraved name and date
	c.draw_line(Vector2(-14, -2), Vector2(11, -2), Color(0.25, 0.18, 0.08), 1.6)
	c.draw_line(Vector2(-10, 2.5), Vector2(7, 2.5), Color(0.25, 0.18, 0.08, 0.8), 1.0)
	# Screw holes and the bent, scratched corner
	c.draw_circle(Vector2(-19, -1), 1.5, Color(0.2, 0.14, 0.06))
	c.draw_circle(Vector2(16, -1), 1.5, Color(0.2, 0.14, 0.06))
	c.draw_colored_polygon(PackedVector2Array([Vector2(14, 6), Vector2(21, 6), Vector2(21, 0)]), brass_dark)
	c.draw_line(Vector2(9, 5), Vector2(16, 1), Color(1, 1, 1, 0.45), 1.0)


## A blue ribbon tied in a double knot (bow with two notched tails).
static func _draw_ribbon(c: CanvasItem) -> void:
	var blue := Color(0.27, 0.42, 0.74)
	var blue_dark := Color(0.15, 0.25, 0.5)
	var shadow := Color(0, 0, 0, 0.35)
	# Shadow of the bow
	c.draw_colored_polygon(PackedVector2Array([Vector2(2, 2), Vector2(-15, -8), Vector2(-15, 10)]), shadow)
	c.draw_colored_polygon(PackedVector2Array([Vector2(2, 2), Vector2(19, -8), Vector2(19, 10)]), shadow)
	# Tails hanging down with V-cut ends
	c.draw_colored_polygon(PackedVector2Array([Vector2(-3, 1), Vector2(1, 3), Vector2(-6, 17), Vector2(-9, 13), Vector2(-12, 16)]), blue_dark)
	c.draw_colored_polygon(PackedVector2Array([Vector2(3, 1), Vector2(-1, 3), Vector2(8, 17), Vector2(10, 12), Vector2(13, 15)]), blue)
	# Two loops of the bow
	c.draw_colored_polygon(PackedVector2Array([Vector2(0, 0), Vector2(-9, -11), Vector2(-17, -8), Vector2(-17, 5), Vector2(-9, 8)]), blue)
	c.draw_colored_polygon(PackedVector2Array([Vector2(0, 0), Vector2(9, -11), Vector2(17, -8), Vector2(17, 5), Vector2(9, 8)]), blue)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-2, 0), Vector2(-10, -6), Vector2(-12, 2)]), blue_dark)
	c.draw_colored_polygon(PackedVector2Array([Vector2(2, 0), Vector2(10, -6), Vector2(12, 2)]), blue_dark)
	c.draw_line(Vector2(-15, -7), Vector2(-9, -9), Color(0.65, 0.78, 1.0, 0.6), 1.2)
	# The fat double knot in the middle
	PlaceholderArt.draw_ellipse(c, Vector2(0, 0), 4.5, 5, blue_dark)
	PlaceholderArt.draw_ellipse(c, Vector2(-0.5, -0.5), 3, 3.5, blue)


## A heavy iron key ring with paper door labels and no keys.
static func _draw_key_ring(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(2, 16), 18, 4, Color(0, 0, 0, 0.35))
	# The ring (dark under-ring, then the ring, then a shine)
	c.draw_arc(Vector2(1, -5), 13, 0, TAU, 32, Color(0, 0, 0, 0.35), 4.0, true)
	c.draw_arc(Vector2(0, -6), 13, 0, TAU, 32, IRON, 3.5, true)
	c.draw_arc(Vector2(0, -6), 13, PI * 1.05, PI * 1.5, 10, IRON_SHINE, 1.4, true)
	# Paper tags on strings: empty labels for every door
	var tags: Array[Vector2] = [Vector2(-14, 12), Vector2(0, 15), Vector2(14, 11)]
	var anchors: Array[Vector2] = [Vector2(-9, 3), Vector2(0, 7), Vector2(9, 3)]
	for i in range(tags.size()):
		var tag: Vector2 = tags[i]
		c.draw_line(anchors[i], tag + Vector2(0, -5), Color(0.75, 0.7, 0.6), 1.0)
		c.draw_rect(Rect2(tag + Vector2(-5, -4), Vector2(11, 9)), Color(0, 0, 0, 0.3))
		c.draw_rect(Rect2(tag + Vector2(-6, -5), Vector2(11, 9)), TAG_PAPER)
		c.draw_circle(tag + Vector2(-0.5, -3), 1.0, Color(0.5, 0.45, 0.35))
		c.draw_line(tag + Vector2(-4, 0), tag + Vector2(3, 0), Color(PlaceholderArt.INK, 0.8), 1.0)
		c.draw_line(tag + Vector2(-4, 2.5), tag + Vector2(1, 2.5), Color(PlaceholderArt.INK, 0.6), 1.0)


## A man's brown leather glove lying flat, fingers to the right, caked with lake mud.
static func _draw_glove(c: CanvasItem) -> void:
	var leather := Color(0.38, 0.25, 0.16)
	var leather_dark := Color(0.24, 0.15, 0.1)
	var mud := Color(0.3, 0.28, 0.2)
	PlaceholderArt.draw_ellipse(c, Vector2(2, 11), 21, 4, Color(0, 0, 0, 0.35))
	# Cuff
	c.draw_rect(Rect2(-21, -8, 10, 17), leather_dark)
	c.draw_line(Vector2(-19, -7), Vector2(-19, 8), Color(0.5, 0.36, 0.24), 1.0)
	# Palm
	c.draw_colored_polygon(PackedVector2Array([Vector2(-12, -9), Vector2(4, -10), Vector2(8, -4),
		Vector2(8, 6), Vector2(2, 10), Vector2(-12, 9)]), leather)
	# Four fingers, slightly spread
	var tips: Array[Vector2] = [Vector2(19, -10), Vector2(21, -4), Vector2(20, 2), Vector2(16, 7)]
	var roots: Array[Vector2] = [Vector2(5, -8), Vector2(7, -3), Vector2(7, 2), Vector2(5, 6)]
	for i in range(4):
		c.draw_line(roots[i], tips[i], leather, 5.0)
		c.draw_circle(tips[i], 2.5, leather)
		c.draw_line(roots[i] + Vector2(0, -1.5), tips[i] + Vector2(-1, -1.5), Color(0.55, 0.4, 0.28, 0.6), 1.0)
	# Thumb folded down
	c.draw_line(Vector2(-4, 8), Vector2(5, 14), leather, 5.0)
	c.draw_circle(Vector2(5, 14), 2.5, leather)
	# Stitching on the back of the hand
	for line_y: float in [-4.0, 0.0, 4.0]:
		c.draw_line(Vector2(-8, line_y), Vector2(2, line_y * 0.8), Color(leather_dark, 0.8), 1.0)
	# Drying lake mud on the fingers and palm
	PlaceholderArt.draw_ellipse(c, Vector2(15, -5), 5, 3.5, mud)
	PlaceholderArt.draw_ellipse(c, Vector2(18, 3), 3.5, 3, mud)
	PlaceholderArt.draw_ellipse(c, Vector2(-3, 4), 4, 3, Color(mud, 0.85))
	c.draw_circle(Vector2(14, -6), 1.2, Color(0.48, 0.45, 0.34))


## A small dark iron key with a paper tag reading "Hall table".
static func _draw_iron_key(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(2, 8), 20, 3, Color(0, 0, 0, 0.35))
	# Paper tag tied to the bow
	c.draw_line(Vector2(-14, -4), Vector2(-15, -9), Color(0.75, 0.7, 0.6), 1.0)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-21, -12), Vector2(-9, -12), Vector2(-9, -6), Vector2(-21, -6)]), TAG_PAPER)
	c.draw_line(Vector2(-19, -9), Vector2(-11, -9), Color(PlaceholderArt.INK, 0.85), 1.0)
	# Bow (a ring), shaft and bit
	c.draw_arc(Vector2(-12, 1), 6, 0, TAU, 18, Color(0, 0, 0, 0.35), 3.5, true)
	c.draw_arc(Vector2(-13, 0), 6, 0, TAU, 18, IRON, 3.5, true)
	c.draw_rect(Rect2(-7, -1.5, 25, 3.5), IRON)
	c.draw_line(Vector2(-7, -1.5), Vector2(18, -1.5), Color(IRON_SHINE, 0.7), 1.0)
	c.draw_rect(Rect2(12, 2, 3, 6), IRON_DARK)
	c.draw_rect(Rect2(16, 2, 3, 4), IRON_DARK)
	c.draw_arc(Vector2(-13, 0), 6, PI * 1.1, PI * 1.5, 6, IRON_SHINE, 1.2, true)


## A folded hand-drawn map: the lake, the path and an X on the boathouse.
static func _draw_map(c: CanvasItem) -> void:
	var paper := Color(0.86, 0.8, 0.64)
	var paper_shade := Color(0.76, 0.7, 0.54)
	c.draw_rect(Rect2(-20, -14, 44, 34), Color(0, 0, 0, 0.35))
	# Three folded panels, the middle one a little darker
	c.draw_rect(Rect2(-23, -17, 15, 32), paper)
	c.draw_rect(Rect2(-8, -17, 15, 32), paper_shade)
	c.draw_rect(Rect2(7, -17, 15, 32), paper)
	c.draw_line(Vector2(-8, -17), Vector2(-8, 15), Color(0.55, 0.48, 0.36), 1.0)
	c.draw_line(Vector2(7, -17), Vector2(7, 15), Color(0.55, 0.48, 0.36), 1.0)
	# The lake, the house and the dotted path between them
	PlaceholderArt.draw_ellipse(c, Vector2(9, 2), 10, 7, Color(0.32, 0.45, 0.62, 0.85))
	c.draw_rect(Rect2(-19, -13, 7, 6), Color(PlaceholderArt.INK, 0.8))
	c.draw_colored_polygon(PackedVector2Array([Vector2(-20, -13), Vector2(-15.5, -16), Vector2(-11, -13)]), Color(PlaceholderArt.INK, 0.8))
	var path: Array[Vector2] = [Vector2(-14, -5), Vector2(-12, 0), Vector2(-8, 4), Vector2(-4, 8), Vector2(0, 10), Vector2(4, 11)]
	for dot in path:
		c.draw_circle(dot, 0.9, Color(0.6, 0.15, 0.12))
	# Red X on the boathouse
	c.draw_line(Vector2(2, 8), Vector2(8, 14), Color(0.75, 0.12, 0.1), 1.8)
	c.draw_line(Vector2(8, 8), Vector2(2, 14), Color(0.75, 0.12, 0.1), 1.8)
	c.draw_line(Vector2(10, -12), Vector2(20, -12), Color(PlaceholderArt.INK, 0.6), 1.0)
