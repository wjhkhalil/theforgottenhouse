@tool
class_name LoftObjects
extends RefCounted
## Placeholder drawings for the hidden objects of House Two, Chapter Three (The Loft).
## Same rules as placeholder_art.gd: every drawing is centred on (0, 0) and
## fits inside get_size(). PlaceholderArt calls these functions.

const BRASS := Color(0.8, 0.62, 0.3)
const BRASS_DARK := Color(0.52, 0.38, 0.16)
const IRON := Color(0.34, 0.33, 0.33)
const IRON_DARK := Color(0.2, 0.19, 0.19)
const TIN := Color(0.62, 0.64, 0.66)
const TIN_DARK := Color(0.4, 0.42, 0.44)
const PAPER := Color(0.9, 0.86, 0.74)
const INK := Color(0.16, 0.14, 0.2)
const LINEN := Color(0.86, 0.84, 0.78)
const SHADOW := Color(0, 0, 0, 0.35)


## Size of the drawing, or Vector2.ZERO if `style` is not one of this chapter's objects.
static func get_size(style: int) -> Vector2:
	match style:
		HiddenObjectData.PlaceholderStyle.CANDLE_STUB:
			return Vector2(26, 40)
		HiddenObjectData.PlaceholderStyle.TIN_CUP:
			return Vector2(36, 30)
		HiddenObjectData.PlaceholderStyle.HAIRPIN:
			return Vector2(34, 14)
		HiddenObjectData.PlaceholderStyle.VISITING_CARD:
			return Vector2(44, 26)
		HiddenObjectData.PlaceholderStyle.POCKET_MIRROR:
			return Vector2(30, 40)
		HiddenObjectData.PlaceholderStyle.BEDSHEET_ROPE:
			return Vector2(30, 70)
		HiddenObjectData.PlaceholderStyle.RAG_DOLL:
			return Vector2(32, 46)
		HiddenObjectData.PlaceholderStyle.PADLOCK_KEY:
			return Vector2(38, 18)
		HiddenObjectData.PlaceholderStyle.SEDATIVE_VIAL:
			return Vector2(18, 40)
		HiddenObjectData.PlaceholderStyle.UNSENT_LETTER:
			return Vector2(46, 32)
		HiddenObjectData.PlaceholderStyle.PRESSED_VIOLET:
			return Vector2(32, 40)
		HiddenObjectData.PlaceholderStyle.WORKSHOP_KEY:
			return Vector2(56, 24)
	return Vector2.ZERO


## Draws `style` and returns true, or returns false if it is not one of this chapter's objects.
static func draw(c: CanvasItem, style: int) -> bool:
	match style:
		HiddenObjectData.PlaceholderStyle.CANDLE_STUB:
			_draw_candle_stub(c)
		HiddenObjectData.PlaceholderStyle.TIN_CUP:
			_draw_tin_cup(c)
		HiddenObjectData.PlaceholderStyle.HAIRPIN:
			_draw_hairpin(c)
		HiddenObjectData.PlaceholderStyle.VISITING_CARD:
			_draw_visiting_card(c)
		HiddenObjectData.PlaceholderStyle.POCKET_MIRROR:
			_draw_pocket_mirror(c)
		HiddenObjectData.PlaceholderStyle.BEDSHEET_ROPE:
			_draw_bedsheet_rope(c)
		HiddenObjectData.PlaceholderStyle.RAG_DOLL:
			_draw_rag_doll(c)
		HiddenObjectData.PlaceholderStyle.PADLOCK_KEY:
			_draw_padlock_key(c)
		HiddenObjectData.PlaceholderStyle.SEDATIVE_VIAL:
			_draw_sedative_vial(c)
		HiddenObjectData.PlaceholderStyle.UNSENT_LETTER:
			_draw_unsent_letter(c)
		HiddenObjectData.PlaceholderStyle.PRESSED_VIOLET:
			_draw_pressed_violet(c)
		HiddenObjectData.PlaceholderStyle.WORKSHOP_KEY:
			_draw_workshop_key(c)
		_:
			return false
	return true


## A short white candle in a tin holder, the wick still smoking.
static func _draw_candle_stub(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 17), 12, 2.5, SHADOW)
	PlaceholderArt.draw_ellipse(c, Vector2(0, 14), 12, 4, TIN_DARK)
	PlaceholderArt.draw_ellipse(c, Vector2(0, 13), 10, 3, TIN)
	c.draw_rect(Rect2(-6, -2, 12, 15), Color(0.93, 0.9, 0.8))
	c.draw_rect(Rect2(-6, -2, 3, 15), Color(1, 1, 0.95))
	# Wax drips over the edge
	c.draw_rect(Rect2(3, -2, 2.5, 7), Color(0.85, 0.82, 0.72))
	c.draw_rect(Rect2(-2, -2, 2, 5), Color(0.85, 0.82, 0.72))
	c.draw_line(Vector2(0, -2), Vector2(0, -6), Color(0.1, 0.08, 0.06), 1.5)
	# A thin curl of smoke: it was blown out a moment ago.
	c.draw_polyline(PackedVector2Array([Vector2(0, -6), Vector2(3, -10), Vector2(-1, -14), Vector2(3, -18), Vector2(1, -20)]),
		Color(0.8, 0.8, 0.82, 0.55), 1.5, true)
	# Holder handle
	c.draw_arc(Vector2(12, 11), 3, -PI / 2, PI / 2, 6, TIN_DARK, 2.0)


## A dented enamel-chipped tin cup.
static func _draw_tin_cup(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(-2, 13), 15, 2.5, SHADOW)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-13, -10), Vector2(9, -10), Vector2(8, 4), Vector2(5, 7),
		Vector2(7, 12), Vector2(-12, 12)]), TIN_DARK)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-12, -9), Vector2(-2, -9), Vector2(-3, 11), Vector2(-11, 11)]), TIN)
	PlaceholderArt.draw_ellipse(c, Vector2(-2, -10), 11, 3, Color(0.25, 0.26, 0.28))
	# Chips in the blue enamel rim
	c.draw_arc(Vector2(-2, -10), 11, 0, PI, 10, Color(0.3, 0.42, 0.6), 1.5)
	c.draw_arc(Vector2(10, 0), 6, -PI / 2, PI / 2, 8, TIN_DARK, 2.5)
	c.draw_circle(Vector2(1, 5), 1.8, Color(0.16, 0.16, 0.16))


## A bent black hairpin with a worn tip.
static func _draw_hairpin(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 5), 15, 1.5, SHADOW)
	var pin := Color(0.12, 0.11, 0.12)
	c.draw_polyline(PackedVector2Array([Vector2(-15, -3), Vector2(10, -3), Vector2(14, 0), Vector2(10, 3), Vector2(-4, 3),
		Vector2(-8, 1), Vector2(-12, 4), Vector2(-15, 2)]), pin, 1.8, true)
	c.draw_line(Vector2(-12, -3), Vector2(6, -3), Color(0.5, 0.5, 0.55, 0.6), 0.8)
	# Scratched-bright tip (it was used to carve the beam)
	c.draw_line(Vector2(-15, 2), Vector2(-12, 4), Color(0.75, 0.72, 0.65), 1.8)


## A cream visiting card with black copperplate lines and a bent corner.
static func _draw_visiting_card(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-19, -9, 42, 22), SHADOW)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-22, -12), Vector2(20, -12), Vector2(20, 4), Vector2(14, 10),
		Vector2(-22, 10)]), Color(0.95, 0.92, 0.84))
	c.draw_colored_polygon(PackedVector2Array([Vector2(20, 4), Vector2(14, 10), Vector2(15, 4)]), Color(0.78, 0.74, 0.66))
	c.draw_line(Vector2(-14, -4), Vector2(12, -4), INK, 2.0)
	c.draw_line(Vector2(-10, 1), Vector2(8, 1), Color(INK, 0.7), 1.0)
	c.draw_line(Vector2(-17, 6), Vector2(-4, 6), Color(INK, 0.6), 1.0)
	# A snake-and-staff mark in the corner
	c.draw_line(Vector2(-18, -9), Vector2(-18, -1), INK, 1.0)
	c.draw_arc(Vector2(-18, -5), 2, 0, TAU, 6, INK, 0.8)


## A small round hand mirror with a crack across the glass.
static func _draw_pocket_mirror(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 19), 11, 2, SHADOW)
	c.draw_rect(Rect2(-3, 4, 6, 15), Color(0.42, 0.26, 0.16))
	c.draw_circle(Vector2(0, -6), 13, Color(0.42, 0.26, 0.16))
	c.draw_circle(Vector2(0, -6), 10.5, Color(0.7, 0.78, 0.84))
	# Moonlight caught in it, and the crack
	c.draw_arc(Vector2(-3, -9), 5, PI, PI * 1.6, 6, Color(1, 1, 1, 0.8), 2.0)
	c.draw_polyline(PackedVector2Array([Vector2(-8, -12), Vector2(-2, -6), Vector2(1, -8), Vector2(8, 0)]), Color(0.25, 0.28, 0.32), 1.2)
	c.draw_line(Vector2(-2, -6), Vector2(-4, 1), Color(0.25, 0.28, 0.32), 1.0)


## A length of torn bedsheets knotted together into a rope, cut at the bottom.
static func _draw_bedsheet_rope(c: CanvasItem) -> void:
	var points := PackedVector2Array([Vector2(-2, -34), Vector2(3, -18), Vector2(-3, -2), Vector2(4, 14), Vector2(-1, 30)])
	c.draw_polyline(points, Color(0.62, 0.6, 0.55), 9.0, true)
	c.draw_polyline(points, LINEN, 6.0, true)
	for knot: Vector2 in [Vector2(1, -22), Vector2(0, -2), Vector2(2, 18)]:
		PlaceholderArt.draw_ellipse(c, knot, 7, 5, Color(0.74, 0.72, 0.66))
		c.draw_line(knot + Vector2(-5, 0), knot + Vector2(5, 0), Color(0.55, 0.53, 0.48), 1.0)
	# Frayed, freshly cut end
	for i in range(4):
		c.draw_line(Vector2(-3 + i * 2, 30), Vector2(-5 + i * 3, 35), LINEN, 1.2)


## A little doll sewn from sacking, with button eyes and a scrap-cloth dress.
static func _draw_rag_doll(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 22), 13, 2.5, SHADOW)
	var sack := Color(0.7, 0.6, 0.44)
	# Arms and legs
	c.draw_line(Vector2(-6, -2), Vector2(-14, 6), sack, 5.0)
	c.draw_line(Vector2(6, -2), Vector2(14, 6), sack, 5.0)
	c.draw_line(Vector2(-4, 12), Vector2(-6, 21), sack, 5.0)
	c.draw_line(Vector2(4, 12), Vector2(6, 21), sack, 5.0)
	# Dress
	c.draw_colored_polygon(PackedVector2Array([Vector2(-6, -5), Vector2(6, -5), Vector2(11, 14), Vector2(-11, 14)]), Color(0.45, 0.3, 0.45))
	c.draw_line(Vector2(-10, 10), Vector2(10, 10), Color(0.75, 0.68, 0.6), 1.5)
	# Head, hair of brown wool and two odd button eyes
	c.draw_circle(Vector2(0, -13), 9, sack)
	c.draw_arc(Vector2(0, -14), 9, PI * 1.05, PI * 1.95, 10, Color(0.4, 0.25, 0.14), 3.0)
	c.draw_circle(Vector2(-3, -13), 1.8, Color(0.1, 0.1, 0.12))
	c.draw_circle(Vector2(3.5, -13), 2.2, Color(0.25, 0.15, 0.3))
	c.draw_line(Vector2(-3, -9), Vector2(3, -9), Color(0.5, 0.2, 0.2), 1.0)


## A small brass padlock key on a loop of string.
static func _draw_padlock_key(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 7), 17, 2, SHADOW)
	c.draw_circle(Vector2(-11, 0), 6, BRASS_DARK)
	c.draw_circle(Vector2(-11, 0), 3, Color(0.1, 0.08, 0.06))
	c.draw_rect(Rect2(-6, -1.5, 18, 3), BRASS)
	c.draw_rect(Rect2(8, 0, 3, 5), BRASS)
	c.draw_rect(Rect2(12, 0, 2.5, 4), BRASS)
	c.draw_line(Vector2(-6, -1), Vector2(10, -1), Color(1, 1, 1, 0.4), 0.8)
	c.draw_arc(Vector2(-13, -1), 6, PI * 0.5, PI * 1.6, 8, Color(0.75, 0.2, 0.18), 1.2)


## A tiny glass vial with a rubber stopper and a typed chemist's label.
static func _draw_sedative_vial(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 18), 8, 2, SHADOW)
	var glass := Color(0.75, 0.85, 0.9, 0.75)
	c.draw_rect(Rect2(-6, -10, 12, 27), glass)
	c.draw_rect(Rect2(-6, 2, 12, 15), Color(0.85, 0.9, 0.95, 0.55))
	c.draw_rect(Rect2(-5, -18, 10, 8), Color(0.55, 0.15, 0.14))
	c.draw_rect(Rect2(-6, -6, 12, 9), PAPER)
	c.draw_line(Vector2(-4, -4), Vector2(4, -4), INK, 1.0)
	c.draw_line(Vector2(-4, -1), Vector2(2, -1), Color(INK, 0.6), 0.8)
	c.draw_line(Vector2(-4, -8), Vector2(-4, 14), Color(1, 1, 1, 0.6), 1.2)


## A sealed envelope addressed in a careful hand, never posted.
static func _draw_unsent_letter(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-20, -12, 44, 28), SHADOW)
	c.draw_rect(Rect2(-23, -15, 44, 28), PAPER)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-23, -15), Vector2(21, -15), Vector2(-1, 1)]), Color(0.82, 0.78, 0.66))
	c.draw_line(Vector2(-23, -15), Vector2(-1, 1), Color(0.7, 0.66, 0.55), 1.0)
	c.draw_line(Vector2(21, -15), Vector2(-1, 1), Color(0.7, 0.66, 0.55), 1.0)
	# The address, and an empty corner where a stamp should be
	c.draw_line(Vector2(-12, 5), Vector2(10, 5), INK, 1.4)
	c.draw_line(Vector2(-12, 9), Vector2(4, 9), Color(INK, 0.7), 1.0)
	c.draw_rect(Rect2(12, -12, 7, 8), Color(0.6, 0.55, 0.45), false, 1.0)


## A dried violet pressed flat in a folded scrap of paper.
static func _draw_pressed_violet(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-13, -17, 30, 38), SHADOW)
	c.draw_rect(Rect2(-15, -19, 30, 38), Color(0.88, 0.84, 0.72))
	c.draw_line(Vector2(0, -19), Vector2(0, 19), Color(0.75, 0.7, 0.58), 1.0)
	c.draw_line(Vector2(2, 14), Vector2(-1, -2), Color(0.35, 0.45, 0.25), 1.5)
	PlaceholderArt.draw_ellipse(c, Vector2(5, 8), 5, 2.5, Color(0.35, 0.48, 0.28))
	for angle in [0.0, 1.25, 2.5, 3.75, 5.0]:
		c.draw_circle(Vector2(-1, -6) + Vector2.from_angle(angle) * 4.0, 3.5, Color(0.45, 0.3, 0.6))
	c.draw_circle(Vector2(-1, -6), 1.8, Color(0.9, 0.8, 0.3))


## A large black iron key with a paper tag reading WORKSHOP.
static func _draw_workshop_key(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 10), 26, 2.5, SHADOW)
	c.draw_arc(Vector2(-19, 0), 7, 0, TAU, 14, IRON_DARK, 4.0)
	c.draw_rect(Rect2(-12, -2, 30, 4), IRON)
	c.draw_rect(Rect2(14, 2, 4, 6), IRON)
	c.draw_rect(Rect2(19, 2, 3, 4), IRON)
	c.draw_line(Vector2(-12, -1.5), Vector2(16, -1.5), Color(1, 1, 1, 0.25), 1.0)
	# Tag on a string
	c.draw_line(Vector2(-19, 7), Vector2(-14, 10), Color(0.7, 0.65, 0.55), 1.0)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-14, 7), Vector2(4, 7), Vector2(4, 12), Vector2(-14, 12), Vector2(-16, 9.5)]), PAPER)
	c.draw_line(Vector2(-11, 9.5), Vector2(1, 9.5), INK, 1.2)
