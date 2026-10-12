@tool
class_name GateLodgeObjects
extends RefCounted
## Placeholder drawings for the hidden objects of House Three, Chapter One (The Gate Lodge).
## Same rules as placeholder_art.gd: every drawing is centred on (0, 0) and
## fits inside get_size(). PlaceholderArt calls these functions.

const BRASS := Color(0.8, 0.62, 0.3)
const BRASS_DARK := Color(0.52, 0.38, 0.16)
const BRASS_LIGHT := Color(0.95, 0.82, 0.5)
const STEEL := Color(0.7, 0.72, 0.75)
const STEEL_DARK := Color(0.42, 0.44, 0.47)
const PAPER := Color(0.92, 0.88, 0.76)
const PAPER_DARK := Color(0.74, 0.68, 0.54)
const INK := Color(0.16, 0.14, 0.2)
const RED_INK := Color(0.62, 0.12, 0.1)
const NAVY := Color(0.12, 0.15, 0.26)
const GLASS := Color(0.75, 0.88, 0.9, 0.45)
const GLASS_EDGE := Color(0.88, 0.96, 1.0, 0.8)
const SHADOW := Color(0, 0, 0, 0.35)

const SIZES := {
	HiddenObjectData.PlaceholderStyle.PORTERS_CAP: Vector2(48, 30),
	HiddenObjectData.PlaceholderStyle.HURRICANE_LAMP: Vector2(28, 50),
	HiddenObjectData.PlaceholderStyle.ENAMEL_MUG: Vector2(30, 26),
	HiddenObjectData.PlaceholderStyle.UNPOSTED_LETTERS: Vector2(46, 34),
	HiddenObjectData.PlaceholderStyle.VISITORS_PASS: Vector2(44, 30),
	HiddenObjectData.PlaceholderStyle.BRASS_WARD_TAG: Vector2(32, 36),
	HiddenObjectData.PlaceholderStyle.SNUFF_BOX: Vector2(36, 24),
	HiddenObjectData.PlaceholderStyle.NIGHT_ROUND_CARD: Vector2(36, 46),
	HiddenObjectData.PlaceholderStyle.DUTY_ROSTER: Vector2(50, 38),
	HiddenObjectData.PlaceholderStyle.ADMISSION_CARD: Vector2(46, 34),
	HiddenObjectData.PlaceholderStyle.WAGE_PACKET: Vector2(46, 30),
	HiddenObjectData.PlaceholderStyle.TOY_SOLDIER: Vector2(22, 46),
	HiddenObjectData.PlaceholderStyle.TRUNK_KEY: Vector2(42, 20),
	HiddenObjectData.PlaceholderStyle.VISITORS_BOOK: Vector2(52, 40),
	HiddenObjectData.PlaceholderStyle.WARD_DOOR_KEY: Vector2(56, 22),
	HiddenObjectData.PlaceholderStyle.PUSHED_NOTE: Vector2(46, 30),
	HiddenObjectData.PlaceholderStyle.SMELLING_SALTS: Vector2(20, 36),
}


## Size of the drawing, or Vector2.ZERO if `style` is not one of this chapter's objects.
static func get_size(style: int) -> Vector2:
	return SIZES.get(style, Vector2.ZERO)


## Draws `style` and returns true, or returns false if it is not one of this chapter's objects.
static func draw(c: CanvasItem, style: int) -> bool:
	match style:
		HiddenObjectData.PlaceholderStyle.PORTERS_CAP:
			_draw_porters_cap(c)
		HiddenObjectData.PlaceholderStyle.HURRICANE_LAMP:
			_draw_hurricane_lamp(c)
		HiddenObjectData.PlaceholderStyle.ENAMEL_MUG:
			_draw_enamel_mug(c)
		HiddenObjectData.PlaceholderStyle.UNPOSTED_LETTERS:
			_draw_unposted_letters(c)
		HiddenObjectData.PlaceholderStyle.VISITORS_PASS:
			_draw_visitors_pass(c)
		HiddenObjectData.PlaceholderStyle.BRASS_WARD_TAG:
			_draw_brass_ward_tag(c)
		HiddenObjectData.PlaceholderStyle.SNUFF_BOX:
			_draw_snuff_box(c)
		HiddenObjectData.PlaceholderStyle.NIGHT_ROUND_CARD:
			_draw_night_round_card(c)
		HiddenObjectData.PlaceholderStyle.DUTY_ROSTER:
			_draw_duty_roster(c)
		HiddenObjectData.PlaceholderStyle.ADMISSION_CARD:
			_draw_admission_card(c)
		HiddenObjectData.PlaceholderStyle.WAGE_PACKET:
			_draw_wage_packet(c)
		HiddenObjectData.PlaceholderStyle.TOY_SOLDIER:
			_draw_toy_soldier(c)
		HiddenObjectData.PlaceholderStyle.TRUNK_KEY:
			_draw_trunk_key(c)
		HiddenObjectData.PlaceholderStyle.VISITORS_BOOK:
			_draw_visitors_book(c)
		HiddenObjectData.PlaceholderStyle.WARD_DOOR_KEY:
			_draw_ward_door_key(c)
		HiddenObjectData.PlaceholderStyle.PUSHED_NOTE:
			_draw_pushed_note(c)
		HiddenObjectData.PlaceholderStyle.SMELLING_SALTS:
			_draw_smelling_salts(c)
		_:
			return false
	return true


## Small text helper (the built-in fallback font).
static func _text(c: CanvasItem, at: Vector2, text: String, font_size: int, color: Color) -> void:
	c.draw_string(ThemeDB.fallback_font, at, text, HORIZONTAL_ALIGNMENT_LEFT, -1, font_size, color)


## A few ruled lines of handwriting.
static func _lines(c: CanvasItem, at: Vector2, width: float, count: int, gap: float, color: Color) -> void:
	for i in range(count):
		var line_width := width if i % 3 != 2 else width * 0.6
		c.draw_line(at + Vector2(0, i * gap), at + Vector2(line_width, i * gap), color, 0.9)


## A navy peaked cap with a shiny peak and a brass badge.
static func _draw_porters_cap(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 13), 22, 3, SHADOW)
	PlaceholderArt.draw_ellipse(c, Vector2(-2, -6), 20, 8, NAVY)
	c.draw_rect(Rect2(-20, -6, 36, 12), NAVY.darkened(0.2))
	c.draw_rect(Rect2(-20, 2, 36, 4), Color(0.05, 0.06, 0.1))
	# The peak
	c.draw_colored_polygon(PackedVector2Array([Vector2(8, 4), Vector2(16, 4), Vector2(24, 11), Vector2(6, 10)]), Color(0.05, 0.05, 0.07))
	c.draw_line(Vector2(10, 6), Vector2(20, 9), Color(1, 1, 1, 0.4), 1.0)
	# Badge
	c.draw_circle(Vector2(2, -4), 5.0, BRASS)
	c.draw_circle(Vector2(2, -4), 3.0, BRASS_DARK)
	c.draw_circle(Vector2(1, -5), 1.0, BRASS_LIGHT)


## A paraffin hurricane lamp: a glass chimney in a wire cage, with a carrying loop.
static func _draw_hurricane_lamp(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 24), 12, 2.5, SHADOW)
	c.draw_arc(Vector2(0, -14), 9.0, PI, TAU, 12, STEEL_DARK, 1.5, true)
	c.draw_rect(Rect2(-5, -16, 10, 6), STEEL_DARK)
	# Glass chimney with a small flame
	c.draw_colored_polygon(PackedVector2Array([Vector2(-6, -10), Vector2(6, -10), Vector2(9, 2), Vector2(6, 12), Vector2(-6, 12), Vector2(-9, 2)]), GLASS)
	c.draw_colored_polygon(PackedVector2Array([Vector2(0, -2), Vector2(3, 6), Vector2(0, 10), Vector2(-3, 6)]), Color(1.0, 0.8, 0.35))
	c.draw_polyline(PackedVector2Array([Vector2(-6, -10), Vector2(-9, 2), Vector2(-6, 12), Vector2(6, 12), Vector2(9, 2), Vector2(6, -10)]), GLASS_EDGE, 1.0, true)
	# Wire guards and the tank
	c.draw_line(Vector2(-11, -8), Vector2(-11, 13), STEEL_DARK, 1.2)
	c.draw_line(Vector2(11, -8), Vector2(11, 13), STEEL_DARK, 1.2)
	c.draw_rect(Rect2(-11, 12, 22, 10), Color(0.2, 0.3, 0.42))
	c.draw_rect(Rect2(-12, 21, 24, 3), STEEL_DARK)
	c.draw_line(Vector2(-9, 14), Vector2(-9, 20), Color(1, 1, 1, 0.4), 1.0)


## A chipped white enamel mug with a blue rim.
static func _draw_enamel_mug(c: CanvasItem) -> void:
	var enamel := Color(0.92, 0.93, 0.9)
	PlaceholderArt.draw_ellipse(c, Vector2(-2, 12), 12, 2.5, SHADOW)
	c.draw_arc(Vector2(10, 1), 6.0, -PI * 0.5, PI * 0.5, 10, enamel, 3.0, true)
	c.draw_rect(Rect2(-12, -9, 22, 21), enamel)
	PlaceholderArt.draw_ellipse(c, Vector2(-1, -9), 11, 3, Color(0.3, 0.2, 0.12))
	c.draw_arc(Vector2(-1, -9), 11.0, 0.0, PI, 12, Color(0.15, 0.25, 0.5), 1.5, true)
	c.draw_rect(Rect2(-12, 10, 22, 2), Color(0.15, 0.25, 0.5))
	# Chips showing black iron underneath
	c.draw_circle(Vector2(-7, 4), 2.0, Color(0.1, 0.1, 0.12))
	c.draw_circle(Vector2(4, -3), 1.3, Color(0.1, 0.1, 0.12))
	c.draw_line(Vector2(-10, -6), Vector2(-10, 8), Color(1, 1, 1, 0.7), 1.0)


## A bundle of stamped letters tied crosswise with string.
static func _draw_unposted_letters(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-20, -12, 44, 30), SHADOW)
	for i in range(4):
		c.draw_rect(Rect2(-23 + i * 1.5, -17 + i * 3.0, 42, 24), PAPER_DARK if i % 2 == 0 else PAPER)
	c.draw_rect(Rect2(-18.5, -8, 42, 24), PAPER)
	_lines(c, Vector2(-14, 2), 18.0, 3, 4.0, INK)
	# Stamp, never postmarked
	c.draw_rect(Rect2(12, -5, 8, 9), Color(0.6, 0.16, 0.16))
	c.draw_rect(Rect2(13.5, -3.5, 5, 6), Color(0.85, 0.6, 0.55))
	# String
	c.draw_line(Vector2(-18, 3), Vector2(23, 3), Color(0.55, 0.42, 0.25), 1.5)
	c.draw_line(Vector2(2, -17), Vector2(2, 16), Color(0.55, 0.42, 0.25), 1.5)
	c.draw_circle(Vector2(2, 3), 2.0, Color(0.55, 0.42, 0.25))


## A pink card pass with a punched corner: ADMIT ONE - R. VANE.
static func _draw_visitors_pass(c: CanvasItem) -> void:
	var pink := Color(0.9, 0.68, 0.68)
	c.draw_rect(Rect2(-20, -12, 42, 28), SHADOW)
	c.draw_rect(Rect2(-22, -14, 42, 28), pink)
	c.draw_rect(Rect2(-20, -12, 38, 24), RED_INK, false, 1.0)
	_text(c, Vector2(-17, -3), "ADMIT ONE", 6, RED_INK)
	_text(c, Vector2(-17, 5), "R. VANE", 7, INK)
	_text(c, Vector2(-17, 11), "all wards", 5, INK)
	c.draw_circle(Vector2(15, -8), 2.5, Color(0.1, 0.08, 0.08))


## A round brass tag on a split ring, stamped with a 7.
static func _draw_brass_ward_tag(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(1, 16), 12, 2.5, SHADOW)
	c.draw_arc(Vector2(0, -12), 5.0, 0.0, TAU, 14, STEEL, 1.5, true)
	c.draw_circle(Vector2(0, 3), 12.0, BRASS_DARK)
	c.draw_circle(Vector2(0, 3), 10.5, BRASS)
	c.draw_circle(Vector2(0, -6), 1.8, Color(0.1, 0.08, 0.06))
	_text(c, Vector2(-4.5, 10), "7", 15, Color(0.3, 0.2, 0.06))
	c.draw_arc(Vector2(0, 3), 9.0, -2.6, -1.3, 8, BRASS_LIGHT, 1.2, true)


## A dented oval pewter snuff box.
static func _draw_snuff_box(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 10), 17, 3, SHADOW)
	PlaceholderArt.draw_ellipse(c, Vector2(0, 3), 17, 8, STEEL_DARK)
	c.draw_rect(Rect2(-17, -3, 34, 6), STEEL_DARK)
	PlaceholderArt.draw_ellipse(c, Vector2(0, -3), 17, 8, STEEL)
	PlaceholderArt.draw_ellipse(c, Vector2(0, -3), 12, 5, Color(0.78, 0.8, 0.82))
	# The tally scratched in the lid
	for i in range(7):
		c.draw_line(Vector2(-8 + i * 2.6, -6), Vector2(-8.5 + i * 2.6, -1), INK, 0.8)
	c.draw_rect(Rect2(-2, 3, 4, 3), STEEL)
	c.draw_arc(Vector2(0, -3), 15.0, -2.8, -1.8, 8, Color(1, 1, 1, 0.7), 1.0, true)


## The porter's printed round card: rows of ticks, and one row struck through.
static func _draw_night_round_card(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-16, -21, 34, 44), SHADOW)
	c.draw_rect(Rect2(-18, -23, 34, 44), PAPER)
	c.draw_rect(Rect2(-18, -23, 34, 8), Color(0.2, 0.3, 0.26))
	_text(c, Vector2(-15, -17), "NIGHT ROUND", 4, PAPER)
	for row in range(5):
		var y := -10.0 + row * 6.5
		_text(c, Vector2(-16, y + 2), ["2", "4", "7", "9", "11"][row], 5, INK)
		if row == 2:
			c.draw_line(Vector2(-8, y), Vector2(13, y), RED_INK, 1.5)
			continue
		for column in range(4):
			var at := Vector2(-6 + column * 5.5, y)
			c.draw_polyline(PackedVector2Array([at + Vector2(-1.5, 0), at + Vector2(0, 1.5), at + Vector2(2.5, -2)]), INK, 0.9)


## The lodge duty roster: a grid of names and nights, one name on every night.
static func _draw_duty_roster(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-23, -17, 50, 36), SHADOW)
	c.draw_rect(Rect2(-25, -19, 50, 36), PAPER)
	_text(c, Vector2(-22, -11), "DUTY - NIGHTS", 5, INK)
	for i in range(6):
		c.draw_line(Vector2(-22 + i * 9.0, -8), Vector2(-22 + i * 9.0, 14), PAPER_DARK, 0.8)
	for i in range(5):
		c.draw_line(Vector2(-22, -8 + i * 5.5), Vector2(23, -8 + i * 5.5), PAPER_DARK, 0.8)
	for i in range(4):
		_text(c, Vector2(-21, -3.5 + i * 5.5), "PIKE", 4, INK)
		for column in range(4):
			c.draw_circle(Vector2(-8.5 + column * 9.0, -5.2 + i * 5.5), 1.2, INK)
	c.draw_line(Vector2(-25, -1), Vector2(25, -1), Color(0.7, 0.64, 0.5, 0.5), 1.0)


## A buff admission card with one corner burnt away.
static func _draw_admission_card(c: CanvasItem) -> void:
	var card := Color(0.86, 0.78, 0.56)
	c.draw_rect(Rect2(-21, -15, 46, 32), SHADOW)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-23, -17), Vector2(23, -17), Vector2(23, 4), Vector2(16, 8),
		Vector2(13, 15), Vector2(-23, 15)]), card)
	# The scorched edge
	c.draw_polyline(PackedVector2Array([Vector2(23, 4), Vector2(16, 8), Vector2(13, 15)]), Color(0.1, 0.07, 0.05), 3.0, true)
	c.draw_polyline(PackedVector2Array([Vector2(21, 2), Vector2(13, 6), Vector2(10, 14)]), Color(0.4, 0.26, 0.12, 0.8), 2.0, true)
	_text(c, Vector2(-21, -9), "ADMISSION", 5, INK)
	_text(c, Vector2(-21, -2), "Tobias Hale", 6, INK)
	_text(c, Vector2(-21, 5), "aged 9", 5, INK)
	_text(c, Vector2(-21, 13), "1985", 9, RED_INK)


## A brown wage envelope with banknotes showing at the open end.
static func _draw_wage_packet(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-21, -11, 46, 26), SHADOW)
	# Notes sticking out
	c.draw_rect(Rect2(8, -14, 16, 22), Color(0.72, 0.8, 0.7))
	c.draw_rect(Rect2(10, -12, 12, 18), Color(0.5, 0.62, 0.5), false, 1.0)
	c.draw_rect(Rect2(-23, -13, 40, 26), Color(0.66, 0.5, 0.32))
	c.draw_rect(Rect2(-23, -13, 40, 26), Color(0.44, 0.32, 0.18), false, 1.0)
	_text(c, Vector2(-20, -3), "A. PIKE", 6, INK)
	_text(c, Vector2(-20, 5), "wages", 5, INK)
	c.draw_rect(Rect2(-20, 7, 22, 4), RED_INK, false, 0.8)


## A painted lead soldier in a red coat, standing to attention.
static func _draw_toy_soldier(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 22), 9, 2, SHADOW)
	c.draw_rect(Rect2(-8, 19, 16, 3), Color(0.2, 0.4, 0.22))
	# Legs, coat, head and a tall black hat
	c.draw_rect(Rect2(-5, 6, 4, 13), Color(0.14, 0.16, 0.3))
	c.draw_rect(Rect2(1, 6, 4, 13), Color(0.14, 0.16, 0.3))
	c.draw_rect(Rect2(-6, -8, 12, 15), Color(0.72, 0.14, 0.12))
	c.draw_line(Vector2(-6, -8), Vector2(6, 6), Color(0.95, 0.95, 0.9), 1.5)
	c.draw_line(Vector2(6, -8), Vector2(-6, 6), Color(0.95, 0.95, 0.9), 1.5)
	c.draw_circle(Vector2(0, -12), 4.0, Color(0.9, 0.72, 0.6))
	c.draw_rect(Rect2(-4, -23, 8, 9), Color(0.08, 0.08, 0.1))
	c.draw_rect(Rect2(-1, -22, 2, 3), BRASS)
	# Musket on the shoulder
	c.draw_line(Vector2(7, 8), Vector2(9, -18), Color(0.3, 0.2, 0.12), 1.5)
	c.draw_line(Vector2(9, -18), Vector2(9.5, -22), STEEL, 1.0)


## A small flat key on a loop of red tape.
static func _draw_trunk_key(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(2, 7), 17, 2, SHADOW)
	# Red tape loop
	c.draw_arc(Vector2(-15, 0), 5.0, 0.0, TAU, 12, Color(0.7, 0.14, 0.14), 2.0, true)
	c.draw_circle(Vector2(-6, 0), 5.5, BRASS)
	c.draw_circle(Vector2(-6, 0), 2.0, Color(0.1, 0.08, 0.06))
	c.draw_rect(Rect2(-1, -1.5, 19, 3), BRASS)
	c.draw_rect(Rect2(11, 1.5, 3, 5), BRASS)
	c.draw_rect(Rect2(15, 1.5, 3, 3.5), BRASS)
	c.draw_line(Vector2(0, -1), Vector2(17, -1), BRASS_LIGHT, 0.8)


## A heavy bound book, open at a spread where the pages were cut out.
static func _draw_visitors_book(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-24, -16, 52, 36), SHADOW)
	c.draw_rect(Rect2(-26, -18, 52, 36), Color(0.26, 0.1, 0.1))
	c.draw_rect(Rect2(-24, -16, 23, 32), PAPER)
	c.draw_rect(Rect2(1, -16, 23, 32), PAPER)
	# Razor-cut stubs down the gutter
	for i in range(6):
		c.draw_line(Vector2(-1, -14 + i * 5.5), Vector2(3, -13 + i * 5.5), PAPER_DARK, 1.5)
	_text(c, Vector2(-22, -9), "VISITORS", 4, INK)
	for i in range(4):
		_text(c, Vector2(-22, -2 + i * 5.0), "R. Vane", 4, INK)
	_lines(c, Vector2(5, -10), 16.0, 6, 4.5, Color(0.3, 0.28, 0.4))


## A long steel key with a numbered brass fob.
static func _draw_ward_door_key(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 8), 26, 2.5, SHADOW)
	c.draw_arc(Vector2(-14, 0), 6.5, 0.0, TAU, 16, STEEL_DARK, 3.0, true)
	c.draw_rect(Rect2(-8, -2, 32, 4), STEEL)
	c.draw_line(Vector2(-8, -1.2), Vector2(23, -1.2), Color(1, 1, 1, 0.7), 0.8)
	c.draw_rect(Rect2(16, 2, 4, 7), STEEL)
	c.draw_rect(Rect2(22, 2, 3, 5), STEEL)
	# Fob on a ring
	c.draw_arc(Vector2(-22, 2), 3.0, 0.0, TAU, 10, STEEL, 1.0, true)
	c.draw_circle(Vector2(-23, 6), 5.0, BRASS)
	_text(c, Vector2(-25.5, 9), "W", 6, Color(0.3, 0.2, 0.06))


## A torn scrap of paper with a pencilled message in a child's capitals.
static func _draw_pushed_note(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-20, -11, 44, 26), SHADOW)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-23, -13), Vector2(20, -15), Vector2(23, 10), Vector2(8, 13),
		Vector2(-4, 11), Vector2(-22, 14)]), PAPER)
	_text(c, Vector2(-19, -4), "WARD 7.", 7, Color(0.25, 0.25, 0.3))
	_text(c, Vector2(-19, 3), "WE ARE", 6, Color(0.25, 0.25, 0.3))
	_text(c, Vector2(-19, 10), "STILL HERE", 6, Color(0.25, 0.25, 0.3))
	# A boot print across one corner
	PlaceholderArt.draw_ellipse(c, Vector2(15, 3), 5, 8, Color(0.3, 0.26, 0.2, 0.3))


## A small green ribbed bottle with a glass stopper and two labels.
static func _draw_smelling_salts(c: CanvasItem) -> void:
	var green := Color(0.2, 0.5, 0.36, 0.9)
	PlaceholderArt.draw_ellipse(c, Vector2(0, 17), 9, 2, SHADOW)
	c.draw_circle(Vector2(0, -14), 3.5, Color(0.8, 0.92, 0.86, 0.8))
	c.draw_rect(Rect2(-2.5, -12, 5, 5), green)
	c.draw_rect(Rect2(-8, -8, 16, 24), green)
	for i in range(4):
		c.draw_line(Vector2(-5 + i * 3.4, -7), Vector2(-5 + i * 3.4, 15), Color(0.1, 0.32, 0.22), 0.8)
	c.draw_rect(Rect2(-7, -3, 14, 12), PAPER)
	c.draw_rect(Rect2(-6, 1, 12, 7), Color(0.98, 0.96, 0.9))
	_lines(c, Vector2(-5, 3), 9.0, 2, 2.5, RED_INK)
	c.draw_line(Vector2(-7, -7), Vector2(-7, 14), Color(1, 1, 1, 0.5), 1.0)
