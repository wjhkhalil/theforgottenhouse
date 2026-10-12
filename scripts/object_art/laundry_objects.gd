@tool
class_name LaundryObjects
extends RefCounted
## Placeholder drawings for the hidden objects of House Three, Chapter Three (The Laundry).
## Same rules as placeholder_art.gd: every drawing is centred on (0, 0) and
## fits inside get_size(). PlaceholderArt calls these functions.

const IRON := Color(0.14, 0.14, 0.16)
const IRON_LIGHT := Color(0.42, 0.43, 0.47)
const STEEL := Color(0.7, 0.72, 0.75)
const STEEL_DARK := Color(0.42, 0.44, 0.47)
const SILVER := Color(0.84, 0.85, 0.88)
const WOOD := Color(0.66, 0.5, 0.32)
const WOOD_DARK := Color(0.42, 0.29, 0.17)
const PAPER := Color(0.92, 0.88, 0.76)
const PAPER_DARK := Color(0.74, 0.68, 0.54)
const LINEN := Color(0.9, 0.9, 0.86)
const LINEN_DARK := Color(0.7, 0.7, 0.66)
const SMOCK_GREY := Color(0.56, 0.58, 0.6)
const INK := Color(0.16, 0.14, 0.2)
const RED_INK := Color(0.62, 0.12, 0.1)
const PENCIL := Color(0.3, 0.3, 0.34)
const SHADOW := Color(0, 0, 0, 0.35)

const SIZES := {
	HiddenObjectData.PlaceholderStyle.FLAT_IRON: Vector2(42, 32),
	HiddenObjectData.PlaceholderStyle.DOLLY_PEG: Vector2(22, 46),
	HiddenObjectData.PlaceholderStyle.CARBOLIC_SOAP: Vector2(34, 16),
	HiddenObjectData.PlaceholderStyle.WASHBOARD: Vector2(34, 50),
	HiddenObjectData.PlaceholderStyle.SMOCK_SEVEN: Vector2(44, 50),
	HiddenObjectData.PlaceholderStyle.LAUNDRY_TICKET: Vector2(46, 30),
	HiddenObjectData.PlaceholderStyle.DARNING_EGG: Vector2(46, 18),
	HiddenObjectData.PlaceholderStyle.BLUE_BAG: Vector2(30, 34),
	HiddenObjectData.PlaceholderStyle.LAUNDRY_SCISSORS: Vector2(54, 22),
	HiddenObjectData.PlaceholderStyle.LINEN_TALLY: Vector2(34, 48),
	HiddenObjectData.PlaceholderStyle.LOCKER_KEY: Vector2(42, 20),
	HiddenObjectData.PlaceholderStyle.INITIALLED_PILLOWCASE: Vector2(52, 36),
	HiddenObjectData.PlaceholderStyle.MANGLE_NOTE: Vector2(46, 24),
	HiddenObjectData.PlaceholderStyle.PRESSED_LETTER: Vector2(48, 36),
	HiddenObjectData.PlaceholderStyle.CHILDS_SPECTACLES: Vector2(50, 22),
	HiddenObjectData.PlaceholderStyle.NELLS_DIARY: Vector2(36, 46),
	HiddenObjectData.PlaceholderStyle.WARD_SEVEN_CHIT: Vector2(46, 34),
	HiddenObjectData.PlaceholderStyle.BOILER_ROOM_KEY: Vector2(30, 52),
	HiddenObjectData.PlaceholderStyle.SCORCHED_PAGE: Vector2(42, 50),
}


## Size of the drawing, or Vector2.ZERO if `style` is not one of this chapter's objects.
static func get_size(style: int) -> Vector2:
	return SIZES.get(style, Vector2.ZERO)


## Draws `style` and returns true, or returns false if it is not one of this chapter's objects.
static func draw(c: CanvasItem, style: int) -> bool:
	match style:
		HiddenObjectData.PlaceholderStyle.FLAT_IRON:
			_draw_flat_iron(c)
		HiddenObjectData.PlaceholderStyle.DOLLY_PEG:
			_draw_dolly_peg(c)
		HiddenObjectData.PlaceholderStyle.CARBOLIC_SOAP:
			_draw_carbolic_soap(c)
		HiddenObjectData.PlaceholderStyle.WASHBOARD:
			_draw_washboard(c)
		HiddenObjectData.PlaceholderStyle.SMOCK_SEVEN:
			_draw_smock_seven(c)
		HiddenObjectData.PlaceholderStyle.LAUNDRY_TICKET:
			_draw_laundry_ticket(c)
		HiddenObjectData.PlaceholderStyle.DARNING_EGG:
			_draw_darning_egg(c)
		HiddenObjectData.PlaceholderStyle.BLUE_BAG:
			_draw_blue_bag(c)
		HiddenObjectData.PlaceholderStyle.LAUNDRY_SCISSORS:
			_draw_laundry_scissors(c)
		HiddenObjectData.PlaceholderStyle.LINEN_TALLY:
			_draw_linen_tally(c)
		HiddenObjectData.PlaceholderStyle.LOCKER_KEY:
			_draw_locker_key(c)
		HiddenObjectData.PlaceholderStyle.INITIALLED_PILLOWCASE:
			_draw_initialled_pillowcase(c)
		HiddenObjectData.PlaceholderStyle.MANGLE_NOTE:
			_draw_mangle_note(c)
		HiddenObjectData.PlaceholderStyle.PRESSED_LETTER:
			_draw_pressed_letter(c)
		HiddenObjectData.PlaceholderStyle.CHILDS_SPECTACLES:
			_draw_childs_spectacles(c)
		HiddenObjectData.PlaceholderStyle.NELLS_DIARY:
			_draw_nells_diary(c)
		HiddenObjectData.PlaceholderStyle.WARD_SEVEN_CHIT:
			_draw_ward_seven_chit(c)
		HiddenObjectData.PlaceholderStyle.BOILER_ROOM_KEY:
			_draw_boiler_room_key(c)
		HiddenObjectData.PlaceholderStyle.SCORCHED_PAGE:
			_draw_scorched_page(c)
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


## A heavy black flat iron with a hooped handle, standing on its sole.
static func _draw_flat_iron(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 15), 20, 2, SHADOW)
	# The body: a blunt heel on the left, a point on the right
	c.draw_colored_polygon(PackedVector2Array([Vector2(-19, 2), Vector2(8, 2), Vector2(20, 13), Vector2(-19, 13)]), IRON)
	c.draw_rect(Rect2(-19, 11, 39, 3), Color(0.3, 0.3, 0.33))
	c.draw_line(Vector2(-17, 4), Vector2(7, 4), IRON_LIGHT, 1.0)
	# Handle posts and the wooden grip
	c.draw_rect(Rect2(-15, -8, 4, 10), IRON)
	c.draw_rect(Rect2(5, -8, 4, 10), IRON)
	c.draw_rect(Rect2(-17, -14, 28, 7), WOOD_DARK)
	c.draw_line(Vector2(-16, -13), Vector2(10, -13), WOOD, 1.5)
	# A last shimmer of warmth
	c.draw_line(Vector2(-10, 13), Vector2(14, 13), Color(1.0, 0.5, 0.2, 0.5), 1.0)


## A dolly peg with an inked face and a scrap of grey smock for a dress.
static func _draw_dolly_peg(c: CanvasItem) -> void:
	# The two legs of the peg
	c.draw_rect(Rect2(-5, 4, 4, 18), WOOD)
	c.draw_rect(Rect2(1, 4, 4, 18), WOOD)
	c.draw_rect(Rect2(-5, -10, 10, 16), WOOD)
	# The round head and its face
	c.draw_circle(Vector2(0, -16), 6.5, WOOD)
	c.draw_circle(Vector2(-2.2, -17), 0.9, INK)
	c.draw_circle(Vector2(2.2, -17), 0.9, INK)
	c.draw_arc(Vector2(0, -15), 2.5, 0.4, PI - 0.4, 6, INK, 0.8, true)
	# The dress, tied at the neck with thread
	c.draw_colored_polygon(PackedVector2Array([Vector2(-4, -9), Vector2(4, -9), Vector2(10, 10), Vector2(-10, 10)]), SMOCK_GREY)
	c.draw_line(Vector2(-4, -8), Vector2(4, -8), RED_INK, 1.2)
	c.draw_line(Vector2(-8, 8), Vector2(8, 8), SMOCK_GREY.darkened(0.25), 1.0)


## A worn sliver of red carbolic soap, with seven strokes scratched into it.
static func _draw_carbolic_soap(c: CanvasItem) -> void:
	var soap := Color(0.78, 0.26, 0.22)
	PlaceholderArt.draw_ellipse(c, Vector2(0, 7), 15, 1.5, SHADOW)
	PlaceholderArt.draw_ellipse(c, Vector2(0, 0), 16, 6.5, soap.darkened(0.25))
	PlaceholderArt.draw_ellipse(c, Vector2(0, -1), 15, 5.5, soap)
	PlaceholderArt.draw_ellipse(c, Vector2(-5, -3), 6, 1.5, Color(1.0, 0.6, 0.55, 0.6))
	for i in range(7):
		c.draw_line(Vector2(-9 + i * 3.0, -2.5), Vector2(-9 + i * 3.0, 2.5), soap.darkened(0.5), 0.9)


## A ribbed zinc washboard in a wooden frame with two legs.
static func _draw_washboard(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-16, -24, 32, 40), WOOD_DARK)
	c.draw_rect(Rect2(-16, 16, 5, 9), WOOD_DARK)
	c.draw_rect(Rect2(11, 16, 5, 9), WOOD_DARK)
	# Soap shelf at the top
	c.draw_rect(Rect2(-12, -21, 24, 7), WOOD)
	# The zinc ribs
	c.draw_rect(Rect2(-12, -12, 24, 25), STEEL_DARK)
	for i in range(6):
		c.draw_line(Vector2(-12, -10 + i * 4.2), Vector2(12, -10 + i * 4.2), SILVER, 1.6)


## A small grey smock on its loop, a red 7 stitched on the collar.
static func _draw_smock_seven(c: CanvasItem) -> void:
	# Hanging loop
	c.draw_arc(Vector2(0, -21), 3.0, PI, TAU, 8, LINEN_DARK, 1.2, true)
	# Sleeves
	c.draw_colored_polygon(PackedVector2Array([Vector2(-10, -18), Vector2(-21, -4), Vector2(-15, 0), Vector2(-9, -8)]), SMOCK_GREY.darkened(0.12))
	c.draw_colored_polygon(PackedVector2Array([Vector2(10, -18), Vector2(21, -4), Vector2(15, 0), Vector2(9, -8)]), SMOCK_GREY.darkened(0.12))
	# Body
	c.draw_colored_polygon(PackedVector2Array([Vector2(-10, -18), Vector2(10, -18), Vector2(15, 24), Vector2(-15, 24)]), SMOCK_GREY)
	# The let-down hem: four old fold lines
	for i in range(4):
		c.draw_line(Vector2(-14, 12 + i * 3.2), Vector2(14, 12 + i * 3.2), SMOCK_GREY.darkened(0.25), 0.8)
	# Collar tab with the number
	c.draw_rect(Rect2(-6, -19, 12, 12), LINEN)
	_text(c, Vector2(-3, -9), "7", 10, RED_INK)
	c.draw_line(Vector2(0, -6), Vector2(0, 10), SMOCK_GREY.darkened(0.2), 0.8)


## A pink laundry ticket on a pin: No. 2616, N. Fry.
static func _draw_laundry_ticket(c: CanvasItem) -> void:
	var pink := Color(0.95, 0.68, 0.72)
	c.draw_rect(Rect2(-21, -12, 44, 26), SHADOW)
	c.draw_rect(Rect2(-23, -14, 44, 26), pink)
	c.draw_rect(Rect2(-23, -14, 44, 26), pink.darkened(0.3), false, 1.0)
	_text(c, Vector2(-20, -6), "No.", 6, INK)
	_text(c, Vector2(-20, 6), "2616", 14, INK)
	_text(c, Vector2(4, -6), "N. Fry", 5, RED_INK)
	# The pin
	c.draw_circle(Vector2(17, -10), 2.2, Color(0.8, 0.66, 0.3))
	c.draw_circle(Vector2(16.4, -10.6), 0.8, Color(1, 1, 1, 0.8))


## A smooth wooden darning egg on a turned handle, a seam where it unscrews.
static func _draw_darning_egg(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 8), 21, 1.5, SHADOW)
	c.draw_rect(Rect2(-22, -2, 24, 4), WOOD_DARK)
	c.draw_circle(Vector2(-21, 0), 3.0, WOOD_DARK)
	c.draw_rect(Rect2(-2, -3.5, 5, 7), WOOD_DARK)
	PlaceholderArt.draw_ellipse(c, Vector2(11, 0), 11, 8, WOOD)
	PlaceholderArt.draw_ellipse(c, Vector2(9, -3), 5, 2, Color(1, 1, 1, 0.35))
	c.draw_line(Vector2(6, -7), Vector2(6, 7), WOOD_DARK, 0.9)


## A little muslin bag of laundry blue, its string knotted in loops.
static func _draw_blue_bag(c: CanvasItem) -> void:
	var blue := Color(0.2, 0.34, 0.74)
	PlaceholderArt.draw_ellipse(c, Vector2(0, 15), 12, 2, SHADOW)
	# The gathered neck
	c.draw_colored_polygon(PackedVector2Array([Vector2(-6, -12), Vector2(6, -12), Vector2(3, -5), Vector2(-3, -5)]), LINEN_DARK)
	# The bag, stained blue through the muslin
	PlaceholderArt.draw_ellipse(c, Vector2(0, 4), 13, 11, LINEN_DARK)
	PlaceholderArt.draw_ellipse(c, Vector2(0, 5), 11, 9, blue)
	PlaceholderArt.draw_ellipse(c, Vector2(-3, 2), 4, 3, blue.lightened(0.3))
	# The string: three short loops, then one long
	c.draw_line(Vector2(-4, -5.5), Vector2(4, -5.5), PAPER, 1.5)
	for i in range(3):
		c.draw_arc(Vector2(-6 + i * 3.0, -8), 1.6, 0.0, TAU, 8, PAPER, 0.8, true)
	c.draw_arc(Vector2(8, -10), 4.5, 0.0, TAU, 12, PAPER, 0.8, true)


## Long black-handled scissors on a loop of linen tape.
static func _draw_laundry_scissors(c: CanvasItem) -> void:
	# Tape loop
	c.draw_arc(Vector2(-22, 0), 4.0, 0.0, TAU, 12, LINEN, 1.5, true)
	# Handles
	c.draw_arc(Vector2(-14, -5), 4.5, 0.0, TAU, 14, IRON, 2.5, true)
	c.draw_arc(Vector2(-14, 5), 4.5, 0.0, TAU, 14, IRON, 2.5, true)
	# Blades
	c.draw_colored_polygon(PackedVector2Array([Vector2(-10, -4), Vector2(-2, -2), Vector2(26, 2), Vector2(-2, 2)]), STEEL)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-10, 4), Vector2(-2, -2), Vector2(26, -1), Vector2(-2, 2)]), SILVER)
	c.draw_line(Vector2(0, -1), Vector2(24, 0), Color(1, 1, 1, 0.9), 0.7)
	c.draw_circle(Vector2(-2, 0), 1.5, IRON)


## A narrow tally book of sheets, ward by ward; Ward 7 added in red.
static func _draw_linen_tally(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-15, -22, 32, 46), SHADOW)
	c.draw_rect(Rect2(-17, -24, 32, 46), Color(0.3, 0.2, 0.14))
	c.draw_rect(Rect2(-14, -22, 27, 42), PAPER)
	_text(c, Vector2(-12, -15), "LINEN", 6, INK)
	c.draw_line(Vector2(-12, -12), Vector2(11, -12), INK, 0.8)
	# Tally strokes for each ward
	for row in range(4):
		for stroke in range(5):
			c.draw_line(Vector2(-11 + stroke * 3.0, -9 + row * 6.0), Vector2(-11 + stroke * 3.0, -5 + row * 6.0), PENCIL, 0.9)
		c.draw_line(Vector2(-12, -5 + row * 6.0), Vector2(2, -9 + row * 6.0), PENCIL, 0.8)
	_text(c, Vector2(-12, 18.5), "W7: 7", 6, RED_INK)


## A small steel key on a safety pin.
static func _draw_locker_key(c: CanvasItem) -> void:
	# Safety pin
	c.draw_line(Vector2(-20, -6), Vector2(-2, -6), STEEL_DARK, 1.2)
	c.draw_line(Vector2(-20, -2), Vector2(-4, -2), STEEL_DARK, 1.2)
	c.draw_arc(Vector2(-20, -4), 2.0, PI * 0.5, PI * 1.5, 6, STEEL_DARK, 1.2, true)
	c.draw_rect(Rect2(-5, -8, 5, 7), STEEL)
	# Key
	c.draw_circle(Vector2(-10, 3), 5.5, SILVER)
	c.draw_circle(Vector2(-10, 2), 1.8, Color(0.1, 0.1, 0.12))
	c.draw_rect(Rect2(-5, 1.6, 24, 2.8), SILVER)
	c.draw_rect(Rect2(12, 4.4, 2.5, 4.5), SILVER)
	c.draw_rect(Rect2(16, 4.4, 2.5, 3), SILVER)
	c.draw_line(Vector2(-4, 2.2), Vector2(18, 2.2), Color(1, 1, 1, 0.9), 0.7)


## A folded pillowcase with R.M. picked out in red thread.
static func _draw_initialled_pillowcase(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-24, -14, 50, 32), SHADOW)
	c.draw_rect(Rect2(-26, -16, 50, 32), LINEN)
	c.draw_rect(Rect2(-26, 10, 50, 6), LINEN_DARK)
	c.draw_line(Vector2(-26, -4), Vector2(24, -4), LINEN_DARK, 0.8)
	# The hem with its buttons
	c.draw_line(Vector2(16, -16), Vector2(16, 16), LINEN_DARK, 1.0)
	for i in range(3):
		c.draw_circle(Vector2(20, -9 + i * 9.0), 1.2, LINEN_DARK)
	# The laundry number unpicked (only needle holes left), the initials sewn over it
	for i in range(5):
		c.draw_circle(Vector2(-20 + i * 2.5, 6), 0.5, PENCIL)
	_text(c, Vector2(-21, 3), "R.M.", 11, RED_INK)


## A slip of paper pressed as thin as a leaf, in a child's pencil.
static func _draw_mangle_note(c: CanvasItem) -> void:
	c.draw_colored_polygon(PackedVector2Array([Vector2(-23, -10), Vector2(22, -12), Vector2(23, 10), Vector2(-21, 12)]), Color(0.93, 0.91, 0.82))
	# Creases ironed in by the rollers
	c.draw_line(Vector2(-8, -11), Vector2(-7, 11), PAPER_DARK, 0.7)
	c.draw_line(Vector2(8, -11), Vector2(9, 11), PAPER_DARK, 0.7)
	_text(c, Vector2(-20, -3), "Are you real?", 5, PENCIL)
	_text(c, Vector2(-20, 4), "7 of us", 6, PENCIL)
	_text(c, Vector2(8, 10), "T.H.", 5, PENCIL)


## A letter ironed dry and flat, its fold lines scorched faintly brown.
static func _draw_pressed_letter(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-22, -16, 46, 34), SHADOW)
	c.draw_rect(Rect2(-24, -18, 46, 34), PAPER)
	c.draw_line(Vector2(-24, -6), Vector2(22, -6), Color(0.6, 0.45, 0.28, 0.7), 1.0)
	c.draw_line(Vector2(-24, 5), Vector2(22, 5), Color(0.6, 0.45, 0.28, 0.7), 1.0)
	_text(c, Vector2(-21, -9), "I believe you.", 6, INK)
	_lines(c, Vector2(-21, -2), 40.0, 5, 3.4, Color(0.3, 0.28, 0.4))
	# The mark of the iron's point in one corner
	c.draw_colored_polygon(PackedVector2Array([Vector2(10, 16), Vector2(22, 16), Vector2(22, 6)]), Color(0.5, 0.36, 0.2, 0.45))


## Small round spectacles, one arm mended with a binding of thread.
static func _draw_childs_spectacles(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 9), 22, 1.5, SHADOW)
	for lens_x: float in [-9.0, 9.0]:
		c.draw_circle(Vector2(lens_x, 0), 6.5, Color(0.75, 0.88, 0.9, 0.4))
		c.draw_arc(Vector2(lens_x, 0), 6.5, 0.0, TAU, 20, STEEL_DARK, 1.4, true)
		c.draw_arc(Vector2(lens_x, 0), 4.5, -2.6, -1.6, 6, Color(1, 1, 1, 0.8), 1.0, true)
	c.draw_arc(Vector2(0, 0), 2.6, PI, TAU, 8, STEEL_DARK, 1.4, true)
	# Arms
	c.draw_line(Vector2(-15.5, 0), Vector2(-24, 5), STEEL_DARK, 1.3)
	c.draw_line(Vector2(15.5, 0), Vector2(24, 5), STEEL_DARK, 1.3)
	# The thread mend
	c.draw_line(Vector2(18, 1.5), Vector2(21.5, 3.6), RED_INK, 3.0)


## A cheap pocket diary with a pencil pushed down its spine.
static func _draw_nells_diary(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-13, -19, 30, 42), SHADOW)
	c.draw_rect(Rect2(-15, -21, 30, 42), Color(0.16, 0.3, 0.24))
	c.draw_rect(Rect2(-15, -21, 5, 42), Color(0.1, 0.2, 0.16))
	c.draw_rect(Rect2(13, -19, 2, 38), PAPER)
	_text(c, Vector2(-8, -8), "1985", 7, Color(0.85, 0.75, 0.45))
	_text(c, Vector2(-8, 2), "DIARY", 5, Color(0.85, 0.75, 0.45))
	_text(c, Vector2(-8, 14), "N.F.", 6, PAPER)
	# The pencil
	c.draw_rect(Rect2(-17, -23, 3, 40), Color(0.9, 0.72, 0.2))
	c.draw_colored_polygon(PackedVector2Array([Vector2(-17, 17), Vector2(-14, 17), Vector2(-15.5, 22)]), PENCIL)


## A chit on stiff blue paper, signed E. Crane.
static func _draw_ward_seven_chit(c: CanvasItem) -> void:
	var blue := Color(0.56, 0.68, 0.86)
	c.draw_rect(Rect2(-21, -15, 44, 32), SHADOW)
	c.draw_rect(Rect2(-23, -17, 44, 32), blue)
	c.draw_rect(Rect2(-23, -17, 44, 32), blue.darkened(0.35), false, 1.0)
	_text(c, Vector2(-20, -8), "WARD 7", 8, INK)
	c.draw_line(Vector2(-20, -5), Vector2(18, -5), INK, 0.8)
	_text(c, Vector2(-20, 1), "Matron only", 5, INK)
	_text(c, Vector2(-20, 7), "after lights out", 4, INK)
	# Signature
	c.draw_polyline(PackedVector2Array([Vector2(-4, 12), Vector2(0, 9), Vector2(3, 12), Vector2(7, 9), Vector2(11, 12), Vector2(17, 10)]), RED_INK, 1.0, true)


## An iron key hanging from a hook of bent wire.
static func _draw_boiler_room_key(c: CanvasItem) -> void:
	# Wire hook
	c.draw_arc(Vector2(0, -21), 4.0, PI, TAU, 10, STEEL, 1.4, true)
	c.draw_line(Vector2(4, -21), Vector2(0, -12), STEEL, 1.4)
	# Bow
	c.draw_arc(Vector2(0, -6), 7.0, 0.0, TAU, 20, IRON, 3.5, true)
	c.draw_arc(Vector2(0, -6), 7.0, -2.4, -1.2, 6, IRON_LIGHT, 1.0, true)
	# Shank and bit
	c.draw_rect(Rect2(-2, 1, 4, 24), IRON)
	c.draw_line(Vector2(-1.2, 2), Vector2(-1.2, 24), IRON_LIGHT, 0.8)
	c.draw_rect(Rect2(2, 15, 8, 4), IRON)
	c.draw_rect(Rect2(2, 21, 6, 4), IRON)
	# Still warm
	c.draw_circle(Vector2(0, 8), 13.0, Color(1.0, 0.45, 0.15, 0.08))


## A page of a register, brown and bitten at the edges by the fire.
static func _draw_scorched_page(c: CanvasItem) -> void:
	var scorch := Color(0.34, 0.2, 0.1)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-20, -24), Vector2(12, -25), Vector2(17, -19), Vector2(20, -8), Vector2(18, 6),
		Vector2(21, 20), Vector2(10, 25), Vector2(-6, 22), Vector2(-21, 24), Vector2(-18, 4)]), scorch)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-17, -21), Vector2(10, -22), Vector2(14, -16), Vector2(16, -6), Vector2(14, 6),
		Vector2(16, 17), Vector2(8, 21), Vector2(-6, 18), Vector2(-17, 20), Vector2(-15, 2)]), PAPER)
	_text(c, Vector2(-14, -13), "ADMISSIONS", 4, INK)
	_text(c, Vector2(-14, -4), "1985", 9, RED_INK)
	_lines(c, Vector2(-13, 1), 24.0, 5, 3.6, Color(0.3, 0.28, 0.4))
	# Embers still eating one corner
	c.draw_circle(Vector2(15, 19), 1.4, Color(1.0, 0.5, 0.15))
	c.draw_circle(Vector2(11, 22), 1.0, Color(1.0, 0.7, 0.2))
