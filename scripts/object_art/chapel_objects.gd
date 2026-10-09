@tool
class_name ChapelObjects
extends RefCounted
## Placeholder drawings for the hidden objects of House Two, Chapter Nine (The Island Chapel).
## Same rules as placeholder_art.gd: every drawing is centred on (0, 0) and
## fits inside get_size(). PlaceholderArt calls these functions.

const BRASS := Color(0.8, 0.63, 0.32)
const BRASS_DARK := Color(0.52, 0.39, 0.17)
const IRON := Color(0.34, 0.33, 0.33)
const IRON_DARK := Color(0.19, 0.18, 0.18)
const PEWTER := Color(0.62, 0.63, 0.64)
const PEWTER_DARK := Color(0.4, 0.41, 0.43)
const PAPER := Color(0.9, 0.86, 0.74)
const PAPER_DARK := Color(0.76, 0.71, 0.58)
const INK := Color(0.16, 0.14, 0.2)
const OAK := Color(0.45, 0.31, 0.19)
const OAK_DARK := Color(0.28, 0.19, 0.12)
const VEIL := Color(0.55, 0.56, 0.58)
const VEIL_DARK := Color(0.38, 0.39, 0.42)
const SHADOW := Color(0, 0, 0, 0.35)


## Size of the drawing, or Vector2.ZERO if `style` is not one of this chapter's objects.
static func get_size(style: int) -> Vector2:
	match style:
		HiddenObjectData.PlaceholderStyle.HYMN_BOOK:
			return Vector2(38, 46)
		HiddenObjectData.PlaceholderStyle.COLLECTION_PLATE:
			return Vector2(52, 24)
		HiddenObjectData.PlaceholderStyle.PRAYER_CARD:
			return Vector2(30, 44)
		HiddenObjectData.PlaceholderStyle.GREY_VEIL:
			return Vector2(48, 56)
		HiddenObjectData.PlaceholderStyle.PARISH_REGISTER:
			return Vector2(58, 40)
		HiddenObjectData.PlaceholderStyle.HAND_BELL:
			return Vector2(32, 46)
		HiddenObjectData.PlaceholderStyle.PEWTER_CUP:
			return Vector2(28, 40)
		HiddenObjectData.PlaceholderStyle.EMBROIDERY_HOOP:
			return Vector2(46, 46)
		HiddenObjectData.PlaceholderStyle.TROWEL:
			return Vector2(58, 22)
		HiddenObjectData.PlaceholderStyle.DOCTORS_LETTER:
			return Vector2(44, 52)
		HiddenObjectData.PlaceholderStyle.CANDLE_SNUFFER:
			return Vector2(60, 22)
		HiddenObjectData.PlaceholderStyle.WOODEN_CROSS:
			return Vector2(30, 46)
		HiddenObjectData.PlaceholderStyle.OARLOCK:
			return Vector2(36, 40)
		HiddenObjectData.PlaceholderStyle.VESTRY_KEY:
			return Vector2(58, 26)
		HiddenObjectData.PlaceholderStyle.COTTAGE_MAP:
			return Vector2(58, 44)
	return Vector2.ZERO


## Draws `style` and returns true, or returns false if it is not one of this chapter's objects.
static func draw(c: CanvasItem, style: int) -> bool:
	match style:
		HiddenObjectData.PlaceholderStyle.HYMN_BOOK:
			_draw_hymn_book(c)
		HiddenObjectData.PlaceholderStyle.COLLECTION_PLATE:
			_draw_collection_plate(c)
		HiddenObjectData.PlaceholderStyle.PRAYER_CARD:
			_draw_prayer_card(c)
		HiddenObjectData.PlaceholderStyle.GREY_VEIL:
			_draw_grey_veil(c)
		HiddenObjectData.PlaceholderStyle.PARISH_REGISTER:
			_draw_parish_register(c)
		HiddenObjectData.PlaceholderStyle.HAND_BELL:
			_draw_hand_bell(c)
		HiddenObjectData.PlaceholderStyle.PEWTER_CUP:
			_draw_pewter_cup(c)
		HiddenObjectData.PlaceholderStyle.EMBROIDERY_HOOP:
			_draw_embroidery_hoop(c)
		HiddenObjectData.PlaceholderStyle.TROWEL:
			_draw_trowel(c)
		HiddenObjectData.PlaceholderStyle.DOCTORS_LETTER:
			_draw_doctors_letter(c)
		HiddenObjectData.PlaceholderStyle.CANDLE_SNUFFER:
			_draw_candle_snuffer(c)
		HiddenObjectData.PlaceholderStyle.WOODEN_CROSS:
			_draw_wooden_cross(c)
		HiddenObjectData.PlaceholderStyle.OARLOCK:
			_draw_oarlock(c)
		HiddenObjectData.PlaceholderStyle.VESTRY_KEY:
			_draw_vestry_key(c)
		HiddenObjectData.PlaceholderStyle.COTTAGE_MAP:
			_draw_cottage_map(c)
		_:
			return false
	return true


## A worn black hymn book with a gold cross and a red ribbon marker.
static func _draw_hymn_book(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-15, -19, 34, 42), SHADOW)
	# Page edges peeking out at the side and bottom
	c.draw_rect(Rect2(-16, -20, 32, 41), PAPER_DARK)
	c.draw_rect(Rect2(-18, -22, 32, 41), Color(0.13, 0.11, 0.12))
	c.draw_rect(Rect2(-18, -22, 5, 41), Color(0.2, 0.17, 0.17))
	c.draw_rect(Rect2(-12, -18, 23, 33), Color(0.75, 0.6, 0.3), false, 1.0)
	# Gold cross on the cover
	c.draw_rect(Rect2(-1.5, -14, 3, 18), BRASS)
	c.draw_rect(Rect2(-6, -9, 12, 3), BRASS)
	# Worn corner, and the ribbon hanging out at the bottom
	c.draw_line(Vector2(10, 19), Vector2(14, 15), Color(0.3, 0.27, 0.27), 2.0)
	c.draw_polyline(PackedVector2Array([Vector2(4, 19), Vector2(5, 22), Vector2(3, 23)]), Color(0.7, 0.12, 0.14), 2.0)


## A brass collection plate lined with faded red felt, a few coins left in it.
static func _draw_collection_plate(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(1, 5), 25, 7, SHADOW)
	PlaceholderArt.draw_ellipse(c, Vector2(0, 2), 25, 9, BRASS_DARK)
	PlaceholderArt.draw_ellipse(c, Vector2(0, 1), 24, 8, BRASS)
	PlaceholderArt.draw_ellipse(c, Vector2(0, 1), 16, 5, Color(0.5, 0.13, 0.14))
	c.draw_arc(Vector2(0, 1), 20, PI * 1.1, PI * 1.6, 8, Color(1, 0.95, 0.75, 0.6), 1.5)
	# Coins
	PlaceholderArt.draw_ellipse(c, Vector2(-5, 1), 4, 2, Color(0.75, 0.75, 0.72))
	PlaceholderArt.draw_ellipse(c, Vector2(4, 2), 3.5, 1.8, Color(0.72, 0.5, 0.3))
	PlaceholderArt.draw_ellipse(c, Vector2(2, -1), 3, 1.5, Color(0.8, 0.8, 0.78))


## A small prayer card: a picture of a lily in an arch, and handwriting on it.
static func _draw_prayer_card(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-12, -19, 28, 42), SHADOW)
	c.draw_rect(Rect2(-14, -21, 28, 42), Color(0.94, 0.91, 0.84))
	c.draw_rect(Rect2(-12, -19, 24, 38), Color(0.7, 0.58, 0.32), false, 1.0)
	# The arched picture
	c.draw_rect(Rect2(-8, -8, 16, 12), Color(0.55, 0.65, 0.78))
	c.draw_circle(Vector2(0, -8), 8, Color(0.55, 0.65, 0.78))
	c.draw_line(Vector2(0, 4), Vector2(0, -6), Color(0.3, 0.45, 0.25), 1.2)
	for angle in [-2.2, -1.57, -0.9]:
		c.draw_line(Vector2(0, -8), Vector2(0, -8) + Vector2.from_angle(angle) * 5.0, Color(0.98, 0.97, 0.92), 2.0)
	c.draw_circle(Vector2(0, -9), 1.2, Color(0.9, 0.75, 0.3))
	# Lines of pencil writing below
	c.draw_line(Vector2(-9, 9), Vector2(9, 9), Color(INK, 0.7), 1.0)
	c.draw_line(Vector2(-9, 13), Vector2(6, 13), Color(INK, 0.6), 1.0)
	c.draw_line(Vector2(-9, 17), Vector2(3, 17), Color(INK, 0.5), 1.0)


## A soft grey veil hanging in folds from a peg, with a white band at the top.
static func _draw_grey_veil(c: CanvasItem) -> void:
	# The cloth, wider at the bottom
	c.draw_colored_polygon(PackedVector2Array([Vector2(-10, -20), Vector2(10, -20), Vector2(22, 24), Vector2(12, 27),
		Vector2(2, 24), Vector2(-8, 27), Vector2(-22, 24)]), VEIL)
	# Darker folds
	for fold: float in [-12.0, -3.0, 7.0, 15.0]:
		c.draw_line(Vector2(fold * 0.4, -16), Vector2(fold, 24), VEIL_DARK, 2.0)
	c.draw_line(Vector2(-8, -18), Vector2(-18, 22), Color(1, 1, 1, 0.18), 1.5)
	# White band and the wooden peg it hangs from
	c.draw_rect(Rect2(-11, -22, 22, 5), Color(0.92, 0.91, 0.88))
	c.draw_rect(Rect2(-3, -28, 6, 8), OAK)
	c.draw_circle(Vector2(0, -27), 3.5, OAK_DARK)


## A big leather-bound parish register lying open, neat columns of names.
static func _draw_parish_register(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-26, -15, 56, 36), SHADOW)
	c.draw_rect(Rect2(-29, -18, 58, 36), Color(0.36, 0.2, 0.13))
	# Two open pages
	c.draw_colored_polygon(PackedVector2Array([Vector2(-27, -16), Vector2(-1, -14), Vector2(-1, 15), Vector2(-27, 16)]), PAPER)
	c.draw_colored_polygon(PackedVector2Array([Vector2(1, -14), Vector2(27, -16), Vector2(27, 16), Vector2(1, 15)]), PAPER)
	c.draw_line(Vector2(0, -15), Vector2(0, 16), Color(0.5, 0.4, 0.3), 2.0)
	# Ruled columns and rows of handwriting
	for page_x: float in [-25.0, 3.0]:
		c.draw_line(Vector2(page_x + 7, -13), Vector2(page_x + 7, 13), Color(0.7, 0.3, 0.3, 0.6), 0.8)
		for row in range(6):
			var y := -10.0 + row * 4.5
			c.draw_line(Vector2(page_x + 1, y), Vector2(page_x + 5, y), Color(INK, 0.6), 1.0)
			c.draw_line(Vector2(page_x + 9, y), Vector2(page_x + 21 - (row % 3) * 3, y), Color(INK, 0.75), 1.0)
	# One entry underlined: Sister Margaret's
	c.draw_line(Vector2(12, 4.5), Vector2(24, 4.5), Color(0.6, 0.15, 0.15), 1.0)


## A brass hand bell with a turned wooden handle.
static func _draw_hand_bell(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 20), 15, 3, SHADOW)
	# Handle
	c.draw_rect(Rect2(-3.5, -22, 7, 15), OAK)
	c.draw_circle(Vector2(0, -21), 4.5, OAK)
	c.draw_line(Vector2(-2, -20), Vector2(-2, -9), Color(1, 1, 1, 0.25), 1.0)
	c.draw_rect(Rect2(-5, -8, 10, 3), BRASS_DARK)
	# The bell flares out to the lip
	c.draw_colored_polygon(PackedVector2Array([Vector2(-6, -6), Vector2(6, -6), Vector2(9, 6), Vector2(14, 15),
		Vector2(-14, 15), Vector2(-9, 6)]), BRASS)
	PlaceholderArt.draw_ellipse(c, Vector2(0, 15), 14, 3.5, BRASS_DARK)
	PlaceholderArt.draw_ellipse(c, Vector2(0, 16), 10, 2, Color(0.25, 0.18, 0.08))
	c.draw_line(Vector2(-4, -4), Vector2(-9, 13), Color(1, 0.95, 0.75, 0.6), 2.0)
	c.draw_circle(Vector2(2, 18), 2.5, BRASS_DARK)  # the clapper


## A plain pewter communion cup on a short stem.
static func _draw_pewter_cup(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 18), 12, 2.5, SHADOW)
	# Foot and stem
	PlaceholderArt.draw_ellipse(c, Vector2(0, 16), 10, 3, PEWTER_DARK)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-7, 15), Vector2(7, 15), Vector2(2, 9), Vector2(-2, 9)]), PEWTER)
	c.draw_rect(Rect2(-2, 0, 4, 10), PEWTER)
	PlaceholderArt.draw_ellipse(c, Vector2(0, 2), 4, 1.5, PEWTER_DARK)
	# The bowl
	c.draw_colored_polygon(PackedVector2Array([Vector2(-11, -17), Vector2(11, -17), Vector2(9, -6), Vector2(4, 0),
		Vector2(-4, 0), Vector2(-9, -6)]), PEWTER)
	PlaceholderArt.draw_ellipse(c, Vector2(0, -17), 11, 2.5, PEWTER_DARK)
	c.draw_line(Vector2(-7, -14), Vector2(-5, -3), Color(1, 1, 1, 0.5), 1.5)
	# A small engraved cross
	c.draw_line(Vector2(3, -13), Vector2(3, -6), Color(0.3, 0.31, 0.33), 1.0)
	c.draw_line(Vector2(0.5, -11), Vector2(5.5, -11), Color(0.3, 0.31, 0.33), 1.0)


## A wooden embroidery hoop: half-stitched blue flowers, and "M.A." in tiny stitches.
static func _draw_embroidery_hoop(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(2, 3), 21, 21, SHADOW)
	c.draw_circle(Vector2.ZERO, 20, Color(0.92, 0.9, 0.84))
	# Forget-me-nots, the last one only half stitched
	for flower: Vector2 in [Vector2(-8, -7), Vector2(2, -10), Vector2(9, -3)]:
		for i in range(5):
			c.draw_circle(flower + Vector2.from_angle(TAU * i / 5.0) * 2.8, 2.2, Color(0.4, 0.55, 0.85))
		c.draw_circle(flower, 1.3, Color(0.95, 0.85, 0.3))
	for i in range(2):
		c.draw_circle(Vector2(-1, 1) + Vector2.from_angle(TAU * i / 5.0) * 2.8, 2.2, Color(0.4, 0.55, 0.85))
	c.draw_polyline(PackedVector2Array([Vector2(-8, -3), Vector2(-6, 2), Vector2(-2, 5)]), Color(0.35, 0.5, 0.3), 1.2)
	c.draw_polyline(PackedVector2Array([Vector2(9, 1), Vector2(6, 4), Vector2(2, 5)]), Color(0.35, 0.5, 0.3), 1.2)
	# The initials "M.A." stitched in red under the flowers
	var red := Color(0.7, 0.15, 0.15)
	c.draw_polyline(PackedVector2Array([Vector2(-10, 13), Vector2(-10, 8), Vector2(-7.5, 11), Vector2(-5, 8), Vector2(-5, 13)]), red, 1.2)
	c.draw_circle(Vector2(-3, 13), 0.8, red)
	c.draw_polyline(PackedVector2Array([Vector2(-1, 13), Vector2(1.5, 8), Vector2(4, 13)]), red, 1.2)
	c.draw_line(Vector2(0, 11), Vector2(3, 11), red, 1.0)
	c.draw_circle(Vector2(6, 13), 0.8, red)
	# A needle with a loose red thread
	c.draw_line(Vector2(9, 9), Vector2(15, 14), Color(0.8, 0.8, 0.82), 1.0)
	c.draw_polyline(PackedVector2Array([Vector2(15, 14), Vector2(19, 18), Vector2(17, 22)]), red, 0.8)
	# The wooden hoop and its brass screw
	c.draw_arc(Vector2.ZERO, 20, 0, TAU, 32, OAK, 4.0)
	c.draw_arc(Vector2.ZERO, 21.5, PI * 1.1, PI * 1.5, 10, Color(0.7, 0.55, 0.38), 1.0)
	c.draw_rect(Rect2(-3, -24, 6, 5), BRASS)


## A small garden trowel with a wooden handle and dry earth on the blade.
static func _draw_trowel(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 8), 27, 2.5, SHADOW)
	# Handle
	c.draw_rect(Rect2(-28, -4, 22, 8), Color(0.55, 0.35, 0.2))
	c.draw_line(Vector2(-27, -2), Vector2(-8, -2), Color(1, 1, 1, 0.2), 1.5)
	c.draw_rect(Rect2(-7, -3, 6, 6), Color(0.55, 0.56, 0.58))
	# Blade, pointed
	c.draw_colored_polygon(PackedVector2Array([Vector2(-1, -8), Vector2(18, -6), Vector2(29, 0), Vector2(18, 6),
		Vector2(-1, 8)]), Color(0.6, 0.62, 0.64))
	c.draw_line(Vector2(0, 0), Vector2(26, 0), Color(0.42, 0.44, 0.46), 1.0)
	# Dry earth caked near the tip
	c.draw_colored_polygon(PackedVector2Array([Vector2(14, -4), Vector2(22, -3), Vector2(26, 1), Vector2(19, 5), Vector2(13, 3)]),
		Color(0.36, 0.26, 0.17))
	c.draw_circle(Vector2(10, 5), 1.5, Color(0.36, 0.26, 0.17))


## A letter on a doctor's headed paper, with a snake-and-staff mark and "R.V.".
static func _draw_doctors_letter(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-18, -23, 40, 50), SHADOW)
	c.draw_rect(Rect2(-21, -26, 40, 50), Color(0.95, 0.94, 0.9))
	# Fold marks
	c.draw_line(Vector2(-21, -9), Vector2(19, -9), Color(0.82, 0.8, 0.75), 1.0)
	c.draw_line(Vector2(-21, 8), Vector2(19, 8), Color(0.82, 0.8, 0.75), 1.0)
	# Letterhead: a staff with a snake, and the initials
	var navy := Color(0.15, 0.2, 0.38)
	c.draw_line(Vector2(-15, -23), Vector2(-15, -13), navy, 1.2)
	c.draw_polyline(PackedVector2Array([Vector2(-17, -21), Vector2(-13, -19), Vector2(-17, -17), Vector2(-13, -15)]), navy, 1.0)
	c.draw_line(Vector2(-9, -20), Vector2(13, -20), navy, 2.0)
	c.draw_line(Vector2(-9, -15), Vector2(6, -15), Color(navy, 0.6), 1.0)
	# Neat lines of writing, and a signature
	for row in range(6):
		var y := -5.0 + row * 4.0
		c.draw_line(Vector2(-17, y), Vector2(15 - (row % 3) * 5, y), Color(INK, 0.75), 1.0)
	c.draw_polyline(PackedVector2Array([Vector2(2, 19), Vector2(5, 15), Vector2(7, 19), Vector2(10, 15), Vector2(15, 18)]), INK, 1.2)


## A long brass candle snuffer: a little cone on the end of a wooden pole.
static func _draw_candle_snuffer(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 9), 29, 2.5, SHADOW)
	c.draw_rect(Rect2(-30, -2, 34, 4), OAK)
	c.draw_line(Vector2(-29, -1), Vector2(2, -1), Color(1, 1, 1, 0.2), 1.0)
	c.draw_rect(Rect2(4, -2.5, 10, 5), BRASS_DARK)
	c.draw_rect(Rect2(14, -1.5, 6, 3), BRASS)
	# The bell-shaped cone, open side down
	c.draw_colored_polygon(PackedVector2Array([Vector2(19, -3), Vector2(26, -3), Vector2(30, 8), Vector2(16, 8)]), BRASS)
	PlaceholderArt.draw_ellipse(c, Vector2(23, 8), 7, 2, BRASS_DARK)
	c.draw_line(Vector2(20, -1), Vector2(18, 6), Color(1, 0.95, 0.75, 0.6), 1.2)
	# The little hook for pulling the wick straight
	c.draw_polyline(PackedVector2Array([Vector2(20, -3), Vector2(22, -8), Vector2(25, -9)]), BRASS, 1.5)


## A small hand-carved wooden cross on a leather cord.
static func _draw_wooden_cross(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(2, 20), 11, 2.5, SHADOW)
	# Cord looped above it
	c.draw_arc(Vector2(0, -18), 7, PI * 1.05, PI * 1.95, 10, Color(0.35, 0.22, 0.12), 1.5)
	c.draw_line(Vector2(-6.5, -19), Vector2(-2, -15), Color(0.35, 0.22, 0.12), 1.5)
	c.draw_line(Vector2(6.5, -19), Vector2(2, -15), Color(0.35, 0.22, 0.12), 1.5)
	c.draw_rect(Rect2(-3.5, -16, 7, 36), OAK_DARK)
	c.draw_rect(Rect2(-12, -8, 24, 7), OAK_DARK)
	c.draw_rect(Rect2(-2.5, -15, 5, 34), OAK)
	c.draw_rect(Rect2(-11, -7, 22, 5), OAK)
	c.draw_line(Vector2(-1.5, -14), Vector2(-1.5, 17), Color(1, 0.9, 0.7, 0.25), 1.0)
	# Knife marks from carving it
	c.draw_line(Vector2(-8, -5), Vector2(-6, -3), OAK_DARK, 1.0)
	c.draw_line(Vector2(0, 8), Vector2(2, 10), OAK_DARK, 1.0)


## An iron oarlock (a U-shaped rowlock with a pin), wet weed still caught on it.
static func _draw_oarlock(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(1, 18), 12, 2.5, SHADOW)
	# The pin it stands on
	c.draw_rect(Rect2(-3, 0, 6, 18), IRON_DARK)
	c.draw_rect(Rect2(-2, 1, 2, 16), Color(0.5, 0.5, 0.5))
	c.draw_rect(Rect2(-5, -1, 10, 3), IRON)
	# The U-shaped horns
	c.draw_arc(Vector2(0, -10), 11, 0, PI, 14, IRON_DARK, 5.5)
	c.draw_arc(Vector2(0, -10), 11, 0.2, PI * 0.9, 12, IRON, 3.0)
	c.draw_line(Vector2(-11, -10), Vector2(-12, -18), IRON_DARK, 5.0)
	c.draw_line(Vector2(11, -10), Vector2(12, -18), IRON_DARK, 5.0)
	c.draw_circle(Vector2(-12, -18), 3, IRON)
	c.draw_circle(Vector2(12, -18), 3, IRON)
	# Rust spots and a strand of lake weed
	c.draw_circle(Vector2(6, -3), 1.5, Color(0.55, 0.3, 0.15))
	c.draw_circle(Vector2(-1, 10), 1.2, Color(0.55, 0.3, 0.15))
	c.draw_polyline(PackedVector2Array([Vector2(-10, -6), Vector2(-14, 0), Vector2(-12, 6), Vector2(-16, 10)]), Color(0.3, 0.45, 0.25), 1.5)


## A long iron church key with a paper tag reading VESTRY.
static func _draw_vestry_key(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 11), 28, 2.5, SHADOW)
	# Ornate bow (a trefoil)
	for angle: float in [PI, PI * 0.6, PI * 1.4]:
		c.draw_arc(Vector2(-20, 0) + Vector2.from_angle(angle) * 4.0, 4.5, 0, TAU, 10, IRON_DARK, 2.5)
	c.draw_rect(Rect2(-15, -2, 33, 4), IRON)
	c.draw_line(Vector2(-14, -1.5), Vector2(16, -1.5), Color(1, 1, 1, 0.25), 1.0)
	# The bit, with notches
	c.draw_rect(Rect2(19, -2, 7, 10), IRON)
	c.draw_rect(Rect2(21, 3, 2, 3), IRON_DARK)
	# Tag on a string
	c.draw_line(Vector2(-14, 2), Vector2(-10, 8), Color(0.7, 0.65, 0.55), 1.0)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-10, 6), Vector2(10, 6), Vector2(10, 12), Vector2(-10, 12), Vector2(-12, 9)]), PAPER)
	c.draw_line(Vector2(-7, 9), Vector2(7, 9), INK, 1.2)


## A hand-drawn map of the lake: a path from the far shore to a small cottage marked with a cross.
static func _draw_cottage_map(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-26, -19, 56, 42), SHADOW)
	c.draw_rect(Rect2(-29, -22, 56, 42), Color(0.88, 0.82, 0.66))
	# Fold lines
	c.draw_line(Vector2(-1, -22), Vector2(-1, 20), PAPER_DARK, 1.0)
	c.draw_line(Vector2(-29, -1), Vector2(27, -1), PAPER_DARK, 1.0)
	# The lake, with the little island and its chapel
	c.draw_colored_polygon(PackedVector2Array([Vector2(-25, -14), Vector2(-8, -18), Vector2(4, -10), Vector2(2, 4),
		Vector2(-10, 14), Vector2(-24, 10)]), Color(0.5, 0.65, 0.75))
	PlaceholderArt.draw_ellipse(c, Vector2(-13, -2), 4, 3, Color(0.55, 0.6, 0.4))
	c.draw_rect(Rect2(-14, -5, 2, 3), INK)
	# Trees on the far shore
	for tree: Vector2 in [Vector2(10, -14), Vector2(16, -8), Vector2(22, -15)]:
		c.draw_circle(tree, 2.5, Color(0.3, 0.42, 0.28))
	# The dotted path across the water and up to the cottage
	var path := [Vector2(-10, -2), Vector2(-2, 2), Vector2(6, 4), Vector2(12, 6), Vector2(17, 9)]
	for point: Vector2 in path:
		c.draw_circle(point, 0.9, Color(0.6, 0.15, 0.12))
	c.draw_rect(Rect2(16, 9, 8, 6), Color(0.45, 0.3, 0.2))
	c.draw_colored_polygon(PackedVector2Array([Vector2(15, 9), Vector2(20, 5), Vector2(25, 9)]), Color(0.35, 0.18, 0.15))
	c.draw_line(Vector2(9, 12), Vector2(14, 17), Color(0.75, 0.1, 0.1), 1.5)
	c.draw_line(Vector2(14, 12), Vector2(9, 17), Color(0.75, 0.1, 0.1), 1.5)
