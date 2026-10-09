@tool
class_name StudyObjects
extends RefCounted
## Placeholder drawings for the hidden objects of Chapter Eight (The Study).
## Same rules as placeholder_art.gd: every drawing is centred on (0, 0) and
## fits inside get_size(). PlaceholderArt calls these functions.

const GOLD := Color(0.82, 0.66, 0.32)
const GOLD_DARK := Color(0.55, 0.42, 0.18)
const SILVER := Color(0.8, 0.82, 0.86)
const SILVER_DARK := Color(0.5, 0.52, 0.56)
const PAPER := Color(0.88, 0.83, 0.7)
const SHADOW := Color(0, 0, 0, 0.35)


## Size of the drawing, or Vector2.ZERO if `style` is not one of this chapter's objects.
static func get_size(style: int) -> Vector2:
	match style:
		HiddenObjectData.PlaceholderStyle.FORGED_PAGE:
			return Vector2(46, 56)
		HiddenObjectData.PlaceholderStyle.FOUNTAIN_PEN:
			return Vector2(58, 14)
		HiddenObjectData.PlaceholderStyle.MAGNIFIER:
			return Vector2(54, 32)
		HiddenObjectData.PlaceholderStyle.SIGNET_RING:
			return Vector2(26, 26)
		HiddenObjectData.PlaceholderStyle.CALENDAR:
			return Vector2(46, 54)
		HiddenObjectData.PlaceholderStyle.LETTER_OPENER:
			return Vector2(60, 14)
		HiddenObjectData.PlaceholderStyle.BOATHOUSE_KEY:
			return Vector2(54, 32)
		HiddenObjectData.PlaceholderStyle.WILL_SCROLL:
			return Vector2(56, 34)
		HiddenObjectData.PlaceholderStyle.PORTRAIT:
			return Vector2(54, 40)
	return Vector2.ZERO


## Draws `style` and returns true, or returns false if it is not one of this chapter's objects.
static func draw(c: CanvasItem, style: int) -> bool:
	match style:
		HiddenObjectData.PlaceholderStyle.FORGED_PAGE:
			_draw_forged_page(c)
		HiddenObjectData.PlaceholderStyle.FOUNTAIN_PEN:
			_draw_fountain_pen(c)
		HiddenObjectData.PlaceholderStyle.MAGNIFIER:
			_draw_magnifier(c)
		HiddenObjectData.PlaceholderStyle.SIGNET_RING:
			_draw_signet_ring(c)
		HiddenObjectData.PlaceholderStyle.CALENDAR:
			_draw_calendar(c)
		HiddenObjectData.PlaceholderStyle.LETTER_OPENER:
			_draw_letter_opener(c)
		HiddenObjectData.PlaceholderStyle.BOATHOUSE_KEY:
			_draw_boathouse_key(c)
		HiddenObjectData.PlaceholderStyle.WILL_SCROLL:
			_draw_will_scroll(c)
		HiddenObjectData.PlaceholderStyle.PORTRAIT:
			_draw_portrait(c)
		_:
			return false
	return true


## A page covered in rows of practice signatures, one row crossed out.
static func _draw_forged_page(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-19, -24, 42, 52), SHADOW)
	c.draw_rect(Rect2(-22, -27, 42, 52), PAPER)
	c.draw_line(Vector2(-22, -27), Vector2(20, -27), Color(1, 1, 1, 0.4), 1.0)
	# Faint ruled lines and seven wobbly copies of the same signature
	for i in range(7):
		var y := -20.0 + i * 6.5
		c.draw_line(Vector2(-19, y + 2), Vector2(17, y + 2), Color(0.55, 0.62, 0.75, 0.35), 1.0)
		var wobble := (i % 3) * 0.8
		c.draw_polyline(PackedVector2Array([Vector2(-17, y + 1), Vector2(-14, y - 3 + wobble), Vector2(-12, y + 1),
			Vector2(-9, y - 1), Vector2(-6, y + 1), Vector2(-3, y - 2), Vector2(0, y + 1),
			Vector2(4, y - 1 - wobble), Vector2(8, y + 1), Vector2(13.0 - i % 2 * 3.0, y - 1)]),
			Color(PlaceholderArt.INK, 0.9), 1.1)
	# One attempt angrily scribbled out
	c.draw_line(Vector2(-18, 0), Vector2(14, -6), Color(0.6, 0.12, 0.1, 0.85), 1.4)
	# Ink blot in the corner
	c.draw_circle(Vector2(14, 20), 2.5, Color(PlaceholderArt.INK, 0.8))


## A black fountain pen with a gold nib, band and clip.
static func _draw_fountain_pen(c: CanvasItem) -> void:
	var black := Color(0.08, 0.08, 0.1)
	PlaceholderArt.draw_ellipse(c, Vector2(2, 5), 27, 2.5, SHADOW)
	# Gold nib on the left
	c.draw_colored_polygon(PackedVector2Array([Vector2(-28, 0), Vector2(-18, -3.5), Vector2(-18, 3.5)]), GOLD)
	c.draw_line(Vector2(-27, 0), Vector2(-19, 0), GOLD_DARK, 0.8)
	c.draw_rect(Rect2(-18, -4, 5, 8), Color(0.16, 0.16, 0.18))
	# Barrel and cap
	c.draw_rect(Rect2(-13, -4.5, 22, 9), black)
	c.draw_rect(Rect2(9, -5, 15, 10), black)
	c.draw_circle(Vector2(24, 0), 5, black)
	c.draw_rect(Rect2(8, -5, 3, 10), GOLD)
	# Clip and a highlight along the top
	c.draw_line(Vector2(13, -3), Vector2(24, -3), GOLD, 1.6)
	c.draw_line(Vector2(-12, -2.5), Vector2(23, -2.5), Color(1, 1, 1, 0.22), 1.0)


## A brass magnifying glass with a dark wooden handle.
static func _draw_magnifier(c: CanvasItem) -> void:
	var lens_center := Vector2(-11, -1)
	PlaceholderArt.draw_ellipse(c, Vector2(0, 13), 25, 3, SHADOW)
	# Handle first, so the rim sits on top of it
	c.draw_line(Vector2(2, 4), Vector2(25, 11), Color(0.3, 0.17, 0.1), 6.0)
	c.draw_line(Vector2(2, 3), Vector2(25, 10), Color(0.48, 0.3, 0.18), 1.5)
	c.draw_line(Vector2(1, 3.5), Vector2(5, 5), GOLD_DARK, 5.0)
	# Glass and rim
	c.draw_circle(lens_center, 13.5, GOLD_DARK)
	c.draw_circle(lens_center, 12, GOLD)
	c.draw_circle(lens_center, 9.5, Color(0.62, 0.72, 0.76))
	c.draw_circle(lens_center + Vector2(1, 1), 7, Color(0.5, 0.6, 0.66))
	c.draw_arc(lens_center, 7, PI * 1.05, PI * 1.5, 8, Color(1, 1, 1, 0.75), 2.0, true)


## A heavy gold signet ring with "TG" on its flat face.
static func _draw_signet_ring(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(1, 10), 11, 2.5, SHADOW)
	# Band seen at an angle
	c.draw_arc(Vector2(0, 3), 8, 0, TAU, 20, GOLD_DARK, 4.0, true)
	c.draw_arc(Vector2(0, 3), 8, PI * 0.15, PI * 0.85, 10, GOLD, 2.5, true)
	# Flat oval face on top
	PlaceholderArt.draw_ellipse(c, Vector2(0, -5), 8, 6, GOLD_DARK)
	PlaceholderArt.draw_ellipse(c, Vector2(0, -6), 7, 5, GOLD)
	PlaceholderArt.draw_ellipse(c, Vector2(0, -6), 5, 3.5, Color(0.68, 0.52, 0.24))
	# Tiny engraved letters
	var engrave := Color(0.35, 0.25, 0.1)
	c.draw_line(Vector2(-4, -8), Vector2(-1, -8), engrave, 1.0)
	c.draw_line(Vector2(-2.5, -8), Vector2(-2.5, -4), engrave, 1.0)
	c.draw_arc(Vector2(2.5, -6), 2, PI * 0.1, PI * 1.8, 6, engrave, 1.0)
	c.draw_arc(Vector2(-1, -8), 5, PI * 1.2, PI * 1.5, 4, Color(1, 1, 1, 0.7), 1.2, true)


## A torn-off wall calendar page: April, with the 17th circled in red.
static func _draw_calendar(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-19, -23, 42, 50), SHADOW)
	c.draw_rect(Rect2(-22, -26, 42, 50), Color(0.93, 0.91, 0.85))
	# Torn binding holes along the top
	for i in range(6):
		c.draw_circle(Vector2(-18 + i * 7, -24), 1.3, Color(0.3, 0.25, 0.2))
	# Red month banner reading "APRIL"
	c.draw_rect(Rect2(-22, -21, 42, 9), Color(0.62, 0.16, 0.14))
	c.draw_string(ThemeDB.fallback_font, Vector2(-14, -13.5), "APRIL", HORIZONTAL_ALIGNMENT_LEFT, -1, 8, Color(0.97, 0.93, 0.85))
	# Grid of days
	var grid := Color(0.55, 0.52, 0.48)
	for row in range(5):
		for column in range(7):
			var cell := Vector2(-20 + column * 5.6, -9 + row * 6.4)
			c.draw_rect(Rect2(cell, Vector2(3.6, 3.2)), Color(grid, 0.6))
	# The 17th (third row, fifth day) circled in red ink
	var circled := Vector2(-20 + 4 * 5.6 + 1.8, -9 + 2 * 6.4 + 1.6)
	c.draw_arc(circled, 4.6, 0, TAU, 14, Color(0.85, 0.1, 0.08), 1.6, true)
	c.draw_line(circled + Vector2(3, -4), circled + Vector2(6, -6), Color(0.85, 0.1, 0.08), 1.2)


## A silver letter opener: long thin blade, ornate handle.
static func _draw_letter_opener(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(1, 5), 28, 2.5, SHADOW)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-29, 0), Vector2(6, -3), Vector2(6, 3)]), SILVER)
	c.draw_line(Vector2(-27, 0), Vector2(5, -1), Color(1, 1, 1, 0.75), 1.0)
	c.draw_line(Vector2(-27, 0.5), Vector2(5, 2.5), SILVER_DARK, 1.0)
	# Cross-guard and handle with a round pommel
	c.draw_rect(Rect2(6, -5.5, 3, 11), SILVER_DARK)
	c.draw_rect(Rect2(9, -3, 15, 6), SILVER)
	for ring_x: float in [12.0, 16.0, 20.0]:
		c.draw_line(Vector2(ring_x, -3), Vector2(ring_x, 3), SILVER_DARK, 1.0)
	c.draw_circle(Vector2(25.5, 0), 3.5, SILVER)
	c.draw_circle(Vector2(25, -1), 1.2, Color(1, 1, 1, 0.8))


## A heavy iron key with a paper tag reading "Boathouse".
static func _draw_boathouse_key(c: CanvasItem) -> void:
	var iron := Color(0.36, 0.36, 0.38)
	var iron_dark := Color(0.2, 0.2, 0.22)
	PlaceholderArt.draw_ellipse(c, Vector2(0, 13), 25, 3, SHADOW)
	# Bow (ring), long shaft and a chunky bit
	c.draw_arc(Vector2(-17, 3), 7, 0, TAU, 18, iron_dark, 5.0, true)
	c.draw_arc(Vector2(-17, 3), 7, PI * 1.1, PI * 1.6, 6, Color(0.6, 0.6, 0.62), 1.5, true)
	c.draw_rect(Rect2(-10, 1, 30, 4.5), iron)
	c.draw_line(Vector2(-10, 1.5), Vector2(20, 1.5), Color(0.6, 0.6, 0.62), 1.0)
	c.draw_rect(Rect2(13, 5, 5, 7), iron)
	c.draw_rect(Rect2(19, 5, 3, 5), iron)
	# String and a brown luggage tag
	c.draw_polyline(PackedVector2Array([Vector2(-17, -4), Vector2(-11, -9), Vector2(-4, -10)]), Color(0.8, 0.75, 0.6), 1.0)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-4, -14), Vector2(18, -14), Vector2(22, -10),
		Vector2(18, -6), Vector2(-4, -6)]), Color(0.78, 0.66, 0.45))
	c.draw_circle(Vector2(-1.5, -10), 1.3, Color(0.3, 0.22, 0.14))
	c.draw_line(Vector2(2, -10), Vector2(16, -10), Color(PlaceholderArt.INK, 0.9), 1.2)


## The real will: a rolled parchment tied with a red ribbon and a wax seal.
static func _draw_will_scroll(c: CanvasItem) -> void:
	var parchment := Color(0.86, 0.78, 0.58)
	var parchment_dark := Color(0.66, 0.57, 0.4)
	PlaceholderArt.draw_ellipse(c, Vector2(2, 13), 27, 4, SHADOW)
	c.draw_rect(Rect2(-22, -9, 44, 18), parchment)
	c.draw_rect(Rect2(-22, 4, 44, 5), parchment_dark)
	c.draw_line(Vector2(-22, -6), Vector2(22, -6), Color(1, 1, 1, 0.35), 1.5)
	# Rolled ends
	PlaceholderArt.draw_ellipse(c, Vector2(-22, 0), 4, 9, parchment_dark)
	PlaceholderArt.draw_ellipse(c, Vector2(22, 0), 4, 9, parchment)
	c.draw_arc(Vector2(22, 0), 2.5, 0, TAU, 10, parchment_dark, 1.0)
	# Red ribbon with trailing ends, and a wax seal
	c.draw_rect(Rect2(-3, -9, 6, 18), Color(0.7, 0.12, 0.14))
	c.draw_line(Vector2(0, 8), Vector2(-7, 16), Color(0.7, 0.12, 0.14), 3.0)
	c.draw_line(Vector2(1, 8), Vector2(7, 16), Color(0.7, 0.12, 0.14), 3.0)
	c.draw_circle(Vector2(0, 0), 5, Color(0.48, 0.1, 0.1))
	c.draw_circle(Vector2(-1, -1), 2, Color(0.68, 0.25, 0.22))


## A small oil portrait of a girl, half unrolled from its canvas roll.
static func _draw_portrait(c: CanvasItem) -> void:
	var canvas_back := Color(0.78, 0.72, 0.6)
	c.draw_rect(Rect2(-22, -15, 44, 36), SHADOW)
	# The painted, flattened part
	c.draw_rect(Rect2(-26, -19, 38, 36), Color(0.2, 0.17, 0.14))
	c.draw_rect(Rect2(-24, -17, 34, 32), Color(0.24, 0.3, 0.27))
	# Girl: dark hair, pale face, blue dress
	PlaceholderArt.draw_ellipse(c, Vector2(-7, -2), 9, 11, Color(0.3, 0.2, 0.12))
	PlaceholderArt.draw_ellipse(c, Vector2(-7, -2), 6, 7.5, Color(0.9, 0.76, 0.64))
	c.draw_colored_polygon(PackedVector2Array([Vector2(-17, 15), Vector2(-12, 7), Vector2(-2, 7), Vector2(3, 15)]),
		Color(0.32, 0.45, 0.7))
	c.draw_circle(Vector2(-9.5, -3), 1.0, Color(0.2, 0.15, 0.12))
	c.draw_circle(Vector2(-4.5, -3), 1.0, Color(0.2, 0.15, 0.12))
	c.draw_line(Vector2(-9, 1.5), Vector2(-5, 1.5), Color(0.7, 0.35, 0.32), 1.0)
	# Rolled-up right side
	c.draw_rect(Rect2(12, -19, 10, 36), canvas_back)
	PlaceholderArt.draw_ellipse(c, Vector2(22, -1), 4, 18, Color(0.62, 0.56, 0.44))
	c.draw_line(Vector2(13, -18), Vector2(13, 16), Color(0, 0, 0, 0.35), 1.5)
	c.draw_line(Vector2(17, -18), Vector2(17, 16), Color(1, 1, 1, 0.3), 1.5)
