@tool
class_name LighthouseStepsObjects
extends RefCounted
## Placeholder drawings for the hidden objects of House Two, Chapter Seven
## (The Lighthouse Steps): Agnes Hale's things, left all the way up the tower.
## Same rules as placeholder_art.gd: every drawing is centred on (0, 0) and
## fits inside get_size(). PlaceholderArt calls these functions.

const BRASS := Color(0.8, 0.62, 0.3)
const BRASS_DARK := Color(0.52, 0.38, 0.16)
const BRASS_LIGHT := Color(0.95, 0.82, 0.5)
const IRON := Color(0.34, 0.33, 0.34)
const IRON_DARK := Color(0.18, 0.18, 0.19)
const OILSKIN := Color(0.86, 0.68, 0.16)
const OILSKIN_DARK := Color(0.6, 0.45, 0.08)
const PAPER := Color(0.9, 0.86, 0.74)
const PAPER_DARK := Color(0.72, 0.67, 0.55)
const INK := Color(0.16, 0.14, 0.2)
const RED := Color(0.7, 0.16, 0.14)
const GLASS := Color(0.6, 0.78, 0.72, 0.45)
const SHADOW := Color(0, 0, 0, 0.35)


## Size of the drawing, or Vector2.ZERO if `style` is not one of this chapter's objects.
static func get_size(style: int) -> Vector2:
	match style:
		HiddenObjectData.PlaceholderStyle.OILSKIN_HAT:
			return Vector2(50, 30)
		HiddenObjectData.PlaceholderStyle.TELESCOPE:
			return Vector2(62, 18)
		HiddenObjectData.PlaceholderStyle.KEEPER_LOGBOOK:
			return Vector2(44, 36)
		HiddenObjectData.PlaceholderStyle.WICK_TRIMMER:
			return Vector2(42, 20)
		HiddenObjectData.PlaceholderStyle.PARAFFIN_CAN:
			return Vector2(34, 42)
		HiddenObjectData.PlaceholderStyle.GULL_FEATHER:
			return Vector2(46, 14)
		HiddenObjectData.PlaceholderStyle.KNITTING_NEEDLES:
			return Vector2(46, 32)
		HiddenObjectData.PlaceholderStyle.BANDAGE_ROLL:
			return Vector2(36, 24)
		HiddenObjectData.PlaceholderStyle.TIDE_TABLE:
			return Vector2(34, 44)
		HiddenObjectData.PlaceholderStyle.BAROMETER:
			return Vector2(34, 58)
		HiddenObjectData.PlaceholderStyle.SHIP_IN_BOTTLE:
			return Vector2(54, 24)
		HiddenObjectData.PlaceholderStyle.LIFESAVING_MEDAL:
			return Vector2(26, 42)
		HiddenObjectData.PlaceholderStyle.KEEPERS_PHOTO:
			return Vector2(38, 46)
		HiddenObjectData.PlaceholderStyle.LAMP_ROOM_KEY:
			return Vector2(58, 26)
	return Vector2.ZERO


## Draws `style` and returns true, or returns false if it is not one of this chapter's objects.
static func draw(c: CanvasItem, style: int) -> bool:
	match style:
		HiddenObjectData.PlaceholderStyle.OILSKIN_HAT:
			_draw_oilskin_hat(c)
		HiddenObjectData.PlaceholderStyle.TELESCOPE:
			_draw_telescope(c)
		HiddenObjectData.PlaceholderStyle.KEEPER_LOGBOOK:
			_draw_keeper_logbook(c)
		HiddenObjectData.PlaceholderStyle.WICK_TRIMMER:
			_draw_wick_trimmer(c)
		HiddenObjectData.PlaceholderStyle.PARAFFIN_CAN:
			_draw_paraffin_can(c)
		HiddenObjectData.PlaceholderStyle.GULL_FEATHER:
			_draw_gull_feather(c)
		HiddenObjectData.PlaceholderStyle.KNITTING_NEEDLES:
			_draw_knitting_needles(c)
		HiddenObjectData.PlaceholderStyle.BANDAGE_ROLL:
			_draw_bandage_roll(c)
		HiddenObjectData.PlaceholderStyle.TIDE_TABLE:
			_draw_tide_table(c)
		HiddenObjectData.PlaceholderStyle.BAROMETER:
			_draw_barometer(c)
		HiddenObjectData.PlaceholderStyle.SHIP_IN_BOTTLE:
			_draw_ship_in_bottle(c)
		HiddenObjectData.PlaceholderStyle.LIFESAVING_MEDAL:
			_draw_lifesaving_medal(c)
		HiddenObjectData.PlaceholderStyle.KEEPERS_PHOTO:
			_draw_keepers_photo(c)
		HiddenObjectData.PlaceholderStyle.LAMP_ROOM_KEY:
			_draw_lamp_room_key(c)
		_:
			return false
	return true


## A yellow sou'wester: a rounded crown, a long brim at the back and a chin strap.
static func _draw_oilskin_hat(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 13), 23, 2.5, SHADOW)
	# The brim, longer at the back (right) to keep rain off the neck
	c.draw_colored_polygon(PackedVector2Array([Vector2(-24, 4), Vector2(-14, 0), Vector2(14, 0), Vector2(25, 5),
		Vector2(22, 11), Vector2(6, 9), Vector2(-12, 9), Vector2(-23, 8)]), OILSKIN_DARK)
	# The crown, made of stitched panels
	c.draw_colored_polygon(PackedVector2Array([Vector2(-14, 2), Vector2(-12, -8), Vector2(-5, -13), Vector2(5, -13),
		Vector2(12, -8), Vector2(14, 2)]), OILSKIN)
	c.draw_line(Vector2(0, -13), Vector2(0, 2), OILSKIN_DARK, 1.0)
	c.draw_line(Vector2(-7, -12), Vector2(-9, 2), Color(OILSKIN_DARK, 0.7), 1.0)
	c.draw_line(Vector2(7, -12), Vector2(9, 2), Color(OILSKIN_DARK, 0.7), 1.0)
	# A shine on the wet oilskin
	c.draw_arc(Vector2(-4, -6), 6, PI * 1.1, PI * 1.6, 6, Color(1, 0.96, 0.75, 0.7), 1.5)
	# Band where the brim meets the crown, and a loose chin strap
	c.draw_line(Vector2(-14, 2), Vector2(14, 2), OILSKIN_DARK.darkened(0.3), 2.0)
	c.draw_polyline(PackedVector2Array([Vector2(-10, 8), Vector2(-8, 13), Vector2(0, 14), Vector2(6, 11)]),
		Color(0.25, 0.2, 0.12), 1.2)


## A brass spyglass, pulled half out, with leather grip and a lens cap on a cord.
static func _draw_telescope(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 8), 30, 2, SHADOW)
	# Widest tube (left) with a leather grip
	c.draw_rect(Rect2(-30, -6, 22, 12), Color(0.35, 0.2, 0.12))
	for x in range(-28, -9, 4):
		c.draw_line(Vector2(x, -6), Vector2(x, 6), Color(0.25, 0.14, 0.08), 1.0)
	c.draw_rect(Rect2(-31, -7, 3, 14), BRASS_DARK)
	PlaceholderArt.draw_ellipse(c, Vector2(-31, 0), 2, 6, Color(0.55, 0.7, 0.8))
	# The drawn-out brass sections, each a little thinner
	c.draw_rect(Rect2(-8, -5, 16, 10), BRASS)
	c.draw_rect(Rect2(-9, -6, 3, 12), BRASS_DARK)
	c.draw_rect(Rect2(8, -4, 14, 8), BRASS)
	c.draw_rect(Rect2(7, -5, 3, 10), BRASS_DARK)
	c.draw_rect(Rect2(22, -3, 8, 6), BRASS_LIGHT)
	c.draw_rect(Rect2(20, -4, 3, 8), BRASS_DARK)
	# Bright highlight along the top
	c.draw_line(Vector2(-6, -3.5), Vector2(29, -2), Color(1, 0.95, 0.75, 0.75), 1.2)
	# Eyepiece cap hanging on a cord
	c.draw_polyline(PackedVector2Array([Vector2(28, 3), Vector2(26, 7), Vector2(20, 8)]), Color(0.2, 0.14, 0.1), 1.0)
	c.draw_circle(Vector2(19, 8), 2, BRASS_DARK)


## A thick leather-bound logbook, open at a page of dated entries.
static func _draw_keeper_logbook(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-20, -14, 44, 32), SHADOW)
	# Cover (dark green leather) peeking out round the pages
	c.draw_rect(Rect2(-22, -16, 44, 32), Color(0.16, 0.26, 0.2))
	c.draw_rect(Rect2(-22, -16, 44, 32), Color(0.08, 0.14, 0.1), false, 1.0)
	# Two open pages
	c.draw_rect(Rect2(-20, -14, 19, 28), PAPER)
	c.draw_rect(Rect2(1, -14, 19, 28), PAPER.lightened(0.05))
	c.draw_line(Vector2(0, -15), Vector2(0, 15), Color(0.4, 0.35, 0.28), 1.5)
	# Ruled columns: date, wind, remarks
	for page_x: float in [-20.0, 1.0]:
		c.draw_line(Vector2(page_x + 5, -14), Vector2(page_x + 5, 14), Color(0.7, 0.3, 0.3, 0.7), 0.8)
		for row in range(6):
			var y := -10.0 + row * 4.2
			c.draw_line(Vector2(page_x + 1, y), Vector2(page_x + 3.5, y), INK, 1.0)
			c.draw_line(Vector2(page_x + 6.5, y), Vector2(page_x + 13.0 + (row % 3) * 1.8, y), Color(INK, 0.75), 0.9)
	# A pencil left in the gutter, and a red ribbon marker
	c.draw_line(Vector2(-6, 16), Vector2(14, 10), Color(0.75, 0.6, 0.2), 2.0)
	c.draw_line(Vector2(14, 10), Vector2(16, 9.4), Color(0.2, 0.18, 0.16), 2.0)
	c.draw_line(Vector2(2, -15), Vector2(4, -18), RED, 2.0)


## Wick trimming scissors: long blades with a little box on one blade to catch the trimmings.
static func _draw_wick_trimmer(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 8), 19, 2, SHADOW)
	# Finger rings
	c.draw_arc(Vector2(-14, -3), 5, 0, TAU, 12, IRON, 2.0)
	c.draw_arc(Vector2(-14, 5), 5, 0, TAU, 12, IRON, 2.0)
	# Arms crossing at the pivot
	c.draw_line(Vector2(-10, -2), Vector2(-2, 1), IRON, 2.5)
	c.draw_line(Vector2(-10, 4), Vector2(-2, 1), IRON, 2.5)
	c.draw_circle(Vector2(-2, 1), 2, BRASS)
	# Blades, and the snuffer box on the upper blade
	c.draw_colored_polygon(PackedVector2Array([Vector2(-2, 0), Vector2(20, -2), Vector2(20, 1), Vector2(-2, 2)]), Color(0.55, 0.56, 0.58))
	c.draw_line(Vector2(-2, 2), Vector2(19, 3), Color(0.45, 0.46, 0.48), 1.5)
	c.draw_rect(Rect2(6, -7, 12, 6), IRON_DARK)
	c.draw_rect(Rect2(7, -6, 10, 2), IRON)
	# Soot on the tip
	c.draw_line(Vector2(17, -1), Vector2(20, -1), Color(0.05, 0.05, 0.05), 2.0)
	c.draw_line(Vector2(0, -0.5), Vector2(16, -1.5), Color(1, 1, 1, 0.35), 0.8)


## A red paraffin can with a screw cap, a spout and a carrying handle.
static func _draw_paraffin_can(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 19), 15, 2.5, SHADOW)
	var red := Color(0.62, 0.15, 0.12)
	c.draw_rect(Rect2(-13, -10, 26, 29), red)
	c.draw_rect(Rect2(-13, -10, 5, 29), red.lightened(0.18))
	c.draw_rect(Rect2(9, -10, 4, 29), red.darkened(0.3))
	# Rolled rims top and bottom
	c.draw_rect(Rect2(-14, -12, 28, 3), red.darkened(0.35))
	c.draw_rect(Rect2(-14, 17, 28, 3), red.darkened(0.35))
	# Stencilled label
	c.draw_rect(Rect2(-9, -2, 18, 10), Color(0.85, 0.78, 0.55))
	c.draw_line(Vector2(-6, 1), Vector2(6, 1), Color(0.3, 0.1, 0.08), 1.2)
	c.draw_line(Vector2(-6, 4.5), Vector2(3, 4.5), Color(0.3, 0.1, 0.08), 1.0)
	# Handle, screw cap and a bent spout
	c.draw_line(Vector2(-10, -12), Vector2(-8, -19), IRON, 2.0)
	c.draw_line(Vector2(-8, -19), Vector2(4, -19), IRON, 2.0)
	c.draw_line(Vector2(4, -19), Vector2(5, -12), IRON, 2.0)
	c.draw_rect(Rect2(6, -16, 6, 4), BRASS_DARK)
	c.draw_line(Vector2(-12, -12), Vector2(-17, -18), Color(0.5, 0.12, 0.1), 3.0)
	# A dark oil drip down the side
	c.draw_line(Vector2(5, -9), Vector2(5, 0), Color(0.3, 0.2, 0.1, 0.7), 1.5)


## A long grey-and-white gull feather.
static func _draw_gull_feather(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(2, 6), 20, 1.5, SHADOW)
	# Vane: a soft leaf shape made of many little barbs
	for i in range(18):
		var t := float(i) / 17.0
		var x := lerpf(-16.0, 20.0, t)
		var width := sin(t * PI) * 6.0 + 0.5
		var colour := Color(0.9, 0.9, 0.92) if t < 0.7 else Color(0.35, 0.37, 0.42)
		c.draw_line(Vector2(x, 0), Vector2(x + 3.0, -width), colour, 1.6)
		c.draw_line(Vector2(x, 0), Vector2(x + 2.5, width * 0.8), colour.darkened(0.08), 1.6)
	# A split in the vane, and the white tip
	c.draw_line(Vector2(4, 0), Vector2(7, -5), Color(0.3, 0.3, 0.32, 0.8), 1.0)
	c.draw_circle(Vector2(21, -1), 1.5, Color(0.95, 0.95, 0.95))
	# The quill
	c.draw_line(Vector2(-22, 1.5), Vector2(21, -0.5), Color(0.92, 0.88, 0.78), 1.2)


## Two wooden knitting needles stuck through a ball of wool, with a little knitted strip.
static func _draw_knitting_needles(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 14), 20, 2.5, SHADOW)
	var wool := Color(0.32, 0.45, 0.62)
	# A small strip of knitting hanging from the needle: far too small for Agnes
	c.draw_rect(Rect2(-18, -4, 16, 15), wool.darkened(0.1))
	for row in range(5):
		for col in range(5):
			var at := Vector2(-16.5 + col * 3.0, -2.5 + row * 3.0)
			c.draw_line(at, at + Vector2(1.5, 2), wool.lightened(0.2), 1.0)
			c.draw_line(at + Vector2(3, 0), at + Vector2(1.5, 2), wool.lightened(0.2), 1.0)
	# Ball of wool
	c.draw_circle(Vector2(10, 4), 10, wool)
	for i in range(4):
		c.draw_arc(Vector2(10, 4), 9 - i * 2, PI * (0.1 + i * 0.3), PI * (0.9 + i * 0.3), 8, wool.lightened(0.18), 1.0)
	c.draw_polyline(PackedVector2Array([Vector2(1, 6), Vector2(-4, 10), Vector2(-10, 11)]), wool.lightened(0.1), 1.2)
	# The two needles, crossed through the ball, with knobs on the ends
	c.draw_line(Vector2(-22, -6), Vector2(20, -12), Color(0.7, 0.55, 0.32), 2.0)
	c.draw_line(Vector2(-14, -14), Vector2(22, 10), Color(0.66, 0.5, 0.3), 2.0)
	c.draw_circle(Vector2(20, -12), 2.2, RED)
	c.draw_circle(Vector2(-14, -14), 2.2, RED)


## A roll of white cotton bandage, a length unrolled, with a safety pin.
static func _draw_bandage_roll(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 10), 17, 2.5, SHADOW)
	var cotton := Color(0.93, 0.92, 0.88)
	# The unrolled tail, gently twisted
	c.draw_colored_polygon(PackedVector2Array([Vector2(-2, 2), Vector2(18, 4), Vector2(17, 10), Vector2(-2, 9)]), cotton.darkened(0.08))
	c.draw_line(Vector2(0, 5.5), Vector2(16, 7), Color(0.75, 0.74, 0.7), 0.8)
	# The roll seen end-on
	c.draw_rect(Rect2(-14, -9, 14, 18), cotton)
	PlaceholderArt.draw_ellipse(c, Vector2(-14, 0), 4, 9, Color(0.82, 0.81, 0.77))
	for i in range(3):
		c.draw_arc(Vector2(-14, 0), 7 - i * 2.2, 0, TAU, 12, Color(0.7, 0.69, 0.65), 0.8)
	c.draw_circle(Vector2(-14, 0), 1.2, Color(0.55, 0.54, 0.5))
	# Safety pin
	c.draw_line(Vector2(-6, -10), Vector2(6, -10), Color(0.75, 0.76, 0.8), 1.2)
	c.draw_line(Vector2(-6, -8), Vector2(5, -8), Color(0.75, 0.76, 0.8), 1.2)
	c.draw_arc(Vector2(-6, -9), 1.2, PI * 0.5, PI * 1.5, 4, Color(0.75, 0.76, 0.8), 1.0)


## A printed tide table booklet for 1988, with one night ringed in red.
static func _draw_tide_table(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-14, -19, 32, 42), SHADOW)
	# Blue card cover with a folded corner
	c.draw_colored_polygon(PackedVector2Array([Vector2(-17, -22), Vector2(17, -22), Vector2(17, 16), Vector2(11, 22),
		Vector2(-17, 22)]), Color(0.78, 0.82, 0.86))
	c.draw_colored_polygon(PackedVector2Array([Vector2(17, 16), Vector2(11, 22), Vector2(11, 16)]), Color(0.6, 0.64, 0.7))
	c.draw_rect(Rect2(-17, -22, 34, 9), Color(0.2, 0.3, 0.5))
	c.draw_line(Vector2(-12, -17.5), Vector2(8, -17.5), Color(0.9, 0.9, 0.95), 2.0)
	# Columns of times
	for row in range(8):
		var y := -9.0 + row * 3.6
		c.draw_line(Vector2(-14, y), Vector2(-9, y), INK, 1.0)
		c.draw_line(Vector2(-6, y), Vector2(2, y), Color(INK, 0.7), 1.0)
		c.draw_line(Vector2(5, y), Vector2(13, y), Color(INK, 0.7), 1.0)
	# One night ringed in red pencil
	var ring := PlaceholderArt.ellipse_points(Vector2(-1, 3.6), 15, 3.2, 20)
	ring.append(ring[0])
	c.draw_polyline(ring, RED, 1.2, true)
	# Tide wave symbol at the bottom
	c.draw_polyline(PackedVector2Array([Vector2(-14, 18), Vector2(-10, 15), Vector2(-6, 18), Vector2(-2, 15),
		Vector2(2, 18)]), Color(0.2, 0.3, 0.5), 1.2)


## A banjo barometer: a wooden case, a round dial with a needle at STORMY, and a thermometer.
static func _draw_barometer(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-13, -25, 30, 56), SHADOW)
	var wood := Color(0.42, 0.24, 0.14)
	# The banjo-shaped case
	c.draw_circle(Vector2(0, 10), 16, wood)
	c.draw_rect(Rect2(-7, -26, 14, 36), wood)
	c.draw_circle(Vector2(0, -24), 5, wood)
	c.draw_line(Vector2(-6, -20), Vector2(-6, 8), wood.lightened(0.15), 1.0)
	# Thermometer in the neck
	c.draw_rect(Rect2(-2, -22, 4, 24), PAPER)
	c.draw_line(Vector2(0, -20), Vector2(0, 0), RED, 1.2)
	c.draw_circle(Vector2(0, 1), 2, RED)
	# Dial with its brass bezel
	c.draw_circle(Vector2(0, 10), 13, BRASS_DARK)
	c.draw_circle(Vector2(0, 10), 11.5, PAPER.lightened(0.05))
	for i in range(9):
		var angle := PI * 0.8 + i * PI * 1.4 / 8.0
		var direction := Vector2.from_angle(angle)
		c.draw_line(Vector2(0, 10) + direction * 8.5, Vector2(0, 10) + direction * 11, INK, 1.0)
	# The needle has swung right round to STORMY (left)
	c.draw_line(Vector2(0, 10), Vector2(0, 10) + Vector2.from_angle(PI * 0.95) * 9.5, IRON_DARK, 1.5)
	c.draw_line(Vector2(0, 10), Vector2(0, 10) + Vector2.from_angle(PI * 1.5) * 8.0, Color(BRASS, 0.9), 1.0)
	c.draw_circle(Vector2(0, 10), 1.5, BRASS)
	c.draw_line(Vector2(-9, 12), Vector2(-5, 12), RED, 1.2)


## A little sailing ship inside a green glass bottle, sealed with a cork.
static func _draw_ship_in_bottle(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 11), 25, 2, SHADOW)
	# The wooden stand
	c.draw_rect(Rect2(-14, 8, 6, 4), Color(0.35, 0.22, 0.14))
	c.draw_rect(Rect2(10, 8, 6, 4), Color(0.35, 0.22, 0.14))
	# Bottle body and neck
	PlaceholderArt.draw_ellipse(c, Vector2(-4, 0), 20, 9, GLASS)
	c.draw_rect(Rect2(14, -3.5, 9, 7), GLASS)
	c.draw_rect(Rect2(22, -3, 5, 6), Color(0.6, 0.45, 0.28))
	# Painted sea and the ship
	c.draw_colored_polygon(PackedVector2Array([Vector2(-20, 3), Vector2(12, 3), Vector2(10, 7), Vector2(-18, 7)]), Color(0.18, 0.32, 0.5))
	c.draw_colored_polygon(PackedVector2Array([Vector2(-14, 1), Vector2(6, 1), Vector2(3, 4), Vector2(-12, 4)]), Color(0.2, 0.12, 0.08))
	c.draw_line(Vector2(-8, 1), Vector2(-8, -8), Color(0.25, 0.16, 0.1), 1.0)
	c.draw_line(Vector2(0, 1), Vector2(0, -6), Color(0.25, 0.16, 0.1), 1.0)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-7, -8), Vector2(-2, -1), Vector2(-7, -1)]), Color(0.95, 0.93, 0.86))
	c.draw_colored_polygon(PackedVector2Array([Vector2(1, -6), Vector2(5, -1), Vector2(1, -1)]), Color(0.95, 0.93, 0.86))
	c.draw_colored_polygon(PackedVector2Array([Vector2(-9, -7), Vector2(-13, -1), Vector2(-9, -1)]), Color(0.9, 0.88, 0.8))
	# Glass highlight
	c.draw_arc(Vector2(-6, -1), 14, PI * 1.15, PI * 1.6, 8, Color(1, 1, 1, 0.55), 1.5)


## A silver medal on a blue and white ribbon: awarded for saving lives at sea.
static func _draw_lifesaving_medal(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 19), 10, 2, SHADOW)
	# Ribbon with stripes
	c.draw_colored_polygon(PackedVector2Array([Vector2(-8, -20), Vector2(8, -20), Vector2(5, -2), Vector2(-5, -2)]), Color(0.2, 0.32, 0.6))
	c.draw_colored_polygon(PackedVector2Array([Vector2(-2.5, -20), Vector2(2.5, -20), Vector2(1.5, -2), Vector2(-1.5, -2)]), Color(0.9, 0.9, 0.92))
	c.draw_rect(Rect2(-9, -21, 18, 3), BRASS_DARK)
	c.draw_rect(Rect2(-2, -3, 4, 4), Color(0.7, 0.72, 0.75))
	# The silver disc with a lifebelt and a crown
	c.draw_circle(Vector2(0, 9), 10, Color(0.55, 0.57, 0.6))
	c.draw_circle(Vector2(0, 9), 8.5, Color(0.8, 0.82, 0.85))
	c.draw_arc(Vector2(0, 10), 5, 0, TAU, 14, Color(0.5, 0.52, 0.56), 2.0)
	for i in range(4):
		var direction := Vector2.from_angle(PI / 4.0 + i * PI / 2.0)
		c.draw_line(Vector2(0, 10) + direction * 4, Vector2(0, 10) + direction * 6, Color(0.7, 0.3, 0.28), 2.0)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-3, 3), Vector2(-2, 1), Vector2(0, 2.5), Vector2(2, 1), Vector2(3, 3)]), Color(0.5, 0.52, 0.56))
	c.draw_arc(Vector2(-2, 6), 6, PI * 1.1, PI * 1.5, 6, Color(1, 1, 1, 0.75), 1.2)


## A small framed photograph: Agnes in her keeper's jacket beside a young woman with dark hair.
static func _draw_keepers_photo(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-16, -20, 36, 46), SHADOW)
	# Wooden frame and a little stand
	c.draw_rect(Rect2(-19, -23, 38, 46), Color(0.38, 0.24, 0.14))
	c.draw_rect(Rect2(-19, -23, 38, 46), Color(0.55, 0.38, 0.22), false, 1.5)
	# Sepia print: sky, the tower and the shore
	c.draw_rect(Rect2(-15, -19, 30, 38), Color(0.72, 0.62, 0.46))
	c.draw_rect(Rect2(-15, 6, 30, 13), Color(0.55, 0.46, 0.33))
	c.draw_colored_polygon(PackedVector2Array([Vector2(8, -16), Vector2(12, -16), Vector2(13, 6), Vector2(7, 6)]), Color(0.88, 0.82, 0.7))
	c.draw_rect(Rect2(7, -18, 6, 2), Color(0.3, 0.22, 0.15))
	# Agnes: grey hair, dark jacket
	c.draw_circle(Vector2(-7, -5), 3.5, Color(0.86, 0.74, 0.6))
	c.draw_arc(Vector2(-7, -6), 3.6, PI, TAU, 8, Color(0.85, 0.85, 0.82), 2.0)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-12, 12), Vector2(-11, 0), Vector2(-3, 0), Vector2(-2, 12)]), Color(0.2, 0.2, 0.26))
	# The young woman: long dark hair, a pale jumper
	c.draw_circle(Vector2(2, -4), 3.2, Color(0.88, 0.76, 0.62))
	c.draw_colored_polygon(PackedVector2Array([Vector2(-1.5, -5), Vector2(0, -8), Vector2(4, -8), Vector2(5.5, -5),
		Vector2(5.5, 3), Vector2(4, -2), Vector2(0, -2), Vector2(-1.5, 3)]), Color(0.18, 0.12, 0.08))
	c.draw_colored_polygon(PackedVector2Array([Vector2(-2, 12), Vector2(-1, 1), Vector2(5, 1), Vector2(6, 12)]), Color(0.78, 0.74, 0.66))
	# Agnes's arm round her shoulders
	c.draw_line(Vector2(-4, 1), Vector2(1, 1.5), Color(0.2, 0.2, 0.26), 2.0)
	# Glass shine
	c.draw_line(Vector2(-13, -10), Vector2(-6, -17), Color(1, 1, 1, 0.35), 1.5)


## A heavy iron key with a wooden tag marked LAMP.
static func _draw_lamp_room_key(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 10), 27, 2.5, SHADOW)
	# Bow (the ring you hold)
	c.draw_circle(Vector2(-18, -2), 8, IRON)
	c.draw_circle(Vector2(-18, -2), 4.5, Color(0.06, 0.06, 0.07))
	c.draw_arc(Vector2(-18, -2), 7.5, PI * 1.1, PI * 1.6, 6, Color(0.6, 0.6, 0.62), 1.2)
	# Shaft and the bit with its teeth
	c.draw_rect(Rect2(-11, -4, 34, 4.5), IRON)
	c.draw_line(Vector2(-10, -3.5), Vector2(22, -3.5), Color(0.6, 0.6, 0.62), 1.0)
	c.draw_rect(Rect2(14, 0, 10, 9), IRON)
	c.draw_rect(Rect2(17, 4, 2.5, 5), Color(0.06, 0.06, 0.07))
	c.draw_rect(Rect2(21, 6, 3, 3), Color(0.06, 0.06, 0.07))
	# Wooden tag on a string, with LAMP burnt into it
	c.draw_line(Vector2(-22, 4), Vector2(-24, 9), Color(0.6, 0.5, 0.35), 1.0)
	c.draw_rect(Rect2(-29, 8, 16, 8), Color(0.66, 0.5, 0.3))
	c.draw_rect(Rect2(-29, 8, 16, 8), Color(0.42, 0.3, 0.18), false, 1.0)
	c.draw_string(ThemeDB.fallback_font, Vector2(-28, 15), "LAMP", HORIZONTAL_ALIGNMENT_LEFT, -1, 6, Color(0.2, 0.12, 0.06))
