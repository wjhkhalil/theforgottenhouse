@tool
class_name JettyObjects
extends RefCounted
## Placeholder drawings for the hidden objects of House Two, Chapter One (The Jetty).
## Same rules as placeholder_art.gd: every drawing is centred on (0, 0) and
## fits inside get_size(). PlaceholderArt calls these functions.

const SILVER := Color(0.78, 0.8, 0.84)
const SILVER_DARK := Color(0.48, 0.5, 0.55)
const BRASS := Color(0.78, 0.6, 0.28)
const BRASS_DARK := Color(0.5, 0.36, 0.14)
const PAPER := Color(0.88, 0.84, 0.72)
const WET_WOOD := Color(0.36, 0.27, 0.19)
const WATER_LINE := Color(0.6, 0.75, 0.85, 0.45)
const SHADOW := Color(0, 0, 0, 0.35)


## Size of the drawing, or Vector2.ZERO if `style` is not one of this chapter's objects.
static func get_size(style: int) -> Vector2:
	match style:
		HiddenObjectData.PlaceholderStyle.POLICE_SEAL:
			return Vector2(58, 26)
		HiddenObjectData.PlaceholderStyle.CIGARETTE_CASE:
			return Vector2(40, 28)
		HiddenObjectData.PlaceholderStyle.FISHING_FLOAT:
			return Vector2(26, 46)
		HiddenObjectData.PlaceholderStyle.NAME_BOARD:
			return Vector2(96, 26)
		HiddenObjectData.PlaceholderStyle.MESSAGE_BOTTLE:
			return Vector2(56, 24)
		HiddenObjectData.PlaceholderStyle.COMPASS:
			return Vector2(36, 36)
		HiddenObjectData.PlaceholderStyle.TACKLE_KEY:
			return Vector2(44, 24)
		HiddenObjectData.PlaceholderStyle.LOG_PAGE:
			return Vector2(44, 52)
		HiddenObjectData.PlaceholderStyle.REGISTRATION:
			return Vector2(56, 42)
		HiddenObjectData.PlaceholderStyle.PRESCRIPTION:
			return Vector2(40, 50)
	return Vector2.ZERO


## Draws `style` and returns true, or returns false if it is not one of this chapter's objects.
static func draw(c: CanvasItem, style: int) -> bool:
	match style:
		HiddenObjectData.PlaceholderStyle.POLICE_SEAL:
			_draw_police_seal(c)
		HiddenObjectData.PlaceholderStyle.CIGARETTE_CASE:
			_draw_cigarette_case(c)
		HiddenObjectData.PlaceholderStyle.FISHING_FLOAT:
			_draw_fishing_float(c)
		HiddenObjectData.PlaceholderStyle.NAME_BOARD:
			_draw_name_board(c)
		HiddenObjectData.PlaceholderStyle.MESSAGE_BOTTLE:
			_draw_message_bottle(c)
		HiddenObjectData.PlaceholderStyle.COMPASS:
			_draw_compass(c)
		HiddenObjectData.PlaceholderStyle.TACKLE_KEY:
			_draw_tackle_key(c)
		HiddenObjectData.PlaceholderStyle.LOG_PAGE:
			_draw_log_page(c)
		HiddenObjectData.PlaceholderStyle.REGISTRATION:
			_draw_registration(c)
		HiddenObjectData.PlaceholderStyle.PRESCRIPTION:
			_draw_prescription(c)
		_:
			return false
	return true


## A torn strip of blue-and-white police tape with a red wax seal.
static func _draw_police_seal(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 11), 27, 3, SHADOW)
	# Two torn halves of the tape, hanging at angles
	c.draw_colored_polygon(PackedVector2Array([Vector2(-28, -8), Vector2(-2, -4), Vector2(0, 3), Vector2(-28, -1)]),
		Color(0.92, 0.93, 0.96))
	c.draw_colored_polygon(PackedVector2Array([Vector2(3, -2), Vector2(28, -6), Vector2(28, 2), Vector2(5, 6)]),
		Color(0.92, 0.93, 0.96))
	for x in [-24.0, -15.0, -6.0]:
		c.draw_line(Vector2(x, -7 + (x + 28) * 0.15), Vector2(x + 4, 0 + (x + 28) * 0.15), Color(0.15, 0.25, 0.6), 3.0)
	for x in [8.0, 17.0, 25.0]:
		c.draw_line(Vector2(x, -3 - (x - 3) * 0.15), Vector2(x - 3, 4 - (x - 3) * 0.15), Color(0.15, 0.25, 0.6), 3.0)
	# Ragged torn ends
	c.draw_polyline(PackedVector2Array([Vector2(-2, -4), Vector2(1, -2), Vector2(-1, 0), Vector2(0, 3)]), Color(0.7, 0.72, 0.76), 1.0)
	# Wax seal on the left piece
	c.draw_circle(Vector2(-16, 6), 6, Color(0.55, 0.08, 0.07))
	c.draw_circle(Vector2(-16, 6), 4, Color(0.7, 0.14, 0.11))
	c.draw_arc(Vector2(-17, 5), 3, PI, PI * 1.6, 5, Color(1, 1, 1, 0.4), 1.0)


## A flat silver cigarette case, dented, engraved with "RV".
static func _draw_cigarette_case(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(1, 12), 19, 3, SHADOW)
	var box := StyleBoxFlat.new()
	box.bg_color = SILVER_DARK
	box.set_corner_radius_all(4)
	c.draw_style_box(box, Rect2(-19, -12, 38, 24))
	box.bg_color = SILVER
	c.draw_style_box(box, Rect2(-18, -12, 36, 21))
	# Engraved border and initials
	c.draw_rect(Rect2(-14, -9, 28, 15), Color(0.55, 0.57, 0.62), false, 1.0)
	var engrave := Color(0.4, 0.42, 0.47)
	c.draw_line(Vector2(-8, -5), Vector2(-8, 3), engrave, 1.3)
	c.draw_arc(Vector2(-6.5, -3), 2.2, -PI / 2, PI / 2, 6, engrave, 1.3)
	c.draw_line(Vector2(-7, -1), Vector2(-4, 3), engrave, 1.3)
	c.draw_line(Vector2(1, -5), Vector2(4, 3), engrave, 1.3)
	c.draw_line(Vector2(4, 3), Vector2(7, -5), engrave, 1.3)
	# A dent and a shine
	c.draw_arc(Vector2(11, 4), 3, PI, TAU, 6, Color(0.4, 0.42, 0.47), 1.2)
	c.draw_line(Vector2(-16, -11), Vector2(10, -11), Color(1, 1, 1, 0.6), 1.2)


## A red-and-white fishing float riding on a little ring of ripples.
static func _draw_fishing_float(c: CanvasItem) -> void:
	# Ripples on the water
	c.draw_arc(Vector2(0, 14), 12, 0, TAU, 18, WATER_LINE, 1.2)
	PlaceholderArt.draw_ellipse(c, Vector2(0, 15), 9, 2.5, Color(0.04, 0.08, 0.14, 0.5))
	# Stem with a rolled note wound round it
	c.draw_line(Vector2(0, -22), Vector2(0, -6), Color(0.2, 0.2, 0.2), 2.0)
	c.draw_rect(Rect2(-3, -18, 6, 6), PAPER)
	c.draw_line(Vector2(-3, -15), Vector2(3, -15), Color(0.5, 0.45, 0.35), 0.8)
	# Red top, white bottom
	PlaceholderArt.draw_ellipse(c, Vector2(0, 2), 8, 11, Color(0.92, 0.92, 0.9))
	c.draw_colored_polygon(PackedVector2Array([Vector2(-8, 1), Vector2(-6, -5), Vector2(0, -9), Vector2(6, -5), Vector2(8, 1)]),
		Color(0.85, 0.14, 0.1))
	c.draw_line(Vector2(-8, 1), Vector2(8, 1), Color(0.3, 0.05, 0.05), 1.0)
	c.draw_arc(Vector2(-2, -3), 4, PI, PI * 1.5, 5, Color(1, 1, 1, 0.6), 1.5)


## A broken plank painted "LADY MARGARET", floating, waterline across the bottom.
static func _draw_name_board(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 10), 48, 4, Color(0.04, 0.08, 0.14, 0.5))
	# Plank with one splintered end
	c.draw_colored_polygon(PackedVector2Array([Vector2(-46, -9), Vector2(40, -10), Vector2(44, -6), Vector2(41, -3),
		Vector2(46, 0), Vector2(42, 8), Vector2(-46, 8)]), WET_WOOD)
	c.draw_line(Vector2(-46, -9), Vector2(40, -10), Color(0.5, 0.38, 0.26), 1.5)
	# White painted letters (blocky placeholder letters)
	var paint := Color(0.9, 0.88, 0.8)
	var x := -40.0
	for width in [5.0, 6.0, 6.0, 6.0, 3.0, 7.0, 6.0, 6.0, 6.0, 6.0, 6.0, 5.0, 5.0]:
		if width > 3.0:
			c.draw_rect(Rect2(x, -5, width - 1.5, 2), paint)
			c.draw_rect(Rect2(x, -5, 1.5, 8), paint)
			c.draw_rect(Rect2(x, 1, width - 1.5, 2), paint)
		x += width
	# Number underneath, in red
	c.draw_line(Vector2(10, 6), Vector2(36, 6), Color(0.75, 0.2, 0.15), 1.5)
	# The waterline and ripples
	c.draw_line(Vector2(-50, 8), Vector2(48, 8), WATER_LINE, 1.5)
	c.draw_arc(Vector2(-30, 10), 8, 0, PI, 8, WATER_LINE, 1.0)
	c.draw_arc(Vector2(28, 10), 9, 0, PI, 8, WATER_LINE, 1.0)


## A corked green bottle lying in the water with a rolled note inside.
static func _draw_message_bottle(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 8), 27, 3.5, Color(0.04, 0.08, 0.14, 0.5))
	var glass := Color(0.2, 0.45, 0.28, 0.9)
	# Body, shoulder and neck
	PlaceholderArt.draw_ellipse(c, Vector2(-6, 0), 18, 9, glass)
	c.draw_colored_polygon(PackedVector2Array([Vector2(8, -6), Vector2(18, -3), Vector2(18, 3), Vector2(8, 6)]), glass)
	c.draw_rect(Rect2(18, -3, 6, 6), Color(0.18, 0.4, 0.25))
	c.draw_rect(Rect2(23, -2.5, 5, 5), Color(0.6, 0.45, 0.28))
	# Rolled note inside
	c.draw_rect(Rect2(-16, -3, 20, 6), Color(PAPER, 0.85))
	c.draw_line(Vector2(-16, 0), Vector2(4, 0), Color(0.5, 0.45, 0.35, 0.7), 0.8)
	# Glint and the waterline cutting across the lower half
	c.draw_line(Vector2(-18, -6), Vector2(4, -7), Color(1, 1, 1, 0.5), 1.5)
	c.draw_rect(Rect2(-26, 3, 54, 7), Color(0.08, 0.16, 0.24, 0.45))
	c.draw_line(Vector2(-27, 3), Vector2(28, 3), WATER_LINE, 1.2)


## A round brass compass, lid open, glass cracked.
static func _draw_compass(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(1, 15), 16, 3, SHADOW)
	c.draw_circle(Vector2(0, 1), 15, BRASS_DARK)
	c.draw_circle(Vector2(0, 0), 14, BRASS)
	c.draw_circle(Vector2(0, 0), 11, Color(0.9, 0.87, 0.78))
	# Compass rose ticks
	for i in range(8):
		var angle := TAU * i / 8.0
		var inner := 7.5 if i % 2 == 0 else 9.0
		c.draw_line(Vector2.from_angle(angle) * inner, Vector2.from_angle(angle) * 10.5, Color(0.3, 0.25, 0.2), 1.0)
	# Needle: red north, dark south
	c.draw_colored_polygon(PackedVector2Array([Vector2(-2, 0), Vector2(5, -7), Vector2(2, 0)]), Color(0.8, 0.15, 0.1))
	c.draw_colored_polygon(PackedVector2Array([Vector2(-2, 0), Vector2(-5, 7), Vector2(2, 0)]), Color(0.2, 0.2, 0.25))
	c.draw_circle(Vector2.ZERO, 1.5, BRASS_DARK)
	# Crack across the glass
	c.draw_polyline(PackedVector2Array([Vector2(-9, -6), Vector2(-3, -2), Vector2(1, -5), Vector2(8, 3)]), Color(1, 1, 1, 0.7), 1.0)
	# Ring at the top
	c.draw_arc(Vector2(0, -16), 3, 0, TAU, 8, BRASS_DARK, 1.6)


## A tiny padlock key on a cork key ring with a paper tag.
static func _draw_tackle_key(c: CanvasItem) -> void:
	PlaceholderArt.draw_ellipse(c, Vector2(0, 9), 20, 2.5, SHADOW)
	# Cork float
	c.draw_rect(Rect2(-21, -6, 14, 11), Color(0.72, 0.55, 0.36))
	for p in [Vector2(-18, -3), Vector2(-12, 1), Vector2(-15, 3)]:
		c.draw_circle(p, 0.9, Color(0.5, 0.36, 0.22))
	c.draw_arc(Vector2(-5, -1), 3.5, 0, TAU, 8, SILVER_DARK, 1.4)
	# Key
	c.draw_circle(Vector2(3, -1), 4.5, SILVER_DARK)
	c.draw_circle(Vector2(3, -1), 2, Color(0.15, 0.15, 0.17))
	c.draw_rect(Rect2(7, -2, 12, 3), SILVER)
	c.draw_rect(Rect2(14, 1, 2, 3), SILVER)
	c.draw_rect(Rect2(17, 1, 2, 2), SILVER)
	# Paper tag
	c.draw_line(Vector2(-14, 5), Vector2(-12, 9), Color(0.6, 0.55, 0.4), 0.8)
	c.draw_rect(Rect2(-16, 8, 10, 6), PAPER)


## A logbook page with a printed grid and two handwritten rows, one edge torn.
static func _draw_log_page(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-18, -22, 40, 48), SHADOW)
	c.draw_colored_polygon(PackedVector2Array([Vector2(-21, -25), Vector2(19, -25), Vector2(20, -18), Vector2(18, -10),
		Vector2(21, -2), Vector2(18, 8), Vector2(20, 16), Vector2(19, 24), Vector2(-21, 24)]), PAPER)
	# Printed columns
	for x in [-11.0, 4.0]:
		c.draw_line(Vector2(x, -20), Vector2(x, 21), Color(0.45, 0.55, 0.7, 0.5), 1.0)
	for i in range(8):
		c.draw_line(Vector2(-19, -18 + i * 5.5), Vector2(17, -18 + i * 5.5), Color(0.45, 0.55, 0.7, 0.35), 1.0)
	# Header and two handwritten entries
	c.draw_rect(Rect2(-19, -24, 38, 4), Color(0.3, 0.38, 0.5, 0.6))
	for row in [-14.0, -8.5]:
		c.draw_line(Vector2(-18, row), Vector2(-13, row), PlaceholderArt.INK, 1.1)
		c.draw_line(Vector2(-9, row), Vector2(2, row), PlaceholderArt.INK, 1.1)
		c.draw_line(Vector2(6, row), Vector2(15, row), PlaceholderArt.INK, 1.1)
	# Water stain
	c.draw_circle(Vector2(6, 12), 7, Color(0.55, 0.48, 0.3, 0.3))


## Official registration papers: a crest, typed lines and a stamp.
static func _draw_registration(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-24, -17, 52, 38), SHADOW)
	c.draw_rect(Rect2(-27, -20, 52, 38), Color(0.86, 0.85, 0.78))
	c.draw_rect(Rect2(-25, -18, 48, 34), Color(0.35, 0.42, 0.55, 0.6), false, 1.0)
	# Crest and title
	c.draw_circle(Vector2(-17, -10), 4, Color(0.35, 0.42, 0.55))
	c.draw_line(Vector2(-10, -12), Vector2(18, -12), PlaceholderArt.INK, 1.6)
	c.draw_line(Vector2(-10, -8), Vector2(8, -8), Color(PlaceholderArt.INK, 0.6), 1.0)
	# Typed lines
	for i in range(4):
		c.draw_line(Vector2(-22, -2 + i * 4.5), Vector2(10.0 - (i % 2) * 8.0, -2 + i * 4.5), Color(PlaceholderArt.INK, 0.75), 1.0)
	# Red "SOLD" stamp
	c.draw_rect(Rect2(9, 2, 13, 9), Color(0.75, 0.15, 0.12, 0.85), false, 1.5)
	c.draw_line(Vector2(11, 6.5), Vector2(20, 6.5), Color(0.75, 0.15, 0.12, 0.85), 1.5)


## A small doctor's prescription pad with "Rx" and a few stubs of torn pages.
static func _draw_prescription(c: CanvasItem) -> void:
	c.draw_rect(Rect2(-16, -21, 36, 46), SHADOW)
	# Cardboard back and the pad
	c.draw_rect(Rect2(-19, -24, 36, 46), Color(0.35, 0.3, 0.26))
	c.draw_rect(Rect2(-18, -19, 34, 40), Color(0.93, 0.93, 0.9))
	# Stubs of torn-out pages along the top
	for x in range(-18, 16, 4):
		c.draw_line(Vector2(x, -21), Vector2(x + 2, -19), Color(0.85, 0.85, 0.82), 1.0)
	c.draw_rect(Rect2(-19, -24, 36, 4), Color(0.2, 0.3, 0.45))
	# "Rx" symbol
	var ink := Color(0.15, 0.25, 0.45)
	c.draw_line(Vector2(-13, -12), Vector2(-13, -2), ink, 1.6)
	c.draw_arc(Vector2(-11, -9.5), 2.6, -PI / 2, PI / 2, 6, ink, 1.6)
	c.draw_line(Vector2(-11, -7), Vector2(-6, -1), ink, 1.6)
	c.draw_line(Vector2(-8, -4), Vector2(-4, -8), ink, 1.3)
	# Printed doctor's name and lines to write on
	c.draw_line(Vector2(-2, -12), Vector2(13, -12), Color(0.2, 0.2, 0.25), 1.4)
	for i in range(4):
		c.draw_line(Vector2(-14, 4 + i * 4.5), Vector2(13, 4 + i * 4.5), Color(0.6, 0.65, 0.75, 0.6), 1.0)
	# Hasty signature at the bottom
	c.draw_polyline(PackedVector2Array([Vector2(0, 19), Vector2(3, 15), Vector2(5, 19), Vector2(8, 15), Vector2(13, 18)]), ink, 1.0)
