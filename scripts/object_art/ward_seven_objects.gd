@tool
class_name WardSevenObjects
extends RefCounted
## Placeholder drawings for the hidden objects of House Three, Chapter Seven (Ward Seven).
## Same rules as placeholder_art.gd: every drawing is centred on (0, 0) and
## fits inside get_size(). PlaceholderArt calls these functions.

const BRASS := Color(0.8, 0.62, 0.3)
const BRASS_DARK := Color(0.52, 0.38, 0.16)
const STEEL := Color(0.7, 0.72, 0.75)
const STEEL_DARK := Color(0.42, 0.44, 0.47)
const SILVER := Color(0.84, 0.85, 0.88)
const IRON := Color(0.16, 0.16, 0.18)
const PAPER := Color(0.92, 0.88, 0.76)
const PAPER_DARK := Color(0.74, 0.68, 0.54)
const LINEN := Color(0.9, 0.9, 0.86)
const SMOCK := Color(0.6, 0.62, 0.62)
const INK := Color(0.16, 0.14, 0.2)
const RED := Color(0.72, 0.12, 0.1)
const RED_DARK := Color(0.45, 0.07, 0.06)
const PENCIL := Color(0.3, 0.3, 0.34)
const LEATHER := Color(0.4, 0.24, 0.13)
const LEATHER_DARK := Color(0.24, 0.14, 0.08)
const SLATE := Color(0.2, 0.23, 0.27)
const CHALK := Color(0.86, 0.88, 0.9)
const SHADOW := Color(0, 0, 0, 0.35)

const SIZES := {
	HiddenObjectData.PlaceholderStyle.BED_FRAME_KEY: Vector2(48, 16),
	HiddenObjectData.PlaceholderStyle.RUTHS_SAMPLER: Vector2(46, 44),
	HiddenObjectData.PlaceholderStyle.STRONGBOX_KEY: Vector2(44, 20),
	HiddenObjectData.PlaceholderStyle.IVYS_TOKEN: Vector2(34, 46),
	HiddenObjectData.PlaceholderStyle.HIDDEN_FILE: Vector2(54, 16),
	HiddenObjectData.PlaceholderStyle.SCRATCHED_CALENDAR: Vector2(56, 46),
	HiddenObjectData.PlaceholderStyle.FIRE_BELL_KEY: Vector2(50, 28),
	HiddenObjectData.PlaceholderStyle.WOODEN_YOYO: Vector2(36, 46),
	HiddenObjectData.PlaceholderStyle.THIMBLE_CASE: Vector2(42, 32),
	HiddenObjectData.PlaceholderStyle.READING_GLASSES: Vector2(54, 28),
	HiddenObjectData.PlaceholderStyle.HAIR_SLIDE: Vector2(48, 18),
	HiddenObjectData.PlaceholderStyle.HARMONICA: Vector2(52, 22),
	HiddenObjectData.PlaceholderStyle.PRAYER_BOOK: Vector2(36, 48),
	HiddenObjectData.PlaceholderStyle.CLOTH_RABBIT: Vector2(36, 54),
	HiddenObjectData.PlaceholderStyle.NIGHT_LAMP: Vector2(32, 48),
	HiddenObjectData.PlaceholderStyle.BED_CHART: Vector2(36, 50),
	HiddenObjectData.PlaceholderStyle.WARD_SLIPPERS: Vector2(50, 24),
	HiddenObjectData.PlaceholderStyle.FIRE_BUCKET: Vector2(40, 48),
	HiddenObjectData.PlaceholderStyle.RESTRAINT_STRAP: Vector2(56, 20),
	HiddenObjectData.PlaceholderStyle.DOSE_TRAY: Vector2(56, 24),
	HiddenObjectData.PlaceholderStyle.WINDOW_BAR: Vector2(56, 14),
	HiddenObjectData.PlaceholderStyle.SEVEN_ENVELOPES: Vector2(52, 38),
	HiddenObjectData.PlaceholderStyle.ALARM_HANDLE: Vector2(32, 54),
}


## Size of the drawing, or Vector2.ZERO if `style` is not one of this chapter's objects.
static func get_size(style: int) -> Vector2:
	return SIZES.get(style, Vector2.ZERO)


## Draws `style` and returns true, or returns false if it is not one of this chapter's objects.
static func draw(c: CanvasItem, style: int) -> bool:
	match style:
		HiddenObjectData.PlaceholderStyle.BED_FRAME_KEY:
			_draw_bed_frame_key(c)
		HiddenObjectData.PlaceholderStyle.RUTHS_SAMPLER:
			_draw_ruths_sampler(c)
		HiddenObjectData.PlaceholderStyle.STRONGBOX_KEY:
			_draw_strongbox_key(c)
		HiddenObjectData.PlaceholderStyle.IVYS_TOKEN:
			_draw_ivys_token(c)
		HiddenObjectData.PlaceholderStyle.HIDDEN_FILE:
			_draw_hidden_file(c)
		HiddenObjectData.PlaceholderStyle.SCRATCHED_CALENDAR:
			_draw_scratched_calendar(c)
		HiddenObjectData.PlaceholderStyle.FIRE_BELL_KEY:
			_draw_fire_bell_key(c)
		HiddenObjectData.PlaceholderStyle.WOODEN_YOYO:
			_draw_wooden_yoyo(c)
		HiddenObjectData.PlaceholderStyle.THIMBLE_CASE:
			_draw_thimble_case(c)
		HiddenObjectData.PlaceholderStyle.READING_GLASSES:
			_draw_reading_glasses(c)
		HiddenObjectData.PlaceholderStyle.HAIR_SLIDE:
			_draw_hair_slide(c)
		HiddenObjectData.PlaceholderStyle.HARMONICA:
			_draw_harmonica(c)
		HiddenObjectData.PlaceholderStyle.PRAYER_BOOK:
			_draw_prayer_book(c)
		HiddenObjectData.PlaceholderStyle.CLOTH_RABBIT:
			_draw_cloth_rabbit(c)
		HiddenObjectData.PlaceholderStyle.NIGHT_LAMP:
			_draw_night_lamp(c)
		HiddenObjectData.PlaceholderStyle.BED_CHART:
			_draw_bed_chart(c)
		HiddenObjectData.PlaceholderStyle.WARD_SLIPPERS:
			_draw_ward_slippers(c)
		HiddenObjectData.PlaceholderStyle.FIRE_BUCKET:
			_draw_fire_bucket(c)
		HiddenObjectData.PlaceholderStyle.RESTRAINT_STRAP:
			_draw_restraint_strap(c)
		HiddenObjectData.PlaceholderStyle.DOSE_TRAY:
			_draw_dose_tray(c)
		HiddenObjectData.PlaceholderStyle.WINDOW_BAR:
			_draw_window_bar(c)
		HiddenObjectData.PlaceholderStyle.SEVEN_ENVELOPES:
			_draw_seven_envelopes(c)
		HiddenObjectData.PlaceholderStyle.ALARM_HANDLE:
			_draw_alarm_handle(c)
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


## A key filed out of a spoon handle: the rounded end of the handle is its bow.
static func _draw_bed_frame_key(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 6.5), 22, 1.2, SHADOW)
	PlaceholderArt.draw_ellipse(c, Vector2(-17, 0), 7, 5.5, STEEL_DARK)
	PlaceholderArt.draw_ellipse(c, Vector2(-17, 0), 5.5, 4, SILVER)
	c.draw_rect(Rect2(-11, -2, 33, 4), SILVER)
	c.draw_line(Vector2(-10, -1.3), Vector2(21, -1.3), Color(1, 1, 1, 0.9), 0.8)
	# Rough hand-filed teeth
	c.draw_rect(Rect2(11, 2, 3, 5), SILVER)
	c.draw_rect(Rect2(16, 2, 2.5, 3.5), SILVER)
	c.draw_rect(Rect2(20, 2, 2, 5.5), SILVER)
	# File scratches
	for i in range(4):
		c.draw_line(Vector2(-6 + i * 4.0, -2), Vector2(-5 + i * 4.0, 2), STEEL_DARK, 0.6)


## A square of sheet stitched with seven names in red thread.
static func _draw_ruths_sampler(c: CanvasItem) -> void:
	c.draw_colored_polygon(PackedVector2Array([Vector2(-22, -21), Vector2(22, -22), Vector2(23, 21), Vector2(-23, 22)]), LINEN)
	c.draw_line(Vector2(-22, 0), Vector2(22, -1), Color(0, 0, 0, 0.08), 1.0)  # the fold
	# Seven rows of red stitching, one for each name
	for i in range(7):
		var y := -15.0 + i * 5.2
		var row_width := 22.0 + (i * 7) % 12
		var x := -17.0
		while x < -17.0 + row_width:
			c.draw_line(Vector2(x, y), Vector2(x + 2.2, y), RED, 1.4)
			x += 3.4
	# Frayed edge and a threaded needle left in the corner
	for i in range(8):
		c.draw_line(Vector2(-20 + i * 5.6, 21), Vector2(-20 + i * 5.6, 23), Color(0.7, 0.7, 0.66), 0.8)
	c.draw_line(Vector2(10, 12), Vector2(20, 18), SILVER, 1.2)
	c.draw_line(Vector2(10, 12), Vector2(6, 17), RED, 0.8)


## A flat steel key, warm from being held.
static func _draw_strongbox_key(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 9), 20, 1.5, SHADOW)
	c.draw_rect(Rect2(-21, -8, 14, 16), STEEL)
	c.draw_rect(Rect2(-21, -8, 14, 16), STEEL_DARK, false, 1.2)
	c.draw_circle(Vector2(-14, 0), 3.0, Color(0.1, 0.1, 0.12))
	c.draw_rect(Rect2(-7, -2.5, 28, 5), STEEL)
	c.draw_line(Vector2(-6, -1.6), Vector2(20, -1.6), Color(1, 1, 1, 0.8), 0.8)
	c.draw_line(Vector2(-6, 0.6), Vector2(20, 0.6), STEEL_DARK, 0.7)
	c.draw_rect(Rect2(9, 2.5, 3, 5), STEEL)
	c.draw_rect(Rect2(14, 2.5, 3, 3), STEEL)
	c.draw_rect(Rect2(18, 2.5, 3, 6), STEEL)


## A numbered brass token on a bootlace.
static func _draw_ivys_token(c: CanvasItem) -> void:
	# The bootlace, looped and knotted
	c.draw_arc(Vector2(0, -8), 13.0, PI * 0.9, PI * 2.1, 18, LEATHER_DARK, 2.0, true)
	c.draw_line(Vector2(-12, -5), Vector2(-1, 5), LEATHER_DARK, 2.0)
	c.draw_line(Vector2(12, -5), Vector2(1, 5), LEATHER_DARK, 2.0)
	c.draw_circle(Vector2(0, 5), 2.2, LEATHER_DARK)
	# The token
	c.draw_circle(Vector2(0, 13), 9.5, BRASS_DARK)
	c.draw_circle(Vector2(0, 13), 8.0, BRASS)
	c.draw_circle(Vector2(0, 7), 1.4, Color(0.1, 0.08, 0.06))
	_text(c, Vector2(-3.5, 18.5), "7", 11, Color(0.3, 0.2, 0.06))
	c.draw_arc(Vector2(0, 13), 6.5, PI * 1.1, PI * 1.5, 6, Color(1, 1, 1, 0.6), 1.0, true)


## A thin steel file, half unwrapped from its rag.
static func _draw_hidden_file(c: CanvasItem) -> void:
	# The file: a tang, then the long cut blade
	c.draw_colored_polygon(PackedVector2Array([Vector2(-6, -2.5), Vector2(25, -1.5), Vector2(26, 1.5), Vector2(-6, 2.5)]), STEEL_DARK)
	c.draw_line(Vector2(-5, -1.6), Vector2(25, -0.8), STEEL, 1.0)
	for i in range(10):
		c.draw_line(Vector2(-3 + i * 2.8, -2), Vector2(-1.6 + i * 2.8, 2), IRON, 0.6)
	# The rag wound round the handle end
	c.draw_colored_polygon(PackedVector2Array([Vector2(-26, -5), Vector2(-8, -7), Vector2(-3, -2), Vector2(-5, 6),
		Vector2(-18, 7), Vector2(-27, 3)]), Color(0.56, 0.54, 0.48))
	c.draw_line(Vector2(-22, -4), Vector2(-17, 6), Color(0.38, 0.36, 0.32), 1.0)
	c.draw_line(Vector2(-15, -5), Vector2(-10, 5), Color(0.38, 0.36, 0.32), 1.0)
	c.draw_line(Vector2(-8, -6), Vector2(-5, 3), Color(0.38, 0.36, 0.32), 1.0)


## A piece of slate scratched with rows of day marks. The last visit is ringed: 05-10.
static func _draw_scratched_calendar(c: CanvasItem) -> void:
	c.draw_colored_polygon(PackedVector2Array([Vector2(-27, -20), Vector2(20, -22), Vector2(27, -14), Vector2(26, 21),
		Vector2(-20, 22), Vector2(-28, 12)]), SLATE)
	c.draw_polyline(PackedVector2Array([Vector2(-27, -20), Vector2(20, -22), Vector2(27, -14)]), Color(0.36, 0.4, 0.45), 1.0)
	# Two rows of tally marks, in fives
	for row in range(2):
		for group in range(4):
			var x := -23.0 + group * 12.0
			var y := -17.0 + row * 8.0
			for mark in range(4):
				c.draw_line(Vector2(x + mark * 2.0, y), Vector2(x + mark * 2.0, y + 5.5), CHALK, 0.8)
			c.draw_line(Vector2(x - 1, y + 4.5), Vector2(x + 7, y + 1), CHALK, 0.8)
	# The doctor's last visit, ringed
	_text(c, Vector2(-17, 13), "05-10", 12, Color(1, 1, 1))
	for i in range(24):
		var a := TAU * i / 24.0
		var b := TAU * (i + 1) / 24.0
		c.draw_line(Vector2(-1 + cos(a) * 20.0, 8.5 + sin(a) * 8.5), Vector2(-1 + cos(b) * 20.0, 8.5 + sin(b) * 8.5), RED, 1.4)


## A red-painted key on a loop of string.
static func _draw_fire_bell_key(c: CanvasItem) -> void:
	# The string
	c.draw_arc(Vector2(-16, -4), 8.0, PI * 0.6, PI * 2.2, 14, Color(0.82, 0.78, 0.66), 1.2, true)
	PlaceholderArt.draw_ellipse(c, Vector2(2, 12), 20, 1.5, SHADOW)
	# The key
	c.draw_circle(Vector2(-12, 3), 7.0, RED)
	c.draw_circle(Vector2(-12, 3), 3.2, Color(0.1, 0.08, 0.08))
	c.draw_rect(Rect2(-6, 1, 30, 4), RED)
	c.draw_line(Vector2(-5, 1.8), Vector2(23, 1.8), Color(1.0, 0.5, 0.45), 0.8)
	c.draw_rect(Rect2(14, 5, 4, 7), RED)
	c.draw_rect(Rect2(20, 5, 4, 5), RED)
	# Paint chipped off at the bit
	c.draw_rect(Rect2(20, 8, 4, 2), STEEL)


## A red wooden yo-yo with a knotted string; T.H. is scratched on it.
static func _draw_wooden_yoyo(c: CanvasItem) -> void:
	# The string up to a finger loop
	c.draw_polyline(PackedVector2Array([Vector2(0, -4), Vector2(3, -12), Vector2(-1, -16)]), LINEN, 1.0, true)
	c.draw_arc(Vector2(-1, -19.5), 3.0, 0.0, TAU, 12, LINEN, 1.0, true)
	c.draw_circle(Vector2(2, -12), 1.2, LINEN)
	PlaceholderArt.draw_ellipse(c, Vector2(0, 21), 13, 1.5, SHADOW)
	c.draw_circle(Vector2(0, 7), 14.0, RED_DARK)
	c.draw_circle(Vector2(0, 7), 12.5, RED)
	c.draw_arc(Vector2(0, 7), 9.0, PI * 1.1, PI * 1.6, 8, Color(1.0, 0.6, 0.5, 0.8), 1.2, true)
	_text(c, Vector2(-8.5, 10.5), "T.H.", 8, Color(0.98, 0.9, 0.8))


## A little bone case with a silver thimble beside its open lid.
static func _draw_thimble_case(c: CanvasItem) -> void:
	var bone := Color(0.9, 0.86, 0.74)
	PlaceholderArt.draw_ellipse(c, Vector2(0, 14), 19, 1.8, SHADOW)
	# The barrel of the case and its lid, tipped open
	c.draw_rect(Rect2(-20, -3, 24, 16), bone)
	c.draw_rect(Rect2(-20, 8, 24, 5), bone.darkened(0.2))
	c.draw_line(Vector2(-20, 2), Vector2(4, 2), bone.darkened(0.3), 0.8)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-20, -3), Vector2(-16, -15), Vector2(6, -13), Vector2(4, -3)]), bone.darkened(0.1))
	c.draw_colored_polygon(PackedVector2Array([Vector2(-17, -5), Vector2(-14.5, -12.5), Vector2(3, -11), Vector2(2, -5)]), Color(0.4, 0.14, 0.2))
	# The thimble
	c.draw_colored_polygon(PackedVector2Array([Vector2(9, 13), Vector2(11, 0), Vector2(17, 0), Vector2(20, 13)]), SILVER)
	PlaceholderArt.draw_ellipse(c, Vector2(14, 0), 3, 1.5, STEEL)
	c.draw_line(Vector2(9, 11), Vector2(20, 11), STEEL_DARK, 1.2)
	for i in range(3):
		c.draw_circle(Vector2(12 + i * 2.2, 4), 0.6, STEEL_DARK)
		c.draw_circle(Vector2(11.5 + i * 2.6, 7.5), 0.6, STEEL_DARK)


## Wire-framed reading glasses lying on their worn case.
static func _draw_reading_glasses(c: CanvasItem) -> void:
	# The case
	var box := StyleBoxFlat.new()
	box.bg_color = LEATHER_DARK
	box.set_corner_radius_all(7)
	c.draw_style_box(box, Rect2(-25, -3, 50, 16))
	c.draw_line(Vector2(-20, 1), Vector2(20, 1), LEATHER, 1.0)
	# The glasses
	for lens_x: float in [-11.0, 11.0]:
		c.draw_circle(Vector2(lens_x, -4), 8.0, Color(0.8, 0.9, 0.95, 0.35))
		c.draw_arc(Vector2(lens_x, -4), 8.0, 0.0, TAU, 20, BRASS, 1.3, true)
		c.draw_line(Vector2(lens_x - 4, -8), Vector2(lens_x - 1, -10), Color(1, 1, 1, 0.8), 1.0)
	c.draw_arc(Vector2(0, -4), 3.0, PI, TAU, 6, BRASS, 1.3, true)
	c.draw_line(Vector2(-19, -4), Vector2(-26, -8), BRASS, 1.2)
	c.draw_line(Vector2(19, -4), Vector2(26, -8), BRASS, 1.2)


## A tortoiseshell hair slide, with one long fair hair still caught in it.
static func _draw_hair_slide(c: CanvasItem) -> void:
	var shell := Color(0.5, 0.28, 0.1)
	var box := StyleBoxFlat.new()
	box.bg_color = shell
	box.set_corner_radius_all(5)
	c.draw_style_box(box, Rect2(-21, -5, 42, 10))
	# Mottling
	for blot: Vector2 in [Vector2(-14, -1), Vector2(-4, 2), Vector2(6, -2), Vector2(15, 1)]:
		PlaceholderArt.draw_ellipse(c, blot, 3.5, 2, Color(0.2, 0.1, 0.04))
	c.draw_line(Vector2(-18, -3.5), Vector2(18, -3.5), Color(1.0, 0.8, 0.5, 0.6), 0.9)
	# The steel pin behind it and the fair hair
	c.draw_line(Vector2(-23, 6), Vector2(23, 6), STEEL, 1.2)
	c.draw_polyline(PackedVector2Array([Vector2(-8, 0), Vector2(2, -7), Vector2(14, -8), Vector2(23, -5)]), Color(0.95, 0.85, 0.5), 0.9, true)


## A small dented mouth organ.
static func _draw_harmonica(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 10), 24, 1.8, SHADOW)
	c.draw_rect(Rect2(-24, -8, 48, 16), STEEL_DARK)
	c.draw_rect(Rect2(-25, -9, 50, 7), SILVER)
	c.draw_rect(Rect2(-25, 3, 50, 6), STEEL)
	# The row of holes in the wooden comb
	c.draw_rect(Rect2(-22, -2, 44, 5), Color(0.5, 0.3, 0.16))
	for i in range(10):
		c.draw_rect(Rect2(-21 + i * 4.4, -1.5, 2.6, 4), Color(0.08, 0.06, 0.05))
	c.draw_line(Vector2(-24, -8), Vector2(24, -8), Color(1, 1, 1, 0.8), 0.8)
	# The dent
	c.draw_arc(Vector2(10, -7), 4.0, 0.3, PI - 0.3, 6, STEEL_DARK, 1.0, true)


## A small black prayer book with a ribbon marker.
static func _draw_prayer_book(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-14, -20, 32, 44), SHADOW)
	c.draw_rect(Rect2(-16, -20, 30, 42), PAPER_DARK)
	c.draw_rect(Rect2(-17, -23, 31, 43), Color(0.09, 0.09, 0.11))
	c.draw_rect(Rect2(-17, -23, 4, 43), Color(0.18, 0.18, 0.2))
	# A gilt cross on the cover
	c.draw_rect(Rect2(-2.5, -15, 3, 20), BRASS)
	c.draw_rect(Rect2(-8, -10, 14, 3), BRASS)
	# The ribbon hanging out of the bottom
	c.draw_colored_polygon(PackedVector2Array([Vector2(3, 20), Vector2(7, 20), Vector2(8, 24), Vector2(5.5, 22.5), Vector2(3.5, 24)]),
		Color(0.6, 0.12, 0.2))


## A rabbit sewn from a grey smock, with button eyes.
static func _draw_cloth_rabbit(c: CanvasItem) -> void:
	var seam := Color(0.36, 0.37, 0.4)
	# Long ears, one flopped over
	PlaceholderArt.draw_ellipse(c, Vector2(-5, -19), 3.5, 8, SMOCK)
	c.draw_colored_polygon(PackedVector2Array([Vector2(2, -13), Vector2(6, -22), Vector2(14, -20), Vector2(13, -16), Vector2(8, -17), Vector2(7, -12)]), SMOCK)
	PlaceholderArt.draw_ellipse(c, Vector2(-5, -19), 1.5, 5.5, SMOCK.lightened(0.2))
	# Body, limbs and head
	PlaceholderArt.draw_ellipse(c, Vector2(0, 11), 11, 13, SMOCK)
	for side: float in [-1.0, 1.0]:
		PlaceholderArt.draw_ellipse(c, Vector2(side * 12, 6), 4, 7, SMOCK.darkened(0.1))
		PlaceholderArt.draw_ellipse(c, Vector2(side * 7, 23), 5, 3.5, SMOCK.darkened(0.1))
	c.draw_circle(Vector2(0, -5), 9.0, SMOCK)
	# Button eyes, a stitched nose and the seam down the front
	c.draw_circle(Vector2(-3.5, -6), 2.0, Color(0.1, 0.1, 0.12))
	c.draw_circle(Vector2(3.5, -6), 2.0, Color(0.3, 0.16, 0.08))
	c.draw_circle(Vector2(-3.5, -6), 0.6, LINEN)
	c.draw_line(Vector2(-1.5, -1.5), Vector2(1.5, -1.5), RED_DARK, 1.2)
	for i in range(5):
		c.draw_line(Vector2(-1.5, 3 + i * 4.0), Vector2(1.5, 4.5 + i * 4.0), seam, 0.9)


## A shaded oil lamp, turned very low.
static func _draw_night_lamp(c: CanvasItem) -> void:
	# The glow of the low flame
	for ring in range(3):
		c.draw_circle(Vector2(0, -6), 15.0 - ring * 4.0, Color(1.0, 0.8, 0.4, 0.08))
	# Brass base and oil font
	c.draw_rect(Rect2(-11, 20, 22, 4), BRASS_DARK)
	PlaceholderArt.draw_ellipse(c, Vector2(0, 14), 10, 7, BRASS)
	c.draw_rect(Rect2(-4, 3, 8, 6), BRASS_DARK)
	c.draw_line(Vector2(-6, 11), Vector2(-3, 9), Color(1, 1, 1, 0.6), 1.0)
	c.draw_circle(Vector2(8, 5), 2.0, BRASS)  # the wick wheel
	# Glass chimney with a small flame
	c.draw_rect(Rect2(-3, -22, 6, 26), Color(0.9, 0.95, 1.0, 0.3))
	PlaceholderArt.draw_ellipse(c, Vector2(0, 0), 1.6, 3, Color(1.0, 0.85, 0.4))
	# The green shade
	c.draw_colored_polygon(PackedVector2Array([Vector2(-6, -17), Vector2(6, -17), Vector2(15, -3), Vector2(-15, -3)]), Color(0.12, 0.34, 0.24))
	c.draw_line(Vector2(-15, -3), Vector2(15, -3), Color(1.0, 0.85, 0.5), 1.5)
	c.draw_line(Vector2(-5, -15), Vector2(-11, -5), Color(1, 1, 1, 0.2), 1.5)


## A clipboard chart from the foot of bed No. 1, with a child's pencil writing under the print.
static func _draw_bed_chart(c: CanvasItem) -> void:
	c.draw_line(Vector2(0, -25), Vector2(0, -20), Color(0.7, 0.66, 0.56), 1.0)  # string
	c.draw_rect(Rect2(-17, -21, 35, 46), Color(0.36, 0.26, 0.16))
	c.draw_rect(Rect2(-15, -17, 31, 40), PAPER)
	c.draw_rect(Rect2(-7, -23, 14, 6), STEEL)
	c.draw_circle(Vector2(0, -20), 1.3, IRON)
	_text(c, Vector2(-13, -8), "No. 1", 8, INK)
	c.draw_line(Vector2(-13, -5), Vector2(14, -5), INK, 0.8)
	# The temperature graph
	c.draw_polyline(PackedVector2Array([Vector2(-12, 3), Vector2(-7, -1), Vector2(-2, 4), Vector2(3, 0), Vector2(8, 5), Vector2(13, 1)]), RED, 0.9, true)
	c.draw_line(Vector2(-13, 8), Vector2(14, 8), Color(0.5, 0.5, 0.6), 0.6)
	# In a child's pencil
	_text(c, Vector2(-13, 15), "MY NAME", 5, PENCIL)
	_text(c, Vector2(-13, 21), "IS TOBY", 5, PENCIL)


## A pair of grey felt slippers, worn through at the toe.
static func _draw_ward_slippers(c: CanvasItem) -> void:
	var felt := Color(0.5, 0.47, 0.44)
	PlaceholderArt.draw_ellipse(c, Vector2(0, 10), 24, 2, SHADOW)
	for pair in range(2):
		var at := Vector2(-11 + pair * 20.0, -2 + pair * 4.0)
		# Sole, upper and the dark opening for the foot
		PlaceholderArt.draw_ellipse(c, at + Vector2(0, 5), 14, 4, felt.darkened(0.4))
		PlaceholderArt.draw_ellipse(c, at, 14, 7, felt)
		PlaceholderArt.draw_ellipse(c, at + Vector2(-5, -1), 7, 4, Color(0.14, 0.12, 0.11))
		# The hole worn in the toe
		c.draw_circle(at + Vector2(9, 1), 2.0, Color(0.1, 0.09, 0.08))
		c.draw_line(at + Vector2(3, -5), at + Vector2(4, 5), felt.darkened(0.25), 0.8)


## A red bucket of sand hanging by its handle.
static func _draw_fire_bucket(c: CanvasItem) -> void:
	# Wire handle up to the hook
	c.draw_arc(Vector2(0, -6), 16.0, PI, TAU, 16, IRON, 1.6, true)
	# Sand heaped in the top, and a corner of hidden paper
	PlaceholderArt.draw_ellipse(c, Vector2(0, -6), 17, 4.5, Color(0.84, 0.74, 0.5))
	c.draw_colored_polygon(PackedVector2Array([Vector2(3, -7), Vector2(8, -12), Vector2(11, -7)]), PAPER)
	# The bucket
	c.draw_colored_polygon(PackedVector2Array([Vector2(-18, -6), Vector2(18, -6), Vector2(13, 22), Vector2(-13, 22)]), RED)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-18, -6), Vector2(-11, -6), Vector2(-8, 22), Vector2(-13, 22)]), RED_DARK)
	c.draw_line(Vector2(-18, -6), Vector2(18, -6), Color(1.0, 0.45, 0.4), 1.5)
	c.draw_line(Vector2(-14, 18), Vector2(14, 18), RED_DARK, 1.2)
	_text(c, Vector2(-8.5, 11), "FIRE", 8, Color(0.98, 0.95, 0.88))


## A buckled leather strap, lined with felt.
static func _draw_restraint_strap(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 9), 26, 1.5, SHADOW)
	c.draw_rect(Rect2(-27, -5, 46, 10), LEATHER)
	c.draw_rect(Rect2(-27, 2, 46, 4), Color(0.5, 0.52, 0.5))  # the felt lining
	c.draw_line(Vector2(-26, -3.5), Vector2(18, -3.5), LEATHER_DARK, 0.7)
	# Punched holes
	for i in range(5):
		c.draw_circle(Vector2(-22 + i * 6.0, -1), 1.1, Color(0.08, 0.05, 0.03))
	# The buckle and its tongue
	c.draw_rect(Rect2(15, -9, 12, 18), STEEL, false, 2.2)
	c.draw_line(Vector2(15, 0), Vector2(26, 0), STEEL, 1.5)
	# The bed number stamped on the end
	_text(c, Vector2(4, 1), "1", 7, PAPER)


## A tin tray of seven small numbered cups.
static func _draw_dose_tray(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 11), 27, 1.5, SHADOW)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-28, 3), Vector2(28, 3), Vector2(25, 10), Vector2(-25, 10)]), STEEL_DARK)
	c.draw_line(Vector2(-28, 3), Vector2(28, 3), SILVER, 1.2)
	# Seven cups of dark draught
	for i in range(7):
		var x := -22.5 + i * 7.5
		c.draw_colored_polygon(PackedVector2Array([Vector2(x - 3, -6), Vector2(x + 3, -6), Vector2(x + 2.2, 3), Vector2(x - 2.2, 3)]),
			Color(0.9, 0.92, 0.95, 0.75))
		c.draw_rect(Rect2(x - 2.4, -3, 4.8, 6), Color(0.36, 0.16, 0.2))
		_text(c, Vector2(x - 1.4, -7), str(i + 1), 4, PAPER)


## An iron window bar, filed nearly through at one end.
static func _draw_window_bar(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 6), 26, 1.5, SHADOW)
	c.draw_rect(Rect2(-28, -3, 56, 6), IRON)
	c.draw_line(Vector2(-27, -1.8), Vector2(27, -1.8), Color(0.42, 0.42, 0.46), 1.0)
	# Rust
	for blot: Vector2 in [Vector2(-18, 1), Vector2(-4, 0), Vector2(8, 1.5)]:
		PlaceholderArt.draw_ellipse(c, blot, 3, 1.3, Color(0.45, 0.22, 0.1, 0.8))
	# The bright filed notch
	c.draw_colored_polygon(PackedVector2Array([Vector2(18, -3), Vector2(23, -3), Vector2(20.5, 2)]), SILVER)
	c.draw_line(Vector2(20.5, 2), Vector2(20.5, 3), STEEL_DARK, 0.8)


## Seven sealed envelopes tied round with tape.
static func _draw_seven_envelopes(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-22, -13, 48, 32), SHADOW)
	# The edges of the stack, then the top envelope
	for i in range(6):
		c.draw_rect(Rect2(-25 + i * 0.6, -13 + i * 1.6, 46, 26), PAPER_DARK if i % 2 == 0 else PAPER)
	c.draw_rect(Rect2(-22, -19, 46, 28), PAPER)
	c.draw_polyline(PackedVector2Array([Vector2(-22, -19), Vector2(1, -4), Vector2(24, -19)]), PAPER_DARK, 1.0)
	_text(c, Vector2(-19, 5), "Tobias Hale", 5, INK)
	# Pink legal tape, tied in a bow
	c.draw_rect(Rect2(-1, -19, 4, 36), Color(0.8, 0.4, 0.46))
	c.draw_rect(Rect2(-25, -7, 49, 3.5), Color(0.8, 0.4, 0.46))
	c.draw_circle(Vector2(1, -5.5), 2.5, Color(0.62, 0.26, 0.32))
	# A red wax seal
	c.draw_circle(Vector2(16, 3), 3.5, RED_DARK)


## The brass pull of the fire bell, on a short length of chain.
static func _draw_alarm_handle(c: CanvasItem) -> void:
	# Chain
	for i in range(4):
		PlaceholderArt.draw_ellipse(c, Vector2(0, -24 + i * 5.0), 2, 3, STEEL_DARK)
		PlaceholderArt.draw_ellipse(c, Vector2(0, -24 + i * 5.0), 0.8, 1.6, Color(0.08, 0.08, 0.1))
	# The stem and the D-shaped grip
	c.draw_rect(Rect2(-2.5, -8, 5, 12), BRASS_DARK)
	c.draw_arc(Vector2(0, 12), 11.0, 0.0, TAU, 24, BRASS_DARK, 6.5, true)
	c.draw_arc(Vector2(0, 12), 11.0, 0.0, TAU, 24, BRASS, 4.0, true)
	c.draw_arc(Vector2(0, 12), 12.0, PI * 1.1, PI * 1.6, 8, Color(1, 1, 1, 0.7), 1.0, true)
	# A red enamel collar: PULL
	c.draw_rect(Rect2(-7, -6, 14, 7), RED)
	_text(c, Vector2(-6, -0.5), "PULL", 5, Color(1, 1, 1))
