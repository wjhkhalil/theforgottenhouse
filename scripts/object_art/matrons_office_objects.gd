@tool
class_name MatronsOfficeObjects
extends RefCounted
## Placeholder drawings for the hidden objects of House Three, Chapter Six (The Matron's Office).
## Same rules as placeholder_art.gd: every drawing is centred on (0, 0) and
## fits inside get_size(). PlaceholderArt calls these functions.

const BRASS := Color(0.8, 0.62, 0.3)
const BRASS_DARK := Color(0.52, 0.38, 0.16)
const GOLD := Color(0.9, 0.74, 0.3)
const STEEL := Color(0.7, 0.72, 0.75)
const STEEL_DARK := Color(0.42, 0.44, 0.47)
const SILVER := Color(0.84, 0.85, 0.88)
const PAPER := Color(0.92, 0.88, 0.76)
const PAPER_DARK := Color(0.74, 0.68, 0.54)
const INK := Color(0.16, 0.14, 0.2)
const RED_INK := Color(0.72, 0.12, 0.1)
const BLACK := Color(0.07, 0.07, 0.08)
const LEATHER := Color(0.42, 0.26, 0.14)
const LEATHER_DARK := Color(0.24, 0.14, 0.08)
const MUD := Color(0.36, 0.26, 0.16)
const GLASS := Color(0.75, 0.88, 0.9, 0.55)
const SHADOW := Color(0, 0, 0, 0.35)

const SIZES := {
	HiddenObjectData.PlaceholderStyle.PICTURE_RAIL_KEY: Vector2(38, 16),
	HiddenObjectData.PlaceholderStyle.CADDY_KEY: Vector2(28, 14),
	HiddenObjectData.PlaceholderStyle.TRAVELLING_CLOAK: Vector2(44, 56),
	HiddenObjectData.PlaceholderStyle.RINGED_CALENDAR: Vector2(50, 56),
	HiddenObjectData.PlaceholderStyle.PACKED_VALISE: Vector2(56, 44),
	HiddenObjectData.PlaceholderStyle.MUDDY_GALOSHES: Vector2(52, 30),
	HiddenObjectData.PlaceholderStyle.TELEPHONE_RECEIVER: Vector2(52, 18),
	HiddenObjectData.PlaceholderStyle.SILVER_INKSTAND: Vector2(54, 36),
	HiddenObjectData.PlaceholderStyle.HAT_PIN: Vector2(14, 52),
	HiddenObjectData.PlaceholderStyle.BRASS_DESK_BELL: Vector2(34, 28),
	HiddenObjectData.PlaceholderStyle.PAYMENT_LEDGER: Vector2(36, 48),
	HiddenObjectData.PlaceholderStyle.SEVEN_DEATH_CERTS: Vector2(42, 50),
	HiddenObjectData.PlaceholderStyle.TRUE_REGISTER: Vector2(48, 38),
	HiddenObjectData.PlaceholderStyle.EIGHT_TICKETS: Vector2(50, 32),
	HiddenObjectData.PlaceholderStyle.BANK_BOOK: Vector2(34, 44),
	HiddenObjectData.PlaceholderStyle.SLEEPING_DRAUGHT: Vector2(24, 48),
	HiddenObjectData.PlaceholderStyle.MASTER_KEY: Vector2(56, 26),
	HiddenObjectData.PlaceholderStyle.CRANE_PHOTOGRAPH: Vector2(40, 50),
	HiddenObjectData.PlaceholderStyle.NAME_TAPE_REEL: Vector2(42, 34),
	HiddenObjectData.PlaceholderStyle.CHARRED_PHOTOGRAPHS: Vector2(48, 36),
	HiddenObjectData.PlaceholderStyle.VANE_FAMILY_RING: Vector2(28, 28),
	HiddenObjectData.PlaceholderStyle.NIGHT_COUNT_SLATE: Vector2(46, 42),
}


## Size of the drawing, or Vector2.ZERO if `style` is not one of this chapter's objects.
static func get_size(style: int) -> Vector2:
	return SIZES.get(style, Vector2.ZERO)


## Draws `style` and returns true, or returns false if it is not one of this chapter's objects.
static func draw(c: CanvasItem, style: int) -> bool:
	match style:
		HiddenObjectData.PlaceholderStyle.PICTURE_RAIL_KEY:
			_draw_picture_rail_key(c)
		HiddenObjectData.PlaceholderStyle.CADDY_KEY:
			_draw_caddy_key(c)
		HiddenObjectData.PlaceholderStyle.TRAVELLING_CLOAK:
			_draw_travelling_cloak(c)
		HiddenObjectData.PlaceholderStyle.RINGED_CALENDAR:
			_draw_ringed_calendar(c)
		HiddenObjectData.PlaceholderStyle.PACKED_VALISE:
			_draw_packed_valise(c)
		HiddenObjectData.PlaceholderStyle.MUDDY_GALOSHES:
			_draw_muddy_galoshes(c)
		HiddenObjectData.PlaceholderStyle.TELEPHONE_RECEIVER:
			_draw_telephone_receiver(c)
		HiddenObjectData.PlaceholderStyle.SILVER_INKSTAND:
			_draw_silver_inkstand(c)
		HiddenObjectData.PlaceholderStyle.HAT_PIN:
			_draw_hat_pin(c)
		HiddenObjectData.PlaceholderStyle.BRASS_DESK_BELL:
			_draw_brass_desk_bell(c)
		HiddenObjectData.PlaceholderStyle.PAYMENT_LEDGER:
			_draw_payment_ledger(c)
		HiddenObjectData.PlaceholderStyle.SEVEN_DEATH_CERTS:
			_draw_seven_death_certs(c)
		HiddenObjectData.PlaceholderStyle.TRUE_REGISTER:
			_draw_true_register(c)
		HiddenObjectData.PlaceholderStyle.EIGHT_TICKETS:
			_draw_eight_tickets(c)
		HiddenObjectData.PlaceholderStyle.BANK_BOOK:
			_draw_bank_book(c)
		HiddenObjectData.PlaceholderStyle.SLEEPING_DRAUGHT:
			_draw_sleeping_draught(c)
		HiddenObjectData.PlaceholderStyle.MASTER_KEY:
			_draw_master_key(c)
		HiddenObjectData.PlaceholderStyle.CRANE_PHOTOGRAPH:
			_draw_crane_photograph(c)
		HiddenObjectData.PlaceholderStyle.NAME_TAPE_REEL:
			_draw_name_tape_reel(c)
		HiddenObjectData.PlaceholderStyle.CHARRED_PHOTOGRAPHS:
			_draw_charred_photographs(c)
		HiddenObjectData.PlaceholderStyle.VANE_FAMILY_RING:
			_draw_vane_family_ring(c)
		HiddenObjectData.PlaceholderStyle.NIGHT_COUNT_SLATE:
			_draw_night_count_slate(c)
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


## A small brass key lying flat, grey with dust from the picture rail.
static func _draw_picture_rail_key(c: CanvasItem) -> void:
	c.draw_circle(Vector2(-11, 0), 6.5, BRASS)
	c.draw_circle(Vector2(-11, 0), 3.0, BLACK)
	c.draw_rect(Rect2(-5, -1.6, 22, 3.2), BRASS)
	c.draw_rect(Rect2(10, 1.6, 3, 5), BRASS)
	c.draw_rect(Rect2(14.5, 1.6, 2.5, 3.5), BRASS)
	c.draw_line(Vector2(-4, -1), Vector2(16, -1), Color(1, 0.95, 0.7, 0.9), 0.8)
	c.draw_line(Vector2(-16, 6.5), Vector2(17, 6.5), Color(0.7, 0.7, 0.68, 0.5), 1.5)


## A tiny silver key with a heart-shaped bow.
static func _draw_caddy_key(c: CanvasItem) -> void:
	c.draw_circle(Vector2(-9, -2), 3.2, SILVER)
	c.draw_circle(Vector2(-9, 2), 3.2, SILVER)
	c.draw_circle(Vector2(-8.5, 0), 1.3, BLACK)
	c.draw_rect(Rect2(-6, -1, 18, 2), SILVER)
	c.draw_rect(Rect2(8, 1, 2, 3.5), SILVER)
	c.draw_rect(Rect2(11, 1, 1.5, 2.5), SILVER)
	c.draw_line(Vector2(-5, -0.6), Vector2(12, -0.6), Color(1, 1, 1, 0.9), 0.6)


## A grey nurse's cloak hanging from its loop, the red lining showing down the front.
static func _draw_travelling_cloak(c: CanvasItem) -> void:
	var grey := Color(0.4, 0.42, 0.47)
	c.draw_arc(Vector2(0, -24), 3.0, PI, TAU, 8, STEEL_DARK, 1.5, true)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-8, -22), Vector2(8, -22), Vector2(21, 26), Vector2(-21, 26)]), grey)
	# The red lining where the front falls open
	c.draw_colored_polygon(PackedVector2Array([Vector2(-2, -16), Vector2(2, -16), Vector2(8, 26), Vector2(-8, 26)]), Color(0.66, 0.1, 0.12))
	c.draw_line(Vector2(0, -16), Vector2(0, 26), Color(0.4, 0.05, 0.07), 1.0)
	# Collar and its chain clasp
	c.draw_colored_polygon(PackedVector2Array([Vector2(-10, -22), Vector2(10, -22), Vector2(7, -14), Vector2(-7, -14)]), grey.darkened(0.25))
	c.draw_line(Vector2(-4, -13), Vector2(4, -13), SILVER, 1.2)
	# Folds
	c.draw_line(Vector2(-9, -10), Vector2(-15, 25), grey.darkened(0.3), 1.0)
	c.draw_line(Vector2(9, -10), Vector2(15, 25), grey.darkened(0.3), 1.0)
	c.draw_line(Vector2(-6, -12), Vector2(-17, 22), Color(1, 1, 1, 0.1), 2.0)


## A wall calendar: tonight's date ringed twice in red, and "01.25" written beside it.
static func _draw_ringed_calendar(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-22, -25, 48, 53), SHADOW)
	c.draw_rect(Rect2(-25, -28, 50, 54), PAPER)
	c.draw_rect(Rect2(-25, -28, 50, 9), Color(0.2, 0.3, 0.42))
	c.draw_circle(Vector2(0, -25), 1.5, BLACK)
	_text(c, Vector2(-11, -21), "MARCH", 6, PAPER)
	# A row of dates, the last one ringed twice
	for i in range(4):
		_text(c, Vector2(-22 + i * 11.0, -8), str(11 + i), 7, INK)
	c.draw_arc(Vector2(15.5, -10.5), 6.5, 0.0, TAU, 20, RED_INK, 1.4, true)
	c.draw_arc(Vector2(15, -10), 8.0, 0.4, TAU + 0.2, 20, RED_INK, 1.0, true)
	c.draw_line(Vector2(-22, 0), Vector2(22, 0), PAPER_DARK, 1.0)
	# The train time, in red pencil
	_text(c, Vector2(-21, 16), "01.25", 14, RED_INK)
	c.draw_line(Vector2(-21, 20), Vector2(19, 20), RED_INK, 1.4)


## A leather valise, strapped, with a big luggage label: E. VANE.
static func _draw_packed_valise(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 20), 27, 2, SHADOW)
	c.draw_arc(Vector2(0, -15), 6.0, PI, TAU, 10, LEATHER_DARK, 3.0, true)
	c.draw_rect(Rect2(-28, -15, 56, 35), LEATHER)
	c.draw_rect(Rect2(-28, -15, 56, 35), LEATHER_DARK, false, 1.5)
	c.draw_rect(Rect2(-28, -15, 56, 5), LEATHER_DARK)
	# Two straps with buckles
	for strap_x: float in [-21.0, 16.0]:
		c.draw_rect(Rect2(strap_x, -15, 5, 35), LEATHER_DARK)
		c.draw_rect(Rect2(strap_x - 1, -8, 7, 5), BRASS)
	# The label, tied to the handle
	c.draw_line(Vector2(0, -15), Vector2(-4, 0), PAPER_DARK, 1.0)
	c.draw_rect(Rect2(-27, 0, 54, 17), PAPER)
	c.draw_rect(Rect2(-27, 0, 54, 17), PAPER_DARK, false, 1.0)
	_text(c, Vector2(-25, 13.5), "E. VANE", 13, INK)


## A pair of black rubber overshoes, wet with mud from the moor road.
static func _draw_muddy_galoshes(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 12), 25, 3, Color(MUD, 0.6))
	for shoe in range(2):
		var offset := Vector2(-13 + shoe * 15.0, -3 + shoe * 4.0)
		c.draw_colored_polygon(PackedVector2Array([offset + Vector2(-11, -8), offset + Vector2(-2, -8), offset + Vector2(1, -1),
			offset + Vector2(20, 2), offset + Vector2(22, 9), offset + Vector2(-11, 9)]), BLACK.lightened(0.06 * shoe))
		c.draw_line(offset + Vector2(-10, -7), offset + Vector2(-3, -7), Color(1, 1, 1, 0.3), 1.0)
		c.draw_line(offset + Vector2(4, 2), Vector2(offset.x + 17, offset.y + 4), Color(1, 1, 1, 0.2), 1.0)
		# Mud on the sole and splashed up the side
		c.draw_rect(Rect2(offset.x - 11, offset.y + 7, 33, 3), MUD)
		c.draw_circle(offset + Vector2(12, 5), 2.2, MUD)
		c.draw_circle(offset + Vector2(-5, 4), 1.6, MUD.lightened(0.1))


## A black telephone receiver lying on its back, with a curl of cord.
static func _draw_telephone_receiver(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 8), 24, 1.5, SHADOW)
	c.draw_rect(Rect2(-17, -6, 34, 6), BLACK)
	c.draw_line(Vector2(-15, -5), Vector2(15, -5), Color(1, 1, 1, 0.35), 1.0)
	# Ear piece and mouth piece
	c.draw_colored_polygon(PackedVector2Array([Vector2(-25, -7), Vector2(-15, -7), Vector2(-14, 6), Vector2(-26, 6)]), BLACK)
	c.draw_colored_polygon(PackedVector2Array([Vector2(15, -7), Vector2(24, -7), Vector2(26, 6), Vector2(14, 6)]), BLACK)
	c.draw_line(Vector2(-25, 6), Vector2(-15, 6), STEEL_DARK, 1.2)
	c.draw_line(Vector2(15, 6), Vector2(25, 6), STEEL_DARK, 1.2)
	c.draw_polyline(PackedVector2Array([Vector2(-20, 6), Vector2(-22, 8.5), Vector2(-18, 8.5), Vector2(-16, 7)]), Color(0.3, 0.2, 0.14), 1.0, true)


## A silver inkstand with two cut-glass wells and a pen, engraved 1979.
static func _draw_silver_inkstand(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 17), 26, 2, SHADOW)
	# The two wells
	for well_x: float in [-15.0, 15.0]:
		c.draw_rect(Rect2(well_x - 7, -11, 14, 12), GLASS)
		c.draw_rect(Rect2(well_x - 6, -6, 12, 7), Color(0.08, 0.08, 0.2, 0.9))
		c.draw_rect(Rect2(well_x - 8, -15, 16, 5), SILVER)
		c.draw_circle(Vector2(well_x, -16), 2.0, SILVER)
		c.draw_line(Vector2(well_x - 5, -10), Vector2(well_x - 5, -1), Color(1, 1, 1, 0.7), 1.0)
	# A pen lying in the tray between them
	c.draw_line(Vector2(-6, -2), Vector2(7, -7), Color(0.1, 0.1, 0.12), 1.8)
	c.draw_line(Vector2(7, -7), Vector2(10, -8), BRASS, 1.2)
	# The base, with the engraving on its front
	c.draw_rect(Rect2(-27, 0, 54, 16), SILVER)
	c.draw_rect(Rect2(-27, 0, 54, 2), Color(1, 1, 1, 0.9))
	c.draw_rect(Rect2(-27, 14, 54, 2), STEEL_DARK)
	_text(c, Vector2(-16, 13), "1979", 13, INK)
	for foot_x: float in [-25.0, 21.0]:
		c.draw_rect(Rect2(foot_x, 16, 4, 2), STEEL_DARK)


## A long steel hat pin with a faceted jet head.
static func _draw_hat_pin(c: CanvasItem) -> void:
	c.draw_line(Vector2(0, -18), Vector2(0, 26), STEEL_DARK, 1.8)
	c.draw_line(Vector2(-0.4, -18), Vector2(-0.4, 24), Color(1, 1, 1, 0.8), 0.6)
	c.draw_colored_polygon(PackedVector2Array([Vector2(0, -26), Vector2(5.5, -21), Vector2(0, -15), Vector2(-5.5, -21)]), BLACK)
	c.draw_colored_polygon(PackedVector2Array([Vector2(0, -25), Vector2(-4, -21), Vector2(0, -20)]), Color(0.3, 0.3, 0.36))
	c.draw_circle(Vector2(-1.5, -22.5), 1.0, Color(1, 1, 1, 0.8))


## A brass bell on a black base, with a button on top to strike.
static func _draw_brass_desk_bell(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 13), 16, 2, SHADOW)
	c.draw_rect(Rect2(-16, 8, 32, 5), BLACK)
	# The dome
	var dome := PackedVector2Array()
	for i in range(13):
		dome.append(Vector2(0, 8) + Vector2.from_angle(PI + PI * i / 12.0) * 13.0)
	c.draw_colored_polygon(dome, BRASS)
	c.draw_arc(Vector2(0, 8), 10.0, PI + 0.4, PI + 1.2, 8, Color(1, 0.95, 0.7, 0.9), 2.0, true)
	c.draw_line(Vector2(-13, 7), Vector2(13, 7), BRASS_DARK, 1.2)
	# The striker button
	c.draw_rect(Rect2(-1.5, -11, 3, 6), BRASS_DARK)
	c.draw_rect(Rect2(-4, -13, 8, 3), BRASS)


## A slim ledger bound in green cloth, with a paper label.
static func _draw_payment_ledger(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-16, -22, 34, 46), SHADOW)
	c.draw_rect(Rect2(-18, -24, 34, 46), Color(0.12, 0.34, 0.22))
	c.draw_rect(Rect2(-18, -24, 5, 46), Color(0.07, 0.22, 0.14))
	c.draw_rect(Rect2(14, -23, 2, 44), PAPER)
	c.draw_rect(Rect2(-9, -16, 21, 14), PAPER)
	_text(c, Vector2(-7, -10), "R.V.", 6, INK)
	_text(c, Vector2(-7, -4), "x 7", 5, RED_INK)
	c.draw_line(Vector2(-10, 12), Vector2(13, 12), Color(0.8, 0.7, 0.3, 0.7), 1.0)


## Seven printed death certificates, fanned a little and held with a pin.
static func _draw_seven_death_certs(c: CanvasItem) -> void:
	for i in range(4):
		c.draw_rect(Rect2(-15 - i * 2.0, -19 - i * 2.0, 34, 44), PAPER_DARK.lightened(i * 0.08))
	c.draw_rect(Rect2(-21, -25, 34, 44), PAPER)
	c.draw_rect(Rect2(-21, -25, 34, 44), BLACK, false, 1.5)
	_text(c, Vector2(-17, -16), "DEATH", 6, BLACK)
	c.draw_line(Vector2(-18, -13), Vector2(10, -13), BLACK, 0.8)
	_lines(c, Vector2(-18, -8), 26.0, 5, 4.0, Color(0.3, 0.28, 0.4))
	# One signature on every sheet, and the pin
	c.draw_polyline(PackedVector2Array([Vector2(-6, 14), Vector2(-3, 10), Vector2(0, 15), Vector2(4, 10), Vector2(9, 13)]), INK, 1.0, true)
	c.draw_line(Vector2(6, -23), Vector2(11, -16), SILVER, 1.2)
	c.draw_circle(Vector2(6, -23), 1.5, SILVER)


## A thick black register with a lock strap and a brass clasp.
static func _draw_true_register(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-22, -17, 48, 36), SHADOW)
	c.draw_rect(Rect2(-24, -19, 48, 36), BLACK)
	c.draw_rect(Rect2(-24, -19, 6, 36), Color(0.2, 0.2, 0.22))
	c.draw_rect(Rect2(-18, 14, 41, 3), PAPER)
	c.draw_rect(Rect2(-12, -13, 26, 12), PAPER)
	_text(c, Vector2(-10, -4), "WARD 7", 6, INK)
	# The strap and its lock
	c.draw_rect(Rect2(8, 0, 16, 7), Color(0.2, 0.2, 0.22))
	c.draw_rect(Rect2(16, -1, 8, 9), BRASS)
	c.draw_circle(Vector2(20, 3.5), 1.3, BLACK)


## Eight green railway tickets, each torn across the middle.
static func _draw_eight_tickets(c: CanvasItem) -> void:
	var card := Color(0.56, 0.72, 0.54)
	for i in range(4):
		var x := -24.0 + i * 12.0
		var y := -14.0 + (i % 2) * 3.0
		# The two halves of one ticket, a little apart
		c.draw_colored_polygon(PackedVector2Array([Vector2(x, y), Vector2(x + 10, y), Vector2(x + 10, y + 11), Vector2(x + 6, y + 9),
			Vector2(x + 3, y + 12), Vector2(x, y + 10)]), card)
		c.draw_colored_polygon(PackedVector2Array([Vector2(x + 1, y + 15), Vector2(x + 4, y + 17), Vector2(x + 7, y + 14),
			Vector2(x + 11, y + 16), Vector2(x + 11, y + 27), Vector2(x + 1, y + 27)]), card.darkened(0.12))
		c.draw_line(Vector2(x + 2, y + 4), Vector2(x + 8, y + 4), INK, 0.8)
		c.draw_line(Vector2(x + 3, y + 22), Vector2(x + 9, y + 22), INK, 0.8)
	_text(c, Vector2(-23, -7), "01.25", 5, INK)
	_text(c, Vector2(1, 15), "SINGLE", 4, INK)


## A savings bank book in a buff cloth cover.
static func _draw_bank_book(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-15, -20, 32, 42), SHADOW)
	c.draw_rect(Rect2(-17, -22, 32, 42), Color(0.62, 0.52, 0.36))
	c.draw_rect(Rect2(-17, -22, 32, 42), Color(0.4, 0.32, 0.2), false, 1.2)
	c.draw_rect(Rect2(-12, -16, 22, 16), PAPER)
	_text(c, Vector2(-10, -9), "BANK", 6, INK)
	_text(c, Vector2(-10, -3), "BOOK", 6, INK)
	_text(c, Vector2(-11, 12), "NIL", 8, RED_INK)
	c.draw_line(Vector2(-12, 14), Vector2(8, 14), RED_INK, 1.0)


## A corked medicine bottle of brown glass with a hand-written label.
static func _draw_sleeping_draught(c: CanvasItem) -> void:
	var glass := Color(0.36, 0.2, 0.1, 0.92)
	PlaceholderArt.draw_ellipse(c, Vector2(0, 23), 11, 2, SHADOW)
	c.draw_rect(Rect2(-3.5, -24, 7, 6), Color(0.72, 0.56, 0.36))
	c.draw_rect(Rect2(-4, -18, 8, 7), glass)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-4, -11), Vector2(4, -11), Vector2(10, -5), Vector2(-10, -5)]), glass)
	c.draw_rect(Rect2(-10, -5, 20, 28), glass)
	c.draw_line(Vector2(-7, -3), Vector2(-7, 20), Color(1, 0.8, 0.6, 0.45), 1.5)
	c.draw_rect(Rect2(-8, 0, 16, 16), PAPER)
	_text(c, Vector2(-6, 7), "x 2", 6, RED_INK)
	_lines(c, Vector2(-6, 10), 12.0, 2, 3.0, INK)


## A heavy iron key whose bow is a ring cut with seven notches.
static func _draw_master_key(c: CanvasItem) -> void:
	var iron := Color(0.22, 0.22, 0.24)
	PlaceholderArt.draw_ellipse(c, Vector2(0, 11), 26, 2, SHADOW)
	c.draw_circle(Vector2(-16, 0), 11.0, iron)
	c.draw_circle(Vector2(-16, 0), 6.0, Color(0.04, 0.04, 0.05))
	# Seven notches round the ring
	for i in range(7):
		var direction := Vector2.from_angle(PI * 0.5 + TAU * (i + 0.5) / 8.0)
		c.draw_line(Vector2(-16, 0) + direction * 8.0, Vector2(-16, 0) + direction * 11.5, BRASS, 1.6)
	c.draw_rect(Rect2(-6, -2.5, 33, 5), iron)
	c.draw_line(Vector2(-5, -1.6), Vector2(26, -1.6), Color(0.6, 0.6, 0.64), 0.9)
	c.draw_rect(Rect2(8, -3.5, 3, 7), iron)
	c.draw_rect(Rect2(17, 2.5, 4, 9), iron)
	c.draw_rect(Rect2(23, 2.5, 4, 6.5), iron)


## A sepia studio photograph on a card mount: a boy and a smaller girl.
static func _draw_crane_photograph(c: CanvasItem) -> void:
	var sepia := Color(0.4, 0.3, 0.2)
	var pale := Color(0.86, 0.76, 0.6)
	c.draw_rect(Rect2(-20, -25, 40, 50), Color(0.8, 0.74, 0.6))
	c.draw_rect(Rect2(-16, -21, 32, 36), sepia)
	c.draw_rect(Rect2(-16, 8, 32, 7), sepia.darkened(0.3))
	# The boy, taller, in a dark jacket
	c.draw_circle(Vector2(-6, -11), 4.0, pale)
	c.draw_rect(Rect2(-10, -15, 8, 2.5), sepia.darkened(0.5))
	c.draw_rect(Rect2(-11, -7, 10, 14), sepia.darkened(0.55))
	c.draw_rect(Rect2(-10, 7, 3.5, 6), sepia.darkened(0.55))
	c.draw_rect(Rect2(-5, 7, 3.5, 6), sepia.darkened(0.55))
	# The girl, smaller, in a pale frock with a bow in her hair
	c.draw_circle(Vector2(7, -5), 3.5, pale)
	c.draw_rect(Rect2(3, -9, 8, 2), sepia.darkened(0.4))
	c.draw_circle(Vector2(10.5, -9.5), 1.6, Color(0.95, 0.9, 0.8))
	c.draw_colored_polygon(PackedVector2Array([Vector2(4, -2), Vector2(10, -2), Vector2(13, 10), Vector2(1, 10)]), pale.darkened(0.1))
	c.draw_line(Vector2(1, 2), Vector2(4, 0), pale, 1.5)  # their hands joined
	_text(c, Vector2(-11, 22), "1946", 6, INK)


## A wooden reel wound with white woven tape; the loose end shows numbers 1 to 7.
static func _draw_name_tape_reel(c: CanvasItem) -> void:
	var tape := Color(0.93, 0.92, 0.86)
	PlaceholderArt.draw_ellipse(c, Vector2(-7, 15), 14, 2, SHADOW)
	c.draw_circle(Vector2(-7, 1), 13.0, Color(0.6, 0.44, 0.26))
	c.draw_circle(Vector2(-7, 1), 11.0, tape)
	c.draw_arc(Vector2(-7, 1), 8.0, 0.0, TAU, 20, PAPER_DARK, 0.8, true)
	c.draw_circle(Vector2(-7, 1), 4.0, Color(0.6, 0.44, 0.26))
	c.draw_circle(Vector2(-7, 1), 1.5, BLACK)
	# The loose end, woven in red: numbers, not names
	c.draw_rect(Rect2(-7, -15, 28, 7), tape)
	c.draw_rect(Rect2(-7, -15, 28, 7), PAPER_DARK, false, 0.8)
	_text(c, Vector2(-3, -9.5), "1 2 3..7", 5, RED_INK)


## A handful of small passport photographs, burnt black at the edges.
static func _draw_charred_photographs(c: CanvasItem) -> void:
	var char_black := Color(0.06, 0.05, 0.05)
	var corners: Array[Vector2] = [Vector2(-22, -15), Vector2(-5, -17), Vector2(8, -10), Vector2(-14, 1), Vector2(4, 3)]
	for i in range(corners.size()):
		var at := corners[i]
		c.draw_rect(Rect2(at.x - 1.5, at.y - 1.5, 17, 17), char_black)
		c.draw_rect(Rect2(at, Vector2(13, 13)), Color(0.72, 0.68, 0.6))
		# A face
		c.draw_circle(at + Vector2(6.5, 5), 2.8, Color(0.36, 0.33, 0.3))
		c.draw_rect(Rect2(at.x + 2.5, at.y + 8, 8, 5), Color(0.3, 0.28, 0.26))
		# The burnt corner
		c.draw_colored_polygon(PackedVector2Array([at + Vector2(7, 13), at + Vector2(13, 6), at + Vector2(13, 13)]), char_black)
	c.draw_circle(Vector2(19, 12), 1.4, Color(0.9, 0.4, 0.1, 0.8))
	c.draw_circle(Vector2(-19, 13), 1.0, Color(0.5, 0.5, 0.5, 0.7))


## A gold signet ring with a worn crest on its oval face.
static func _draw_vane_family_ring(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 13), 10, 1.5, SHADOW)
	c.draw_arc(Vector2(0, 3), 8.5, 0.0, TAU, 28, BRASS_DARK, 4.5, true)
	c.draw_arc(Vector2(0, 3), 8.5, 0.0, TAU, 28, GOLD, 3.0, true)
	c.draw_arc(Vector2(0, 3), 8.5, PI + 0.3, PI + 1.1, 8, Color(1, 1, 0.85, 0.9), 1.2, true)
	# The signet face and its crest: a weather vane
	PlaceholderArt.draw_ellipse(c, Vector2(0, -7), 7.5, 5.5, BRASS_DARK)
	PlaceholderArt.draw_ellipse(c, Vector2(0, -7), 6.2, 4.3, GOLD)
	c.draw_line(Vector2(0, -10), Vector2(0, -4), BRASS_DARK, 1.0)
	c.draw_line(Vector2(-3.5, -8), Vector2(3.5, -8), BRASS_DARK, 1.0)
	c.draw_colored_polygon(PackedVector2Array([Vector2(3.5, -9.5), Vector2(5.5, -8), Vector2(3.5, -6.5)]), BRASS_DARK)


## A school slate in a wooden frame, hung on a string: "7" and chalk tallies.
static func _draw_night_count_slate(c: CanvasItem) -> void:
	var chalk := Color(0.92, 0.92, 0.88)
	c.draw_polyline(PackedVector2Array([Vector2(-12, -15), Vector2(0, -21), Vector2(12, -15)]), PAPER_DARK, 1.0, true)
	c.draw_rect(Rect2(-23, -15, 46, 35), Color(0.6, 0.44, 0.26))
	c.draw_rect(Rect2(-19, -11, 38, 27), Color(0.13, 0.15, 0.17))
	_text(c, Vector2(-16, 1), "12: 7", 9, chalk)
	# Seven tally strokes: five crossed, and two
	for i in range(4):
		c.draw_line(Vector2(-15 + i * 3.0, 5), Vector2(-15 + i * 3.0, 13), chalk, 1.0)
	c.draw_line(Vector2(-17, 12), Vector2(-4, 6), chalk, 1.0)
	c.draw_line(Vector2(0, 5), Vector2(0, 13), chalk, 1.0)
	c.draw_line(Vector2(3, 5), Vector2(3, 13), chalk, 1.0)
	_text(c, Vector2(7, 12), "1!", 6, chalk)
