@tool
class_name XrayRoomObjects
extends RefCounted
## Placeholder drawings for the hidden objects of House Three, Chapter Two (The X-Ray Room).
## Same rules as placeholder_art.gd: every drawing is centred on (0, 0) and
## fits inside get_size(). PlaceholderArt calls these functions.

const BRASS := Color(0.8, 0.62, 0.3)
const BRASS_DARK := Color(0.52, 0.38, 0.16)
const STEEL := Color(0.7, 0.72, 0.75)
const STEEL_DARK := Color(0.42, 0.44, 0.47)
const SILVER := Color(0.84, 0.85, 0.88)
const PAPER := Color(0.92, 0.88, 0.76)
const PAPER_DARK := Color(0.74, 0.68, 0.54)
const INK := Color(0.16, 0.14, 0.2)
const RED_INK := Color(0.62, 0.12, 0.1)
const PENCIL := Color(0.3, 0.3, 0.34)
const GLASS := Color(0.75, 0.88, 0.9, 0.45)
const GLASS_EDGE := Color(0.88, 0.96, 1.0, 0.8)
const FILM := Color(0.08, 0.1, 0.13)
const BONE := Color(0.78, 0.86, 0.9, 0.85)
const SHADOW := Color(0, 0, 0, 0.35)

const SIZES := {
	HiddenObjectData.PlaceholderStyle.PENCIL_STUB: Vector2(34, 12),
	HiddenObjectData.PlaceholderStyle.WARD_MAP: Vector2(50, 38),
	HiddenObjectData.PlaceholderStyle.SEWN_PHOTOGRAPH: Vector2(46, 36),
	HiddenObjectData.PlaceholderStyle.ROLLED_NOTE: Vector2(40, 14),
	HiddenObjectData.PlaceholderStyle.BOOT_HEEL_KEY: Vector2(30, 16),
	HiddenObjectData.PlaceholderStyle.BENT_SPOON: Vector2(46, 16),
	HiddenObjectData.PlaceholderStyle.CHEST_XRAY: Vector2(42, 52),
	HiddenObjectData.PlaceholderStyle.DARKROOM_TONGS: Vector2(52, 18),
	HiddenObjectData.PlaceholderStyle.LEAD_GLOVES: Vector2(46, 44),
	HiddenObjectData.PlaceholderStyle.APPOINTMENT_BOOK: Vector2(50, 36),
	HiddenObjectData.PlaceholderStyle.TORN_LABEL: Vector2(40, 26),
	HiddenObjectData.PlaceholderStyle.NAME_TAGS: Vector2(54, 30),
	HiddenObjectData.PlaceholderStyle.MATRONS_MEMO: Vector2(40, 50),
	HiddenObjectData.PlaceholderStyle.XRAY_TUBE: Vector2(56, 26),
	HiddenObjectData.PlaceholderStyle.WARD_SEVEN_KEY: Vector2(54, 24),
	HiddenObjectData.PlaceholderStyle.PAPER_BOAT: Vector2(46, 30),
	HiddenObjectData.PlaceholderStyle.RED_SAFELIGHT: Vector2(34, 40),
	HiddenObjectData.PlaceholderStyle.NURSES_WATCH: Vector2(24, 42),
}


## Size of the drawing, or Vector2.ZERO if `style` is not one of this chapter's objects.
static func get_size(style: int) -> Vector2:
	return SIZES.get(style, Vector2.ZERO)


## Draws `style` and returns true, or returns false if it is not one of this chapter's objects.
static func draw(c: CanvasItem, style: int) -> bool:
	match style:
		HiddenObjectData.PlaceholderStyle.PENCIL_STUB:
			_draw_pencil_stub(c)
		HiddenObjectData.PlaceholderStyle.WARD_MAP:
			_draw_ward_map(c)
		HiddenObjectData.PlaceholderStyle.SEWN_PHOTOGRAPH:
			_draw_sewn_photograph(c)
		HiddenObjectData.PlaceholderStyle.ROLLED_NOTE:
			_draw_rolled_note(c)
		HiddenObjectData.PlaceholderStyle.BOOT_HEEL_KEY:
			_draw_boot_heel_key(c)
		HiddenObjectData.PlaceholderStyle.BENT_SPOON:
			_draw_bent_spoon(c)
		HiddenObjectData.PlaceholderStyle.CHEST_XRAY:
			_draw_chest_xray(c)
		HiddenObjectData.PlaceholderStyle.DARKROOM_TONGS:
			_draw_darkroom_tongs(c)
		HiddenObjectData.PlaceholderStyle.LEAD_GLOVES:
			_draw_lead_gloves(c)
		HiddenObjectData.PlaceholderStyle.APPOINTMENT_BOOK:
			_draw_appointment_book(c)
		HiddenObjectData.PlaceholderStyle.TORN_LABEL:
			_draw_torn_label(c)
		HiddenObjectData.PlaceholderStyle.NAME_TAGS:
			_draw_name_tags(c)
		HiddenObjectData.PlaceholderStyle.MATRONS_MEMO:
			_draw_matrons_memo(c)
		HiddenObjectData.PlaceholderStyle.XRAY_TUBE:
			_draw_xray_tube(c)
		HiddenObjectData.PlaceholderStyle.WARD_SEVEN_KEY:
			_draw_ward_seven_key(c)
		HiddenObjectData.PlaceholderStyle.PAPER_BOAT:
			_draw_paper_boat(c)
		HiddenObjectData.PlaceholderStyle.RED_SAFELIGHT:
			_draw_red_safelight(c)
		HiddenObjectData.PlaceholderStyle.NURSES_WATCH:
			_draw_nurses_watch(c)
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


## A chewed stub of yellow pencil with a blunt point.
static func _draw_pencil_stub(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-15, -3, 22, 6), Color(0.9, 0.72, 0.2))
	c.draw_line(Vector2(-15, -1), Vector2(7, -1), Color(1.0, 0.86, 0.4), 1.0)
	c.draw_colored_polygon(PackedVector2Array([Vector2(7, -3), Vector2(14, 0), Vector2(7, 3)]), Color(0.86, 0.72, 0.52))
	c.draw_colored_polygon(PackedVector2Array([Vector2(12, -1), Vector2(16, 0), Vector2(12, 1)]), PENCIL)
	# Tooth marks at the chewed end
	c.draw_rect(Rect2(-17, -3, 3, 6), Color(0.7, 0.52, 0.16))
	for i in range(3):
		c.draw_line(Vector2(-13 + i * 3.0, -3), Vector2(-12 + i * 3.0, -1), Color(0.5, 0.36, 0.1), 0.8)


## A plan of the wards inked on a square of pillowcase, with a cross on Ward 7.
static func _draw_ward_map(c: CanvasItem) -> void:
	var cloth := Color(0.88, 0.88, 0.84)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-25, -17), Vector2(24, -19), Vector2(25, 17), Vector2(-23, 19)]), cloth)
	# Corridors and wards
	c.draw_rect(Rect2(-20, -3, 40, 5), PENCIL, false, 1.0)
	for i in range(4):
		c.draw_rect(Rect2(-19 + i * 10.0, -14, 8, 11), PENCIL, false, 1.0)
		c.draw_rect(Rect2(-19 + i * 10.0, 2, 8, 11), PENCIL, false, 1.0)
	# Ward 7 and the way down
	c.draw_line(Vector2(12, 4), Vector2(18, 11), RED_INK, 1.5)
	c.draw_line(Vector2(18, 4), Vector2(12, 11), RED_INK, 1.5)
	_text(c, Vector2(10, 18), "7", 6, RED_INK)
	c.draw_line(Vector2(-14, 8), Vector2(-14, 16), RED_INK, 1.0)
	c.draw_polyline(PackedVector2Array([Vector2(-16, 14), Vector2(-14, 17), Vector2(-12, 14)]), RED_INK, 1.0)
	# Stitched hem
	for i in range(9):
		c.draw_line(Vector2(-22 + i * 5.5, -16), Vector2(-20 + i * 5.5, -16), Color(0.5, 0.55, 0.7), 1.0)


## A photograph of seven patients on a bench, with needle holes round the edge.
static func _draw_sewn_photograph(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-23, -18, 46, 36), Color(0.9, 0.88, 0.8))
	c.draw_rect(Rect2(-20, -15, 40, 26), Color(0.26, 0.25, 0.24))
	# Seven small grey figures in a row
	for i in range(7):
		var x := -16.0 + i * 5.4
		c.draw_circle(Vector2(x, -6 + (i % 2)), 2.0, Color(0.8, 0.78, 0.72))
		c.draw_rect(Rect2(x - 2.2, -3.5 + (i % 2), 4.4, 9), Color(0.6, 0.6, 0.58))
	c.draw_rect(Rect2(-19, 6, 38, 2), Color(0.16, 0.15, 0.14))
	_text(c, Vector2(-12, 16.5), "all of us", 4, INK)
	# Needle holes where it was stitched in
	for i in range(8):
		c.draw_circle(Vector2(-21 + i * 6.0, -16.5), 0.6, INK)
		c.draw_circle(Vector2(-21 + i * 6.0, 16.5), 0.6, INK)


## A slip of paper rolled into a tight little tube and tied with thread.
static func _draw_rolled_note(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-18, -5, 34, 10), PAPER)
	c.draw_rect(Rect2(-18, 2, 34, 3), PAPER_DARK)
	PlaceholderArt.draw_ellipse(c, Vector2(16, 0), 3, 5, PAPER)
	c.draw_arc(Vector2(16, 0), 2.0, 0.0, TAU * 1.5, 14, PAPER_DARK, 0.9, true)
	PlaceholderArt.draw_ellipse(c, Vector2(-18, 0), 3, 5, PAPER_DARK)
	# Thread
	c.draw_line(Vector2(-2, -5), Vector2(-2, 5), Color(0.5, 0.14, 0.14), 1.5)
	c.draw_line(Vector2(1, -5), Vector2(1, 5), Color(0.5, 0.14, 0.14), 1.0)
	_lines(c, Vector2(4, -2), 9.0, 2, 2.5, PENCIL)


## A tiny flat key, filed down to fit inside a boot heel.
static func _draw_boot_heel_key(c: CanvasItem) -> void:
	c.draw_circle(Vector2(-9, 0), 5.0, SILVER)
	c.draw_circle(Vector2(-9, 0), 2.0, Color(0.1, 0.1, 0.12))
	c.draw_rect(Rect2(-5, -1.3, 17, 2.6), SILVER)
	c.draw_rect(Rect2(6, 1.3, 2.5, 4), SILVER)
	c.draw_rect(Rect2(10, 1.3, 2, 2.8), SILVER)
	c.draw_line(Vector2(-4, -0.8), Vector2(11, -0.8), Color(1, 1, 1, 0.9), 0.7)
	# File marks where the bow was cut down
	c.draw_line(Vector2(-13, -3), Vector2(-11, 3), STEEL_DARK, 0.7)


## A spoon whose bowl has been worn to a point on the mortar.
static func _draw_bent_spoon(c: CanvasItem) -> void:
	# Handle with a kink in it
	c.draw_polyline(PackedVector2Array([Vector2(-22, 2), Vector2(-8, -1), Vector2(-2, 3), Vector2(8, 1)]), STEEL_DARK, 4.0, true)
	c.draw_polyline(PackedVector2Array([Vector2(-22, 1.5), Vector2(-8, -1.5), Vector2(-2, 2.5), Vector2(8, 0.5)]), SILVER, 2.0, true)
	# The worn, pointed bowl
	c.draw_colored_polygon(PackedVector2Array([Vector2(7, -5), Vector2(15, -5), Vector2(23, 1), Vector2(14, 6), Vector2(7, 6)]), STEEL_DARK)
	c.draw_colored_polygon(PackedVector2Array([Vector2(8, -4), Vector2(14, -4), Vector2(20, 1), Vector2(13, 5), Vector2(8, 5)]), SILVER)
	c.draw_line(Vector2(15, -3), Vector2(22, 1), PAPER_DARK, 1.0)  # mortar dust on the edge
	c.draw_circle(Vector2(-20, 2), 2.5, SILVER)


## A dark X-ray plate of a small ribcage, half out of its paper sleeve.
static func _draw_chest_xray(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-19, -24, 40, 50), SHADOW)
	c.draw_rect(Rect2(-21, -14, 40, 40), PAPER)
	_text(c, Vector2(-18, 22), "PATIENT 7", 5, INK)
	c.draw_rect(Rect2(-18, -26, 34, 40), FILM)
	# Spine and ribs
	c.draw_line(Vector2(-1, -22), Vector2(-1, 11), BONE, 2.0)
	for i in range(6):
		var y := -17.0 + i * 5.0
		c.draw_arc(Vector2(-1, y), 6.0 + i * 1.2, 0.2, PI - 0.2, 10, BONE, 1.2, true)
	c.draw_line(Vector2(-12, -20), Vector2(10, -20), BONE, 1.2)  # collar bones
	_text(c, Vector2(-17, 12.5), "0791", 5, Color(0.9, 0.95, 1.0))


## Wooden darkroom tongs, stained at the tips.
static func _draw_darkroom_tongs(c: CanvasItem) -> void:
	var wood := Color(0.72, 0.56, 0.36)
	c.draw_line(Vector2(-24, -3), Vector2(22, -6), wood, 4.0)
	c.draw_line(Vector2(-24, 3), Vector2(22, 6), wood, 4.0)
	c.draw_line(Vector2(-24, -4), Vector2(20, -7), wood.lightened(0.2), 1.0)
	c.draw_rect(Rect2(-26, -5, 5, 10), wood.darkened(0.2))
	c.draw_circle(Vector2(-22, 0), 1.5, STEEL_DARK)
	# Chemical stains on the tips
	c.draw_line(Vector2(12, -5.4), Vector2(24, -6.2), Color(0.3, 0.22, 0.14), 4.0)
	c.draw_line(Vector2(12, 5.4), Vector2(24, 6.2), Color(0.3, 0.22, 0.14), 4.0)


## A pair of heavy lead-lined gauntlets, one lying across the other.
static func _draw_lead_gloves(c: CanvasItem) -> void:
	var lead := Color(0.3, 0.33, 0.38)
	PlaceholderArt.draw_ellipse(c, Vector2(0, 20), 20, 3, SHADOW)
	for glove in range(2):
		var offset := Vector2(-8 + glove * 14.0, glove * 4.0)
		var shade := lead.darkened(0.15) if glove == 0 else lead
		c.draw_rect(Rect2(offset.x - 8, offset.y - 2, 16, 18), shade)  # cuff
		c.draw_rect(Rect2(offset.x - 9, offset.y + 13, 18, 4), shade.darkened(0.3))
		c.draw_rect(Rect2(offset.x - 9, offset.y - 12, 18, 12), shade)  # palm
		for finger in range(4):
			c.draw_rect(Rect2(offset.x - 9 + finger * 4.6, offset.y - 21, 4, 10), shade)
		c.draw_rect(Rect2(offset.x + 9, offset.y - 10, 4, 9), shade)  # thumb
		c.draw_line(Vector2(offset.x - 6, offset.y - 9), Vector2(offset.x - 6, offset.y + 10), Color(1, 1, 1, 0.12), 2.0)


## A cloth-bound diary open at a week, the same entry every Sunday.
static func _draw_appointment_book(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-23, -16, 50, 36), SHADOW)
	c.draw_rect(Rect2(-25, -18, 50, 36), Color(0.14, 0.24, 0.3))
	c.draw_rect(Rect2(-23, -16, 22, 32), PAPER)
	c.draw_rect(Rect2(1, -16, 22, 32), PAPER)
	_lines(c, Vector2(-21, -10), 17.0, 6, 4.5, Color(0.3, 0.28, 0.4))
	_text(c, Vector2(3, -8), "SUNDAY", 4, RED_INK)
	_text(c, Vector2(3, -1), "Dr V.", 6, INK)
	_text(c, Vector2(3, 6), "Ward 7", 5, INK)
	c.draw_line(Vector2(3, 9), Vector2(20, 9), RED_INK, 1.0)
	# Ribbon marker
	c.draw_rect(Rect2(-1, -18, 2, 40), Color(0.6, 0.14, 0.14))


## Half of a buff luggage label, with its eyelet and a bit of string.
static func _draw_torn_label(c: CanvasItem) -> void:
	c.draw_colored_polygon(PackedVector2Array([Vector2(-12, -12), Vector2(19, -12), Vector2(19, 12), Vector2(-14, 12),
		Vector2(-10, 5), Vector2(-15, 0), Vector2(-11, -6)]), Color(0.84, 0.74, 0.52))
	c.draw_circle(Vector2(14, 0), 3.0, Color(0.6, 0.48, 0.3))
	c.draw_circle(Vector2(14, 0), 1.4, Color(0.1, 0.08, 0.06))
	c.draw_line(Vector2(14, 0), Vector2(20, -9), Color(0.6, 0.55, 0.45), 1.0)
	_text(c, Vector2(-9, -3), "..bias", 5, INK)
	_text(c, Vector2(-9, 3), "Hale", 6, INK)
	_text(c, Vector2(-9, 9), "4 Mill Row", 4, INK)


## Seven cloth wrist tags threaded on one string.
static func _draw_name_tags(c: CanvasItem) -> void:
	c.draw_polyline(PackedVector2Array([Vector2(-26, -10), Vector2(-12, -6), Vector2(0, -5), Vector2(12, -6), Vector2(26, -10)]),
		Color(0.6, 0.55, 0.45), 1.0, true)
	for i in range(7):
		var x := -22.0 + i * 7.4
		var top := -6.0 - absf(i - 3.0) * 1.2
		c.draw_rect(Rect2(x - 3, top, 6, 18), Color(0.9, 0.9, 0.86) if i % 2 == 0 else Color(0.82, 0.82, 0.78))
		c.draw_circle(Vector2(x, top + 2), 0.9, INK)
		# The name inked out, a number written over it
		c.draw_rect(Rect2(x - 2, top + 5, 4, 4), INK)
		_text(c, Vector2(x - 1.6, top + 16), str(i + 1), 5, RED_INK)


## A typed memo on thin paper, initialled E.C.
static func _draw_matrons_memo(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-18, -23, 38, 48), SHADOW)
	c.draw_rect(Rect2(-20, -25, 38, 48), Color(0.94, 0.93, 0.88))
	_text(c, Vector2(-17, -17), "MEMO", 6, INK)
	c.draw_line(Vector2(-17, -14), Vector2(14, -14), INK, 0.8)
	_text(c, Vector2(-17, -7), "Ward 7:", 5, INK)
	_text(c, Vector2(-17, -1), "NUMBERS", 5, RED_INK)
	_text(c, Vector2(-17, 5), "ONLY", 5, RED_INK)
	_lines(c, Vector2(-17, 9), 30.0, 3, 3.2, Color(0.3, 0.28, 0.4))
	c.draw_polyline(PackedVector2Array([Vector2(2, 20), Vector2(5, 16), Vector2(7, 20), Vector2(11, 16), Vector2(14, 19)]), INK, 1.0, true)


## A glass X-ray tube: a bulb with two arms and metal caps.
static func _draw_xray_tube(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 12), 24, 2.5, SHADOW)
	c.draw_rect(Rect2(-24, -3, 48, 6), GLASS)
	c.draw_rect(Rect2(-24, -3, 48, 6), GLASS_EDGE, false, 1.0)
	c.draw_circle(Vector2(0, 0), 11.0, GLASS)
	c.draw_arc(Vector2(0, 0), 11.0, 0.0, TAU, 28, GLASS_EDGE, 1.0, true)
	# Cathode cup and the slanted anode inside the bulb
	c.draw_rect(Rect2(-9, -2, 5, 4), STEEL_DARK)
	c.draw_colored_polygon(PackedVector2Array([Vector2(3, -4), Vector2(8, -2), Vector2(8, 2), Vector2(5, 4)]), BRASS)
	c.draw_line(Vector2(8, 0), Vector2(22, 0), BRASS_DARK, 1.5)
	c.draw_line(Vector2(-22, 0), Vector2(-9, 0), STEEL_DARK, 1.0)
	# Caps
	c.draw_rect(Rect2(-28, -4, 5, 8), STEEL_DARK)
	c.draw_rect(Rect2(23, -4, 5, 8), STEEL_DARK)
	c.draw_arc(Vector2(0, 0), 8.0, -2.6, -1.5, 8, Color(1, 1, 1, 0.8), 1.2, true)


## A black iron key with a white enamel disc: 7.
static func _draw_ward_seven_key(c: CanvasItem) -> void:
	var iron := Color(0.14, 0.14, 0.15)
	PlaceholderArt.draw_ellipse(c, Vector2(0, 9), 25, 2.5, SHADOW)
	c.draw_circle(Vector2(-16, 0), 9.0, iron)
	c.draw_circle(Vector2(-16, 0), 6.5, Color(0.94, 0.94, 0.9))
	_text(c, Vector2(-19, 4.5), "7", 11, iron)
	c.draw_rect(Rect2(-8, -2, 32, 4), iron)
	c.draw_line(Vector2(-7, -1.3), Vector2(23, -1.3), Color(0.45, 0.45, 0.48), 0.8)
	c.draw_rect(Rect2(15, 2, 4, 8), iron)
	c.draw_rect(Rect2(21, 2, 3, 5.5), iron)


## A little boat folded from a brown paper X-ray sleeve, with pencil writing on its side.
static func _draw_paper_boat(c: CanvasItem) -> void:
	var sleeve := Color(0.8, 0.7, 0.5)
	PlaceholderArt.draw_ellipse(c, Vector2(0, 13), 20, 2.5, SHADOW)
	# Sail
	c.draw_colored_polygon(PackedVector2Array([Vector2(0, -15), Vector2(10, 2), Vector2(-10, 2)]), sleeve.lightened(0.15))
	c.draw_line(Vector2(0, -15), Vector2(0, 2), sleeve.darkened(0.25), 1.0)
	# Hull
	c.draw_colored_polygon(PackedVector2Array([Vector2(-23, 1), Vector2(23, 1), Vector2(13, 12), Vector2(-13, 12)]), sleeve)
	c.draw_line(Vector2(-23, 1), Vector2(23, 1), sleeve.darkened(0.3), 1.0)
	_text(c, Vector2(-12, 9.5), "Mara?", 6, PENCIL)


## A darkroom lamp: a black metal box with a round ruby glass.
static func _draw_red_safelight(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-4, -20, 8, 5), STEEL_DARK)
	c.draw_rect(Rect2(-15, -15, 30, 32), Color(0.1, 0.1, 0.11))
	c.draw_rect(Rect2(-15, -15, 30, 32), STEEL_DARK, false, 1.5)
	for ring in range(3):
		c.draw_circle(Vector2(0, 1), 17.0 - ring * 3.0, Color(0.9, 0.1, 0.08, 0.07))
	c.draw_circle(Vector2(0, 1), 10.0, Color(0.55, 0.05, 0.05))
	c.draw_circle(Vector2(0, 1), 8.0, Color(0.85, 0.12, 0.1))
	c.draw_circle(Vector2(-3, -2), 2.5, Color(1.0, 0.6, 0.5, 0.8))
	# Vent slots
	for i in range(3):
		c.draw_line(Vector2(-8 + i * 8.0, -12), Vector2(-4 + i * 8.0, -12), STEEL_DARK, 1.5)


## A nurse's fob watch hanging upside down from a pin and a short strap.
static func _draw_nurses_watch(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(1, 20), 9, 2, SHADOW)
	# Pin bar and strap
	c.draw_rect(Rect2(-8, -20, 16, 4), SILVER)
	c.draw_rect(Rect2(-3, -16, 6, 14), Color(0.12, 0.16, 0.34))
	# Case and face
	c.draw_circle(Vector2(0, 7), 10.5, STEEL_DARK)
	c.draw_circle(Vector2(0, 7), 9.0, SILVER)
	c.draw_circle(Vector2(0, 7), 7.5, Color(0.96, 0.95, 0.9))
	for i in range(12):
		var direction := Vector2.from_angle(TAU * i / 12.0)
		c.draw_line(Vector2(0, 7) + direction * 6.0, Vector2(0, 7) + direction * 7.0, INK, 0.8)
	c.draw_line(Vector2(0, 7), Vector2(2.5, 10.5), INK, 1.2)
	c.draw_line(Vector2(0, 7), Vector2(-4.5, 5.5), INK, 0.8)
	c.draw_line(Vector2(0, 7), Vector2(0, 13), RED_INK, 0.6)
