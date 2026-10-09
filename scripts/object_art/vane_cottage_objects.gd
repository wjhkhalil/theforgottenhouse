@tool
class_name VaneCottageObjects
extends RefCounted
## Placeholder drawings for the hidden objects of House Two, Chapter Ten (Dr Vane's Cottage).
## Same rules as placeholder_art.gd: every drawing is centred on (0, 0) and
## fits inside get_size(). PlaceholderArt calls these functions.

const BRASS := Color(0.8, 0.62, 0.3)
const BRASS_DARK := Color(0.52, 0.38, 0.16)
const BRASS_LIGHT := Color(0.95, 0.82, 0.5)
const STEEL := Color(0.7, 0.72, 0.75)
const STEEL_DARK := Color(0.42, 0.44, 0.47)
const SILVER := Color(0.82, 0.83, 0.86)
const PAPER := Color(0.92, 0.88, 0.76)
const PAPER_DARK := Color(0.74, 0.68, 0.54)
const INK := Color(0.16, 0.14, 0.2)
const RED_INK := Color(0.62, 0.12, 0.1)
const GLASS := Color(0.75, 0.88, 0.9, 0.45)
const GLASS_EDGE := Color(0.88, 0.96, 1.0, 0.8)
const RUBBER := Color(0.12, 0.12, 0.13)
const SHADOW := Color(0, 0, 0, 0.35)


## Size of the drawing, or Vector2.ZERO if `style` is not one of this chapter's objects.
static func get_size(style: int) -> Vector2:
	match style:
		HiddenObjectData.PlaceholderStyle.STETHOSCOPE:
			return Vector2(44, 44)
		HiddenObjectData.PlaceholderStyle.GLASS_SYRINGE:
			return Vector2(48, 14)
		HiddenObjectData.PlaceholderStyle.DEATH_CERTIFICATE:
			return Vector2(42, 54)
		HiddenObjectData.PlaceholderStyle.CHEQUE_BOOK:
			return Vector2(46, 24)
		HiddenObjectData.PlaceholderStyle.PEN_KNIFE:
			return Vector2(38, 12)
		HiddenObjectData.PlaceholderStyle.CARRIAGE_CLOCK:
			return Vector2(26, 36)
		HiddenObjectData.PlaceholderStyle.DECANTER:
			return Vector2(26, 42)
		HiddenObjectData.PlaceholderStyle.SPECIMEN_JAR:
			return Vector2(22, 32)
		HiddenObjectData.PlaceholderStyle.CELLAR_KEY:
			return Vector2(54, 22)
		HiddenObjectData.PlaceholderStyle.TIMETABLE:
			return Vector2(42, 30)
		HiddenObjectData.PlaceholderStyle.PASSPORT:
			return Vector2(28, 36)
		HiddenObjectData.PlaceholderStyle.CONFESSION:
			return Vector2(42, 50)
		HiddenObjectData.PlaceholderStyle.GREY_SHAWL:
			return Vector2(52, 34)
		HiddenObjectData.PlaceholderStyle.MEDICAL_FILE:
			return Vector2(46, 34)
		HiddenObjectData.PlaceholderStyle.POLICE_WHISTLE:
			return Vector2(36, 18)
		HiddenObjectData.PlaceholderStyle.NAME_BRACELET:
			return Vector2(36, 28)
	return Vector2.ZERO


## Draws `style` and returns true, or returns false if it is not one of this chapter's objects.
static func draw(c: CanvasItem, style: int) -> bool:
	match style:
		HiddenObjectData.PlaceholderStyle.STETHOSCOPE:
			_draw_stethoscope(c)
		HiddenObjectData.PlaceholderStyle.GLASS_SYRINGE:
			_draw_glass_syringe(c)
		HiddenObjectData.PlaceholderStyle.DEATH_CERTIFICATE:
			_draw_death_certificate(c)
		HiddenObjectData.PlaceholderStyle.CHEQUE_BOOK:
			_draw_cheque_book(c)
		HiddenObjectData.PlaceholderStyle.PEN_KNIFE:
			_draw_pen_knife(c)
		HiddenObjectData.PlaceholderStyle.CARRIAGE_CLOCK:
			_draw_carriage_clock(c)
		HiddenObjectData.PlaceholderStyle.DECANTER:
			_draw_decanter(c)
		HiddenObjectData.PlaceholderStyle.SPECIMEN_JAR:
			_draw_specimen_jar(c)
		HiddenObjectData.PlaceholderStyle.CELLAR_KEY:
			_draw_cellar_key(c)
		HiddenObjectData.PlaceholderStyle.TIMETABLE:
			_draw_timetable(c)
		HiddenObjectData.PlaceholderStyle.PASSPORT:
			_draw_passport(c)
		HiddenObjectData.PlaceholderStyle.CONFESSION:
			_draw_confession(c)
		HiddenObjectData.PlaceholderStyle.GREY_SHAWL:
			_draw_grey_shawl(c)
		HiddenObjectData.PlaceholderStyle.MEDICAL_FILE:
			_draw_medical_file(c)
		HiddenObjectData.PlaceholderStyle.POLICE_WHISTLE:
			_draw_police_whistle(c)
		HiddenObjectData.PlaceholderStyle.NAME_BRACELET:
			_draw_name_bracelet(c)
		_:
			return false
	return true


## Small text helper (the built-in fallback font).
static func _text(c: CanvasItem, at: Vector2, text: String, font_size: int, color: Color) -> void:
	c.draw_string(ThemeDB.fallback_font, at, text, HORIZONTAL_ALIGNMENT_LEFT, -1, font_size, color)


## A doctor's stethoscope: black rubber tubes, steel earpieces and a round chest piece.
static func _draw_stethoscope(c: CanvasItem) -> void:
	# The two ear tubes come together at the Y.
	c.draw_polyline(PackedVector2Array([Vector2(-14, -19), Vector2(-15, -10), Vector2(-9, -2), Vector2(-2, 2)]), STEEL, 2.0, true)
	c.draw_polyline(PackedVector2Array([Vector2(4, -19), Vector2(6, -10), Vector2(2, -2), Vector2(-2, 2)]), STEEL, 2.0, true)
	c.draw_circle(Vector2(-14, -20), 2.2, RUBBER)
	c.draw_circle(Vector2(4, -20), 2.2, RUBBER)
	# One long tube looping down to the chest piece.
	var tube := PackedVector2Array()
	for i in range(19):
		var t := i / 18.0
		tube.append(Vector2(-2, 2).lerp(Vector2(12, 12), t) + Vector2(sin(t * PI) * -14.0, sin(t * PI * 2.0) * 6.0 + t * 4.0))
	c.draw_polyline(tube, RUBBER, 3.0, true)
	c.draw_polyline(tube, Color(0.35, 0.35, 0.38), 1.0, true)
	c.draw_circle(Vector2(14, 15), 7.0, STEEL_DARK)
	c.draw_circle(Vector2(14, 15), 5.5, STEEL)
	c.draw_circle(Vector2(14, 15), 3.5, Color(0.86, 0.9, 0.92))
	c.draw_arc(Vector2(14, 15), 5.5, -2.4, -0.6, 8, Color(1, 1, 1, 0.8), 1.0, true)


## An old glass syringe with a steel plunger and a fine needle.
static func _draw_glass_syringe(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 5), 20, 2, SHADOW)
	# Plunger handle and rod
	c.draw_rect(Rect2(-23, -5, 3, 10), STEEL_DARK)
	c.draw_rect(Rect2(-20, -1, 8, 2), STEEL)
	# Finger flanges
	c.draw_rect(Rect2(-13, -6, 2, 12), STEEL)
	# Glass barrel with markings and a little cloudy liquid left in it
	c.draw_rect(Rect2(-11, -3.5, 22, 7), GLASS)
	c.draw_rect(Rect2(2, -3, 9, 6), Color(0.85, 0.82, 0.55, 0.6))
	c.draw_rect(Rect2(-11, -3.5, 22, 7), GLASS_EDGE, false, 1.0)
	for i in range(5):
		c.draw_line(Vector2(-7 + i * 4, -3.5), Vector2(-7 + i * 4, -1), INK, 0.8)
	c.draw_line(Vector2(-10, -2.4), Vector2(10, -2.4), Color(1, 1, 1, 0.7), 1.0)
	# Steel tip and needle
	c.draw_rect(Rect2(11, -2, 4, 4), STEEL)
	c.draw_line(Vector2(15, 0), Vector2(24, 0), STEEL_DARK, 1.0)


## The forged death certificate: Mara Ashworth, 1987, signed R. Vane.
static func _draw_death_certificate(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-19, -25, 40, 52), SHADOW)
	c.draw_rect(Rect2(-21, -27, 40, 52), PAPER)
	c.draw_rect(Rect2(-19, -25, 36, 48), Color(0.45, 0.32, 0.2), false, 1.0)
	_text(c, Vector2(-17, -16), "CERTIFICATE", 6, INK)
	_text(c, Vector2(-14, -9), "OF DEATH", 7, Color(0.1, 0.1, 0.12))
	c.draw_line(Vector2(-16, -6), Vector2(14, -6), PAPER_DARK, 1.0)
	_text(c, Vector2(-17, 1), "Mara Ashworth", 6, INK)
	_text(c, Vector2(-17, 8), "aged 16", 5, INK)
	# The year, large and clear
	_text(c, Vector2(-17, 16), "1987", 9, RED_INK)
	# Vane's signature in a sloping scrawl
	c.draw_polyline(PackedVector2Array([Vector2(1, 20), Vector2(4, 15), Vector2(6, 20), Vector2(9, 16), Vector2(12, 19), Vector2(16, 17)]), INK, 1.0, true)
	_text(c, Vector2(2, 13), "R.V.", 5, INK)
	# An official seal
	c.draw_circle(Vector2(10, 4), 4.5, Color(0.6, 0.14, 0.12))
	c.draw_circle(Vector2(10, 4), 3.0, Color(0.72, 0.2, 0.16))


## A cheque book open at the stubs: "T.G." every month.
static func _draw_cheque_book(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-21, -9, 44, 22), SHADOW)
	c.draw_rect(Rect2(-23, -11, 46, 22), Color(0.2, 0.28, 0.22))
	c.draw_rect(Rect2(-21, -10, 42, 19), Color(0.88, 0.9, 0.82))
	# The stubs, torn edges down the middle
	for i in range(8):
		c.draw_line(Vector2(-4, -10 + i * 2.4), Vector2(-2, -9 + i * 2.4), PAPER_DARK, 1.0)
	_text(c, Vector2(-20, -3), "T.G.", 6, INK)
	_text(c, Vector2(-20, 4), "T.G.", 6, INK)
	_text(c, Vector2(1, -3), "Pay T.G.", 5, INK)
	_text(c, Vector2(1, 4), "£ 200 -", 5, INK)
	c.draw_line(Vector2(1, 6), Vector2(19, 6), Color(0.4, 0.5, 0.45), 0.8)


## A small folding pen knife with a mother-of-pearl handle.
static func _draw_pen_knife(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 4), 17, 2, SHADOW)
	c.draw_rect(Rect2(-17, -3, 18, 7), Color(0.88, 0.86, 0.82))
	c.draw_rect(Rect2(-15, -2, 14, 2), Color(0.95, 0.9, 0.95))
	c.draw_rect(Rect2(-18, -3, 2, 7), SILVER)
	c.draw_rect(Rect2(0, -3, 2, 7), SILVER)
	c.draw_circle(Vector2(1, 0.5), 1.0, STEEL_DARK)
	# The blade, opened out
	c.draw_colored_polygon(PackedVector2Array([Vector2(2, -2), Vector2(16, -2), Vector2(18, 0), Vector2(2, 2)]), STEEL)
	c.draw_line(Vector2(3, -1.5), Vector2(16, -1.5), Color(1, 1, 1, 0.8), 0.8)


## A brass carriage clock with a handle on top and a white enamel face.
static func _draw_carriage_clock(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 17), 12, 2, SHADOW)
	c.draw_arc(Vector2(0, -12), 6.0, PI, TAU, 10, BRASS_DARK, 2.0, true)
	c.draw_rect(Rect2(-11, -12, 22, 3), BRASS_DARK)
	c.draw_rect(Rect2(-10, -10, 20, 24), BRASS)
	c.draw_rect(Rect2(-12, 13, 24, 4), BRASS_DARK)
	# Bevelled glass sides
	c.draw_rect(Rect2(-9, -8, 2, 20), BRASS_LIGHT)
	c.draw_rect(Rect2(7, -8, 2, 20), BRASS_DARK)
	# Face
	c.draw_circle(Vector2(0, 1), 7.0, Color(0.95, 0.93, 0.86))
	for i in range(12):
		var direction := Vector2.from_angle(TAU * i / 12.0)
		c.draw_line(Vector2(0, 1) + direction * 5.5, Vector2(0, 1) + direction * 6.5, INK, 0.8)
	c.draw_line(Vector2(0, 1), Vector2(-2.5, -2.5), INK, 1.2)  # hour hand
	c.draw_line(Vector2(0, 1), Vector2(4.5, -1.5), INK, 0.8)  # minute hand


## A cut-glass decanter, half full of brandy, with a stopper.
static func _draw_decanter(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 19), 12, 2.5, SHADOW)
	# Body: a wide base narrowing to the neck
	var body := PackedVector2Array([Vector2(-4, -8), Vector2(4, -8), Vector2(11, 4), Vector2(11, 17), Vector2(-11, 17), Vector2(-11, 4)])
	c.draw_colored_polygon(body, GLASS)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-10.5, 6), Vector2(10.5, 6), Vector2(10.5, 16.5), Vector2(-10.5, 16.5)]), Color(0.62, 0.32, 0.1, 0.8))
	c.draw_polyline(PackedVector2Array([Vector2(-4, -8), Vector2(-11, 4), Vector2(-11, 17), Vector2(11, 17), Vector2(11, 4), Vector2(4, -8)]), GLASS_EDGE, 1.0, true)
	# Diamond cuts
	for i in range(4):
		var x := -8.0 + i * 5.3
		c.draw_line(Vector2(x, 8), Vector2(x + 2.6, 13), Color(1, 1, 1, 0.3), 0.8)
		c.draw_line(Vector2(x + 2.6, 8), Vector2(x, 13), Color(1, 1, 1, 0.3), 0.8)
	# Neck and ball stopper
	c.draw_rect(Rect2(-3, -14, 6, 7), GLASS)
	c.draw_rect(Rect2(-3, -14, 6, 7), GLASS_EDGE, false, 1.0)
	c.draw_circle(Vector2(0, -17), 4.0, Color(0.85, 0.93, 0.96, 0.7))
	c.draw_circle(Vector2(-1.2, -18.2), 1.2, Color(1, 1, 1, 0.9))
	c.draw_line(Vector2(-8, 4), Vector2(-8, 15), Color(1, 1, 1, 0.6), 1.0)


## A stoppered glass specimen jar, with a handwritten label "M."
static func _draw_specimen_jar(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 15), 10, 2, SHADOW)
	c.draw_rect(Rect2(-6, -16, 12, 5), Color(0.55, 0.38, 0.24))  # cork
	c.draw_rect(Rect2(-9, -11, 18, 26), GLASS)
	# Murky liquid and something pale floating in it (just a few dried flowers)
	c.draw_rect(Rect2(-8, -4, 16, 18), Color(0.7, 0.75, 0.45, 0.45))
	c.draw_circle(Vector2(-2, 4), 2.0, Color(0.85, 0.82, 0.92, 0.8))
	c.draw_circle(Vector2(2, 7), 1.6, Color(0.82, 0.78, 0.9, 0.8))
	c.draw_line(Vector2(-2, 6), Vector2(0, 12), Color(0.4, 0.5, 0.3), 1.0)
	c.draw_rect(Rect2(-9, -11, 18, 26), GLASS_EDGE, false, 1.0)
	# Paper label
	c.draw_rect(Rect2(-7, -9, 14, 7), PAPER)
	_text(c, Vector2(-5, -3), "M. 87", 5, INK)
	c.draw_line(Vector2(-7, -10), Vector2(-7, 13), Color(1, 1, 1, 0.6), 1.0)


## A big black iron key with a cardboard tag: "CELLAR".
static func _draw_cellar_key(c: CanvasItem) -> void:
	var iron := Color(0.2, 0.19, 0.19)
	var iron_light := Color(0.42, 0.4, 0.38)
	PlaceholderArt.draw_ellipse(c, Vector2(0, 8), 24, 2.5, SHADOW)
	c.draw_arc(Vector2(-17, 0), 7.0, 0.0, TAU, 18, iron, 3.5, true)
	c.draw_arc(Vector2(-17, 0), 7.0, -2.4, -1.0, 6, iron_light, 1.0, true)
	c.draw_rect(Rect2(-10, -2, 30, 4), iron)
	c.draw_line(Vector2(-10, -1.4), Vector2(19, -1.4), iron_light, 0.8)
	# Bit
	c.draw_rect(Rect2(14, 2, 4, 7), iron)
	c.draw_rect(Rect2(20, 2, 3, 5), iron)
	# Tag on a loop of string
	c.draw_line(Vector2(-22, 3), Vector2(-24, 7), Color(0.75, 0.7, 0.6), 1.0)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-27, 6), Vector2(-14, 6), Vector2(-14, 11), Vector2(-27, 11)]), PAPER)
	_text(c, Vector2(-26, 10.5), "CELLAR", 4, INK)


## A folded railway timetable, the 23:50 ringed in pencil.
static func _draw_timetable(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-18, -12, 40, 28), SHADOW)
	c.draw_rect(Rect2(-21, -15, 42, 28), Color(0.94, 0.92, 0.84))
	c.draw_rect(Rect2(-21, -15, 42, 6), Color(0.2, 0.3, 0.5))
	_text(c, Vector2(-19, -10), "RAILWAY TIMES", 5, Color(0.95, 0.95, 0.9))
	c.draw_line(Vector2(0, -9), Vector2(0, 13), PAPER_DARK, 1.0)  # fold
	for i in range(3):
		_text(c, Vector2(-19, -3 + i * 5), ["21:10", "22:35", "06:40"][i], 5, INK)
	_text(c, Vector2(2, 4), "23:50", 6, INK)
	c.draw_arc(Vector2(9, 2), 9.0, 0.0, TAU, 18, RED_INK, 1.0, true)


## A passport with a gold crest on the cover.
static func _draw_passport(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-12, -16, 26, 34), SHADOW)
	c.draw_rect(Rect2(-14, -18, 26, 34), Color(0.36, 0.08, 0.14))
	c.draw_rect(Rect2(-14, -18, 3, 34), Color(0.26, 0.05, 0.1))
	_text(c, Vector2(-9, -9), "PASS", 6, BRASS_LIGHT)
	_text(c, Vector2(-9, -3), "PORT", 6, BRASS_LIGHT)
	c.draw_circle(Vector2(-1, 6), 4.5, BRASS)
	c.draw_circle(Vector2(-1, 6), 3.0, Color(0.36, 0.08, 0.14))
	c.draw_circle(Vector2(-1, 6), 1.2, BRASS)
	# A paper ticket sticking out of the top
	c.draw_rect(Rect2(2, -21, 9, 6), PAPER)


## Two pages of Vane's unsent, unsigned confession, folded in half.
static func _draw_confession(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-17, -21, 38, 46), SHADOW)
	c.draw_rect(Rect2(-17, -23, 36, 46), PAPER_DARK)
	c.draw_rect(Rect2(-21, -25, 36, 46), PAPER)
	_text(c, Vector2(-19, -16), "I, Robert Vane,", 5, INK)
	for i in range(8):
		var width := 28.0 if i % 3 != 2 else 18.0
		c.draw_line(Vector2(-18, -11 + i * 4.0), Vector2(-18 + width, -11 + i * 4.0), Color(0.3, 0.28, 0.4), 0.9)
	# Unsigned: a blank line at the bottom, with a blot of ink where the pen stopped
	c.draw_line(Vector2(-6, 18), Vector2(12, 18), INK, 0.8)
	c.draw_circle(Vector2(-6, 17), 1.6, INK)
	c.draw_line(Vector2(-21, -2), Vector2(15, -2), Color(0.7, 0.64, 0.5, 0.6), 1.0)  # fold


## Mara's grey wool shawl, folded, with a fringe.
static func _draw_grey_shawl(c: CanvasItem) -> void:
	var wool := Color(0.58, 0.58, 0.6)
	var wool_dark := Color(0.42, 0.42, 0.45)
	PlaceholderArt.draw_ellipse(c, Vector2(0, 13), 24, 3, SHADOW)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-24, -6), Vector2(22, -12), Vector2(25, 6), Vector2(-20, 12)]), wool)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-24, -6), Vector2(22, -12), Vector2(18, -4), Vector2(-20, 1)]), wool.lightened(0.1))
	# Knitted ribs
	for i in range(7):
		var x := -18.0 + i * 6.5
		c.draw_line(Vector2(x, -5 - i * 0.8), Vector2(x + 3, 10 - i * 0.8), wool_dark, 1.0)
	# Fringe hanging from the edge
	for i in range(11):
		var start := Vector2(-20, 12).lerp(Vector2(25, 6), i / 10.0)
		c.draw_line(start, start + Vector2(-1, 5), wool_dark, 1.0)


## A buff medical folder: "PATIENT M. - PRIVATE".
static func _draw_medical_file(c: CanvasItem) -> void:
	var buff := Color(0.82, 0.7, 0.46)
	c.draw_rect(Rect2(-20, -14, 44, 32), SHADOW)
	# Papers sticking out
	c.draw_rect(Rect2(-19, -18, 36, 8), PAPER)
	c.draw_rect(Rect2(-22, -16, 44, 32), buff)
	c.draw_rect(Rect2(-22, -18, 14, 4), buff)  # tab
	c.draw_rect(Rect2(-22, -16, 44, 32), buff.darkened(0.3), false, 1.0)
	_text(c, Vector2(-18, -3), "PATIENT M.", 7, INK)
	_text(c, Vector2(-14, 10), "PRIVATE", 6, RED_INK)
	c.draw_rect(Rect2(-16, 3, 30, 9), RED_INK, false, 1.0)


## A nickel police whistle on a short chain.
static func _draw_police_whistle(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(2, 7), 15, 2, SHADOW)
	# Chain
	for i in range(5):
		c.draw_arc(Vector2(-15 + i * 3.0, -4 + i * 1.2), 1.5, 0.0, TAU, 8, STEEL_DARK, 1.0)
	c.draw_arc(Vector2(-3, 0), 2.5, 0.0, TAU, 10, STEEL, 1.2)
	# Barrel and round chamber
	c.draw_rect(Rect2(0, -3, 12, 6), SILVER)
	c.draw_circle(Vector2(12, 1), 5.0, SILVER)
	c.draw_circle(Vector2(12, 1), 5.0, STEEL_DARK, false, 1.0)
	c.draw_rect(Rect2(6, -3, 4, 2), RUBBER)  # the sound hole
	c.draw_line(Vector2(1, -2), Vector2(10, -2), Color(1, 1, 1, 0.8), 1.0)
	c.draw_rect(Rect2(0, -3, 12, 6), STEEL_DARK, false, 0.8)


## A small silver bracelet with an engraved name plate: MARA.
static func _draw_name_bracelet(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 10), 16, 3, SHADOW)
	# The chain links in a loose oval
	for i in range(18):
		var angle := TAU * i / 18.0
		c.draw_arc(Vector2(cos(angle) * 14.0, sin(angle) * 7.0 + 2.0), 2.0, 0.0, TAU, 8, SILVER, 1.0)
	# The name plate
	c.draw_rect(Rect2(-11, -10, 22, 9), SILVER)
	c.draw_rect(Rect2(-11, -10, 22, 9), STEEL_DARK, false, 1.0)
	_text(c, Vector2(-9, -3), "MARA", 7, Color(0.25, 0.25, 0.3))
	c.draw_line(Vector2(-10, -9), Vector2(8, -9), Color(1, 1, 1, 0.9), 0.8)
