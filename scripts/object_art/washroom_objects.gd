@tool
class_name WashroomObjects
extends RefCounted
## Placeholder drawings for the hidden objects of Chapter Five (The Washroom).
## Same rules as placeholder_art.gd: every drawing is centred on (0, 0) and
## fits inside get_size(). PlaceholderArt calls these functions.

const BRASS := Color(0.82, 0.66, 0.3)
const BRASS_DARK := Color(0.55, 0.42, 0.18)
const DROP_SHADOW := Color(0, 0, 0, 0.3)


## Size of the drawing, or Vector2.ZERO if `style` is not one of this chapter's objects.
static func get_size(style: int) -> Vector2:
	match style:
		HiddenObjectData.PlaceholderStyle.HAIRBRUSH:
			return Vector2(58, 22)
		HiddenObjectData.PlaceholderStyle.RUBBER_DUCK:
			return Vector2(40, 36)
		HiddenObjectData.PlaceholderStyle.PERFUME:
			return Vector2(28, 44)
		HiddenObjectData.PlaceholderStyle.RAZOR:
			return Vector2(54, 18)
		HiddenObjectData.PlaceholderStyle.TINY_KEY:
			return Vector2(36, 18)
		HiddenObjectData.PlaceholderStyle.PILL_BOTTLE:
			return Vector2(24, 38)
		HiddenObjectData.PlaceholderStyle.WET_PHOTO:
			return Vector2(46, 38)
		HiddenObjectData.PlaceholderStyle.SOAP:
			return Vector2(40, 26)
	return Vector2.ZERO


## Draws `style` and returns true, or returns false if it is not one of this chapter's objects.
static func draw(c: CanvasItem, style: int) -> bool:
	match style:
		HiddenObjectData.PlaceholderStyle.HAIRBRUSH:
			_draw_hairbrush(c)
		HiddenObjectData.PlaceholderStyle.RUBBER_DUCK:
			_draw_rubber_duck(c)
		HiddenObjectData.PlaceholderStyle.PERFUME:
			_draw_perfume(c)
		HiddenObjectData.PlaceholderStyle.RAZOR:
			_draw_razor(c)
		HiddenObjectData.PlaceholderStyle.TINY_KEY:
			_draw_tiny_key(c)
		HiddenObjectData.PlaceholderStyle.PILL_BOTTLE:
			_draw_pill_bottle(c)
		HiddenObjectData.PlaceholderStyle.WET_PHOTO:
			_draw_wet_photo(c)
		HiddenObjectData.PlaceholderStyle.SOAP:
			_draw_soap(c)
		_:
			return false
	return true


## Wooden hairbrush lying on its back, with long dark hairs caught in it.
static func _draw_hairbrush(c: CanvasItem) -> void:
	var wood := Color(0.5, 0.32, 0.2)
	var wood_light := Color(0.68, 0.47, 0.31)
	PlaceholderArt.draw_ellipse(c, Vector2(2, 7), 26, 3.5, DROP_SHADOW)
	# Handle
	c.draw_colored_polygon(PackedVector2Array([Vector2(-27, -2.5), Vector2(-3, -4.5),
		Vector2(-3, 4), Vector2(-27, 2.5)]), wood)
	PlaceholderArt.draw_ellipse(c, Vector2(-27, 0), 2.5, 2.5, wood)
	c.draw_line(Vector2(-25, -1.5), Vector2(-5, -3), wood_light, 1.0)
	# Oval head with a dark bristle pad
	PlaceholderArt.draw_ellipse(c, Vector2(12, 0), 15, 8, wood)
	PlaceholderArt.draw_ellipse(c, Vector2(12, -0.5), 12.5, 6, Color(0.17, 0.14, 0.13))
	for y: float in [-3.5, -0.5, 2.5]:
		for i in range(7):
			var x := 3.0 + i * 3.0
			if absf(x - 12.0) > 10.0 - absf(y) * 0.9:
				continue
			c.draw_circle(Vector2(x, y), 0.9, Color(0.82, 0.76, 0.62))
	# Long dark hairs, still damp
	c.draw_polyline(PackedVector2Array([Vector2(5, -3), Vector2(13, 2), Vector2(22, 5), Vector2(28, 9)]),
		Color(0.1, 0.07, 0.05), 1.0, true)
	c.draw_polyline(PackedVector2Array([Vector2(9, -4), Vector2(18, 0), Vector2(25, 6), Vector2(27, 10)]),
		Color(0.1, 0.07, 0.05), 1.0, true)


## A yellow rubber duck.
static func _draw_rubber_duck(c: CanvasItem) -> void:
	var yellow := Color(0.99, 0.84, 0.22)
	var yellow_dark := Color(0.86, 0.62, 0.1)
	PlaceholderArt.draw_ellipse(c, Vector2(1, 15), 17, 3, DROP_SHADOW)
	# Tail and body
	c.draw_colored_polygon(PackedVector2Array([Vector2(12, 1), Vector2(19, -5), Vector2(17, 8)]), yellow_dark)
	PlaceholderArt.draw_ellipse(c, Vector2(2, 7), 16, 8.5, yellow_dark)
	PlaceholderArt.draw_ellipse(c, Vector2(1, 5.5), 15, 7.5, yellow)
	# Wing
	PlaceholderArt.draw_ellipse(c, Vector2(5, 6), 7, 3.5, yellow_dark)
	c.draw_arc(Vector2(5, 5), 6, PI * 0.1, PI * 0.9, 8, Color(0.75, 0.52, 0.08), 1.0, true)
	# Head, beak and eye
	c.draw_circle(Vector2(-7, -7), 8, yellow)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-13, -7), Vector2(-20, -4.5), Vector2(-13, -2)]), Color(0.96, 0.5, 0.14))
	c.draw_line(Vector2(-19, -4.5), Vector2(-13, -4.5), Color(0.7, 0.32, 0.08), 1.0)
	c.draw_circle(Vector2(-9, -9), 1.7, Color(0.08, 0.08, 0.1))
	c.draw_circle(Vector2(-9.5, -9.6), 0.6, Color(1, 1, 1))
	c.draw_circle(Vector2(-4, -11), 2.0, Color(1, 1, 0.9, 0.55))


## A faceted pink perfume bottle with a gold atomiser bulb.
static func _draw_perfume(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(1, 19), 12, 2.5, DROP_SHADOW)
	# Faceted glass body and the perfume inside
	c.draw_colored_polygon(PackedVector2Array([Vector2(-11, -3), Vector2(-7, -8), Vector2(7, -8),
		Vector2(11, -3), Vector2(11, 14), Vector2(7, 19), Vector2(-7, 19), Vector2(-11, 14)]), Color(0.95, 0.66, 0.76, 0.92))
	c.draw_colored_polygon(PackedVector2Array([Vector2(-9, 3), Vector2(9, 3), Vector2(9, 13),
		Vector2(6, 17), Vector2(-6, 17), Vector2(-9, 13)]), Color(0.84, 0.4, 0.55))
	c.draw_line(Vector2(-5, -7), Vector2(-5, 18), Color(1, 1, 1, 0.3), 1.0)
	c.draw_line(Vector2(5, -7), Vector2(5, 18), Color(0.5, 0.2, 0.3, 0.3), 1.0)
	c.draw_line(Vector2(-8.5, -2), Vector2(-8.5, 12), Color(1, 1, 1, 0.6), 2.0)
	# Gold label
	c.draw_rect(Rect2(-5, 6, 10, 5), Color(0.9, 0.75, 0.4))
	# Neck, nozzle, tube and bulb with a tassel
	c.draw_rect(Rect2(-3.5, -12, 7, 4), BRASS)
	c.draw_rect(Rect2(-2, -15, 4, 3), BRASS_DARK)
	c.draw_polyline(PackedVector2Array([Vector2(2, -14), Vector2(5, -16), Vector2(7, -17)]), BRASS_DARK, 1.2, true)
	c.draw_circle(Vector2(10, -17), 3.8, Color(0.75, 0.3, 0.4))
	c.draw_circle(Vector2(9, -18), 1.2, Color(1, 0.8, 0.85, 0.7))
	c.draw_line(Vector2(12, -14), Vector2(13, -8), BRASS, 1.2)


## An open straight razor: ivory handle and a steel blade.
static func _draw_razor(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(2, 6), 25, 2.5, DROP_SHADOW)
	# Ivory handle (the scales) with the engraved initials
	c.draw_colored_polygon(PackedVector2Array([Vector2(-26, -2), Vector2(-3, -4), Vector2(0, 0),
		Vector2(-3, 3), Vector2(-26, 2)]), Color(0.92, 0.88, 0.78))
	c.draw_polyline(PackedVector2Array([Vector2(-26, 2), Vector2(-3, 3), Vector2(0, 0)]), Color(0.6, 0.55, 0.45), 1.0)
	c.draw_line(Vector2(-19, 0), Vector2(-16, 0), Color(0.35, 0.3, 0.25), 1.0)
	c.draw_line(Vector2(-14, 0), Vector2(-11, 0), Color(0.35, 0.3, 0.25), 1.0)
	# Steel blade with a bright edge
	c.draw_colored_polygon(PackedVector2Array([Vector2(0, -3), Vector2(22, -5), Vector2(26, -3),
		Vector2(26, 2), Vector2(2, 3)]), Color(0.76, 0.79, 0.83))
	c.draw_line(Vector2(0, -3), Vector2(22, -5), Color(0.45, 0.48, 0.52), 1.5)
	c.draw_line(Vector2(2, 2.5), Vector2(26, 1.5), Color(1, 1, 1, 0.9), 1.0)
	c.draw_line(Vector2(6, -1), Vector2(20, -2), Color(1, 1, 1, 0.35), 1.0)
	c.draw_circle(Vector2(-1, 0), 1.8, BRASS)


## A tiny brass key, its ribbon tied in a double knot.
static func _draw_tiny_key(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 6), 15, 2, DROP_SHADOW)
	# Bow, shaft and bit
	c.draw_arc(Vector2(-9, 0), 4.5, 0, TAU, 16, BRASS, 2.5, true)
	c.draw_rect(Rect2(-5, -1.2, 18, 2.4), BRASS)
	c.draw_line(Vector2(-5, -1.2), Vector2(13, -1.2), Color(1, 0.95, 0.75, 0.6), 1.0)
	c.draw_rect(Rect2(8, 1, 2.5, 4), BRASS_DARK)
	c.draw_rect(Rect2(11.5, 1, 2, 3), BRASS_DARK)
	# Red ribbon through the bow, tied twice
	var ribbon := Color(0.78, 0.14, 0.18)
	c.draw_line(Vector2(-12, -3), Vector2(-14, -5), ribbon, 2.0)
	c.draw_circle(Vector2(-14, -5), 2.0, ribbon)
	c.draw_circle(Vector2(-11.5, -7), 1.7, ribbon)
	c.draw_line(Vector2(-14, -5), Vector2(-17, 3), ribbon, 1.5)
	c.draw_line(Vector2(-14, -5), Vector2(-13, 5), ribbon, 1.5)


## An amber pill bottle with a new white label.
static func _draw_pill_bottle(c: CanvasItem) -> void:
	var amber := Color(0.74, 0.4, 0.12, 0.95)
	PlaceholderArt.draw_ellipse(c, Vector2(1, 17), 11, 2.5, DROP_SHADOW)
	c.draw_rect(Rect2(-9, -10, 18, 26), amber)
	PlaceholderArt.draw_ellipse(c, Vector2(0, 16), 9, 2.5, amber)
	# Pills showing through the glass
	for pill: Vector2 in [Vector2(-4, -6), Vector2(1, -7), Vector2(5, -5)]:
		c.draw_circle(pill, 1.8, Color(0.95, 0.9, 0.8, 0.8))
	# White cap with ridges
	c.draw_rect(Rect2(-10, -17, 20, 7), Color(0.95, 0.95, 0.92))
	for x in range(-8, 9, 3):
		c.draw_line(Vector2(x, -16), Vector2(x, -11), Color(0.75, 0.75, 0.72), 1.0)
	# Typed label
	c.draw_rect(Rect2(-8, -2, 16, 12), Color(0.97, 0.95, 0.88))
	c.draw_line(Vector2(-6, 1), Vector2(6, 1), Color(0.7, 0.12, 0.12), 1.5)
	c.draw_line(Vector2(-6, 4.5), Vector2(5, 4.5), Color(PlaceholderArt.INK, 0.7), 1.0)
	c.draw_line(Vector2(-6, 7.5), Vector2(3, 7.5), Color(PlaceholderArt.INK, 0.7), 1.0)
	c.draw_line(Vector2(-6.5, -8), Vector2(-6.5, 14), Color(1, 1, 1, 0.35), 1.5)


## A soaked photograph of the boathouse with a new padlock.
static func _draw_wet_photo(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-19, -13, 42, 32), DROP_SHADOW)
	c.draw_rect(Rect2(-21, -16, 42, 32), Color(0.9, 0.9, 0.85))
	# Night sky, the lake and the boathouse
	c.draw_rect(Rect2(-18, -13, 36, 14), Color(0.5, 0.55, 0.58))
	c.draw_rect(Rect2(-18, 1, 36, 9), Color(0.24, 0.3, 0.36))
	c.draw_colored_polygon(PackedVector2Array([Vector2(-9, -4), Vector2(0, -10), Vector2(9, -4)]), Color(0.14, 0.11, 0.1))
	c.draw_rect(Rect2(-7, -4, 14, 6), Color(0.2, 0.16, 0.13))
	c.draw_rect(Rect2(-2, -3, 4, 5), Color(0.08, 0.06, 0.05))
	c.draw_circle(Vector2(0, 0), 1.3, Color(0.95, 0.8, 0.35))
	c.draw_rect(Rect2(-7, 2, 14, 4), Color(0.2, 0.16, 0.13, 0.4))
	# Water stains, drops and a curling corner
	PlaceholderArt.draw_ellipse(c, Vector2(10, -6), 7, 5, Color(0.65, 0.72, 0.78, 0.4))
	PlaceholderArt.draw_ellipse(c, Vector2(-12, 7), 5, 3, Color(0.65, 0.72, 0.78, 0.35))
	for drop: Vector2 in [Vector2(-15, -10), Vector2(14, 6), Vector2(-4, 12), Vector2(17, -12)]:
		c.draw_circle(drop, 1.5, Color(0.85, 0.95, 1, 0.8))
	c.draw_colored_polygon(PackedVector2Array([Vector2(21, -16), Vector2(21, -8), Vector2(13, -16)]), Color(0.72, 0.72, 0.68))


## A bar of soap with the shape of a key pressed into it.
static func _draw_soap(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(1, 9), 19, 3.5, DROP_SHADOW)
	var side := StyleBoxFlat.new()
	side.bg_color = Color(0.76, 0.78, 0.66)
	side.set_corner_radius_all(6)
	c.draw_style_box(side, Rect2(-18, -6, 36, 16))
	var top := StyleBoxFlat.new()
	top.bg_color = Color(0.9, 0.92, 0.82)
	top.set_corner_radius_all(6)
	c.draw_style_box(top, Rect2(-18, -10, 36, 15))
	# The key imprint
	var dent := Color(0.62, 0.64, 0.52)
	c.draw_arc(Vector2(-8, -3), 3.5, 0, TAU, 14, dent, 2.0, true)
	c.draw_line(Vector2(-4.5, -3), Vector2(11, -3), dent, 2.0)
	c.draw_line(Vector2(7, -3), Vector2(7, 0.5), dent, 2.0)
	c.draw_line(Vector2(10, -3), Vector2(10, 1), dent, 2.0)
	c.draw_line(Vector2(-14, -8), Vector2(6, -8), Color(1, 1, 1, 0.6), 1.0)
