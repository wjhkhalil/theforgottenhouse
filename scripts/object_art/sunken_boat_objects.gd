@tool
class_name SunkenBoatObjects
extends RefCounted
## Placeholder drawings for the hidden objects of House Two, Chapter Five (The Sunken Boat).
## Same rules as placeholder_art.gd: every drawing is centred on (0, 0) and
## fits inside get_size(). PlaceholderArt calls these functions.
## Everything has lain under the lake for years, so colours are dulled and
## a little green, with a few bright edges so the objects still stand out.

const BRASS := Color(0.78, 0.64, 0.32)
const BRASS_DARK := Color(0.5, 0.4, 0.18)
const IRON := Color(0.36, 0.34, 0.32)
const IRON_DARK := Color(0.2, 0.19, 0.18)
const RUST := Color(0.5, 0.3, 0.18)
const STEEL := Color(0.62, 0.66, 0.68)
const STEEL_DARK := Color(0.38, 0.42, 0.44)
const SILVER := Color(0.8, 0.82, 0.84)
const CHINA := Color(0.9, 0.9, 0.86)
const LEATHER := Color(0.36, 0.22, 0.14)
const PAPER := Color(0.82, 0.8, 0.68)
const INK := Color(0.16, 0.14, 0.2)
const SLIME := Color(0.3, 0.42, 0.26, 0.6)
const SHADOW := Color(0, 0, 0, 0.35)


## Size of the drawing, or Vector2.ZERO if `style` is not one of this chapter's objects.
static func get_size(style: int) -> Vector2:
	match style:
		HiddenObjectData.PlaceholderStyle.SHIP_LOG:
			return Vector2(46, 38)
		HiddenObjectData.PlaceholderStyle.SHIP_LANTERN:
			return Vector2(32, 48)
		HiddenObjectData.PlaceholderStyle.TEACUP:
			return Vector2(38, 26)
		HiddenObjectData.PlaceholderStyle.HAIR_COMB:
			return Vector2(38, 18)
		HiddenObjectData.PlaceholderStyle.IRON_SHACKLE:
			return Vector2(48, 32)
		HiddenObjectData.PlaceholderStyle.STEEL_FILE:
			return Vector2(52, 14)
		HiddenObjectData.PlaceholderStyle.WINE_BOTTLE:
			return Vector2(20, 52)
		HiddenObjectData.PlaceholderStyle.SEXTANT:
			return Vector2(44, 42)
		HiddenObjectData.PlaceholderStyle.CABIN_KEY:
			return Vector2(46, 22)
		HiddenObjectData.PlaceholderStyle.PEARL_EARRING:
			return Vector2(18, 28)
		HiddenObjectData.PlaceholderStyle.DRILL_BIT:
			return Vector2(48, 14)
		HiddenObjectData.PlaceholderStyle.SILVER_FRAME:
			return Vector2(40, 48)
		HiddenObjectData.PlaceholderStyle.ICE_HOUSE_KEY:
			return Vector2(58, 30)
	return Vector2.ZERO


## Draws `style` and returns true, or returns false if it is not one of this chapter's objects.
static func draw(c: CanvasItem, style: int) -> bool:
	match style:
		HiddenObjectData.PlaceholderStyle.SHIP_LOG:
			_draw_ship_log(c)
		HiddenObjectData.PlaceholderStyle.SHIP_LANTERN:
			_draw_ship_lantern(c)
		HiddenObjectData.PlaceholderStyle.TEACUP:
			_draw_teacup(c)
		HiddenObjectData.PlaceholderStyle.HAIR_COMB:
			_draw_hair_comb(c)
		HiddenObjectData.PlaceholderStyle.IRON_SHACKLE:
			_draw_iron_shackle(c)
		HiddenObjectData.PlaceholderStyle.STEEL_FILE:
			_draw_steel_file(c)
		HiddenObjectData.PlaceholderStyle.WINE_BOTTLE:
			_draw_wine_bottle(c)
		HiddenObjectData.PlaceholderStyle.SEXTANT:
			_draw_sextant(c)
		HiddenObjectData.PlaceholderStyle.CABIN_KEY:
			_draw_cabin_key(c)
		HiddenObjectData.PlaceholderStyle.PEARL_EARRING:
			_draw_pearl_earring(c)
		HiddenObjectData.PlaceholderStyle.DRILL_BIT:
			_draw_drill_bit(c)
		HiddenObjectData.PlaceholderStyle.SILVER_FRAME:
			_draw_silver_frame(c)
		HiddenObjectData.PlaceholderStyle.ICE_HOUSE_KEY:
			_draw_ice_house_key(c)
		_:
			return false
	return true


## Vane's leather-bound ship's log, swollen with water, a ribbon marking the last page.
static func _draw_ship_log(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-19, -14, 42, 32), SHADOW)
	# Page edges, then the cover
	c.draw_rect(Rect2(-21, -15, 41, 31), Color(0.7, 0.68, 0.56))
	for i in range(3):
		c.draw_line(Vector2(-19, 13 + i * -1.0), Vector2(19, 13 + i * -1.0), Color(0.55, 0.52, 0.42), 0.8)
	c.draw_rect(Rect2(-22, -17, 40, 30), LEATHER)
	c.draw_rect(Rect2(-22, -17, 7, 30), LEATHER.darkened(0.3))  # spine
	c.draw_rect(Rect2(-12, -9, 26, 12), Color(0.62, 0.55, 0.38))
	c.draw_string(ThemeDB.fallback_font, Vector2(-9, 1), "LOG", HORIZONTAL_ALIGNMENT_LEFT, -1, 10, LEATHER.darkened(0.4))
	# Brass corners, a water stain and the red ribbon hanging out
	c.draw_rect(Rect2(14, -17, 4, 4), BRASS)
	c.draw_rect(Rect2(14, 9, 4, 4), BRASS)
	PlaceholderArt.draw_ellipse(c, Vector2(4, 8), 9, 3, Color(0.2, 0.12, 0.08, 0.5))
	c.draw_polyline(PackedVector2Array([Vector2(6, 13), Vector2(7, 18), Vector2(5, 19)]), Color(0.7, 0.16, 0.14), 2.0)


## A brass ship's lantern with a ring handle and cracked glass.
static func _draw_ship_lantern(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 22), 14, 2.5, SHADOW)
	c.draw_arc(Vector2(0, -19), 5, PI, TAU, 8, BRASS_DARK, 2.0)  # carrying ring
	c.draw_rect(Rect2(-9, -16, 18, 6), BRASS)  # top cap
	c.draw_colored_polygon(PackedVector2Array([Vector2(-6, -21), Vector2(6, -21), Vector2(9, -16), Vector2(-9, -16)]), BRASS_DARK)
	# Glass chimney with three guard wires
	c.draw_rect(Rect2(-10, -10, 20, 22), Color(0.7, 0.8, 0.78, 0.45))
	PlaceholderArt.draw_ellipse(c, Vector2(0, 4), 3, 5, Color(0.3, 0.25, 0.15, 0.6))  # old wick
	for x: float in [-10.0, 0.0, 10.0]:
		c.draw_line(Vector2(x, -10), Vector2(x, 12), BRASS_DARK, 1.6)
	c.draw_polyline(PackedVector2Array([Vector2(-7, -6), Vector2(-3, -1), Vector2(-6, 4)]), Color(1, 1, 1, 0.7), 1.0)
	# Fuel base, green with slime
	c.draw_rect(Rect2(-12, 12, 24, 9), BRASS)
	c.draw_rect(Rect2(-12, 18, 24, 3), SLIME)
	c.draw_line(Vector2(-11, 13), Vector2(11, 13), Color(1, 1, 1, 0.35), 1.0)


## A china teacup on its saucer, painted with a thin blue rim and a tiny rose.
static func _draw_teacup(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 10), 18, 3.5, SHADOW)
	PlaceholderArt.draw_ellipse(c, Vector2(0, 8), 18, 4.5, CHINA.darkened(0.15))  # saucer
	PlaceholderArt.draw_ellipse(c, Vector2(0, 7), 15, 3.5, CHINA)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-12, -8), Vector2(12, -8), Vector2(9, 5), Vector2(-9, 5)]), CHINA)
	c.draw_colored_polygon(PackedVector2Array([Vector2(4, -8), Vector2(12, -8), Vector2(9, 5), Vector2(4, 5)]), CHINA.darkened(0.12))
	PlaceholderArt.draw_ellipse(c, Vector2(0, -8), 12, 3, Color(0.3, 0.32, 0.28))  # lake water inside
	c.draw_arc(Vector2(0, -8), 12, 0, PI, 12, Color(0.3, 0.4, 0.7), 1.4)
	c.draw_arc(Vector2(13, -2), 4, -PI / 2, PI / 2, 8, CHINA.darkened(0.1), 2.5)  # handle
	c.draw_circle(Vector2(-3, -1), 2.2, Color(0.8, 0.4, 0.45))
	c.draw_line(Vector2(-1, 0), Vector2(2, 1), Color(0.35, 0.5, 0.3), 1.0)
	# A chip out of the rim
	c.draw_colored_polygon(PackedVector2Array([Vector2(-10, -9), Vector2(-6, -9), Vector2(-8, -6)]), Color(0.3, 0.32, 0.28))


## A tortoiseshell hair comb, one tooth missing.
static func _draw_hair_comb(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 7), 18, 2, SHADOW)
	var shell := Color(0.55, 0.3, 0.12)
	c.draw_rect(Rect2(-17, -7, 34, 6), shell)
	c.draw_arc(Vector2(0, 6), 18, PI * 1.25, PI * 1.75, 10, shell.lightened(0.15), 3.0)
	# Darker tortoiseshell blotches
	for spot: Vector2 in [Vector2(-11, -4), Vector2(-2, -5), Vector2(8, -3)]:
		PlaceholderArt.draw_ellipse(c, spot, 3, 1.5, Color(0.25, 0.12, 0.05))
	for i in range(15):
		if i == 9:
			continue  # the missing tooth
		var x := -16.0 + i * 2.25
		c.draw_line(Vector2(x, -1), Vector2(x, 7), shell, 1.3)
	c.draw_line(Vector2(-16, -6), Vector2(16, -6), Color(1, 0.9, 0.7, 0.4), 1.0)


## An iron shackle (a cuff on a short chain), filed right through: the cut is still bright.
static func _draw_iron_shackle(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 13), 22, 3, SHADOW)
	# The cuff: a thick ring with a gap where it was cut
	c.draw_arc(Vector2(-9, 0), 11, 0.5, TAU - 0.25, 18, IRON_DARK, 6.0)
	c.draw_arc(Vector2(-9, 0), 11, 0.5, TAU - 0.25, 18, IRON, 3.0)
	c.draw_arc(Vector2(-9, 0), 13, 3.6, 4.6, 6, RUST, 2.0)
	# The bright filed ends either side of the cut
	c.draw_circle(Vector2(-9, 0) + Vector2.from_angle(0.5) * 11.0, 3.0, STEEL)
	c.draw_circle(Vector2(-9, 0) + Vector2.from_angle(-0.25) * 11.0, 3.0, STEEL)
	# The hinge lug and three chain links
	c.draw_rect(Rect2(1, -4, 5, 8), IRON_DARK)
	for i in range(3):
		var at := Vector2(10 + i * 8, 1 + i * 2.0)
		PlaceholderArt.draw_ellipse(c, at, 5, 3, IRON_DARK)
		PlaceholderArt.draw_ellipse(c, at, 3, 1.4, Color(0.08, 0.08, 0.08))
	c.draw_arc(Vector2(-9, 0), 11, 1.4, 2.4, 6, Color(1, 1, 1, 0.3), 1.0)


## A long steel file with a crosshatched blade and a wooden handle.
static func _draw_steel_file(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 5), 25, 2, SHADOW)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-10, -3), Vector2(22, -2), Vector2(25, 0), Vector2(22, 2),
		Vector2(-10, 3)]), STEEL_DARK)
	# Crosshatched teeth
	for i in range(11):
		var x := -8.0 + i * 3.0
		c.draw_line(Vector2(x, -2.5), Vector2(x + 2, 2.5), Color(0.25, 0.27, 0.3), 0.8)
	c.draw_line(Vector2(-10, -2.5), Vector2(22, -1.8), Color(1, 1, 1, 0.4), 0.8)
	# Tang and handle
	c.draw_rect(Rect2(-14, -1, 4, 2), STEEL_DARK)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-26, -3.5), Vector2(-14, -4), Vector2(-14, 4), Vector2(-26, 3.5)]),
		Color(0.45, 0.32, 0.2))
	c.draw_rect(Rect2(-15, -4.5, 2, 9), BRASS_DARK)  # ferrule
	c.draw_line(Vector2(-25, -2), Vector2(-16, -2), Color(1, 0.9, 0.7, 0.3), 1.0)


## A dark green wine bottle, cork still in, its paper label peeling.
static func _draw_wine_bottle(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 24), 9, 2, SHADOW)
	var glass := Color(0.12, 0.3, 0.16)
	c.draw_rect(Rect2(-8, -6, 16, 30), glass)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-8, -6), Vector2(8, -6), Vector2(3, -16), Vector2(-3, -16)]), glass)
	c.draw_rect(Rect2(-3, -24, 6, 9), glass)
	c.draw_rect(Rect2(-3.5, -26, 7, 4), Color(0.55, 0.45, 0.32))  # cork
	c.draw_rect(Rect2(-3.5, -22, 7, 3), Color(0.5, 0.15, 0.15))  # foil
	# Label, curling at one corner
	c.draw_rect(Rect2(-7, 4, 14, 12), Color(0.78, 0.74, 0.6))
	c.draw_colored_polygon(PackedVector2Array([Vector2(3, 16), Vector2(7, 16), Vector2(7, 11)]), glass)
	c.draw_line(Vector2(-5, 8), Vector2(4, 8), INK, 1.2)
	c.draw_line(Vector2(-5, 11), Vector2(2, 11), Color(INK, 0.6), 0.8)
	c.draw_line(Vector2(-6, -4), Vector2(-6, 22), Color(1, 1, 1, 0.35), 1.5)


## A brass sextant: a curved scale, two little mirrors and a telescope.
static func _draw_sextant(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 19), 20, 2.5, SHADOW)
	var top := Vector2(0, -18)
	# The frame: two arms and the curved scale along the bottom
	c.draw_line(top, Vector2(-18, 14), BRASS_DARK, 3.0)
	c.draw_line(top, Vector2(18, 14), BRASS_DARK, 3.0)
	c.draw_arc(top, 34, PI / 2 - 0.55, PI / 2 + 0.55, 16, BRASS, 5.0)
	for i in range(9):
		var angle := PI / 2 - 0.5 + i * 0.125
		c.draw_line(top + Vector2.from_angle(angle) * 31.0, top + Vector2.from_angle(angle) * 34.0, BRASS_DARK, 1.0)
	# The index arm swinging down across the scale
	c.draw_line(top, top + Vector2.from_angle(PI / 2 + 0.2) * 34.0, STEEL_DARK, 2.0)
	# Mirrors and the little telescope
	c.draw_rect(Rect2(-4, -21, 8, 6), Color(0.6, 0.75, 0.8))
	c.draw_rect(Rect2(6, -6, 6, 8), Color(0.6, 0.75, 0.8))
	c.draw_rect(Rect2(-14, -6, 18, 5), IRON_DARK)
	c.draw_circle(top, 3.0, BRASS)
	# Wooden handle at the back
	c.draw_rect(Rect2(14, -2, 5, 12), Color(0.35, 0.22, 0.14))


## A brass cabin key with a round bow and a bone tag marked CABIN.
static func _draw_cabin_key(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 9), 21, 2, SHADOW)
	c.draw_arc(Vector2(-14, -3), 6, 0, TAU, 12, BRASS_DARK, 3.5)
	c.draw_rect(Rect2(-8, -4.5, 26, 3), BRASS)
	c.draw_rect(Rect2(13, -1.5, 3, 5), BRASS)
	c.draw_rect(Rect2(17, -1.5, 3, 3.5), BRASS)
	c.draw_line(Vector2(-8, -4), Vector2(16, -4), Color(1, 1, 1, 0.4), 0.8)
	# The tag on a twist of wire
	c.draw_line(Vector2(-14, 3), Vector2(-10, 5), STEEL_DARK, 1.0)
	c.draw_rect(Rect2(-12, 3, 20, 8), Color(0.86, 0.82, 0.7))
	c.draw_string(ThemeDB.fallback_font, Vector2(-11, 10), "CABIN", HORIZONTAL_ALIGNMENT_LEFT, -1, 7, INK)


## A single pearl earring on a gold hook.
static func _draw_pearl_earring(c: CanvasItem) -> void:
	var gold := Color(0.85, 0.7, 0.35)
	c.draw_arc(Vector2(0, -7), 5, PI * 0.9, TAU + 0.3, 12, gold, 1.5)
	c.draw_line(Vector2(0, -2), Vector2(0, 3), gold, 1.5)
	c.draw_circle(Vector2(0, 3), 2, gold)
	# The pearl, with a soft shine
	c.draw_circle(Vector2(0, 9), 6.5, Color(0.8, 0.8, 0.76))
	c.draw_circle(Vector2(0.5, 9.5), 5.5, Color(0.92, 0.92, 0.88))
	c.draw_circle(Vector2(-2, 7), 1.8, Color(1, 1, 1, 0.9))
	c.draw_arc(Vector2(0, 9), 6.5, 0.2, 1.6, 8, Color(0.6, 0.62, 0.66), 1.0)


## A long auger drill bit: a square shank and a twisted spiral end.
static func _draw_drill_bit(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 5), 23, 2, SHADOW)
	c.draw_rect(Rect2(-23, -2.5, 12, 5), STEEL_DARK)  # square shank
	c.draw_line(Vector2(-23, -2), Vector2(-11, -2), Color(1, 1, 1, 0.3), 0.8)
	c.draw_rect(Rect2(-11, -1.5, 8, 3), STEEL)
	# The spiral twist
	c.draw_rect(Rect2(-3, -4, 22, 8), STEEL_DARK)
	for i in range(6):
		var x := -3.0 + i * 3.8
		c.draw_line(Vector2(x, 4), Vector2(x + 3.5, -4), STEEL, 2.0)
	# Screw point, with a little rust and wood fibres still caught in it
	c.draw_colored_polygon(PackedVector2Array([Vector2(19, -3), Vector2(24, 0), Vector2(19, 3)]), STEEL_DARK)
	c.draw_line(Vector2(5, 3), Vector2(12, 4), RUST, 1.5)
	c.draw_line(Vector2(14, -3), Vector2(17, -5), Color(0.7, 0.55, 0.35), 1.0)


## A tarnished silver photo frame: two girls side by side, the older one taller.
static func _draw_silver_frame(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-17, -21, 38, 46), SHADOW)
	c.draw_rect(Rect2(-20, -24, 38, 46), SILVER.darkened(0.25))
	c.draw_rect(Rect2(-18, -22, 34, 42), SILVER)
	c.draw_rect(Rect2(-18, 14, 34, 6), Color(0.55, 0.58, 0.5, 0.6))  # tarnish
	# The photograph
	c.draw_rect(Rect2(-13, -17, 24, 31), Color(0.66, 0.62, 0.5))
	c.draw_rect(Rect2(-13, -17, 24, 12), Color(0.58, 0.62, 0.62))  # sky
	# Ellie, older and taller, on the left; Mara, smaller, on the right
	c.draw_circle(Vector2(-6, -7), 3.2, Color(0.35, 0.28, 0.22))
	c.draw_colored_polygon(PackedVector2Array([Vector2(-9, -3), Vector2(-3, -3), Vector2(-2, 12), Vector2(-10, 12)]),
		Color(0.32, 0.36, 0.45))
	c.draw_circle(Vector2(4, -3), 2.8, Color(0.45, 0.32, 0.2))
	c.draw_colored_polygon(PackedVector2Array([Vector2(1, 0), Vector2(7, 0), Vector2(8, 12), Vector2(0, 12)]),
		Color(0.5, 0.36, 0.42))
	c.draw_line(Vector2(-3, 1), Vector2(1, 2), Color(0.35, 0.3, 0.3), 1.2)  # holding hands
	# A water stain creeping in, and a shine on the frame
	PlaceholderArt.draw_ellipse(c, Vector2(7, 10), 5, 3, Color(0.3, 0.3, 0.22, 0.45))
	c.draw_line(Vector2(-17, -21), Vector2(-17, 18), Color(1, 1, 1, 0.5), 1.2)


## A big old iron key on a ring, with a wooden tag burnt with the words ICE HOUSE.
static func _draw_ice_house_key(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 13), 27, 2.5, SHADOW)
	# The key ring, and a second smaller key behind
	c.draw_arc(Vector2(-18, -4), 9, 0, TAU, 16, STEEL_DARK, 2.0)
	c.draw_line(Vector2(-20, 4), Vector2(-26, 12), IRON, 2.5)
	# The big key: bow, long shaft and heavy bit
	c.draw_arc(Vector2(-10, -4), 6, 0, TAU, 12, IRON_DARK, 4.0)
	c.draw_rect(Rect2(-4, -6, 26, 4), IRON)
	c.draw_rect(Rect2(16, -2, 4, 7), IRON)
	c.draw_rect(Rect2(21, -2, 3, 5), IRON)
	c.draw_line(Vector2(-4, -5.5), Vector2(20, -5.5), Color(1, 1, 1, 0.3), 1.0)
	c.draw_arc(Vector2(-10, -4), 8, 3.4, 4.3, 6, RUST, 2.0)
	# The tag
	c.draw_line(Vector2(-14, 1), Vector2(-8, 4), Color(0.6, 0.55, 0.42), 1.0)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-10, 3), Vector2(16, 3), Vector2(16, 13), Vector2(-10, 13),
		Vector2(-12, 8)]), Color(0.62, 0.5, 0.34))
	c.draw_string(ThemeDB.fallback_font, Vector2(-8, 11), "ICE HOUSE", HORIZONTAL_ALIGNMENT_LEFT, -1, 7, Color(0.18, 0.12, 0.08))
