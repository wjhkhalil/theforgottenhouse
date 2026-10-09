@tool
class_name KitchenObjects
extends RefCounted
## Placeholder drawings for the hidden objects of Chapter Seven (The Kitchen).
## Same rules as placeholder_art.gd: every drawing is centred on (0, 0) and
## fits inside get_size(). PlaceholderArt calls these functions.

const IRON := Color(0.2, 0.19, 0.19)
const IRON_LIGHT := Color(0.38, 0.36, 0.35)
const STEEL := Color(0.62, 0.63, 0.66)
const STEEL_DARK := Color(0.4, 0.41, 0.44)
const CHAR := Color(0.1, 0.07, 0.05)
const INK_BLUE := Color(0.2, 0.25, 0.45)


## Size of the drawing, or Vector2.ZERO if `style` is not one of this chapter's objects.
static func get_size(style: int) -> Vector2:
	match style:
		HiddenObjectData.PlaceholderStyle.SPOON:
			return Vector2(18, 58)
		HiddenObjectData.PlaceholderStyle.EGG_TIMER:
			return Vector2(26, 40)
		HiddenObjectData.PlaceholderStyle.RECIPE_CARD:
			return Vector2(42, 32)
		HiddenObjectData.PlaceholderStyle.POISON_TIN:
			return Vector2(30, 36)
		HiddenObjectData.PlaceholderStyle.TIN_OPENER:
			return Vector2(18, 50)
		HiddenObjectData.PlaceholderStyle.BURNT_LETTER:
			return Vector2(46, 36)
		HiddenObjectData.PlaceholderStyle.SERVANTS_KEY:
			return Vector2(62, 26)
		HiddenObjectData.PlaceholderStyle.SUGAR_MOUSE:
			return Vector2(46, 28)
		HiddenObjectData.PlaceholderStyle.PEBBLE:
			return Vector2(28, 18)
	return Vector2.ZERO


## Draws `style` and returns true, or returns false if it is not one of this chapter's objects.
static func draw(c: CanvasItem, style: int) -> bool:
	match style:
		HiddenObjectData.PlaceholderStyle.SPOON:
			_draw_wooden_spoon(c)
		HiddenObjectData.PlaceholderStyle.EGG_TIMER:
			_draw_egg_timer(c)
		HiddenObjectData.PlaceholderStyle.RECIPE_CARD:
			_draw_recipe_card(c)
		HiddenObjectData.PlaceholderStyle.POISON_TIN:
			_draw_poison_tin(c)
		HiddenObjectData.PlaceholderStyle.TIN_OPENER:
			_draw_tin_opener(c)
		HiddenObjectData.PlaceholderStyle.BURNT_LETTER:
			_draw_burnt_letter(c)
		HiddenObjectData.PlaceholderStyle.SERVANTS_KEY:
			_draw_servants_key(c)
		HiddenObjectData.PlaceholderStyle.SUGAR_MOUSE:
			_draw_sugar_mouse(c)
		HiddenObjectData.PlaceholderStyle.PEBBLE:
			_draw_pebble(c)
		_:
			return false
	return true


# ---------------------------------------------------------------------------

## A wooden spoon hanging by the hole in its handle; the bowl is burnt at the tip.
static func _draw_wooden_spoon(c: CanvasItem) -> void:
	var wood := Color(0.66, 0.5, 0.32)
	var wood_dark := Color(0.45, 0.32, 0.2)
	# Soft shadow on the wall behind it
	c.draw_line(Vector2(2, -23), Vector2(2, 10), Color(0, 0, 0, 0.3), 5.0)
	PlaceholderArt.draw_ellipse(c, Vector2(2, 19), 7, 10, Color(0, 0, 0, 0.3))
	# Handle with a hanging hole
	c.draw_line(Vector2(0, -26), Vector2(0, 9), wood_dark, 5.0)
	c.draw_line(Vector2(-1, -26), Vector2(-1, 9), wood, 3.0)
	c.draw_circle(Vector2(0, -24), 2.6, wood)
	c.draw_circle(Vector2(0, -24), 1.2, Color(0.1, 0.07, 0.05))
	# Bowl, darkened and burnt at the tip
	PlaceholderArt.draw_ellipse(c, Vector2(0, 17), 7.5, 11, wood_dark)
	PlaceholderArt.draw_ellipse(c, Vector2(0, 16.5), 6, 9.5, wood)
	PlaceholderArt.draw_ellipse(c, Vector2(0, 17), 3.5, 6, wood.darkened(0.12))
	PlaceholderArt.draw_ellipse(c, Vector2(0, 24), 5, 3, CHAR)
	c.draw_line(Vector2(-3, 12), Vector2(-3, 18), Color(1, 0.95, 0.8, 0.3), 1.2)


## A sand timer in a turned wooden frame; all the sand has run to the bottom.
static func _draw_egg_timer(c: CanvasItem) -> void:
	var wood := Color(0.5, 0.33, 0.2)
	var wood_light := Color(0.65, 0.46, 0.28)
	var glass := Color(0.8, 0.88, 0.92, 0.35)
	var sand := Color(0.88, 0.74, 0.46)
	PlaceholderArt.draw_ellipse(c, Vector2(2, 18), 13, 3, Color(0, 0, 0, 0.35))
	# Glass bulbs
	PlaceholderArt.draw_ellipse(c, Vector2(0, -8), 7, 8, glass)
	PlaceholderArt.draw_ellipse(c, Vector2(0, 8), 7, 8, glass)
	c.draw_rect(Rect2(-1.5, -2, 3, 4), glass)
	# Sand: a full heap below, a thin trace left above
	c.draw_colored_polygon(PackedVector2Array([Vector2(-6, 13), Vector2(-4, 7), Vector2(0, 4), Vector2(4, 7), Vector2(6, 13)]), sand)
	PlaceholderArt.draw_ellipse(c, Vector2(0, 12), 6, 2.5, sand)
	c.draw_line(Vector2(-3, -13), Vector2(3, -13), Color(sand, 0.6), 1.0)
	c.draw_arc(Vector2(-2, -9), 4, PI * 1.05, PI * 1.45, 6, Color(1, 1, 1, 0.6), 1.2, true)
	# Frame: top and bottom discs joined by three posts
	c.draw_rect(Rect2(-11, -19, 22, 4), wood)
	c.draw_rect(Rect2(-11, -19, 22, 1.5), wood_light)
	c.draw_rect(Rect2(-11, 15, 22, 4), wood)
	c.draw_rect(Rect2(-11, 15, 22, 1.5), wood_light)
	for post_x: float in [-9.0, 9.0]:
		c.draw_line(Vector2(post_x, -15), Vector2(post_x, 15), wood, 2.2)
		c.draw_circle(Vector2(post_x, 0), 1.6, wood_light)


## Mother's handwritten card, pinned up, with a little cake drawn in the corner.
static func _draw_recipe_card(c: CanvasItem) -> void:
	var card := Color(0.92, 0.88, 0.78)
	c.draw_rect(Rect2(-17, -11, 38, 28), Color(0, 0, 0, 0.32))
	c.draw_rect(Rect2(-20, -14, 38, 28), card)
	c.draw_rect(Rect2(-20, -14, 38, 28), Color(0.7, 0.62, 0.48), false, 1.0)
	# Red ruled header line and the title "Birthday Cake" in a loopy hand
	c.draw_line(Vector2(-20, -6), Vector2(18, -6), Color(0.75, 0.3, 0.3, 0.8), 1.0)
	c.draw_polyline(PackedVector2Array([Vector2(-16, -9), Vector2(-14, -12), Vector2(-12, -8), Vector2(-9, -11),
		Vector2(-6, -8), Vector2(-3, -11), Vector2(0, -8), Vector2(3, -11)]), Color(INK_BLUE, 0.9), 1.2)
	for i in range(4):
		var y := -1.0 + i * 4.0
		c.draw_line(Vector2(-17, y), Vector2(3.0 - (i % 2) * 5.0, y), Color(INK_BLUE, 0.6), 1.0)
	# Tiny cake with a candle
	c.draw_rect(Rect2(6, 3, 9, 6), Color(0.88, 0.6, 0.62))
	c.draw_rect(Rect2(6, 3, 9, 1.5), Color(0.98, 0.95, 0.9))
	c.draw_line(Vector2(10.5, 3), Vector2(10.5, -1), Color(0.4, 0.5, 0.8), 1.2)
	c.draw_circle(Vector2(10.5, -2), 1.1, Color(1, 0.75, 0.3))
	# Drawing pin
	c.draw_circle(Vector2(-1, -12), 2.6, Color(0.7, 0.16, 0.12))
	c.draw_circle(Vector2(-1.6, -12.6), 0.9, Color(1, 0.7, 0.6))


## A rusty round tin with a skull label and "RATS & MICE".
static func _draw_poison_tin(c: CanvasItem) -> void:
	var tin := Color(0.5, 0.42, 0.3)
	var rust := Color(0.52, 0.26, 0.14)
	var label := Color(0.78, 0.68, 0.3)
	PlaceholderArt.draw_ellipse(c, Vector2(2, 15), 15, 3, Color(0, 0, 0, 0.4))
	c.draw_rect(Rect2(-12, -12, 24, 26), tin)
	PlaceholderArt.draw_ellipse(c, Vector2(0, 14), 12, 3, tin.darkened(0.2))
	PlaceholderArt.draw_ellipse(c, Vector2(0, -12), 12, 3.5, tin.lightened(0.15))
	PlaceholderArt.draw_ellipse(c, Vector2(0, -12), 9, 2.2, tin.darkened(0.15))
	# Paper label with a skull and cross bones
	c.draw_rect(Rect2(-12, -6, 24, 15), label)
	c.draw_line(Vector2(-9, 3), Vector2(-1, -3), Color(0.15, 0.12, 0.1), 1.4)
	c.draw_line(Vector2(-9, -3), Vector2(-1, 3), Color(0.15, 0.12, 0.1), 1.4)
	c.draw_circle(Vector2(-5, -1), 2.6, Color(0.95, 0.93, 0.88))
	c.draw_circle(Vector2(-6, -1.5), 0.7, Color(0.1, 0.1, 0.1))
	c.draw_circle(Vector2(-4, -1.5), 0.7, Color(0.1, 0.1, 0.1))
	for i in range(3):
		c.draw_line(Vector2(2, -3.0 + i * 3.0), Vector2(10.0 - i * 2.0, -3.0 + i * 3.0), Color(0.15, 0.12, 0.1, 0.85), 1.0)
	c.draw_rect(Rect2(-12, 9, 24, 1.5), Color(0.6, 0.12, 0.1))
	# Rust patches and a highlight
	PlaceholderArt.draw_ellipse(c, Vector2(8, 11), 3, 2, rust)
	PlaceholderArt.draw_ellipse(c, Vector2(-8, -9), 2.5, 1.5, rust)
	c.draw_line(Vector2(9, -9), Vector2(9, 12), Color(1, 1, 1, 0.15), 1.5)


## An old lever tin opener: steel blade and hook on a wooden handle, hung by a ring.
static func _draw_tin_opener(c: CanvasItem) -> void:
	var wood := Color(0.48, 0.3, 0.18)
	c.draw_line(Vector2(2, -14), Vector2(2, 24), Color(0, 0, 0, 0.3), 6.0)
	# Hanging ring
	c.draw_arc(Vector2(0, -20), 3.5, 0, TAU, 14, STEEL_DARK, 1.6, true)
	# Steel shank, the curved cutting blade and the lever hook
	c.draw_line(Vector2(0, -16), Vector2(0, 2), STEEL, 3.0)
	c.draw_line(Vector2(-1, -16), Vector2(-1, 2), Color(1, 1, 1, 0.35), 1.0)
	c.draw_colored_polygon(PackedVector2Array([Vector2(1, -12), Vector2(8, -15), Vector2(7, -9), Vector2(1, -7)]), STEEL)
	c.draw_line(Vector2(8, -15), Vector2(7, -9), STEEL_DARK, 1.2)
	c.draw_arc(Vector2(-3, -6), 3.5, PI * 0.5, PI * 1.5, 8, STEEL_DARK, 2.0, true)
	# Wooden handle with a brass ferrule
	c.draw_rect(Rect2(-2.5, 2, 5, 3), Color(0.72, 0.58, 0.3))
	c.draw_colored_polygon(PackedVector2Array([Vector2(-3, 5), Vector2(3, 5), Vector2(4.5, 24), Vector2(-4.5, 24)]), wood)
	c.draw_line(Vector2(-1.5, 7), Vector2(-2, 22), Color(1, 0.9, 0.7, 0.25), 1.2)


## A letter with one side burnt away to a black, glowing edge.
static func _draw_burnt_letter(c: CanvasItem) -> void:
	var paper := Color(0.84, 0.76, 0.6)
	var edge: Array[Vector2] = [Vector2(-21, -15), Vector2(10, -15), Vector2(13, -9), Vector2(9, -4),
		Vector2(15, 1), Vector2(11, 6), Vector2(17, 10), Vector2(12, 15), Vector2(-21, 15)]
	var shadow := PackedVector2Array()
	for point in edge:
		shadow.append(point + Vector2(3, 3))
	c.draw_colored_polygon(shadow, Color(0, 0, 0, 0.4))
	# Scorched rim, then the paper inset a little
	c.draw_colored_polygon(PackedVector2Array(edge), CHAR)
	var inner := PackedVector2Array()
	for point in edge:
		inner.append(point + Vector2(-2.5 if point.x > 0 else 0.0, 0))
	c.draw_colored_polygon(inner, paper)
	PlaceholderArt.draw_ellipse(c, Vector2(8, 3), 5, 11, Color(0.45, 0.3, 0.15, 0.6))
	# Typed lines that stop at the burn
	for i in range(5):
		var y := -10.0 + i * 5.0
		c.draw_line(Vector2(-18, y), Vector2(4.0 - (i % 2) * 3.0, y), Color(PlaceholderArt.INK, 0.7), 1.0)
	# Embers still glowing on the edge
	c.draw_circle(Vector2(14, 1), 1.3, Color(1, 0.5, 0.15))
	c.draw_circle(Vector2(15, 10), 1.0, Color(1, 0.45, 0.12))
	c.draw_circle(Vector2(12, -9), 0.9, Color(1, 0.55, 0.2))


## A long iron key with a paper tag tied to its bow.
static func _draw_servants_key(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(2, 9), 28, 3, Color(0, 0, 0, 0.35))
	# Big oval bow
	c.draw_arc(Vector2(-21, 0), 6, 0, TAU, 18, IRON, 3.5, true)
	c.draw_arc(Vector2(-21, 0), 6, PI * 1.1, PI * 1.5, 6, IRON_LIGHT, 1.2, true)
	# Long shaft and a chunky bit
	c.draw_rect(Rect2(-15, -1.8, 40, 3.6), IRON)
	c.draw_line(Vector2(-15, -1.6), Vector2(25, -1.6), IRON_LIGHT, 1.0)
	c.draw_rect(Rect2(17, 1.5, 4, 7), IRON)
	c.draw_rect(Rect2(22, 1.5, 3, 5), IRON)
	c.draw_rect(Rect2(-12, -3, 3, 6), IRON)
	# Paper tag on a string
	c.draw_line(Vector2(-23, 5), Vector2(-24, 8), Color(0.75, 0.7, 0.6), 1.0)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-30, 8), Vector2(-18, 8), Vector2(-18, 13), Vector2(-30, 13)]), Color(0.86, 0.8, 0.64))
	c.draw_line(Vector2(-28, 10.5), Vector2(-20, 10.5), Color(PlaceholderArt.INK, 0.8), 1.0)


## A white sugar mouse with pink ears and a string tail, on a sheet of wax paper.
static func _draw_sugar_mouse(c: CanvasItem) -> void:
	var sugar := Color(0.96, 0.93, 0.9)
	var pink := Color(0.92, 0.62, 0.68)
	# Crumpled wax paper
	c.draw_colored_polygon(PackedVector2Array([Vector2(-22, -6), Vector2(-8, -12), Vector2(12, -10), Vector2(22, -4),
		Vector2(20, 12), Vector2(-4, 14), Vector2(-21, 9)]), Color(0.88, 0.84, 0.66, 0.85))
	c.draw_line(Vector2(-14, -8), Vector2(-10, 10), Color(1, 1, 1, 0.35), 1.0)
	c.draw_line(Vector2(14, -8), Vector2(10, 11), Color(1, 1, 1, 0.35), 1.0)
	PlaceholderArt.draw_ellipse(c, Vector2(1, 8), 13, 3, Color(0, 0, 0, 0.3))
	# Body: a teardrop with the nose pointing right
	c.draw_colored_polygon(PackedVector2Array([Vector2(-12, 6), Vector2(-11, -1), Vector2(-5, -6), Vector2(3, -6),
		Vector2(10, -2), Vector2(15, 3), Vector2(10, 6)]), sugar)
	c.draw_line(Vector2(-10, 5), Vector2(10, 5.5), Color(0.8, 0.76, 0.72), 1.2)
	# Ears, eye, nose
	c.draw_circle(Vector2(5, -6), 2.6, pink)
	c.draw_circle(Vector2(5, -6), 1.3, Color(0.98, 0.8, 0.82))
	c.draw_circle(Vector2(9, -1), 0.9, Color(0.2, 0.12, 0.12))
	c.draw_circle(Vector2(15, 3), 1.2, pink)
	# String tail
	c.draw_polyline(PackedVector2Array([Vector2(-12, 4), Vector2(-16, 1), Vector2(-19, 4), Vector2(-21, 0)]), Color(0.75, 0.68, 0.55), 1.2)


## A smooth black lake pebble, still glistening wet.
static func _draw_pebble(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(1, 5), 13, 3.5, Color(0, 0, 0, 0.4))
	PlaceholderArt.draw_ellipse(c, Vector2(0, 0), 12, 7, Color(0.1, 0.11, 0.12))
	PlaceholderArt.draw_ellipse(c, Vector2(-1, -1), 10, 5.5, Color(0.17, 0.18, 0.2))
	# Wet shine and a water drop beside it
	c.draw_arc(Vector2(-2, -1), 6, PI * 1.1, PI * 1.6, 8, Color(0.85, 0.9, 1, 0.65), 1.5, true)
	c.draw_circle(Vector2(5, -3), 1.0, Color(1, 1, 1, 0.7))
	PlaceholderArt.draw_ellipse(c, Vector2(11, 6), 2.5, 1.2, Color(0.6, 0.7, 0.8, 0.4))
