@tool
class_name BoatShedObjects
extends RefCounted
## Placeholder drawings for the hidden objects of House Two, Chapter Two (The Boat Shed).
## Same rules as placeholder_art.gd: every drawing is centred on (0, 0) and
## fits inside get_size(). PlaceholderArt calls these functions.

const BRASS := Color(0.8, 0.62, 0.3)
const BRASS_DARK := Color(0.52, 0.38, 0.16)
const VERDIGRIS := Color(0.35, 0.6, 0.5)
const STEEL := Color(0.62, 0.65, 0.7)
const STEEL_DARK := Color(0.36, 0.38, 0.43)
const PAPER := Color(0.9, 0.86, 0.74)
const SHADOW := Color(0, 0, 0, 0.35)


## Size of the drawing, or Vector2.ZERO if `style` is not one of this chapter's objects.
static func get_size(style: int) -> Vector2:
	match style:
		HiddenObjectData.PlaceholderStyle.HANDKERCHIEF:
			return Vector2(44, 34)
		HiddenObjectData.PlaceholderStyle.TRAIN_TICKET:
			return Vector2(46, 26)
		HiddenObjectData.PlaceholderStyle.COAT_BUTTON:
			return Vector2(24, 24)
		HiddenObjectData.PlaceholderStyle.SHIP_BELL:
			return Vector2(44, 48)
		HiddenObjectData.PlaceholderStyle.PURSE:
			return Vector2(42, 36)
		HiddenObjectData.PlaceholderStyle.TORCH:
			return Vector2(56, 22)
		HiddenObjectData.PlaceholderStyle.GOGGLES:
			return Vector2(52, 24)
		HiddenObjectData.PlaceholderStyle.ETHER_BOTTLE:
			return Vector2(26, 50)
		HiddenObjectData.PlaceholderStyle.BENCH_KEY:
			return Vector2(44, 22)
		HiddenObjectData.PlaceholderStyle.BANK_RECEIPT:
			return Vector2(36, 52)
		HiddenObjectData.PlaceholderStyle.LOFT_KEY:
			return Vector2(60, 24)
	return Vector2.ZERO


## Draws `style` and returns true, or returns false if it is not one of this chapter's objects.
static func draw(c: CanvasItem, style: int) -> bool:
	match style:
		HiddenObjectData.PlaceholderStyle.HANDKERCHIEF:
			_draw_handkerchief(c)
		HiddenObjectData.PlaceholderStyle.TRAIN_TICKET:
			_draw_train_ticket(c)
		HiddenObjectData.PlaceholderStyle.COAT_BUTTON:
			_draw_coat_button(c)
		HiddenObjectData.PlaceholderStyle.SHIP_BELL:
			_draw_ship_bell(c)
		HiddenObjectData.PlaceholderStyle.PURSE:
			_draw_purse(c)
		HiddenObjectData.PlaceholderStyle.TORCH:
			_draw_torch(c)
		HiddenObjectData.PlaceholderStyle.GOGGLES:
			_draw_goggles(c)
		HiddenObjectData.PlaceholderStyle.ETHER_BOTTLE:
			_draw_ether_bottle(c)
		HiddenObjectData.PlaceholderStyle.BENCH_KEY:
			_draw_bench_key(c)
		HiddenObjectData.PlaceholderStyle.BANK_RECEIPT:
			_draw_bank_receipt(c)
		HiddenObjectData.PlaceholderStyle.LOFT_KEY:
			_draw_loft_key(c)
		_:
			return false
	return true


## A crumpled white handkerchief with a blue "RV" monogram in one corner.
static func _draw_handkerchief(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(1, 13), 21, 3, SHADOW)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-21, -6), Vector2(-8, -16), Vector2(6, -12), Vector2(20, -15),
		Vector2(18, 0), Vector2(21, 12), Vector2(4, 9), Vector2(-12, 14), Vector2(-19, 6)]), Color(0.94, 0.94, 0.92))
	# Folds
	c.draw_line(Vector2(-8, -16), Vector2(-2, 8), Color(0.75, 0.75, 0.75), 1.0)
	c.draw_line(Vector2(6, -12), Vector2(10, 9), Color(0.75, 0.75, 0.75), 1.0)
	# Damp patch
	c.draw_circle(Vector2(-10, 2), 6, Color(0.7, 0.72, 0.75, 0.4))
	# Monogram
	var thread := Color(0.2, 0.3, 0.6)
	c.draw_line(Vector2(9, 0), Vector2(9, 6), thread, 1.2)
	c.draw_arc(Vector2(10, 1.5), 1.6, -PI / 2, PI / 2, 5, thread, 1.2)
	c.draw_line(Vector2(10, 3), Vector2(12, 6), thread, 1.2)
	c.draw_line(Vector2(13, 0), Vector2(15, 6), thread, 1.2)
	c.draw_line(Vector2(15, 6), Vector2(17, 0), thread, 1.2)


## A pale green railway ticket with a punched hole and printed text.
static func _draw_train_ticket(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-20, -10, 44, 24), SHADOW)
	c.draw_rect(Rect2(-23, -13, 44, 24), Color(0.74, 0.84, 0.7))
	c.draw_rect(Rect2(-21, -11, 40, 20), Color(0.3, 0.45, 0.3, 0.6), false, 1.0)
	c.draw_line(Vector2(-18, -6), Vector2(4, -6), Color(0.15, 0.25, 0.15), 1.6)
	c.draw_line(Vector2(-18, -1), Vector2(10, -1), Color(0.15, 0.25, 0.15, 0.7), 1.0)
	c.draw_line(Vector2(-18, 3), Vector2(0, 3), Color(0.15, 0.25, 0.15, 0.7), 1.0)
	# Bold time in the corner and a clipper hole
	c.draw_rect(Rect2(7, 1, 11, 6), Color(0.6, 0.15, 0.12, 0.85))
	c.draw_circle(Vector2(13, -6), 2.2, Color(0.1, 0.08, 0.06))
	# Drawing pin at the top
	c.draw_circle(Vector2(-1, -13), 3, Color(0.75, 0.15, 0.12))
	c.draw_circle(Vector2(-2, -14), 1, Color(1, 1, 1, 0.6))


## A round brass button with a tiny snake-and-staff crest and a torn thread.
static func _draw_coat_button(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(1, 10), 10, 2, SHADOW)
	c.draw_circle(Vector2(0, 0), 10, BRASS_DARK)
	c.draw_circle(Vector2(0, -0.5), 8.5, BRASS)
	c.draw_line(Vector2(0, -6), Vector2(0, 6), BRASS_DARK, 1.4)
	c.draw_arc(Vector2(0, -2), 2.5, PI * 0.5, PI * 1.5, 5, BRASS_DARK, 1.2)
	c.draw_arc(Vector2(0, 2), 2.5, -PI * 0.5, PI * 0.5, 5, BRASS_DARK, 1.2)
	c.draw_arc(Vector2(-2, -3), 6, PI, PI * 1.5, 6, Color(1, 1, 1, 0.55), 1.4)
	# Ripped thread
	c.draw_polyline(PackedVector2Array([Vector2(6, 6), Vector2(10, 9), Vector2(8, 11), Vector2(11, 12)]), Color(0.15, 0.15, 0.2), 1.0)


## A small brass ship's bell gone green in places, with a fresh rope through its crown.
static func _draw_ship_bell(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 21), 21, 3.5, SHADOW)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-8, -14), Vector2(8, -14), Vector2(12, 4), Vector2(19, 16),
		Vector2(-19, 16), Vector2(-12, 4)]), BRASS_DARK)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-6, -13), Vector2(5, -13), Vector2(9, 4), Vector2(15, 14),
		Vector2(-16, 14), Vector2(-10, 4)]), BRASS)
	c.draw_rect(Rect2(-19, 14, 38, 4), BRASS_DARK)
	# Green corrosion and an engraved band
	c.draw_circle(Vector2(-8, 8), 4, Color(VERDIGRIS, 0.7))
	c.draw_circle(Vector2(7, -4), 3, Color(VERDIGRIS, 0.6))
	c.draw_line(Vector2(-12, 6), Vector2(11, 6), Color(0.4, 0.28, 0.1), 1.2)
	c.draw_line(Vector2(-4, -10), Vector2(-7, 10), Color(1, 1, 1, 0.35), 2.0)
	# Crown and a new white rope
	c.draw_arc(Vector2(0, -17), 4, PI, TAU, 6, BRASS_DARK, 3.0)
	c.draw_polyline(PackedVector2Array([Vector2(0, -20), Vector2(6, -23), Vector2(14, -21), Vector2(20, -23)]), Color(0.92, 0.9, 0.82), 2.0)


## A small beaded evening purse with a clasp, dark with water.
static func _draw_purse(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 16), 20, 3, SHADOW)
	var body := Color(0.32, 0.16, 0.3)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-18, -4), Vector2(18, -4), Vector2(16, 14), Vector2(-16, 14)]), body)
	PlaceholderArt.draw_ellipse(c, Vector2(0, -4), 18, 5, Color(0.42, 0.22, 0.4))
	# Rows of tiny beads
	for row in range(3):
		for i in range(8):
			c.draw_circle(Vector2(-13 + i * 3.8, 1 + row * 4.5), 0.9, Color(0.85, 0.8, 0.9, 0.6))
	# Clasp and chain
	c.draw_rect(Rect2(-14, -7, 28, 3), BRASS)
	c.draw_circle(Vector2(-3, -9), 2, BRASS)
	c.draw_circle(Vector2(3, -9), 2, BRASS)
	c.draw_arc(Vector2(0, -8), 14, PI * 1.1, PI * 1.9, 10, BRASS_DARK, 1.0)


## An old metal torch lying on its side, its beam still shining.
static func _draw_torch(c: CanvasItem) -> void:
	# Beam first, so the torch sits on top of it
	c.draw_colored_polygon(PackedVector2Array([Vector2(16, -4), Vector2(28, -11), Vector2(28, 11), Vector2(16, 4)]),
		Color(1, 0.95, 0.7, 0.35))
	PlaceholderArt.draw_ellipse(c, Vector2(-2, 9), 22, 2.5, SHADOW)
	c.draw_rect(Rect2(-26, -4, 30, 8), STEEL_DARK)
	c.draw_rect(Rect2(-26, -4, 30, 3), STEEL)
	c.draw_colored_polygon(PackedVector2Array([Vector2(4, -4), Vector2(13, -7), Vector2(13, 7), Vector2(4, 4)]), STEEL)
	c.draw_rect(Rect2(13, -7, 4, 14), STEEL_DARK)
	c.draw_rect(Rect2(15, -6, 2, 12), Color(1, 0.97, 0.8))
	c.draw_rect(Rect2(-12, -6, 5, 2), Color(0.2, 0.2, 0.22))
	# Knurled grip
	for x in range(-24, -14, 3):
		c.draw_line(Vector2(x, -3), Vector2(x, 3), Color(0.3, 0.32, 0.36), 1.0)


## Rubber diving goggles with two round glass eyes and a strap with weed caught in it.
static func _draw_goggles(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 10), 24, 2.5, SHADOW)
	var rubber := Color(0.12, 0.12, 0.13)
	c.draw_arc(Vector2(0, 2), 24, PI * 1.05, PI * 1.95, 12, rubber, 3.0)
	for x in [-10.0, 10.0]:
		c.draw_circle(Vector2(x, 0), 9, rubber)
		c.draw_circle(Vector2(x, 0), 6.5, Color(0.45, 0.6, 0.65))
		c.draw_arc(Vector2(x - 2, -2), 3.5, PI, PI * 1.5, 5, Color(1, 1, 1, 0.7), 1.5)
	c.draw_rect(Rect2(-2, -2, 4, 4), rubber)
	# Lake weed on the strap
	c.draw_polyline(PackedVector2Array([Vector2(-22, -6), Vector2(-18, 2), Vector2(-24, 8)]), Color(0.25, 0.45, 0.2), 2.0)


## A brown glass bottle with a paper label and a cork.
static func _draw_ether_bottle(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 23), 12, 2.5, SHADOW)
	var glass := Color(0.38, 0.2, 0.08, 0.92)
	c.draw_rect(Rect2(-11, -6, 22, 29), glass)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-11, -6), Vector2(-4, -14), Vector2(4, -14), Vector2(11, -6)]), glass)
	c.draw_rect(Rect2(-4, -21, 8, 8), glass)
	c.draw_rect(Rect2(-4.5, -25, 9, 5), Color(0.65, 0.5, 0.32))
	# Liquid line, half way down
	c.draw_rect(Rect2(-10, 8, 20, 14), Color(0.25, 0.1, 0.03, 0.6))
	# Label
	c.draw_rect(Rect2(-9, -2, 18, 12), PAPER)
	c.draw_line(Vector2(-7, 1), Vector2(7, 1), Color(0.5, 0.1, 0.1), 1.4)
	c.draw_line(Vector2(-7, 5), Vector2(4, 5), Color(0.2, 0.2, 0.25), 1.0)
	c.draw_line(Vector2(-8, -5), Vector2(-8, 20), Color(1, 1, 1, 0.3), 1.5)


## A small steel key with a brown cardboard tag on a string.
static func _draw_bench_key(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 8), 20, 2.5, SHADOW)
	c.draw_circle(Vector2(-8, 0), 5.5, STEEL_DARK)
	c.draw_circle(Vector2(-8, 0), 2.5, Color(0.1, 0.1, 0.12))
	c.draw_rect(Rect2(-3, -1.5, 18, 3.5), STEEL)
	c.draw_rect(Rect2(10, 2, 2.5, 4), STEEL)
	c.draw_rect(Rect2(13.5, 2, 2, 3), STEEL)
	# Tag
	c.draw_line(Vector2(-12, 3), Vector2(-16, 6), Color(0.85, 0.8, 0.7), 0.8)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-22, 4), Vector2(-14, 4), Vector2(-14, 11), Vector2(-22, 11), Vector2(-24, 7.5)]),
		Color(0.7, 0.55, 0.36))


## A narrow bank slip with a printed header, columns of figures and a stamp.
static func _draw_bank_receipt(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-14, -23, 32, 50), SHADOW)
	c.draw_rect(Rect2(-17, -26, 32, 50), PAPER)
	c.draw_rect(Rect2(-17, -26, 32, 7), Color(0.25, 0.35, 0.55))
	for i in range(7):
		var y := -15.0 + i * 5.0
		c.draw_line(Vector2(-14, y), Vector2(0, y), Color(PlaceholderArt.INK, 0.7), 1.0)
		c.draw_line(Vector2(4, y), Vector2(12, y), Color(PlaceholderArt.INK, 0.9), 1.0)
	c.draw_line(Vector2(-14, 21), Vector2(12, 21), PlaceholderArt.INK, 1.6)
	# "PAID" stamp, slightly crooked
	c.draw_colored_polygon(PackedVector2Array([Vector2(-12, 8), Vector2(6, 5), Vector2(7, 12), Vector2(-11, 15)]), Color(0.75, 0.15, 0.12, 0.35))


## A long black iron key with an ornate bow and a "LOFT" tag.
static func _draw_loft_key(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 9), 28, 2.5, SHADOW)
	var iron := Color(0.2, 0.2, 0.22)
	c.draw_arc(Vector2(-20, 0), 7, 0, TAU, 14, iron, 3.0)
	c.draw_circle(Vector2(-20, 0), 2, iron)
	c.draw_rect(Rect2(-13, -2, 34, 4), iron)
	c.draw_rect(Rect2(14, 2, 3, 6), iron)
	c.draw_rect(Rect2(19, 2, 3, 4), iron)
	c.draw_line(Vector2(-12, -1.5), Vector2(20, -1.5), Color(1, 1, 1, 0.2), 1.0)
	# Tag
	c.draw_line(Vector2(-20, 7), Vector2(-16, 10), Color(0.85, 0.8, 0.7), 0.8)
	c.draw_rect(Rect2(-17, 8, 12, 7), PAPER)
	c.draw_line(Vector2(-15, 11.5), Vector2(-7, 11.5), PlaceholderArt.INK, 1.0)
