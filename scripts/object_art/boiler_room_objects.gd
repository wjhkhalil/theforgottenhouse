@tool
class_name BoilerRoomObjects
extends RefCounted
## Placeholder drawings for the hidden objects of House Three, Chapter Four (The Boiler Room).
## Same rules as placeholder_art.gd: every drawing is centred on (0, 0) and
## fits inside get_size(). PlaceholderArt calls these functions.

const BRASS := Color(0.82, 0.64, 0.3)
const BRASS_DARK := Color(0.52, 0.38, 0.16)
const BRASS_BRIGHT := Color(1.0, 0.88, 0.5)
const IRON := Color(0.3, 0.31, 0.34)
const IRON_DARK := Color(0.15, 0.15, 0.17)
const STEEL := Color(0.72, 0.74, 0.77)
const TIN := Color(0.62, 0.65, 0.66)
const WOOD := Color(0.6, 0.42, 0.24)
const PAPER := Color(0.92, 0.88, 0.76)
const PAPER_DARK := Color(0.74, 0.68, 0.54)
const BUFF := Color(0.82, 0.7, 0.46)
const SCORCH := Color(0.12, 0.08, 0.06)
const INK := Color(0.16, 0.14, 0.2)
const RED_INK := Color(0.62, 0.12, 0.1)
const PENCIL := Color(0.3, 0.3, 0.34)
const SOOT := Color(0.08, 0.08, 0.09)
const SHADOW := Color(0, 0, 0, 0.35)

const SIZES := {
	HiddenObjectData.PlaceholderStyle.COAL_SHOVEL: Vector2(56, 18),
	HiddenObjectData.PlaceholderStyle.STOKERS_CAP: Vector2(44, 24),
	HiddenObjectData.PlaceholderStyle.CRACKED_GAUGE: Vector2(36, 36),
	HiddenObjectData.PlaceholderStyle.OIL_RAG: Vector2(40, 26),
	HiddenObjectData.PlaceholderStyle.BILLY_CAN: Vector2(30, 40),
	HiddenObjectData.PlaceholderStyle.SPANNER: Vector2(52, 16),
	HiddenObjectData.PlaceholderStyle.CLINKER_RAKE: Vector2(16, 56),
	HiddenObjectData.PlaceholderStyle.HALF_BURNT_LEDGER: Vector2(46, 34),
	HiddenObjectData.PlaceholderStyle.MAKERS_PLATE: Vector2(54, 30),
	HiddenObjectData.PlaceholderStyle.BURIED_SATCHEL: Vector2(46, 40),
	HiddenObjectData.PlaceholderStyle.SCORCHED_BUCKLE: Vector2(26, 24),
	HiddenObjectData.PlaceholderStyle.BURN_ORDER: Vector2(38, 48),
	HiddenObjectData.PlaceholderStyle.LIFT_CRANK: Vector2(46, 30),
	HiddenObjectData.PlaceholderStyle.UNBURNT_FILE: Vector2(46, 36),
	HiddenObjectData.PlaceholderStyle.STOKERS_PAY_SLIP: Vector2(44, 28),
	HiddenObjectData.PlaceholderStyle.NIGHT_LOG: Vector2(44, 36),
	HiddenObjectData.PlaceholderStyle.PENCILLED_PLAN: Vector2(46, 36),
	HiddenObjectData.PlaceholderStyle.TIN_WHISTLE: Vector2(54, 12),
	HiddenObjectData.PlaceholderStyle.LIFT_KEY: Vector2(50, 20),
	HiddenObjectData.PlaceholderStyle.DOSE_CUP: Vector2(24, 30),
}


## Size of the drawing, or Vector2.ZERO if `style` is not one of this chapter's objects.
static func get_size(style: int) -> Vector2:
	return SIZES.get(style, Vector2.ZERO)


## Draws `style` and returns true, or returns false if it is not one of this chapter's objects.
static func draw(c: CanvasItem, style: int) -> bool:
	match style:
		HiddenObjectData.PlaceholderStyle.COAL_SHOVEL:
			_draw_coal_shovel(c)
		HiddenObjectData.PlaceholderStyle.STOKERS_CAP:
			_draw_stokers_cap(c)
		HiddenObjectData.PlaceholderStyle.CRACKED_GAUGE:
			_draw_cracked_gauge(c)
		HiddenObjectData.PlaceholderStyle.OIL_RAG:
			_draw_oil_rag(c)
		HiddenObjectData.PlaceholderStyle.BILLY_CAN:
			_draw_billy_can(c)
		HiddenObjectData.PlaceholderStyle.SPANNER:
			_draw_spanner(c)
		HiddenObjectData.PlaceholderStyle.CLINKER_RAKE:
			_draw_clinker_rake(c)
		HiddenObjectData.PlaceholderStyle.HALF_BURNT_LEDGER:
			_draw_half_burnt_ledger(c)
		HiddenObjectData.PlaceholderStyle.MAKERS_PLATE:
			_draw_makers_plate(c)
		HiddenObjectData.PlaceholderStyle.BURIED_SATCHEL:
			_draw_buried_satchel(c)
		HiddenObjectData.PlaceholderStyle.SCORCHED_BUCKLE:
			_draw_scorched_buckle(c)
		HiddenObjectData.PlaceholderStyle.BURN_ORDER:
			_draw_burn_order(c)
		HiddenObjectData.PlaceholderStyle.LIFT_CRANK:
			_draw_lift_crank(c)
		HiddenObjectData.PlaceholderStyle.UNBURNT_FILE:
			_draw_unburnt_file(c)
		HiddenObjectData.PlaceholderStyle.STOKERS_PAY_SLIP:
			_draw_stokers_pay_slip(c)
		HiddenObjectData.PlaceholderStyle.NIGHT_LOG:
			_draw_night_log(c)
		HiddenObjectData.PlaceholderStyle.PENCILLED_PLAN:
			_draw_pencilled_plan(c)
		HiddenObjectData.PlaceholderStyle.TIN_WHISTLE:
			_draw_tin_whistle(c)
		HiddenObjectData.PlaceholderStyle.LIFT_KEY:
			_draw_lift_key(c)
		HiddenObjectData.PlaceholderStyle.DOSE_CUP:
			_draw_dose_cup(c)
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


## A stoker's shovel lying flat: a worn bright blade, with burnt paper stuck to it.
static func _draw_coal_shovel(c: CanvasItem) -> void:
	# Shaft and D-handle
	c.draw_line(Vector2(-20, 0), Vector2(8, 0), WOOD.darkened(0.2), 4.0)
	c.draw_line(Vector2(-20, -1), Vector2(8, -1), WOOD, 1.5)
	c.draw_rect(Rect2(-28, -6, 4, 12), WOOD.darkened(0.2))
	c.draw_line(Vector2(-26, -5), Vector2(-20, 0), WOOD.darkened(0.2), 2.5)
	c.draw_line(Vector2(-26, 5), Vector2(-20, 0), WOOD.darkened(0.2), 2.5)
	# Blade
	c.draw_colored_polygon(PackedVector2Array([Vector2(6, -3), Vector2(12, -9), Vector2(27, -8), Vector2(28, 8), Vector2(12, 9),
		Vector2(6, 3)]), IRON)
	c.draw_colored_polygon(PackedVector2Array([Vector2(18, -8), Vector2(27, -8), Vector2(28, 8), Vector2(18, 8)]), STEEL)
	c.draw_line(Vector2(12, -8), Vector2(12, 8), IRON_DARK, 1.0)
	# Flakes of burnt paper
	c.draw_rect(Rect2(20, -4, 4, 3), SCORCH)
	c.draw_rect(Rect2(22, 3, 3, 3), SCORCH)
	c.draw_rect(Rect2(15, 1, 3, 2), PAPER_DARK)


## A greasy flat cap, black with coal dust.
static func _draw_stokers_cap(c: CanvasItem) -> void:
	var cloth := Color(0.2, 0.2, 0.22)
	# Peak
	c.draw_colored_polygon(PackedVector2Array([Vector2(4, 2), Vector2(21, 5), Vector2(20, 10), Vector2(2, 9)]), SOOT)
	# Crown
	c.draw_colored_polygon(PackedVector2Array([Vector2(-21, 6), Vector2(-19, -5), Vector2(-8, -11), Vector2(6, -10), Vector2(15, -3),
		Vector2(16, 6), Vector2(-4, 10)]), cloth)
	c.draw_line(Vector2(-20, 6), Vector2(-4, 10), SOOT, 2.0)
	c.draw_line(Vector2(-4, 10), Vector2(16, 6), SOOT, 2.0)
	# Seams and the button on top
	c.draw_line(Vector2(-3, -9), Vector2(-10, 7), Color(0.34, 0.34, 0.36), 0.8)
	c.draw_line(Vector2(-3, -9), Vector2(8, 6), Color(0.34, 0.34, 0.36), 0.8)
	c.draw_circle(Vector2(-3, -9), 1.8, Color(0.34, 0.34, 0.36))
	# A greasy shine
	c.draw_line(Vector2(-15, -3), Vector2(-9, -7), Color(1, 1, 1, 0.18), 2.0)


## A brass pressure gauge: cracked glass, the needle jammed in the red.
static func _draw_cracked_gauge(c: CanvasItem) -> void:
	c.draw_circle(Vector2.ZERO, 17.5, BRASS_DARK)
	c.draw_circle(Vector2.ZERO, 16.0, BRASS)
	c.draw_circle(Vector2.ZERO, 13.0, Color(0.95, 0.93, 0.86))
	# The scale, with its red danger zone on the right
	c.draw_arc(Vector2.ZERO, 10.5, PI * 0.8, PI * 1.85, 18, INK, 1.2, true)
	c.draw_arc(Vector2.ZERO, 10.5, PI * 1.85, PI * 2.2, 10, Color(0.85, 0.12, 0.1), 3.0, true)
	for i in range(8):
		var direction := Vector2.from_angle(PI * 0.8 + i * PI * 0.2)
		c.draw_line(direction * 8.0, direction * 10.5, INK, 0.8)
	# Needle, hard over
	c.draw_line(Vector2.ZERO, Vector2.from_angle(PI * 2.05) * 11.0, INK, 1.6)
	c.draw_circle(Vector2.ZERO, 2.0, BRASS_DARK)
	# The crack across the glass
	c.draw_polyline(PackedVector2Array([Vector2(-11, -6), Vector2(-4, -1), Vector2(-6, 4), Vector2(2, 7), Vector2(5, 12)]),
		Color(0.2, 0.25, 0.3, 0.9), 1.0, true)
	c.draw_line(Vector2(-4, -1), Vector2(3, -7), Color(0.2, 0.25, 0.3, 0.7), 0.8)
	c.draw_arc(Vector2.ZERO, 11.5, -2.6, -1.7, 8, Color(1, 1, 1, 0.8), 1.2, true)


## A crumpled rag, stiff with oil, with the brass corner of a ledger showing.
static func _draw_oil_rag(c: CanvasItem) -> void:
	var rag := Color(0.34, 0.3, 0.24)
	PlaceholderArt.draw_ellipse(c, Vector2(0, 11), 18, 2, SHADOW)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-19, 2), Vector2(-13, -9), Vector2(-2, -6), Vector2(6, -12), Vector2(18, -6),
		Vector2(15, 4), Vector2(19, 11), Vector2(2, 9), Vector2(-10, 12)]), rag)
	# Folds and oil stains
	c.draw_polyline(PackedVector2Array([Vector2(-13, -8), Vector2(-6, 0), Vector2(-10, 10)]), rag.darkened(0.4), 1.0, true)
	c.draw_polyline(PackedVector2Array([Vector2(6, -11), Vector2(3, -1), Vector2(12, 6)]), rag.darkened(0.4), 1.0, true)
	PlaceholderArt.draw_ellipse(c, Vector2(-11, 3), 5, 4, Color(0.06, 0.05, 0.05, 0.7))
	PlaceholderArt.draw_ellipse(c, Vector2(11, -4), 4, 3, Color(0.06, 0.05, 0.05, 0.7))
	# The snapped-off brass corner
	c.draw_colored_polygon(PackedVector2Array([Vector2(-2, -3), Vector2(8, -3), Vector2(8, 7)]), BRASS)
	c.draw_line(Vector2(-2, -3), Vector2(8, 7), BRASS_DARK, 1.0)
	c.draw_circle(Vector2(5.5, -0.5), 1.0, BRASS_DARK)


## A dented tin tea can with a wire handle and a lid.
static func _draw_billy_can(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 19), 13, 2, SHADOW)
	# Wire handle
	c.draw_arc(Vector2(0, -6), 12.0, PI, TAU, 14, IRON, 1.5, true)
	# Body
	c.draw_rect(Rect2(-12, -6, 24, 24), TIN.darkened(0.2))
	c.draw_rect(Rect2(-12, -6, 9, 24), TIN)
	c.draw_rect(Rect2(8, -6, 4, 24), TIN.darkened(0.45))
	# Lid and rim
	c.draw_rect(Rect2(-13, -9, 26, 4), TIN.lightened(0.15))
	c.draw_rect(Rect2(-4, -12, 8, 3), TIN.darkened(0.2))
	c.draw_line(Vector2(-12, 16), Vector2(12, 16), TIN.darkened(0.5), 1.5)
	# A dent, and soot from the fire up one side
	c.draw_arc(Vector2(2, 5), 5.0, 0.4, 2.4, 8, TIN.darkened(0.5), 1.2, true)
	c.draw_rect(Rect2(-12, 8, 24, 9), Color(0, 0, 0, 0.3))
	# A wisp of steam: the tea is still warm
	c.draw_polyline(PackedVector2Array([Vector2(7, -11), Vector2(9, -14), Vector2(7, -17), Vector2(9, -19)]), Color(1, 1, 1, 0.5), 1.0, true)


## A long adjustable spanner.
static func _draw_spanner(c: CanvasItem) -> void:
	# Handle
	c.draw_rect(Rect2(-25, -3, 36, 6), IRON)
	c.draw_line(Vector2(-24, -1.5), Vector2(10, -1.5), STEEL, 1.0)
	c.draw_circle(Vector2(-22, 0), 1.6, IRON_DARK)
	# Fixed jaw, sliding jaw and the worm screw
	c.draw_colored_polygon(PackedVector2Array([Vector2(9, -5), Vector2(25, -8), Vector2(26, -3), Vector2(17, -2), Vector2(17, 5),
		Vector2(9, 5)]), IRON)
	c.draw_rect(Rect2(19, 2, 7, 5), IRON)
	c.draw_rect(Rect2(11, 2, 6, 5), STEEL)
	for i in range(3):
		c.draw_line(Vector2(12 + i * 2.0, 2), Vector2(12 + i * 2.0, 7), IRON_DARK, 0.8)
	c.draw_line(Vector2(10, -4), Vector2(24, -7), STEEL, 0.8)


## A long iron rake for dragging clinker out of the fire, standing upright.
static func _draw_clinker_rake(c: CanvasItem) -> void:
	# Ring handle at the top
	c.draw_arc(Vector2(0, -23), 4.5, 0.0, TAU, 14, IRON, 2.0, true)
	# Shaft
	c.draw_line(Vector2(0, -19), Vector2(0, 22), IRON_DARK, 3.5)
	c.draw_line(Vector2(-0.8, -19), Vector2(-0.8, 22), STEEL, 0.8)
	# The hooked blade at the bottom, burnt rusty
	c.draw_rect(Rect2(-7, 21, 14, 4), IRON_DARK)
	c.draw_rect(Rect2(-7, 21, 4, 7), Color(0.4, 0.2, 0.12))
	c.draw_rect(Rect2(3, 21, 4, 7), Color(0.4, 0.2, 0.12))
	c.draw_line(Vector2(-7, 21.5), Vector2(7, 21.5), Color(0.6, 0.3, 0.16), 1.0)


## A ledger pulled from the ash: one edge burnt away, a column of payments left.
static func _draw_half_burnt_ledger(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-21, -15, 40, 32), SHADOW)
	# Cover, burnt ragged down the right-hand side
	c.draw_colored_polygon(PackedVector2Array([Vector2(-23, -17), Vector2(14, -17), Vector2(19, -9), Vector2(13, -2), Vector2(21, 6),
		Vector2(15, 15), Vector2(-23, 15)]), Color(0.3, 0.12, 0.1))
	# Page
	c.draw_colored_polygon(PackedVector2Array([Vector2(-20, -14), Vector2(11, -14), Vector2(15, -8), Vector2(9, -2), Vector2(16, 6),
		Vector2(11, 12), Vector2(-20, 12)]), PAPER)
	# The scorched edge
	c.draw_polyline(PackedVector2Array([Vector2(11, -14), Vector2(15, -8), Vector2(9, -2), Vector2(16, 6), Vector2(11, 12)]), SCORCH, 2.5, true)
	c.draw_polyline(PackedVector2Array([Vector2(8, -13), Vector2(11, -8), Vector2(6, -2), Vector2(12, 6), Vector2(8, 11)]),
		Color(0.4, 0.24, 0.1, 0.7), 1.5, true)
	# Payments, and the initials
	_text(c, Vector2(-18, -7), "7 heads", 5, INK)
	_lines(c, Vector2(-18, -3), 20.0, 3, 3.5, Color(0.3, 0.28, 0.4))
	_text(c, Vector2(-18, 11), "R.V.", 6, RED_INK)


## The boiler's brass plate: "No. 1911", the numbers polished bright.
static func _draw_makers_plate(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-27, -15, 54, 30), BRASS_DARK)
	c.draw_rect(Rect2(-25, -13, 50, 26), BRASS)
	c.draw_rect(Rect2(-23, -11, 46, 22), BRASS_DARK, false, 1.0)
	# Rivets
	for corner: Vector2 in [Vector2(-21, -9), Vector2(21, -9), Vector2(-21, 9), Vector2(21, 9)]:
		c.draw_circle(corner, 1.6, BRASS_DARK)
		c.draw_circle(corner + Vector2(-0.4, -0.4), 0.7, BRASS_BRIGHT)
	_text(c, Vector2(-13, -5), "BOILER", 5, BRASS_DARK)
	# The patch Hobbs has rubbed bright with his thumb
	c.draw_rect(Rect2(-18, -3, 36, 12), BRASS_BRIGHT)
	_text(c, Vector2(-17, 7), "No. 1911", 8, INK)


## A child's school satchel, black with coal dust.
static func _draw_buried_satchel(c: CanvasItem) -> void:
	var leather := Color(0.3, 0.2, 0.13)
	PlaceholderArt.draw_ellipse(c, Vector2(0, 19), 21, 2.5, SHADOW)
	# Shoulder strap
	c.draw_arc(Vector2(0, -8), 14.0, PI + 0.3, TAU - 0.3, 14, leather.darkened(0.3), 2.5, true)
	# Body and flap
	c.draw_rect(Rect2(-21, -8, 42, 26), leather.darkened(0.25))
	c.draw_colored_polygon(PackedVector2Array([Vector2(-22, -10), Vector2(22, -10), Vector2(22, 4), Vector2(16, 8), Vector2(-16, 8),
		Vector2(-22, 4)]), leather)
	# Two straps and buckles
	for strap_x: float in [-12.0, 12.0]:
		c.draw_rect(Rect2(strap_x - 2, -10, 4, 24), leather.darkened(0.4))
		c.draw_rect(Rect2(strap_x - 3, 8, 6, 5), BRASS, false, 1.2)
	# Name label inside the flap, just showing
	c.draw_rect(Rect2(-7, -6, 14, 7), PAPER)
	_text(c, Vector2(-6, -1), "T.Hale", 4, INK)
	# Coal dust
	PlaceholderArt.draw_ellipse(c, Vector2(-14, 12), 8, 5, Color(0, 0, 0, 0.45))
	PlaceholderArt.draw_ellipse(c, Vector2(13, -5), 7, 4, Color(0, 0, 0, 0.4))
	c.draw_circle(Vector2(4, 14), 1.5, SOOT)
	c.draw_circle(Vector2(-3, 16), 1.2, SOOT)


## The brass buckle of a small shoe, blackened by the fire.
static func _draw_scorched_buckle(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 10), 11, 2, SHADOW)
	# A scrap of charred strap
	c.draw_rect(Rect2(-13, -3, 8, 6), SCORCH)
	# Frame
	c.draw_rect(Rect2(-9, -9, 18, 18), BRASS_DARK, false, 4.0)
	c.draw_rect(Rect2(-9, -9, 18, 18), BRASS, false, 2.0)
	# Bar and prong
	c.draw_line(Vector2(-3, -9), Vector2(-3, 9), BRASS_DARK, 2.0)
	c.draw_line(Vector2(-3, 0), Vector2(10, 0), BRASS, 1.5)
	# Scorch marks
	c.draw_line(Vector2(2, -9), Vector2(9, -9), SCORCH, 3.0)
	c.draw_line(Vector2(9, -9), Vector2(9, -2), SCORCH, 3.0)
	c.draw_circle(Vector2(-8, 8), 1.0, BRASS_BRIGHT)


## A sheet of headed paper, scorched at one corner: the matron's order.
static func _draw_burn_order(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-16, -22, 34, 46), SHADOW)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-18, -24), Vector2(16, -24), Vector2(16, 12), Vector2(11, 15), Vector2(12, 20),
		Vector2(6, 22), Vector2(-18, 22)]), PAPER)
	# The scorched corner
	c.draw_polyline(PackedVector2Array([Vector2(16, 12), Vector2(11, 15), Vector2(12, 20), Vector2(6, 22)]), SCORCH, 2.5, true)
	PlaceholderArt.draw_ellipse(c, Vector2(9, 15), 5, 5, Color(0.4, 0.24, 0.1, 0.4))
	# Letterhead
	_text(c, Vector2(-15, -17), "HOLLOWMERE", 4, RED_INK)
	c.draw_line(Vector2(-15, -14), Vector2(13, -14), RED_INK, 0.8)
	_text(c, Vector2(-15, -7), "Hobbs,", 5, INK)
	_text(c, Vector2(-15, 0), "BURN", 7, INK)
	_text(c, Vector2(-15, 6), "Ward 7", 5, INK)
	_lines(c, Vector2(-15, 10), 22.0, 2, 3.2, Color(0.3, 0.28, 0.4))
	_text(c, Vector2(-15, 21), "E.C.", 5, INK)


## A cranked iron handle with a wooden grip.
static func _draw_lift_crank(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 13), 20, 2, SHADOW)
	# The square socket end
	c.draw_rect(Rect2(-23, -13, 10, 10), IRON)
	c.draw_rect(Rect2(-20, -10, 4, 4), Color(0.04, 0.04, 0.05))
	# The cranked arm
	c.draw_polyline(PackedVector2Array([Vector2(-14, -8), Vector2(-2, -8), Vector2(-2, 7), Vector2(6, 7)]), IRON_DARK, 5.0, true)
	c.draw_polyline(PackedVector2Array([Vector2(-14, -9), Vector2(-3, -9), Vector2(-3, 6), Vector2(6, 6)]), STEEL, 1.0, true)
	# Wooden grip
	c.draw_rect(Rect2(6, 2, 16, 10), WOOD)
	c.draw_rect(Rect2(6, 2, 16, 3), WOOD.lightened(0.2))
	c.draw_rect(Rect2(21, 3, 2, 8), IRON)


## A buff file tied with tape, sooty but not burnt: "No. 4".
static func _draw_unburnt_file(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-21, -16, 44, 34), SHADOW)
	c.draw_rect(Rect2(-23, -18, 44, 34), BUFF.darkened(0.2))
	c.draw_rect(Rect2(-20, -16, 40, 4), PAPER)  # papers showing at the top
	c.draw_rect(Rect2(-23, -14, 44, 30), BUFF)
	# Tab and title
	c.draw_rect(Rect2(8, -18, 12, 5), BUFF)
	_text(c, Vector2(-19, -4), "No. 4", 8, INK)
	_text(c, Vector2(-19, 4), "Ivy Pell", 5, RED_INK)
	# Pink tape
	c.draw_rect(Rect2(-23, 7, 44, 2.5), Color(0.8, 0.4, 0.44))
	c.draw_rect(Rect2(8, -14, 2.5, 30), Color(0.8, 0.4, 0.44))
	# Soot from the grate
	PlaceholderArt.draw_ellipse(c, Vector2(-15, 12), 7, 4, Color(0, 0, 0, 0.35))
	PlaceholderArt.draw_ellipse(c, Vector2(16, -8), 5, 4, Color(0, 0, 0, 0.3))


## A pay slip, folded small, with a second sum under the first.
static func _draw_stokers_pay_slip(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-20, -12, 42, 26), SHADOW)
	c.draw_rect(Rect2(-22, -14, 42, 26), Color(0.86, 0.9, 0.84))
	# Fold lines
	c.draw_line(Vector2(-8, -14), Vector2(-8, 12), Color(0, 0, 0, 0.15), 1.0)
	c.draw_line(Vector2(6, -14), Vector2(6, 12), Color(0, 0, 0, 0.15), 1.0)
	_text(c, Vector2(-19, -7), "J. HOBBS", 5, INK)
	c.draw_line(Vector2(-19, -5), Vector2(17, -5), INK, 0.8)
	_text(c, Vector2(-19, 1), "Wages", 5, INK)
	c.draw_line(Vector2(4, -1), Vector2(16, -1), PENCIL, 0.9)
	_text(c, Vector2(-19, 9), "+ Ward 7", 6, RED_INK)


## The boiler's night log: a black book with a red spine, open at a page.
static func _draw_night_log(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-20, -16, 44, 36), SHADOW)
	c.draw_rect(Rect2(-22, -18, 44, 36), Color(0.1, 0.1, 0.12))
	c.draw_rect(Rect2(-20, -16, 19, 32), PAPER)
	c.draw_rect(Rect2(1, -16, 19, 32), PAPER)
	c.draw_rect(Rect2(-1, -18, 2, 36), Color(0.6, 0.14, 0.14))
	# Columns of pressures on the left page
	_lines(c, Vector2(-18, -11), 15.0, 7, 3.8, Color(0.3, 0.28, 0.4))
	c.draw_line(Vector2(-11, -13), Vector2(-11, 13), RED_INK, 0.7)
	# The same entry every night
	_text(c, Vector2(3, -9), "NIGHT", 4, INK)
	_text(c, Vector2(3, -2), "Ward", 6, RED_INK)
	_text(c, Vector2(7, 6), "7", 8, RED_INK)
	c.draw_line(Vector2(3, 10), Vector2(18, 10), RED_INK, 1.0)


## A greasy folded sheet with the pipe runs sketched in pencil.
static func _draw_pencilled_plan(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-21, -16, 44, 34), SHADOW)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-23, -17), Vector2(21, -18), Vector2(22, 16), Vector2(-22, 17)]), PAPER_DARK.lightened(0.15))
	# Fold lines and a grease spot
	c.draw_line(Vector2(0, -18), Vector2(0, 17), Color(0, 0, 0, 0.15), 1.0)
	c.draw_line(Vector2(-23, 0), Vector2(22, 0), Color(0, 0, 0, 0.15), 1.0)
	PlaceholderArt.draw_ellipse(c, Vector2(-13, 9), 6, 4, Color(0.5, 0.4, 0.2, 0.4))
	# The boiler, and the pipes going up from it
	c.draw_rect(Rect2(-19, 6, 10, 8), PENCIL, false, 1.0)
	c.draw_polyline(PackedVector2Array([Vector2(-14, 6), Vector2(-14, -3), Vector2(4, -3)]), PENCIL, 1.0)
	c.draw_polyline(PackedVector2Array([Vector2(-10, 10), Vector2(8, 10), Vector2(8, 3)]), PENCIL, 1.0)
	# One pipe runs on up to a room with seven radiators
	c.draw_polyline(PackedVector2Array([Vector2(4, -3), Vector2(4, -13), Vector2(-16, -13)]), RED_INK, 1.2)
	c.draw_rect(Rect2(3, -15, 17, 9), PENCIL, false, 1.0)
	for i in range(7):
		c.draw_line(Vector2(5 + i * 2.2, -13), Vector2(5 + i * 2.2, -8), RED_INK, 0.9)
	_text(c, Vector2(11, 8), "x7", 6, RED_INK)


## A penny whistle: a tin tube with six holes and a blue mouthpiece.
static func _draw_tin_whistle(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-17, -3, 43, 6), TIN.darkened(0.25))
	c.draw_rect(Rect2(-17, -3, 43, 2), STEEL)
	# Mouthpiece and its window
	c.draw_colored_polygon(PackedVector2Array([Vector2(-27, -2), Vector2(-17, -4), Vector2(-17, 4), Vector2(-27, 2)]), Color(0.16, 0.3, 0.6))
	c.draw_rect(Rect2(-16, -3, 3, 3), IRON_DARK)
	# Six finger holes
	for i in range(6):
		c.draw_circle(Vector2(-6 + i * 5.2, 0), 1.3, IRON_DARK)
	c.draw_rect(Rect2(25, -3, 1.5, 6), TIN.darkened(0.5))


## A flat steel key on a brass tag stamped LIFT.
static func _draw_lift_key(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 9), 23, 2, SHADOW)
	# Brass tag
	c.draw_rect(Rect2(-25, -8, 20, 14), BRASS)
	c.draw_rect(Rect2(-25, -8, 20, 14), BRASS_DARK, false, 1.0)
	_text(c, Vector2(-23, 2), "LIFT", 7, INK)
	# Ring
	c.draw_arc(Vector2(-3, -1), 4.0, 0.0, TAU, 14, STEEL, 1.2, true)
	# Flat key
	c.draw_circle(Vector2(5, -1), 5.0, STEEL)
	c.draw_circle(Vector2(4, -1), 1.6, IRON_DARK)
	c.draw_rect(Rect2(8, -2.5, 17, 3), STEEL)
	c.draw_rect(Rect2(17, 0.5, 2.5, 4), STEEL)
	c.draw_rect(Rect2(21, 0.5, 3, 5.5), STEEL)
	c.draw_line(Vector2(9, -1.8), Vector2(24, -1.8), Color(1, 1, 1, 0.9), 0.7)


## A small glass medicine cup with a sticky brown residue in the bottom.
static func _draw_dose_cup(c: CanvasItem) -> void:
	var glass := Color(0.75, 0.88, 0.9, 0.45)
	var glass_edge := Color(0.88, 0.96, 1.0, 0.85)
	PlaceholderArt.draw_ellipse(c, Vector2(0, 13), 10, 2, SHADOW)
	var outline := PackedVector2Array([Vector2(-11, -13), Vector2(11, -13), Vector2(8, 12), Vector2(-8, 12)])
	c.draw_colored_polygon(outline, glass)
	# The dregs of the sleeping draught
	c.draw_colored_polygon(PackedVector2Array([Vector2(-8.6, 6), Vector2(8.6, 6), Vector2(8, 12), Vector2(-8, 12)]), Color(0.45, 0.22, 0.12, 0.85))
	c.draw_polyline(PackedVector2Array([Vector2(-11, -13), Vector2(-8, 12), Vector2(8, 12), Vector2(11, -13)]), glass_edge, 1.2)
	PlaceholderArt.draw_ellipse(c, Vector2(0, -13), 11, 2, glass_edge)
	# Measuring marks
	for i in range(3):
		c.draw_line(Vector2(-9, -6 + i * 5.0), Vector2(-4, -6 + i * 5.0), Color(1, 1, 1, 0.8), 0.8)
	c.draw_line(Vector2(6, -9), Vector2(5, 3), Color(1, 1, 1, 0.6), 1.2)
