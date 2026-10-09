@tool
class_name LampRoomObjects
extends RefCounted
## Placeholder drawings for the hidden objects of House Two, Chapter Eight (The Lamp Room).
## Same rules as placeholder_art.gd: every drawing is centred on (0, 0) and
## fits inside get_size(). PlaceholderArt calls these functions.

const BRASS := Color(0.82, 0.64, 0.3)
const BRASS_DARK := Color(0.52, 0.38, 0.16)
const BRASS_LIGHT := Color(0.98, 0.86, 0.55)
const IRON := Color(0.32, 0.32, 0.33)
const IRON_DARK := Color(0.17, 0.17, 0.18)
const PAPER := Color(0.92, 0.88, 0.76)
const PAPER_DARK := Color(0.72, 0.67, 0.55)
const TELEGRAM_BUFF := Color(0.93, 0.84, 0.58)
const INK := Color(0.16, 0.14, 0.2)
const PENCIL := Color(0.35, 0.35, 0.38)
const WOOD := Color(0.48, 0.32, 0.18)
const WOOD_DARK := Color(0.28, 0.18, 0.1)
const GLASS := Color(0.78, 0.88, 0.92, 0.55)
const SHADOW := Color(0, 0, 0, 0.35)


## Size of the drawing, or Vector2.ZERO if `style` is not one of this chapter's objects.
static func get_size(style: int) -> Vector2:
	match style:
		HiddenObjectData.PlaceholderStyle.LENS_CLOTH:
			return Vector2(40, 30)
		HiddenObjectData.PlaceholderStyle.LAMP_MANTLE:
			return Vector2(22, 34)
		HiddenObjectData.PlaceholderStyle.TELEGRAM_FORM:
			return Vector2(50, 34)
		HiddenObjectData.PlaceholderStyle.POSTCARD:
			return Vector2(48, 32)
		HiddenObjectData.PlaceholderStyle.PENCIL_SKETCH:
			return Vector2(38, 48)
		HiddenObjectData.PlaceholderStyle.NEWSPAPER_PAGE:
			return Vector2(52, 40)
		HiddenObjectData.PlaceholderStyle.OIL_FUNNEL:
			return Vector2(34, 36)
		HiddenObjectData.PlaceholderStyle.BINOCULARS:
			return Vector2(44, 30)
		HiddenObjectData.PlaceholderStyle.RADIO_VALVE:
			return Vector2(18, 36)
		HiddenObjectData.PlaceholderStyle.BELL_HAMMER:
			return Vector2(48, 20)
		HiddenObjectData.PlaceholderStyle.TOBACCO_TIN:
			return Vector2(38, 24)
		HiddenObjectData.PlaceholderStyle.ROSARY:
			return Vector2(34, 42)
		HiddenObjectData.PlaceholderStyle.FERRY_TICKET:
			return Vector2(42, 22)
		HiddenObjectData.PlaceholderStyle.WIND_GAUGE:
			return Vector2(36, 42)
		HiddenObjectData.PlaceholderStyle.CHAPEL_KEY:
			return Vector2(58, 26)
	return Vector2.ZERO


## Draws `style` and returns true, or returns false if it is not one of this chapter's objects.
static func draw(c: CanvasItem, style: int) -> bool:
	match style:
		HiddenObjectData.PlaceholderStyle.LENS_CLOTH:
			_draw_lens_cloth(c)
		HiddenObjectData.PlaceholderStyle.LAMP_MANTLE:
			_draw_lamp_mantle(c)
		HiddenObjectData.PlaceholderStyle.TELEGRAM_FORM:
			_draw_telegram_form(c)
		HiddenObjectData.PlaceholderStyle.POSTCARD:
			_draw_postcard(c)
		HiddenObjectData.PlaceholderStyle.PENCIL_SKETCH:
			_draw_pencil_sketch(c)
		HiddenObjectData.PlaceholderStyle.NEWSPAPER_PAGE:
			_draw_newspaper_page(c)
		HiddenObjectData.PlaceholderStyle.OIL_FUNNEL:
			_draw_oil_funnel(c)
		HiddenObjectData.PlaceholderStyle.BINOCULARS:
			_draw_binoculars(c)
		HiddenObjectData.PlaceholderStyle.RADIO_VALVE:
			_draw_radio_valve(c)
		HiddenObjectData.PlaceholderStyle.BELL_HAMMER:
			_draw_bell_hammer(c)
		HiddenObjectData.PlaceholderStyle.TOBACCO_TIN:
			_draw_tobacco_tin(c)
		HiddenObjectData.PlaceholderStyle.ROSARY:
			_draw_rosary(c)
		HiddenObjectData.PlaceholderStyle.FERRY_TICKET:
			_draw_ferry_ticket(c)
		HiddenObjectData.PlaceholderStyle.WIND_GAUGE:
			_draw_wind_gauge(c)
		HiddenObjectData.PlaceholderStyle.CHAPEL_KEY:
			_draw_chapel_key(c)
		_:
			return false
	return true


## A folded yellow chamois leather for polishing the lens.
static func _draw_lens_cloth(c: CanvasItem) -> void:
	var cloth := Color(0.9, 0.78, 0.48)
	var fold := Color(0.74, 0.6, 0.34)
	PlaceholderArt.draw_ellipse(c, Vector2(1, 12), 19, 3, SHADOW)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-18, -6), Vector2(14, -12), Vector2(19, 6), Vector2(16, 12),
		Vector2(-16, 12), Vector2(-19, 2)]), fold)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-17, -7), Vector2(13, -13), Vector2(16, 0), Vector2(-15, 6)]), cloth)
	# Soft creases and a corner flopping over
	c.draw_polyline(PackedVector2Array([Vector2(-12, -3), Vector2(-2, -6), Vector2(10, -8)]), fold, 1.2, true)
	c.draw_polyline(PackedVector2Array([Vector2(-14, 9), Vector2(0, 8), Vector2(14, 9)]), cloth.darkened(0.3), 1.0, true)
	c.draw_colored_polygon(PackedVector2Array([Vector2(13, -13), Vector2(16, 0), Vector2(8, -4)]), cloth.lightened(0.15))
	# A smear of soot from the lamp
	PlaceholderArt.draw_ellipse(c, Vector2(-5, -1), 5, 2, Color(0.2, 0.17, 0.12, 0.45))


## A gas lamp mantle: a white woven sock on a little ceramic ring.
static func _draw_lamp_mantle(c: CanvasItem) -> void:
	var mesh := Color(0.95, 0.94, 0.88)
	PlaceholderArt.draw_ellipse(c, Vector2(0, 16), 9, 2, SHADOW)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-5, -12), Vector2(5, -12), Vector2(9, 0), Vector2(8, 10),
		Vector2(-8, 10), Vector2(-9, 0)]), mesh)
	# Woven mesh pattern
	for i in range(5):
		var y := -9.0 + i * 4.5
		c.draw_line(Vector2(-8, y), Vector2(8, y), Color(0.7, 0.68, 0.6), 0.8)
	for x in [-5.0, -2.0, 1.0, 4.0]:
		c.draw_line(Vector2(x * 0.7, -12), Vector2(x, 10), Color(0.75, 0.73, 0.65), 0.8)
	PlaceholderArt.draw_ellipse(c, Vector2(0, 10), 8, 2.5, Color(0.82, 0.8, 0.72))
	# Ceramic ring and the wire loop on top
	c.draw_rect(Rect2(-5, -16, 10, 4), Color(0.86, 0.82, 0.72))
	c.draw_line(Vector2(-5, -14), Vector2(5, -14), Color(0.6, 0.55, 0.45), 1.0)
	c.draw_arc(Vector2(0, -16), 2.5, PI, TAU, 6, IRON, 1.0)


## A buff Post Office telegram form with typed strips pasted on.
static func _draw_telegram_form(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-22, -14, 48, 32), SHADOW)
	c.draw_rect(Rect2(-25, -17, 50, 34), TELEGRAM_BUFF)
	c.draw_rect(Rect2(-25, -17, 50, 8), Color(0.62, 0.22, 0.16))
	c.draw_string(ThemeDB.fallback_font, Vector2(-22, -10.5), "TELEGRAM", HORIZONTAL_ALIGNMENT_LEFT, -1, 7, Color(0.98, 0.92, 0.75))
	c.draw_circle(Vector2(19, -13), 2.5, Color(0.98, 0.9, 0.7))
	# Typed strips of text pasted on
	for i in range(3):
		var y := -5.0 + i * 6.5
		c.draw_rect(Rect2(-22, y, 40 - i * 7, 4.5), Color(0.98, 0.97, 0.92))
		for j in range(6 - i):
			c.draw_line(Vector2(-21 + j * 6, y + 2.2), Vector2(-17 + j * 6, y + 2.2), INK, 1.0)
	# Stamped date in purple ink
	c.draw_arc(Vector2(16, 10), 5, 0, TAU, 12, Color(0.45, 0.25, 0.5, 0.8), 1.0)
	c.draw_line(Vector2(12, 10), Vector2(20, 10), Color(0.45, 0.25, 0.5, 0.8), 1.0)
	c.draw_line(Vector2(-25, 16), Vector2(25, 16), PAPER_DARK, 1.0)


## A picture postcard: the little island chapel on its hill across the water.
static func _draw_postcard(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-21, -13, 48, 32), SHADOW)
	c.draw_rect(Rect2(-24, -16, 48, 32), Color(0.97, 0.95, 0.88))
	var pic := Rect2(-21, -13, 42, 26)
	c.draw_rect(pic, Color(0.62, 0.76, 0.86))
	c.draw_rect(Rect2(pic.position.x, -2, pic.size.x, 15), Color(0.3, 0.48, 0.62))
	# The island and its green hill
	c.draw_colored_polygon(PackedVector2Array([Vector2(-16, 2), Vector2(-6, -6), Vector2(8, -7), Vector2(17, 2)]),
		Color(0.36, 0.56, 0.32))
	# The chapel: white walls, grey roof, a bell turret with a cross
	c.draw_rect(Rect2(-3, -10, 10, 7), Color(0.98, 0.97, 0.94))
	c.draw_colored_polygon(PackedVector2Array([Vector2(-4, -10), Vector2(2, -14), Vector2(8, -10)]), Color(0.42, 0.42, 0.46))
	c.draw_rect(Rect2(-2, -15, 3, 5), Color(0.95, 0.94, 0.9))
	c.draw_line(Vector2(-0.5, -19), Vector2(-0.5, -15), INK, 0.8)
	c.draw_line(Vector2(-2, -17.5), Vector2(1, -17.5), INK, 0.8)
	c.draw_rect(Rect2(1, -7, 2, 4), Color(0.3, 0.22, 0.16))
	# A ferry crossing and the water's ripples
	c.draw_rect(Rect2(-14, 6, 8, 2.5), Color(0.15, 0.15, 0.18))
	c.draw_rect(Rect2(-12, 4, 3, 2), Color(0.8, 0.2, 0.15))
	for x in [-4.0, 6.0, 13.0]:
		c.draw_line(Vector2(x, 9), Vector2(x + 5, 9), Color(0.8, 0.88, 0.95, 0.7), 1.0)
	c.draw_string(ThemeDB.fallback_font, Vector2(-20, 15), "The Island Chapel", HORIZONTAL_ALIGNMENT_LEFT, -1, 5, INK)


## A pencil sketch of a young woman's face, "Margaret" written underneath.
static func _draw_pencil_sketch(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-16, -21, 36, 46), SHADOW)
	c.draw_rect(Rect2(-19, -24, 38, 48), Color(0.96, 0.95, 0.9))
	# A torn edge at the top
	for i in range(8):
		c.draw_line(Vector2(-19 + i * 5, -24), Vector2(-16.5 + i * 5, -22.5), Color(0.82, 0.8, 0.74), 1.0)
	# Hair falling to the shoulders
	c.draw_polyline(PackedVector2Array([Vector2(-10, 10), Vector2(-11, -4), Vector2(-7, -15), Vector2(0, -18),
		Vector2(7, -15), Vector2(11, -4), Vector2(10, 10)]), PENCIL, 1.2, true)
	for x in [-9.0, -7.0, 7.0, 9.0]:
		c.draw_line(Vector2(x, -6), Vector2(x * 1.05, 8), Color(PENCIL, 0.6), 0.8)
	# The face
	c.draw_arc(Vector2(0, -5), 7, 0, TAU, 18, PENCIL, 1.0, true)
	c.draw_line(Vector2(-4, -7), Vector2(-1.5, -7), PENCIL, 1.0)
	c.draw_line(Vector2(1.5, -7), Vector2(4, -7), PENCIL, 1.0)
	c.draw_line(Vector2(0, -6), Vector2(-0.8, -2.5), Color(PENCIL, 0.7), 0.8)
	c.draw_arc(Vector2(0, -1), 2.5, 0.3, PI - 0.3, 6, PENCIL, 0.9)
	# Shoulders and a little shading
	c.draw_polyline(PackedVector2Array([Vector2(-14, 14), Vector2(-6, 6), Vector2(6, 6), Vector2(14, 14)]), PENCIL, 1.0, true)
	for i in range(4):
		c.draw_line(Vector2(-12 + i * 2, 13), Vector2(-9 + i * 2, 10), Color(PENCIL, 0.45), 0.8)
	c.draw_string(ThemeDB.fallback_font, Vector2(-15, 21), "Margaret", HORIZONTAL_ALIGNMENT_LEFT, -1, 8, PENCIL)


## A yellowed newspaper page: "ASHWORTH GIRL DECLARED DEAD".
static func _draw_newspaper_page(c: CanvasItem) -> void:
	var newsprint := Color(0.86, 0.83, 0.72)
	c.draw_rect(Rect2(-23, -17, 52, 40), SHADOW)
	c.draw_rect(Rect2(-26, -20, 52, 40), newsprint)
	c.draw_rect(Rect2(-26, -20, 52, 40), PAPER_DARK, false, 1.0)
	c.draw_string(ThemeDB.fallback_font, Vector2(-24, -14), "BLACKWATER GAZETTE  1987", HORIZONTAL_ALIGNMENT_LEFT, -1, 4, INK)
	c.draw_line(Vector2(-24, -12.5), Vector2(24, -12.5), INK, 0.8)
	c.draw_string(ThemeDB.fallback_font, Vector2(-24, -6), "ASHWORTH GIRL", HORIZONTAL_ALIGNMENT_LEFT, -1, 7, INK)
	c.draw_string(ThemeDB.fallback_font, Vector2(-24, 0), "DECLARED DEAD", HORIZONTAL_ALIGNMENT_LEFT, -1, 7, INK)
	# A grainy photograph of a girl, and columns of text
	c.draw_rect(Rect2(10, 2, 13, 15), Color(0.45, 0.44, 0.42))
	c.draw_circle(Vector2(16.5, 7.5), 3.2, Color(0.75, 0.73, 0.68))
	c.draw_rect(Rect2(12, 11, 9, 6), Color(0.62, 0.6, 0.56))
	for i in range(5):
		var y := 4.0 + i * 3.0
		c.draw_line(Vector2(-24, y), Vector2(-9, y), Color(INK, 0.55), 0.8)
		c.draw_line(Vector2(-7, y), Vector2(7, y), Color(INK, 0.55), 0.8)
	# A brown tea ring
	c.draw_arc(Vector2(-14, 12), 6, 0, TAU, 14, Color(0.5, 0.35, 0.2, 0.35), 1.5)


## A small brass funnel for filling the lamp with paraffin.
static func _draw_oil_funnel(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 16), 12, 2.5, SHADOW)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-15, -12), Vector2(15, -12), Vector2(3, 4), Vector2(-3, 4)]), BRASS)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-15, -12), Vector2(-6, -12), Vector2(-1, 4), Vector2(-3, 4)]), BRASS_LIGHT)
	PlaceholderArt.draw_ellipse(c, Vector2(0, -12), 15, 4, BRASS_DARK)
	PlaceholderArt.draw_ellipse(c, Vector2(0, -12), 12, 2.5, Color(0.2, 0.15, 0.08))
	c.draw_rect(Rect2(-2.5, 4, 5, 13), BRASS_DARK)
	c.draw_line(Vector2(-1.5, 4), Vector2(-1.5, 16), BRASS_LIGHT, 1.0)
	# A drip of oil and the little hanging ring
	c.draw_circle(Vector2(0, 17), 1.5, Color(0.55, 0.42, 0.15, 0.8))
	c.draw_arc(Vector2(15, -6), 3, -PI / 2, PI / 2, 6, BRASS_DARK, 1.5)


## A pair of black marine binoculars with brass rims and a neck strap.
static func _draw_binoculars(c: CanvasItem) -> void:
	var body := Color(0.13, 0.13, 0.14)
	PlaceholderArt.draw_ellipse(c, Vector2(0, 13), 20, 3, SHADOW)
	# Strap
	c.draw_polyline(PackedVector2Array([Vector2(-16, -6), Vector2(-20, 6), Vector2(-8, 13), Vector2(8, 13),
		Vector2(20, 6), Vector2(16, -6)]), Color(0.36, 0.24, 0.14), 1.5, true)
	for side in [-1.0, 1.0]:
		c.draw_rect(Rect2(side * 10 - 7, -10, 14, 20), body)
		c.draw_rect(Rect2(side * 10 - 7, -10, 3, 20), Color(0.28, 0.28, 0.3))
		# Big front lenses at the bottom, eyepieces at the top
		PlaceholderArt.draw_ellipse(c, Vector2(side * 10, 10), 7, 3, BRASS)
		PlaceholderArt.draw_ellipse(c, Vector2(side * 10, 10), 5, 2, Color(0.4, 0.55, 0.65))
		c.draw_rect(Rect2(side * 10 - 4, -14, 8, 5), body)
		PlaceholderArt.draw_ellipse(c, Vector2(side * 10, -14), 4, 1.5, Color(0.3, 0.3, 0.32))
	# The bridge and focus wheel
	c.draw_rect(Rect2(-3, -6, 6, 8), Color(0.22, 0.22, 0.24))
	c.draw_rect(Rect2(-2, -10, 4, 4), BRASS_DARK)


## A glass radio valve (vacuum tube) with a black base and pins.
static func _draw_radio_valve(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 17), 8, 2, SHADOW)
	# Black bakelite base and its pins
	c.draw_rect(Rect2(-7, 7, 14, 7), Color(0.12, 0.1, 0.09))
	for x in [-4.0, -1.0, 2.0, 5.0]:
		c.draw_line(Vector2(x - 0.5, 14), Vector2(x - 0.5, 17), Color(0.75, 0.72, 0.65), 1.0)
	# Glass envelope with the metal insides showing through
	c.draw_colored_polygon(PackedVector2Array([Vector2(-7, 7), Vector2(-7, -10), Vector2(-4, -16), Vector2(4, -16),
		Vector2(7, -10), Vector2(7, 7)]), GLASS)
	c.draw_rect(Rect2(-4, -8, 8, 12), Color(0.45, 0.45, 0.48))
	c.draw_rect(Rect2(-3, -6, 6, 8), Color(0.25, 0.25, 0.27))
	c.draw_line(Vector2(0, -12), Vector2(0, -8), Color(0.6, 0.6, 0.62), 1.0)
	# Silvery "getter" patch at the top and a highlight
	c.draw_rect(Rect2(-5, -15, 10, 3), Color(0.7, 0.72, 0.76, 0.85))
	c.draw_line(Vector2(-5.5, -9), Vector2(-5.5, 5), Color(1, 1, 1, 0.75), 1.2)
	c.draw_circle(Vector2(0, -17), 1.2, GLASS)


## The hammer used to strike the fog bell by hand: round iron head, worn wooden handle.
static func _draw_bell_hammer(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 8), 22, 2.5, SHADOW)
	c.draw_line(Vector2(-22, 2), Vector2(10, 0), WOOD_DARK, 5.0)
	c.draw_line(Vector2(-22, 1), Vector2(10, -1), WOOD, 3.0)
	c.draw_line(Vector2(-20, 0), Vector2(6, -1.5), Color(0.62, 0.45, 0.28), 1.0)
	# Leather loop on the end of the handle
	c.draw_arc(Vector2(-23, 2), 3.5, PI / 2, PI * 1.5, 8, Color(0.4, 0.22, 0.12), 1.5)
	# The heavy round head
	c.draw_rect(Rect2(9, -8, 6, 16), IRON_DARK)
	PlaceholderArt.draw_ellipse(c, Vector2(18, 0), 6, 8, IRON)
	PlaceholderArt.draw_ellipse(c, Vector2(17, -2), 3, 4, Color(0.5, 0.5, 0.52))
	c.draw_circle(Vector2(18, -4), 1.2, Color(0.75, 0.75, 0.78))


## A flat tobacco tin with a red and gold lid.
static func _draw_tobacco_tin(c: CanvasItem) -> void:
	var red := Color(0.62, 0.14, 0.12)
	var gold := Color(0.86, 0.7, 0.32)
	c.draw_rect(Rect2(-16, -8, 36, 22), SHADOW)
	_rounded(c, Rect2(-19, -11, 38, 22), Color(0.5, 0.48, 0.44), 4)
	_rounded(c, Rect2(-18, -12, 36, 19), red, 4)
	c.draw_rect(Rect2(-16, -10, 32, 15), gold, false, 1.0)
	# The label: a little sailor's head and the brand name
	c.draw_circle(Vector2(-9, -3), 4, Color(0.95, 0.88, 0.72))
	c.draw_rect(Rect2(-13, -8, 8, 2.5), Color(0.1, 0.1, 0.3))
	c.draw_string(ThemeDB.fallback_font, Vector2(-3, -3), "NAVY", HORIZONTAL_ALIGNMENT_LEFT, -1, 7, gold)
	c.draw_string(ThemeDB.fallback_font, Vector2(-3, 3), "CUT", HORIZONTAL_ALIGNMENT_LEFT, -1, 6, gold)
	# Worn shiny corners
	c.draw_line(Vector2(14, -11), Vector2(17, -8), Color(0.8, 0.8, 0.8), 1.2)
	c.draw_line(Vector2(-18, 5), Vector2(-15, 7), Color(0.8, 0.8, 0.8), 1.2)


## A loop of wooden rosary beads with a small cross, and a little brass key tied on.
static func _draw_rosary(c: CanvasItem) -> void:
	var bead := Color(0.42, 0.26, 0.16)
	PlaceholderArt.draw_ellipse(c, Vector2(0, 19), 14, 2, SHADOW)
	# The loop of beads
	for i in range(22):
		var angle := TAU * i / 22.0
		var at := Vector2(cos(angle) * 13.0, -6 + sin(angle) * 11.0)
		c.draw_circle(at, 1.9, bead)
		c.draw_circle(at + Vector2(-0.5, -0.5), 0.6, Color(0.7, 0.5, 0.35))
	# The short tail down to the cross
	for i in range(3):
		c.draw_circle(Vector2(0, 7 + i * 3.2), 1.7, bead)
	c.draw_rect(Rect2(-1.2, 15, 2.4, 9), Color(0.85, 0.82, 0.75))
	c.draw_rect(Rect2(-4, 17, 8, 2.2), Color(0.85, 0.82, 0.75))
	# A tiny brass key tied on beside the cross with thread
	c.draw_line(Vector2(9, 3), Vector2(11, 8), Color(0.8, 0.75, 0.7), 0.8)
	c.draw_arc(Vector2(11, 10), 2.2, 0, TAU, 8, BRASS, 1.2)
	c.draw_line(Vector2(11, 12), Vector2(11, 19), BRASS, 1.4)
	c.draw_line(Vector2(11, 17), Vector2(13.5, 17), BRASS, 1.2)
	c.draw_line(Vector2(11, 19), Vector2(13.5, 19), BRASS, 1.2)


## A ferry ticket: "ISLAND FERRY - SINGLE", with a torn perforated stub.
static func _draw_ferry_ticket(c: CanvasItem) -> void:
	var card := Color(0.72, 0.84, 0.72)
	c.draw_rect(Rect2(-18, -7, 40, 20), SHADOW)
	c.draw_rect(Rect2(-21, -10, 42, 20), card)
	c.draw_rect(Rect2(-21, -10, 42, 4), Color(0.3, 0.45, 0.35))
	# The perforated stub on the right
	for y in range(-8, 10, 3):
		c.draw_circle(Vector2(11, y), 0.7, Color(0.3, 0.35, 0.3))
	c.draw_string(ThemeDB.fallback_font, Vector2(-19, 0), "ISLAND FERRY", HORIZONTAL_ALIGNMENT_LEFT, -1, 5, INK)
	c.draw_string(ThemeDB.fallback_font, Vector2(-19, 7), "SINGLE  06:40", HORIZONTAL_ALIGNMENT_LEFT, -1, 5, Color(0.55, 0.12, 0.1))
	c.draw_string(ThemeDB.fallback_font, Vector2(13, 4), "No", HORIZONTAL_ALIGNMENT_LEFT, -1, 4, INK)
	c.draw_line(Vector2(13, 6), Vector2(19, 6), INK, 0.8)


## A hand-held wind gauge: three little cups spinning on top of a dial.
static func _draw_wind_gauge(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 20), 10, 2, SHADOW)
	# Handle
	c.draw_rect(Rect2(-3, 8, 6, 12), Color(0.15, 0.14, 0.14))
	c.draw_line(Vector2(-2, 9), Vector2(-2, 19), Color(0.35, 0.34, 0.34), 1.0)
	# The dial with its needle
	c.draw_circle(Vector2(0, 2), 8, BRASS_DARK)
	c.draw_circle(Vector2(0, 2), 6.5, Color(0.95, 0.93, 0.85))
	for tick in range(7):
		var direction := Vector2.from_angle(PI * 0.8 + tick * PI * 1.4 / 6.0)
		c.draw_line(Vector2(0, 2) + direction * 4.5, Vector2(0, 2) + direction * 6.2, INK, 0.8)
	c.draw_line(Vector2(0, 2), Vector2(4, -1), Color(0.7, 0.1, 0.1), 1.0)
	# Spindle and the three cups
	c.draw_line(Vector2(0, -6), Vector2(0, -12), IRON, 1.5)
	for i in range(3):
		var angle := -PI / 2 + TAU * i / 3.0 + 0.3
		var arm := Vector2(cos(angle) * 14.0, -13 + sin(angle) * 5.0)
		c.draw_line(Vector2(0, -13), arm, IRON, 1.2)
		PlaceholderArt.draw_ellipse(c, arm, 3.5, 3, Color(0.6, 0.62, 0.66))
		PlaceholderArt.draw_ellipse(c, arm + Vector2(0.8, 0), 2, 1.8, Color(0.3, 0.32, 0.36))


## A big old iron key with a cross cut into its bow: the key to the island chapel.
static func _draw_chapel_key(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(2, 10), 26, 2.5, SHADOW)
	# Round bow with a cross cut out of it
	c.draw_circle(Vector2(-18, 0), 10, IRON)
	c.draw_arc(Vector2(-18, 0), 10, 0, TAU, 20, IRON_DARK, 1.5)
	c.draw_rect(Rect2(-19.5, -6, 3, 12), Color(0.08, 0.07, 0.07))
	c.draw_rect(Rect2(-23, -2.5, 10, 3), Color(0.08, 0.07, 0.07))
	# Shaft with a collar
	c.draw_rect(Rect2(-8, -2.5, 30, 5), IRON)
	c.draw_line(Vector2(-8, -2), Vector2(22, -2), Color(0.55, 0.55, 0.58), 1.0)
	c.draw_rect(Rect2(-9, -4, 4, 8), IRON_DARK)
	# The bit, with notches
	c.draw_rect(Rect2(16, 2, 12, 9), IRON)
	c.draw_rect(Rect2(19, 7, 3, 4), Color(0.08, 0.07, 0.07))
	c.draw_rect(Rect2(24, 5, 2, 6), Color(0.08, 0.07, 0.07))
	# A paper label tied to the bow: "Chapel"
	c.draw_line(Vector2(-12, 7), Vector2(-6, 11), Color(0.8, 0.75, 0.65), 0.8)
	c.draw_rect(Rect2(-7, 8, 13, 5), PAPER)
	c.draw_string(ThemeDB.fallback_font, Vector2(-6, 12.5), "Chapel", HORIZONTAL_ALIGNMENT_LEFT, -1, 4, INK)


static func _rounded(c: CanvasItem, rect: Rect2, color: Color, radius: int) -> void:
	var box := StyleBoxFlat.new()
	box.bg_color = color
	box.set_corner_radius_all(radius)
	c.draw_style_box(box, rect)
