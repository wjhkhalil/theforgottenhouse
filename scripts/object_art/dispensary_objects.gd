@tool
class_name DispensaryObjects
extends RefCounted
## Placeholder drawings for the hidden objects of House Three, Chapter Five (The Dispensary).
## Same rules as placeholder_art.gd: every drawing is centred on (0, 0) and
## fits inside get_size(). PlaceholderArt calls these functions.
##
## The first six have look-alikes in the room (LookAlikes recolours a copy of the
## same drawing), so each of them is painted in ONE strong, plain colour: cobalt
## blue, bright brass, a red lid, clear glass, white, bright silver.

const BRASS := Color(0.92, 0.72, 0.24)
const BRASS_DARK := Color(0.62, 0.44, 0.12)
const BRASS_LIGHT := Color(1.0, 0.9, 0.5)
const COBALT := Color(0.1, 0.22, 0.8)
const COBALT_DARK := Color(0.05, 0.1, 0.5)
const COBALT_LIGHT := Color(0.4, 0.55, 1.0)
const LID_RED := Color(0.84, 0.1, 0.1)
const SILVER := Color(0.88, 0.89, 0.92)
const SILVER_DARK := Color(0.6, 0.62, 0.66)
const WHITE_POT := Color(0.96, 0.96, 0.94)
const WHITE_POT_SHADE := Color(0.78, 0.78, 0.76)
const CLEAR_GLASS := Color(0.86, 0.9, 0.92, 0.5)
const CLEAR_GLASS_EDGE := Color(0.96, 0.98, 1.0, 0.95)
const STEEL := Color(0.7, 0.72, 0.75)
const STEEL_DARK := Color(0.42, 0.44, 0.47)
const PAPER := Color(0.92, 0.88, 0.76)
const PAPER_DARK := Color(0.74, 0.68, 0.54)
const INK := Color(0.16, 0.14, 0.2)
const RED_INK := Color(0.62, 0.12, 0.1)
const BROWN_GLASS := Color(0.4, 0.22, 0.08)
const SHADOW := Color(0, 0, 0, 0.35)

const SIZES := {
	HiddenObjectData.PlaceholderStyle.BLUE_BOTTLE: Vector2(22, 46),
	HiddenObjectData.PlaceholderStyle.BRASS_WEIGHT: Vector2(28, 30),
	HiddenObjectData.PlaceholderStyle.PILL_BOX: Vector2(34, 22),
	HiddenObjectData.PlaceholderStyle.MEASURING_GLASS: Vector2(28, 40),
	HiddenObjectData.PlaceholderStyle.OINTMENT_JAR: Vector2(32, 30),
	HiddenObjectData.PlaceholderStyle.MEDICINE_SPOON: Vector2(48, 16),
	HiddenObjectData.PlaceholderStyle.APOTHECARY_SCALES: Vector2(50, 52),
	HiddenObjectData.PlaceholderStyle.PRESCRIPTION_SPIKE: Vector2(28, 48),
	HiddenObjectData.PlaceholderStyle.LABEL_ROLL: Vector2(40, 30),
	HiddenObjectData.PlaceholderStyle.PESTLE: Vector2(46, 16),
	HiddenObjectData.PlaceholderStyle.CHLORAL_BOTTLE: Vector2(26, 48),
	HiddenObjectData.PlaceholderStyle.DOSE_BOOK: Vector2(36, 52),
	HiddenObjectData.PlaceholderStyle.BLANK_DEATH_FORMS: Vector2(42, 50),
	HiddenObjectData.PlaceholderStyle.SEALED_AMPOULES: Vector2(50, 30),
	HiddenObjectData.PlaceholderStyle.STANDING_ORDERS: Vector2(46, 50),
	HiddenObjectData.PlaceholderStyle.BUREAU_KEY: Vector2(36, 16),
	HiddenObjectData.PlaceholderStyle.SUGAR_PILLS: Vector2(50, 30),
	HiddenObjectData.PlaceholderStyle.RESIGNATION_DRAFT: Vector2(44, 48),
	HiddenObjectData.PlaceholderStyle.WARD_CHART: Vector2(52, 38),
	HiddenObjectData.PlaceholderStyle.MATRONS_OFFICE_KEY: Vector2(54, 26),
	HiddenObjectData.PlaceholderStyle.CRANE_TELEGRAM: Vector2(52, 34),
}


## Size of the drawing, or Vector2.ZERO if `style` is not one of this chapter's objects.
static func get_size(style: int) -> Vector2:
	return SIZES.get(style, Vector2.ZERO)


## Draws `style` and returns true, or returns false if it is not one of this chapter's objects.
static func draw(c: CanvasItem, style: int) -> bool:
	match style:
		HiddenObjectData.PlaceholderStyle.BLUE_BOTTLE:
			_draw_blue_bottle(c)
		HiddenObjectData.PlaceholderStyle.BRASS_WEIGHT:
			_draw_brass_weight(c)
		HiddenObjectData.PlaceholderStyle.PILL_BOX:
			_draw_pill_box(c)
		HiddenObjectData.PlaceholderStyle.MEASURING_GLASS:
			_draw_measuring_glass(c)
		HiddenObjectData.PlaceholderStyle.OINTMENT_JAR:
			_draw_ointment_jar(c)
		HiddenObjectData.PlaceholderStyle.MEDICINE_SPOON:
			_draw_medicine_spoon(c)
		HiddenObjectData.PlaceholderStyle.APOTHECARY_SCALES:
			_draw_apothecary_scales(c)
		HiddenObjectData.PlaceholderStyle.PRESCRIPTION_SPIKE:
			_draw_prescription_spike(c)
		HiddenObjectData.PlaceholderStyle.LABEL_ROLL:
			_draw_label_roll(c)
		HiddenObjectData.PlaceholderStyle.PESTLE:
			_draw_pestle(c)
		HiddenObjectData.PlaceholderStyle.CHLORAL_BOTTLE:
			_draw_chloral_bottle(c)
		HiddenObjectData.PlaceholderStyle.DOSE_BOOK:
			_draw_dose_book(c)
		HiddenObjectData.PlaceholderStyle.BLANK_DEATH_FORMS:
			_draw_blank_death_forms(c)
		HiddenObjectData.PlaceholderStyle.SEALED_AMPOULES:
			_draw_sealed_ampoules(c)
		HiddenObjectData.PlaceholderStyle.STANDING_ORDERS:
			_draw_standing_orders(c)
		HiddenObjectData.PlaceholderStyle.BUREAU_KEY:
			_draw_bureau_key(c)
		HiddenObjectData.PlaceholderStyle.SUGAR_PILLS:
			_draw_sugar_pills(c)
		HiddenObjectData.PlaceholderStyle.RESIGNATION_DRAFT:
			_draw_resignation_draft(c)
		HiddenObjectData.PlaceholderStyle.WARD_CHART:
			_draw_ward_chart(c)
		HiddenObjectData.PlaceholderStyle.MATRONS_OFFICE_KEY:
			_draw_matrons_office_key(c)
		HiddenObjectData.PlaceholderStyle.CRANE_TELEGRAM:
			_draw_crane_telegram(c)
		_:
			return false
	return true


## Small text helper (the built-in fallback font).
static func _text(c: CanvasItem, at: Vector2, text: String, font_size: int, color: Color) -> void:
	c.draw_string(ThemeDB.fallback_font, at, text, HORIZONTAL_ALIGNMENT_LEFT, -1, font_size, color)


## A few ruled lines of writing.
static func _lines(c: CanvasItem, at: Vector2, width: float, count: int, gap: float, color: Color) -> void:
	for i in range(count):
		var line_width := width if i % 3 != 2 else width * 0.6
		c.draw_line(at + Vector2(0, i * gap), at + Vector2(line_width, i * gap), color, 0.9)


## A ribbed poison bottle, cobalt blue all over (no label: the colour is the clue).
static func _draw_blue_bottle(c: CanvasItem) -> void:
	# Stopper and neck
	c.draw_rect(Rect2(-4, -23, 8, 5), COBALT_DARK)
	c.draw_rect(Rect2(-3, -18, 6, 7), COBALT)
	# Shoulders and body
	c.draw_colored_polygon(PackedVector2Array([Vector2(-3, -12), Vector2(3, -12), Vector2(10, -5), Vector2(-10, -5)]), COBALT)
	c.draw_rect(Rect2(-10, -5, 20, 27), COBALT)
	c.draw_rect(Rect2(-10, 20, 20, 3), COBALT_DARK)
	# The ribs that warn a hand in the dark
	for i in range(5):
		c.draw_line(Vector2(-7 + i * 3.5, -3), Vector2(-7 + i * 3.5, 19), COBALT_DARK, 1.0)
	c.draw_line(Vector2(-8.5, -3), Vector2(-8.5, 18), COBALT_LIGHT, 1.5)
	c.draw_line(Vector2(-2, -17), Vector2(-2, -12), COBALT_LIGHT, 1.0)


## A bright brass scale weight with a knob on top.
static func _draw_brass_weight(c: CanvasItem) -> void:
	# Knob
	c.draw_circle(Vector2(0, -10), 4.5, BRASS)
	c.draw_rect(Rect2(-2.5, -7, 5, 4), BRASS_DARK)
	# Body, wider at the foot
	c.draw_colored_polygon(PackedVector2Array([Vector2(-10, -4), Vector2(10, -4), Vector2(13, 14), Vector2(-13, 14)]), BRASS)
	c.draw_rect(Rect2(-13, 11, 26, 3), BRASS_DARK)
	c.draw_line(Vector2(-10, -4), Vector2(10, -4), BRASS_LIGHT, 1.5)
	c.draw_line(Vector2(-8, -2), Vector2(-10, 10), BRASS_LIGHT, 2.0)
	c.draw_circle(Vector2(-1.5, -11.5), 1.5, BRASS_LIGHT)
	_text(c, Vector2(-2.5, 9), "7", 9, BRASS_DARK)


## A round card pill box with a red lid.
static func _draw_pill_box(c: CanvasItem) -> void:
	# The card drum (a narrow band: the lid is most of what shows)
	c.draw_rect(Rect2(-14, 2, 28, 7), Color(0.8, 0.74, 0.6))
	PlaceholderArt.draw_ellipse(c, Vector2(0, 9), 14, 2, Color(0.66, 0.6, 0.48))
	# The red lid
	c.draw_rect(Rect2(-16, -6, 32, 9), LID_RED.darkened(0.2))
	PlaceholderArt.draw_ellipse(c, Vector2(0, 3), 16, 3, LID_RED.darkened(0.2))
	PlaceholderArt.draw_ellipse(c, Vector2(0, -6), 16, 4.5, LID_RED)
	PlaceholderArt.draw_ellipse(c, Vector2(-4, -7), 7, 1.5, Color(1.0, 0.45, 0.4))


## A conical measure of clear, colourless glass with a pouring lip and engraved lines.
static func _draw_measuring_glass(c: CanvasItem) -> void:
	var cone := PackedVector2Array([Vector2(-12, -19), Vector2(12, -19), Vector2(4, 11), Vector2(-4, 11)])
	c.draw_colored_polygon(cone, CLEAR_GLASS)
	c.draw_polyline(PackedVector2Array([Vector2(-14, -20), Vector2(-12, -19), Vector2(-4, 11), Vector2(4, 11), Vector2(12, -19)]),
		CLEAR_GLASS_EDGE, 1.5, true)
	c.draw_line(Vector2(-12, -19), Vector2(12, -19), CLEAR_GLASS_EDGE, 1.0)
	# Stem and foot
	c.draw_rect(Rect2(-2, 11, 4, 4), CLEAR_GLASS_EDGE)
	c.draw_rect(Rect2(-10, 15, 20, 4), CLEAR_GLASS)
	c.draw_rect(Rect2(-10, 15, 20, 4), CLEAR_GLASS_EDGE, false, 1.0)
	# Engraved doses, and a shine down one side
	for i in range(4):
		c.draw_line(Vector2(-1, -13 + i * 6.0), Vector2(5 - i, -13 + i * 6.0), Color(1, 1, 1, 0.9), 1.0)
	c.draw_line(Vector2(-8, -16), Vector2(-3, 6), Color(1, 1, 1, 0.75), 2.0)


## A squat white ointment pot with a white paper label.
static func _draw_ointment_jar(c: CanvasItem) -> void:
	# Lid
	c.draw_rect(Rect2(-14, -14, 28, 7), WHITE_POT)
	c.draw_rect(Rect2(-14, -8, 28, 2), WHITE_POT_SHADE)
	c.draw_rect(Rect2(-4, -16, 8, 3), WHITE_POT_SHADE)
	# Pot
	c.draw_rect(Rect2(-13, -6, 26, 19), WHITE_POT)
	c.draw_rect(Rect2(8, -6, 5, 19), WHITE_POT_SHADE)
	c.draw_rect(Rect2(-13, 12, 26, 2), WHITE_POT_SHADE)
	# Label
	c.draw_rect(Rect2(-9, -2, 16, 10), Color(1, 1, 1))
	c.draw_rect(Rect2(-9, -2, 16, 10), Color(0.6, 0.6, 0.6), false, 0.8)
	c.draw_line(Vector2(-6, 2), Vector2(4, 2), Color(0.45, 0.45, 0.47), 1.0)
	c.draw_line(Vector2(-6, 5), Vector2(1, 5), Color(0.45, 0.45, 0.47), 1.0)


## A bright silver dosing spoon with a deep covered bowl (the bowl is on the right).
static func _draw_medicine_spoon(c: CanvasItem) -> void:
	# Handle
	c.draw_rect(Rect2(-23, -2, 28, 4), SILVER)
	c.draw_line(Vector2(-23, -1), Vector2(4, -1), Color(1, 1, 1), 1.0)
	c.draw_circle(Vector2(-21, 0), 3.5, SILVER)
	c.draw_circle(Vector2(-21, 0), 1.3, SILVER_DARK)
	# Covered bowl
	PlaceholderArt.draw_ellipse(c, Vector2(13, 0), 11, 7, SILVER_DARK)
	PlaceholderArt.draw_ellipse(c, Vector2(13, -1), 10, 5.5, SILVER)
	PlaceholderArt.draw_ellipse(c, Vector2(10, -2.5), 5, 1.8, Color(1, 1, 1))
	# Tooth marks
	c.draw_line(Vector2(17, -1), Vector2(18, 2), SILVER_DARK, 1.0)
	c.draw_line(Vector2(20, -1), Vector2(21, 2), SILVER_DARK, 1.0)


## A brass hand balance hanging on its stand, two small pans on chains.
static func _draw_apothecary_scales(c: CanvasItem) -> void:
	var brass := Color(0.8, 0.62, 0.3)
	var brass_dark := Color(0.52, 0.38, 0.16)
	PlaceholderArt.draw_ellipse(c, Vector2(0, 24), 16, 2, SHADOW)
	# Stand
	c.draw_rect(Rect2(-12, 20, 24, 4), Color(0.2, 0.1, 0.07))
	c.draw_rect(Rect2(-1.5, -22, 3, 42), brass_dark)
	c.draw_circle(Vector2(0, -23), 3.0, brass)
	# Beam, tipped a little
	c.draw_line(Vector2(-17, -15), Vector2(17, -19), brass, 2.5)
	# Chains and pans (the left one worn brighter)
	for side: float in [-1.0, 1.0]:
		var hang := Vector2(17.0 * side, -17.0 - 2.0 * side)
		var pan_y := 8.0 - 2.0 * side
		c.draw_line(hang, Vector2(hang.x - 6, pan_y), brass_dark, 0.8)
		c.draw_line(hang, Vector2(hang.x + 6, pan_y), brass_dark, 0.8)
		c.draw_colored_polygon(PackedVector2Array([Vector2(hang.x - 7, pan_y), Vector2(hang.x + 7, pan_y),
			Vector2(hang.x + 4, pan_y + 4), Vector2(hang.x - 4, pan_y + 4)]), Color(1.0, 0.86, 0.5) if side < 0.0 else brass)


## A steel spike on a round base, stacked with paper slips.
static func _draw_prescription_spike(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 22), 13, 2, SHADOW)
	PlaceholderArt.draw_ellipse(c, Vector2(0, 19), 12, 4, STEEL_DARK)
	PlaceholderArt.draw_ellipse(c, Vector2(0, 18), 10, 3, STEEL)
	# Slips, skewed this way and that
	for i in range(6):
		var slip_y := 13.0 - i * 3.0
		var shift := -2.0 if i % 2 == 0 else 2.0
		c.draw_colored_polygon(PackedVector2Array([Vector2(-11 + shift, slip_y - 2), Vector2(11 + shift, slip_y - 3),
			Vector2(12 + shift, slip_y), Vector2(-10 + shift, slip_y + 1)]), PAPER if i % 2 == 0 else PAPER_DARK)
	c.draw_line(Vector2(-6, -3), Vector2(4, -4), INK, 0.8)
	# The spike
	c.draw_line(Vector2(0, -6), Vector2(0, -22), STEEL_DARK, 2.5)
	c.draw_line(Vector2(-0.5, -6), Vector2(-0.5, -23), Color(1, 1, 1, 0.8), 1.0)


## A roll of gummed labels, printed with numbers only, one end hanging loose.
static func _draw_label_roll(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(-2, 13), 16, 2, SHADOW)
	c.draw_circle(Vector2(-6, 0), 13.0, PAPER_DARK)
	c.draw_circle(Vector2(-6, 0), 11.5, PAPER)
	c.draw_arc(Vector2(-6, 0), 8.0, 0.0, TAU, 20, PAPER_DARK, 0.8, true)
	c.draw_circle(Vector2(-6, 0), 4.5, Color(0.5, 0.4, 0.28))
	c.draw_circle(Vector2(-6, 0), 2.5, Color(0.2, 0.15, 0.1))
	# The loose end, with two labels showing
	c.draw_rect(Rect2(-6, 7, 25, 7), PAPER)
	c.draw_rect(Rect2(-6, 13, 25, 1), PAPER_DARK)
	c.draw_line(Vector2(7, 7), Vector2(7, 14), PAPER_DARK, 0.8)
	_text(c, Vector2(-1, 13), "6", 6, INK)
	_text(c, Vector2(11, 13), "7", 6, RED_INK)


## A heavy white stone pestle, dusted with powder.
static func _draw_pestle(c: CanvasItem) -> void:
	var stone := Color(0.88, 0.87, 0.82)
	PlaceholderArt.draw_ellipse(c, Vector2(0, 7), 21, 1.5, SHADOW)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-21, -3), Vector2(12, -5), Vector2(12, 5), Vector2(-21, 3)]), stone)
	c.draw_circle(Vector2(-20, 0), 3.2, stone)
	PlaceholderArt.draw_ellipse(c, Vector2(15, 0), 7, 6.5, stone)
	PlaceholderArt.draw_ellipse(c, Vector2(19, 0), 3, 5, Color(1, 1, 1))
	c.draw_line(Vector2(-19, 2), Vector2(12, 4), Color(0.62, 0.61, 0.57), 1.0)
	c.draw_line(Vector2(-18, -2), Vector2(10, -3.5), Color(1, 1, 1, 0.7), 1.0)


## A brown stoppered bottle with a skull on its label.
static func _draw_chloral_bottle(c: CanvasItem) -> void:
	# Glass stopper and neck
	c.draw_circle(Vector2(0, -21), 3.5, BROWN_GLASS.lightened(0.2))
	c.draw_rect(Rect2(-3, -18, 6, 7), BROWN_GLASS)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-3, -12), Vector2(3, -12), Vector2(12, -5), Vector2(-12, -5)]), BROWN_GLASS)
	c.draw_rect(Rect2(-12, -5, 24, 28), BROWN_GLASS)
	c.draw_rect(Rect2(-12, 21, 24, 2), BROWN_GLASS.darkened(0.4))
	c.draw_line(Vector2(-10, -3), Vector2(-10, 19), Color(0.75, 0.5, 0.25, 0.8), 1.5)
	# Label with a skull and crossed bones
	c.draw_rect(Rect2(-8, -1, 17, 19), PAPER)
	c.draw_circle(Vector2(0.5, 6), 4.5, INK)
	c.draw_rect(Rect2(-2, 9, 5, 4), INK)
	c.draw_circle(Vector2(-1.2, 6), 1.2, PAPER)
	c.draw_circle(Vector2(2.2, 6), 1.2, PAPER)
	c.draw_line(Vector2(-6, 12), Vector2(7, 16), INK, 1.0)
	c.draw_line(Vector2(7, 12), Vector2(-6, 16), INK, 1.0)


## A narrow book ruled in seven columns, with the hour of the night round: 21.30.
static func _draw_dose_book(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-15, -24, 34, 50), SHADOW)
	c.draw_rect(Rect2(-18, -26, 34, 50), Color(0.2, 0.26, 0.2))
	c.draw_rect(Rect2(-15, -25, 30, 48), PAPER)
	# The hour, written large across the top and underlined
	_text(c, Vector2(-14, -12), "21.30", 10, RED_INK)
	c.draw_line(Vector2(-14, -9), Vector2(14, -9), RED_INK, 1.0)
	# Seven columns of ticks
	for i in range(8):
		c.draw_line(Vector2(-14 + i * 4.0, -6), Vector2(-14 + i * 4.0, 21), PAPER_DARK, 0.6)
	for row in range(5):
		c.draw_line(Vector2(-14, -1 + row * 5.0), Vector2(14, -1 + row * 5.0), PAPER_DARK, 0.6)
		for column in range(7):
			var tick := Vector2(-13 + column * 4.0, -3.5 + row * 5.0)
			c.draw_polyline(PackedVector2Array([tick, tick + Vector2(1, 1.5), tick + Vector2(2.6, -1.5)]), INK, 0.7)


## A pad of death certificates: black-bordered, blank, and signed at the bottom.
static func _draw_blank_death_forms(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-17, -21, 38, 46), PAPER_DARK)
	c.draw_rect(Rect2(-19, -23, 38, 46), PAPER_DARK.lightened(0.15))
	c.draw_rect(Rect2(-21, -25, 38, 46), Color(0.95, 0.94, 0.88))
	c.draw_rect(Rect2(-19, -23, 34, 42), INK, false, 1.5)
	_text(c, Vector2(-16, -15), "DEATH", 7, INK)
	c.draw_line(Vector2(-16, -12), Vector2(12, -12), INK, 0.8)
	# Blank spaces where the name and cause should be
	for i in range(3):
		c.draw_line(Vector2(-16, -4 + i * 6.0), Vector2(12, -4 + i * 6.0), Color(0.6, 0.6, 0.6), 0.6)
	# The signature
	c.draw_polyline(PackedVector2Array([Vector2(-12, 15), Vector2(-9, 10), Vector2(-7, 15), Vector2(-3, 11), Vector2(0, 15),
		Vector2(4, 12), Vector2(10, 14)]), Color(0.1, 0.12, 0.45), 1.0, true)
	# The torn stubs of seven forms at the top
	for i in range(6):
		c.draw_line(Vector2(-20 + i * 6.0, -25), Vector2(-17 + i * 6.0, -27), PAPER_DARK, 1.0)


## A card of glass ampoules held by a band, with one gap.
static func _draw_sealed_ampoules(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-23, -11, 48, 26), SHADOW)
	c.draw_rect(Rect2(-25, -13, 48, 26), Color(0.84, 0.8, 0.68))
	c.draw_rect(Rect2(-25, 6, 48, 4), Color(0.5, 0.12, 0.1))
	for i in range(6):
		var ampoule_x := -20.0 + i * 8.0
		if i == 4:
			# The fresh gap
			c.draw_rect(Rect2(ampoule_x - 2.5, -8, 5, 14), Color(0.6, 0.56, 0.46))
			continue
		c.draw_rect(Rect2(ampoule_x - 2.5, -4, 5, 12), Color(0.8, 0.9, 0.92, 0.85))
		c.draw_rect(Rect2(ampoule_x - 1, -10, 2, 6), Color(0.8, 0.9, 0.92, 0.85))
		c.draw_rect(Rect2(ampoule_x - 2.5, 1, 5, 7), Color(0.85, 0.7, 0.3, 0.8))
		c.draw_line(Vector2(ampoule_x - 1.5, -3), Vector2(ampoule_x - 1.5, 7), Color(1, 1, 1, 0.8), 0.8)


## Two closely written pages, addressed to Edith and signed R.V.
static func _draw_standing_orders(c: CanvasItem) -> void:
	c.draw_colored_polygon(PackedVector2Array([Vector2(-15, -22), Vector2(22, -24), Vector2(23, 22), Vector2(-14, 24)]), PAPER_DARK)
	c.draw_rect(Rect2(-22, -24, 36, 46), PAPER)
	_text(c, Vector2(-19, -16), "Edith,", 7, INK)
	_lines(c, Vector2(-19, -11), 30.0, 9, 3.2, Color(0.25, 0.22, 0.34))
	_text(c, Vector2(-2, 20), "R.V.", 6, INK)
	# The fold
	c.draw_line(Vector2(-22, -1), Vector2(14, -1), PAPER_DARK, 0.8)


## A small brass key with a film of slime on it.
static func _draw_bureau_key(c: CanvasItem) -> void:
	var brass := Color(0.8, 0.62, 0.3)
	var brass_dark := Color(0.52, 0.38, 0.16)
	c.draw_circle(Vector2(-11, 0), 6.5, brass)
	c.draw_circle(Vector2(-11, 0), 3.0, brass_dark.darkened(0.4))
	c.draw_rect(Rect2(-5, -1.5, 21, 3), brass)
	c.draw_rect(Rect2(10, 1.5, 3, 5), brass)
	c.draw_rect(Rect2(14, 1.5, 2, 3.5), brass)
	# Slime
	c.draw_line(Vector2(-3, -1), Vector2(9, -1), Color(0.5, 0.7, 0.4, 0.8), 1.2)
	c.draw_circle(Vector2(-14, -3), 1.6, Color(0.5, 0.7, 0.4, 0.8))
	c.draw_circle(Vector2(4, 3.5), 1.3, Color(0.5, 0.7, 0.4, 0.7))


## A shallow wooden tray of plain white pills.
static func _draw_sugar_pills(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 14), 24, 2, SHADOW)
	c.draw_rect(Rect2(-25, -12, 50, 24), Color(0.36, 0.24, 0.14))
	c.draw_rect(Rect2(-22, -9, 44, 18), Color(0.2, 0.13, 0.08))
	for row in range(3):
		for column in range(7):
			var pill := Vector2(-18 + column * 6.0, -5 + row * 5.5)
			c.draw_circle(pill, 2.3, Color(0.96, 0.96, 0.93))
			c.draw_circle(pill + Vector2(-0.6, -0.6), 0.8, Color(1, 1, 1))


## A much-folded letter, begun three times and crossed out twice.
static func _draw_resignation_draft(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-18, -20, 38, 44), SHADOW)
	c.draw_rect(Rect2(-21, -23, 40, 45), Color(0.9, 0.9, 0.84))
	var ink := Color(0.12, 0.16, 0.4)
	_text(c, Vector2(-18, -15), "Matron,", 6, ink)
	_lines(c, Vector2(-18, -11), 32.0, 2, 3.0, ink)
	c.draw_line(Vector2(-19, -12), Vector2(15, -7), RED_INK, 1.0)
	_text(c, Vector2(-18, 0), "Matron,", 6, ink)
	_lines(c, Vector2(-18, 4), 32.0, 2, 3.0, ink)
	c.draw_line(Vector2(-19, 3), Vector2(15, 8), RED_INK, 1.0)
	_text(c, Vector2(-18, 15), "Matron, I", 6, ink)
	c.draw_line(Vector2(-18, 18), Vector2(-2, 18), ink, 0.9)
	# Fold lines
	c.draw_line(Vector2(-1, -23), Vector2(-1, 22), Color(0.7, 0.7, 0.64), 0.8)
	c.draw_line(Vector2(-21, -4), Vector2(19, -4), Color(0.7, 0.7, 0.64), 0.8)


## A folded chart of seven numbered beds in a row.
static func _draw_ward_chart(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-24, -16, 50, 34), SHADOW)
	c.draw_rect(Rect2(-26, -18, 50, 34), PAPER)
	_text(c, Vector2(-23, -10), "WARD 7", 6, RED_INK)
	for i in range(7):
		var bed_x := -23.0 + i * 6.6
		c.draw_rect(Rect2(bed_x, -6, 5, 12), INK, false, 0.8)
		c.draw_rect(Rect2(bed_x, -6, 5, 3), Color(0.8, 0.8, 0.8))
		_text(c, Vector2(bed_x + 0.8, 12), str(i + 1), 5, INK)
	# Fold
	c.draw_line(Vector2(-1, -18), Vector2(-1, 16), PAPER_DARK, 0.8)


## A long steel key on a black ribbon sewn with a white E.C.
static func _draw_matrons_office_key(c: CanvasItem) -> void:
	# Ribbon
	c.draw_colored_polygon(PackedVector2Array([Vector2(-27, -12), Vector2(-17, -12), Vector2(-14, -1), Vector2(-20, 3)]), Color(0.06, 0.06, 0.07))
	c.draw_colored_polygon(PackedVector2Array([Vector2(-27, 12), Vector2(-17, 12), Vector2(-14, 1), Vector2(-20, -3)]), Color(0.1, 0.1, 0.12))
	_text(c, Vector2(-26, -5), "EC", 5, Color(1, 1, 1))
	# Bow, shank and bit
	c.draw_arc(Vector2(-10, 0), 6.0, 0.0, TAU, 20, STEEL, 2.5, true)
	c.draw_rect(Rect2(-4, -1.5, 30, 3), STEEL)
	c.draw_line(Vector2(-3, -1), Vector2(25, -1), Color(1, 1, 1, 0.7), 0.8)
	c.draw_rect(Rect2(18, 1.5, 3, 8), STEEL)
	c.draw_rect(Rect2(22, 1.5, 4, 6), STEEL)
	c.draw_rect(Rect2(4, -2.5, 2, 5), STEEL_DARK)


## A buff telegram form with pasted strips of capitals.
static func _draw_crane_telegram(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-24, -14, 50, 30), SHADOW)
	c.draw_rect(Rect2(-26, -16, 50, 30), Color(0.9, 0.8, 0.56))
	c.draw_rect(Rect2(-26, -16, 50, 6), Color(0.72, 0.6, 0.36))
	_text(c, Vector2(-23, -11), "TELEGRAM", 5, INK)
	for i in range(3):
		c.draw_rect(Rect2(-23, -7 + i * 7.0, 44 if i < 2 else 30, 5), Color(0.97, 0.95, 0.88))
	_text(c, Vector2(-22, -3), "POLICE HAVE VANE", 4, INK)
	_text(c, Vector2(-22, 4), "MOVE THE SEVEN", 4, INK)
	_text(c, Vector2(-22, 11), "TONIGHT", 4, INK)
