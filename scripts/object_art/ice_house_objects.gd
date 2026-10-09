@tool
class_name IceHouseObjects
extends RefCounted
## Placeholder drawings for the hidden objects of House Two, Chapter Six (The Ice House).
## Same rules as placeholder_art.gd: every drawing is centred on (0, 0) and
## fits inside get_size(). PlaceholderArt calls these functions.

const IRON := Color(0.36, 0.37, 0.4)
const IRON_DARK := Color(0.2, 0.21, 0.24)
const STEEL := Color(0.66, 0.7, 0.74)
const WOOD := Color(0.44, 0.31, 0.19)
const WOOD_DARK := Color(0.26, 0.18, 0.11)
const BRASS := Color(0.8, 0.64, 0.3)
const BRASS_DARK := Color(0.52, 0.39, 0.16)
const PAPER := Color(0.9, 0.87, 0.77)
const INK := Color(0.16, 0.16, 0.24)
const ICE := Color(0.78, 0.9, 0.98, 0.55)
const FROST := Color(0.95, 0.98, 1.0, 0.85)
const SHADOW := Color(0, 0, 0, 0.35)


## Size of the drawing, or Vector2.ZERO if `style` is not one of this chapter's objects.
static func get_size(style: int) -> Vector2:
	match style:
		HiddenObjectData.PlaceholderStyle.ICE_PICK:
			return Vector2(26, 60)
		HiddenObjectData.PlaceholderStyle.ICE_TONGS:
			return Vector2(44, 56)
		HiddenObjectData.PlaceholderStyle.HORSE_BLANKET:
			return Vector2(70, 46)
		HiddenObjectData.PlaceholderStyle.TORN_SLEEVE:
			return Vector2(46, 30)
		HiddenObjectData.PlaceholderStyle.FROZEN_PIKE:
			return Vector2(66, 24)
		HiddenObjectData.PlaceholderStyle.SOUP_TIN:
			return Vector2(28, 36)
		HiddenObjectData.PlaceholderStyle.LOST_MITTEN:
			return Vector2(30, 38)
		HiddenObjectData.PlaceholderStyle.KEEPERS_NOTE:
			return Vector2(44, 34)
		HiddenObjectData.PlaceholderStyle.SIGNAL_WHISTLE:
			return Vector2(42, 20)
		HiddenObjectData.PlaceholderStyle.SCRATCHED_SLATE:
			return Vector2(52, 40)
		HiddenObjectData.PlaceholderStyle.ICE_SAW:
			return Vector2(72, 28)
		HiddenObjectData.PlaceholderStyle.FROZEN_BROOCH:
			return Vector2(30, 30)
		HiddenObjectData.PlaceholderStyle.SNOWSHOE:
			return Vector2(30, 66)
		HiddenObjectData.PlaceholderStyle.LIGHTHOUSE_KEY:
			return Vector2(58, 24)
	return Vector2.ZERO


## Draws `style` and returns true, or returns false if it is not one of this chapter's objects.
static func draw(c: CanvasItem, style: int) -> bool:
	match style:
		HiddenObjectData.PlaceholderStyle.ICE_PICK:
			_draw_ice_pick(c)
		HiddenObjectData.PlaceholderStyle.ICE_TONGS:
			_draw_ice_tongs(c)
		HiddenObjectData.PlaceholderStyle.HORSE_BLANKET:
			_draw_horse_blanket(c)
		HiddenObjectData.PlaceholderStyle.TORN_SLEEVE:
			_draw_torn_sleeve(c)
		HiddenObjectData.PlaceholderStyle.FROZEN_PIKE:
			_draw_frozen_pike(c)
		HiddenObjectData.PlaceholderStyle.SOUP_TIN:
			_draw_soup_tin(c)
		HiddenObjectData.PlaceholderStyle.LOST_MITTEN:
			_draw_lost_mitten(c)
		HiddenObjectData.PlaceholderStyle.KEEPERS_NOTE:
			_draw_keepers_note(c)
		HiddenObjectData.PlaceholderStyle.SIGNAL_WHISTLE:
			_draw_signal_whistle(c)
		HiddenObjectData.PlaceholderStyle.SCRATCHED_SLATE:
			_draw_scratched_slate(c)
		HiddenObjectData.PlaceholderStyle.ICE_SAW:
			_draw_ice_saw(c)
		HiddenObjectData.PlaceholderStyle.FROZEN_BROOCH:
			_draw_frozen_brooch(c)
		HiddenObjectData.PlaceholderStyle.SNOWSHOE:
			_draw_snowshoe(c)
		HiddenObjectData.PlaceholderStyle.LIGHTHOUSE_KEY:
			_draw_lighthouse_key(c)
		_:
			return false
	return true


## A long-handled ice pick: wooden handle, iron collar and a sharp steel spike.
static func _draw_ice_pick(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 28), 9, 2, SHADOW)
	# Wooden handle with a rounded knob
	c.draw_rect(Rect2(-4, -28, 8, 30), WOOD)
	c.draw_rect(Rect2(-4, -28, 2.5, 30), WOOD.lightened(0.2))
	PlaceholderArt.draw_ellipse(c, Vector2(0, -28), 5, 3, WOOD_DARK)
	# Iron collar
	c.draw_rect(Rect2(-5, 2, 10, 5), IRON_DARK)
	# The spike, tapering to a point
	c.draw_colored_polygon(PackedVector2Array([Vector2(-2.5, 7), Vector2(2.5, 7), Vector2(0.5, 29), Vector2(-0.5, 29)]), STEEL)
	c.draw_line(Vector2(-1.5, 8), Vector2(-0.3, 27), Color(1, 1, 1, 0.6), 0.8)
	# A few chips of ice still stuck to it
	c.draw_circle(Vector2(2, 18), 1.5, FROST)
	c.draw_circle(Vector2(-1, 24), 1.2, FROST)


## Iron ice tongs: two curved jaws hinged in the middle, with ring handles.
static func _draw_ice_tongs(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 26), 18, 2, SHADOW)
	# Handles from the hinge up to the rings
	c.draw_line(Vector2(0, 0), Vector2(-9, -20), IRON, 3.5)
	c.draw_line(Vector2(0, 0), Vector2(9, -20), IRON, 3.5)
	c.draw_arc(Vector2(-10, -23), 4.5, 0, TAU, 10, IRON_DARK, 2.5)
	c.draw_arc(Vector2(10, -23), 4.5, 0, TAU, 10, IRON_DARK, 2.5)
	# The jaws curve out and back in, with sharp teeth at the tips
	c.draw_polyline(PackedVector2Array([Vector2(0, 0), Vector2(-14, 8), Vector2(-19, 18), Vector2(-12, 25)]), IRON, 3.5)
	c.draw_polyline(PackedVector2Array([Vector2(0, 0), Vector2(14, 8), Vector2(19, 18), Vector2(12, 25)]), IRON, 3.5)
	c.draw_line(Vector2(-12, 25), Vector2(-8, 23), STEEL, 2.0)
	c.draw_line(Vector2(12, 25), Vector2(8, 23), STEEL, 2.0)
	c.draw_circle(Vector2(0, 0), 3.5, IRON_DARK)
	c.draw_circle(Vector2(0, 0), 1.4, STEEL)
	# Rime along one jaw
	c.draw_line(Vector2(-13, 8), Vector2(-17, 15), FROST, 1.2)


## A folded brown horse blanket with a red stripe and a leather strap.
static func _draw_horse_blanket(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 20), 34, 3, SHADOW)
	var cloth := Color(0.42, 0.3, 0.2)
	var cloth_dark := Color(0.3, 0.21, 0.14)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-33, -10), Vector2(-20, -21), Vector2(26, -19), Vector2(34, -6),
		Vector2(32, 18), Vector2(-31, 19)]), cloth_dark)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-31, -9), Vector2(-19, -19), Vector2(25, -17), Vector2(32, -6),
		Vector2(30, 6), Vector2(-30, 7)]), cloth)
	# Red and cream stripes across the fold
	c.draw_line(Vector2(-30, -2), Vector2(31, -1), Color(0.62, 0.16, 0.14), 4.0)
	c.draw_line(Vector2(-30, 3), Vector2(30, 4), Color(0.85, 0.78, 0.6), 1.5)
	# Folds lower down
	c.draw_line(Vector2(-30, 12), Vector2(31, 12), cloth.darkened(0.3), 1.5)
	# Leather strap and buckle
	c.draw_rect(Rect2(8, -18, 6, 36), Color(0.22, 0.13, 0.08))
	c.draw_rect(Rect2(7, 4, 8, 6), BRASS, false, 1.5)
	# Straw stuck in the wool
	c.draw_line(Vector2(-22, -12), Vector2(-14, -8), Color(0.85, 0.74, 0.4), 1.0)
	c.draw_line(Vector2(18, 14), Vector2(26, 11), Color(0.85, 0.74, 0.4), 1.0)


## A torn-off sleeve of a blue nightdress, the edge ripped and frayed.
static func _draw_torn_sleeve(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 12), 20, 2, SHADOW)
	var cloth := Color(0.6, 0.68, 0.8)
	var cloth_dark := Color(0.42, 0.5, 0.62)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-22, -6), Vector2(-14, -12), Vector2(-6, -9), Vector2(2, -13),
		Vector2(10, -10), Vector2(21, -4), Vector2(22, 6), Vector2(-20, 10)]), cloth)
	# The cuff with two little buttons
	c.draw_colored_polygon(PackedVector2Array([Vector2(15, -6), Vector2(22, -4), Vector2(22, 7), Vector2(15, 8)]), cloth_dark)
	c.draw_circle(Vector2(18.5, -1), 1.3, Color(0.95, 0.95, 0.92))
	c.draw_circle(Vector2(18.5, 4), 1.3, Color(0.95, 0.95, 0.92))
	# Ragged torn edge with loose threads
	for i in range(5):
		var start := Vector2(-22 + i * 1.0, -6 + i * 3.5)
		c.draw_line(start, start + Vector2(-3, 1 + i % 2), cloth_dark, 1.0)
	# Creases, and a brown stain from the porthole's rusty rim
	c.draw_line(Vector2(-10, -4), Vector2(8, -2), cloth_dark, 1.0)
	c.draw_line(Vector2(-8, 4), Vector2(10, 3), cloth_dark, 1.0)
	PlaceholderArt.draw_ellipse(c, Vector2(-4, 1), 5, 3, Color(0.5, 0.3, 0.2, 0.5))


## A pike frozen stiff, with a coating of frost and a glassy eye.
static func _draw_frozen_pike(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 10), 30, 2, SHADOW)
	var body := Color(0.4, 0.48, 0.32)
	var belly := Color(0.78, 0.8, 0.66)
	# Tail fin
	c.draw_colored_polygon(PackedVector2Array([Vector2(22, 0), Vector2(32, -9), Vector2(29, 0), Vector2(32, 9)]), body.darkened(0.2))
	# Long body with a pointed snout
	c.draw_colored_polygon(PackedVector2Array([Vector2(-32, 1), Vector2(-24, -5), Vector2(-6, -8), Vector2(14, -6),
		Vector2(23, -1), Vector2(23, 2), Vector2(12, 7), Vector2(-8, 7), Vector2(-24, 5)]), body)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-24, 3), Vector2(-6, 7), Vector2(12, 6), Vector2(-8, 4)]), belly)
	# Pale spots along the side
	for spot: Vector2 in [Vector2(-12, -3), Vector2(-4, -1), Vector2(4, -4), Vector2(10, -1), Vector2(-16, 1)]:
		PlaceholderArt.draw_ellipse(c, spot, 2.2, 1.2, Color(0.75, 0.78, 0.55))
	# Fins on the back and belly
	c.draw_colored_polygon(PackedVector2Array([Vector2(8, -6), Vector2(13, -11), Vector2(16, -5)]), body.darkened(0.2))
	c.draw_colored_polygon(PackedVector2Array([Vector2(6, 7), Vector2(10, 11), Vector2(13, 6)]), body.darkened(0.2))
	# Eye and gill
	c.draw_circle(Vector2(-22, -1), 2.2, Color(0.85, 0.85, 0.7))
	c.draw_circle(Vector2(-22, -1), 1.1, Color(0.1, 0.1, 0.1))
	c.draw_arc(Vector2(-16, 0), 5, -PI * 0.4, PI * 0.4, 6, body.darkened(0.4), 1.2)
	# Frost crust
	c.draw_line(Vector2(-20, -6), Vector2(10, -8), FROST, 1.5)
	c.draw_circle(Vector2(18, -3), 1.2, FROST)


## A dented tin of soup with a paper label and a wire bail handle.
static func _draw_soup_tin(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 17), 13, 2.5, SHADOW)
	var tin := Color(0.66, 0.68, 0.7)
	c.draw_rect(Rect2(-11, -11, 22, 27), tin)
	c.draw_rect(Rect2(-11, -11, 4, 27), tin.lightened(0.25))
	# Red and cream label
	c.draw_rect(Rect2(-11, -5, 22, 15), Color(0.7, 0.18, 0.15))
	c.draw_rect(Rect2(-11, -1, 22, 6), Color(0.92, 0.86, 0.7))
	c.draw_line(Vector2(-7, 2), Vector2(6, 2), Color(0.7, 0.18, 0.15), 1.5)
	# Rim, and a dent
	PlaceholderArt.draw_ellipse(c, Vector2(0, -11), 11, 3, tin.darkened(0.25))
	PlaceholderArt.draw_ellipse(c, Vector2(0, -11), 9, 2, Color(0.3, 0.22, 0.14))
	c.draw_arc(Vector2(7, 12), 3, PI * 0.6, PI * 1.4, 6, tin.darkened(0.35), 1.2)
	# Wire handle Agnes carried it by
	c.draw_arc(Vector2(0, -11), 11, PI, TAU, 12, IRON_DARK, 1.2)


## A red knitted mitten with a white snowflake pattern.
static func _draw_lost_mitten(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 18), 13, 2, SHADOW)
	var wool := Color(0.66, 0.16, 0.16)
	# Hand and thumb
	PlaceholderArt.draw_ellipse(c, Vector2(1, -5), 11, 13, wool)
	PlaceholderArt.draw_ellipse(c, Vector2(-10, 0), 4, 7, wool)
	# Ribbed cuff
	c.draw_rect(Rect2(-10, 6, 21, 11), wool.darkened(0.2))
	for i in range(6):
		c.draw_line(Vector2(-8 + i * 3.5, 7), Vector2(-8 + i * 3.5, 16), wool.darkened(0.4), 1.0)
	# Snowflake knitted on the back
	var flake := Color(0.96, 0.94, 0.9)
	for i in range(3):
		var direction := Vector2.from_angle(i * PI / 3.0) * 5.0
		c.draw_line(Vector2(2, -6) - direction, Vector2(2, -6) + direction, flake, 1.3)
	# A line of white stitches above the cuff
	for i in range(5):
		c.draw_circle(Vector2(-7 + i * 4.0, 4), 1.0, flake)


## A folded note on lined paper, written in pencil, with a lighthouse stamp.
static func _draw_keepers_note(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-19, -13, 42, 31), SHADOW)
	c.draw_rect(Rect2(-22, -16, 42, 31), PAPER)
	# Fold line and blue ruled lines
	c.draw_line(Vector2(-1, -16), Vector2(-1, 15), Color(0.75, 0.72, 0.62), 1.0)
	for y in range(-8, 14, 5):
		c.draw_line(Vector2(-20, y), Vector2(18, y), Color(0.55, 0.65, 0.8, 0.5), 0.8)
	# Pencil writing
	c.draw_line(Vector2(-18, -10), Vector2(-4, -10), INK, 1.2)
	c.draw_line(Vector2(-18, -5), Vector2(-5, -5), Color(INK, 0.8), 1.0)
	c.draw_line(Vector2(-18, 0), Vector2(-8, 0), Color(INK, 0.8), 1.0)
	c.draw_line(Vector2(2, -10), Vector2(16, -10), Color(INK, 0.8), 1.0)
	c.draw_line(Vector2(2, -5), Vector2(14, -5), Color(INK, 0.8), 1.0)
	# A little lighthouse printed in the corner of the paper
	c.draw_colored_polygon(PackedVector2Array([Vector2(10, 12), Vector2(12, 2), Vector2(14, 2), Vector2(16, 12)]), Color(0.6, 0.2, 0.18))
	c.draw_rect(Rect2(11.5, 0, 3, 2), Color(0.95, 0.8, 0.3))
	c.draw_line(Vector2(15, 1), Vector2(19, -1), Color(0.95, 0.8, 0.3), 1.0)


## A brass signal whistle on a cord, the kind lighthouse keepers carry.
static func _draw_signal_whistle(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 8), 19, 2, SHADOW)
	# Barrel and mouthpiece
	c.draw_rect(Rect2(-8, -5, 22, 10), BRASS)
	c.draw_circle(Vector2(14, 0), 5, BRASS)
	c.draw_rect(Rect2(-17, -3, 10, 6), BRASS_DARK)
	c.draw_line(Vector2(-8, -4), Vector2(14, -4), Color(1, 0.95, 0.8, 0.6), 1.2)
	# The sound slot on top
	c.draw_rect(Rect2(-4, -5, 6, 3), Color(0.15, 0.1, 0.05))
	# Ring and a loop of tarred cord
	c.draw_arc(Vector2(-19, 0), 2.5, 0, TAU, 8, BRASS_DARK, 1.5)
	c.draw_polyline(PackedVector2Array([Vector2(-21, 1), Vector2(-20, 7), Vector2(-12, 9), Vector2(-4, 8)]), Color(0.18, 0.15, 0.12), 1.4)


## A school slate in a wooden frame, with "M.A. alive 3.10.88" scratched on it.
static func _draw_scratched_slate(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-23, -16, 50, 38), SHADOW)
	c.draw_rect(Rect2(-26, -20, 50, 38), WOOD)
	c.draw_rect(Rect2(-22, -16, 42, 30), Color(0.2, 0.22, 0.24))
	# Scratched letters, pale grey where the slate shows through
	var scratch := Color(0.82, 0.84, 0.86)
	c.draw_string(ThemeDB.fallback_font, Vector2(-20, -4), "M.A. alive", HORIZONTAL_ALIGNMENT_LEFT, -1, 9, scratch)
	c.draw_string(ThemeDB.fallback_font, Vector2(-17, 8), "3.10.88", HORIZONTAL_ALIGNMENT_LEFT, -1, 9, scratch)
	# Stray scratches and a corner chipped off
	c.draw_line(Vector2(-19, 11), Vector2(-8, 12), Color(scratch, 0.5), 0.8)
	c.draw_colored_polygon(PackedVector2Array([Vector2(16, 14), Vector2(24, 14), Vector2(24, 6)]), Color(0.12, 0.13, 0.15))


## A two-handled ice saw with long ragged teeth.
static func _draw_ice_saw(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 12), 34, 2, SHADOW)
	# The blade
	c.draw_colored_polygon(PackedVector2Array([Vector2(-26, -6), Vector2(30, -6), Vector2(30, 2), Vector2(-26, 4)]), STEEL)
	c.draw_line(Vector2(-26, -5), Vector2(30, -5), Color(1, 1, 1, 0.6), 1.0)
	# Teeth along the bottom (separate triangles)
	var teeth := PackedColorArray([STEEL.darkened(0.2), STEEL.darkened(0.2), STEEL.darkened(0.2)])
	for i in range(11):
		var x := -25.0 + i * 5.0
		c.draw_primitive(PackedVector2Array([Vector2(x, 3), Vector2(x + 5, 2.6), Vector2(x + 2, 8)]), teeth, PackedVector2Array())
	# The big T-handle at one end
	c.draw_rect(Rect2(-34, -13, 9, 20), WOOD)
	c.draw_rect(Rect2(-34, -13, 2.5, 20), WOOD.lightened(0.2))
	c.draw_circle(Vector2(-29, -3), 1.5, IRON_DARK)
	# Rust and a smear of frost
	c.draw_circle(Vector2(12, -2), 2, Color(0.55, 0.32, 0.18, 0.7))
	c.draw_line(Vector2(0, -3), Vector2(20, -3), FROST, 1.0)


## A silver swallow brooch caught in a little disc of ice.
static func _draw_frozen_brooch(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 13), 12, 2, SHADOW)
	var silver := Color(0.82, 0.84, 0.88)
	# The swallow: body, two swept-back wings and a forked tail
	c.draw_colored_polygon(PackedVector2Array([Vector2(-9, -2), Vector2(-3, -4), Vector2(5, -2), Vector2(3, 2), Vector2(-6, 1)]), silver)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-3, -3), Vector2(2, -12), Vector2(1, -2)]), silver.darkened(0.15))
	c.draw_colored_polygon(PackedVector2Array([Vector2(-2, 0), Vector2(4, 9), Vector2(2, 1)]), silver.darkened(0.15))
	c.draw_line(Vector2(4, -1), Vector2(11, -5), silver, 1.5)
	c.draw_line(Vector2(4, 0), Vector2(11, 3), silver, 1.5)
	c.draw_circle(Vector2(-7, -1), 1.0, Color(0.2, 0.3, 0.6))
	# The ice it froze in
	c.draw_circle(Vector2.ZERO, 13, ICE)
	c.draw_arc(Vector2.ZERO, 13, 0, TAU, 20, Color(1, 1, 1, 0.6), 1.2)
	c.draw_arc(Vector2(-3, -3), 8, PI, PI * 1.5, 8, Color(1, 1, 1, 0.8), 1.5)


## A wooden snowshoe strung with rawhide, with a leather toe strap.
static func _draw_snowshoe(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 31), 10, 2, SHADOW)
	# The bent-wood frame: a teardrop with a long tail
	var frame := PackedVector2Array()
	for i in range(17):
		var angle := PI + i * PI / 16.0
		frame.append(Vector2(cos(angle) * 13.0, -12.0 + sin(angle) * 18.0))
	frame.append(Vector2(13, -8))
	frame.append(Vector2(2, 30))
	frame.append(Vector2(-2, 30))
	frame.append(Vector2(-13, -8))
	c.draw_polyline(frame, WOOD, 3.0, true)
	# Rawhide webbing
	var web := Color(0.8, 0.7, 0.5, 0.8)
	for y in range(-24, 20, 5):
		var half_width := 11.0 if y < -6 else maxf(11.0 - (y + 6) * 0.38, 1.5)
		c.draw_line(Vector2(-half_width, y), Vector2(half_width, y), web, 0.8)
	for x in [-6.0, 0.0, 6.0]:
		c.draw_line(Vector2(x, -27), Vector2(x * 0.4, 20), web, 0.8)
	# Cross bars and toe strap
	c.draw_line(Vector2(-12, -14), Vector2(12, -14), WOOD_DARK, 2.0)
	c.draw_line(Vector2(-11, -2), Vector2(11, -2), WOOD_DARK, 2.0)
	c.draw_rect(Rect2(-7, -11, 14, 5), Color(0.3, 0.18, 0.1))
	# Snow packed in the webbing
	c.draw_circle(Vector2(-4, 6), 2.5, FROST)
	c.draw_circle(Vector2(3, -20), 2, FROST)


## A big iron key with a ring, and a brass tag stamped with a little lighthouse.
static func _draw_lighthouse_key(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 11), 27, 2.5, SHADOW)
	# Bow (the ring you hold)
	c.draw_arc(Vector2(-20, -2), 7, 0, TAU, 14, IRON_DARK, 4.0)
	c.draw_arc(Vector2(-20, -2), 7, PI, PI * 1.5, 6, STEEL, 1.2)
	# Shaft and bit
	c.draw_rect(Rect2(-13, -4, 32, 4), IRON)
	c.draw_rect(Rect2(14, 0, 4, 7), IRON)
	c.draw_rect(Rect2(20, 0, 3, 5), IRON)
	c.draw_line(Vector2(-13, -3.5), Vector2(18, -3.5), Color(1, 1, 1, 0.3), 1.0)
	# Brass tag with a red-and-white lighthouse
	c.draw_line(Vector2(-20, 5), Vector2(-14, 7), BRASS_DARK, 1.0)
	c.draw_rect(Rect2(-15, 5, 16, 8), BRASS)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-9, 12), Vector2(-8, 6.5), Vector2(-6, 6.5), Vector2(-5, 12)]), Color(0.92, 0.9, 0.86))
	c.draw_rect(Rect2(-8.6, 9, 3.2, 1.5), Color(0.7, 0.15, 0.12))
	c.draw_line(Vector2(-5, 6.5), Vector2(-1, 5.5), Color(1, 0.95, 0.6), 1.0)
