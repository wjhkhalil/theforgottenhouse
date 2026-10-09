@tool
class_name PlaceholderArt
extends RefCounted
## Procedural placeholder drawings for the hidden objects + the shared colour palette.
##
## Every drawing is centred on (0, 0) and fits inside get_style_size().
## The same drawing code is used in the room (PlaceholderVisual) and in the
## objective list (ObjectIcon), so both always match.
##
## When real artwork is added, these drawings are simply no longer used.

# --- Shared colour palette (dark blue, muted brown, dusty beige, faded green, warm light) ---
const WALL_TOP := Color(0.075, 0.09, 0.15)
const WALL_BOTTOM := Color(0.16, 0.19, 0.29)
const WOOD := Color(0.42, 0.29, 0.2)
const WOOD_DARK := Color(0.27, 0.18, 0.13)
const WOOD_LIGHT := Color(0.55, 0.4, 0.28)
const BEIGE := Color(0.85, 0.79, 0.65)
const BEIGE_DARK := Color(0.66, 0.59, 0.46)
const GREEN := Color(0.36, 0.43, 0.31)
const GREEN_DARK := Color(0.25, 0.31, 0.22)
const WARM := Color(0.95, 0.76, 0.48)
const MOON := Color(0.82, 0.86, 0.94)
const SHADOW := Color(0, 0, 0, 0.35)
const INK := Color(0.22, 0.2, 0.28)


## Returns the size (in pixels) of a placeholder drawing.
## Used to size the click area and to fit icons.
static func get_style_size(style: int) -> Vector2:
	match style:
		HiddenObjectData.PlaceholderStyle.KEY:
			return Vector2(62, 26)
		HiddenObjectData.PlaceholderStyle.PHOTOGRAPH:
			return Vector2(48, 58)
		HiddenObjectData.PlaceholderStyle.LETTER:
			return Vector2(58, 40)
		HiddenObjectData.PlaceholderStyle.DIARY:
			return Vector2(46, 60)
		HiddenObjectData.PlaceholderStyle.TEDDY_BEAR:
			return Vector2(50, 64)
		HiddenObjectData.PlaceholderStyle.WRISTBAND:
			return Vector2(32, 46)
		HiddenObjectData.PlaceholderStyle.FILM_NEGATIVES:
			return Vector2(26, 66)
		HiddenObjectData.PlaceholderStyle.MUSIC_BOX:
			return Vector2(46, 36)
		HiddenObjectData.PlaceholderStyle.RAIN_BOOTS:
			return Vector2(48, 40)
		HiddenObjectData.PlaceholderStyle.POCKET_WATCH:
			return Vector2(32, 44)
		HiddenObjectData.PlaceholderStyle.NEWSPAPER:
			return Vector2(54, 42)
		HiddenObjectData.PlaceholderStyle.SMALL_KEY:
			return Vector2(38, 18)
		HiddenObjectData.PlaceholderStyle.DOCUMENT:
			return Vector2(46, 58)
		HiddenObjectData.PlaceholderStyle.LEDGER:
			return Vector2(56, 40)
		HiddenObjectData.PlaceholderStyle.CHILD_DRAWING:
			return Vector2(52, 42)
		HiddenObjectData.PlaceholderStyle.SPECTACLES:
			return Vector2(42, 18)
		HiddenObjectData.PlaceholderStyle.LOCKET:
			return Vector2(26, 40)
		HiddenObjectData.PlaceholderStyle.TELEGRAM:
			return Vector2(54, 34)
	# Chapters Four to Eight keep their drawings in scripts/object_art/.
	for chapter_size: Vector2 in [StaircaseObjects.get_size(style), WashroomObjects.get_size(style),
			LivingRoomObjects.get_size(style), KitchenObjects.get_size(style), StudyObjects.get_size(style),
			JettyObjects.get_size(style), BoatShedObjects.get_size(style), LoftObjects.get_size(style)]:
		if chapter_size != Vector2.ZERO:
			return chapter_size
	for art in _later_chapter_art():
		var later_size: Vector2 = art.get_size(style)
		if later_size != Vector2.ZERO:
			return later_size
	return Vector2(40, 40)


## House Two, Chapters Four to Ten keep their drawings in these files. They are
## looked up by path, so a chapter whose file doesn't exist yet is simply skipped.
const LATER_CHAPTER_ART: Array[String] = [
	"res://scripts/object_art/workshop_objects.gd",
	"res://scripts/object_art/sunken_boat_objects.gd",
	"res://scripts/object_art/ice_house_objects.gd",
	"res://scripts/object_art/lighthouse_steps_objects.gd",
	"res://scripts/object_art/lamp_room_objects.gd",
	"res://scripts/object_art/chapel_objects.gd",
	"res://scripts/object_art/vane_cottage_objects.gd",
]

static var _later_art_cache: Array[Script] = []
static var _later_art_loaded: bool = false


static func _later_chapter_art() -> Array[Script]:
	if not _later_art_loaded:
		_later_art_loaded = true
		for path in LATER_CHAPTER_ART:
			if ResourceLoader.exists(path):
				var art := load(path) as Script
				if art != null:
					_later_art_cache.append(art)
	return _later_art_cache


## Draws the placeholder for `style` onto `canvas`.
## Must be called from inside the canvas' _draw() function.
static func draw_object(canvas: CanvasItem, style: int) -> void:
	match style:
		HiddenObjectData.PlaceholderStyle.KEY:
			_draw_key(canvas)
		HiddenObjectData.PlaceholderStyle.PHOTOGRAPH:
			_draw_photograph(canvas)
		HiddenObjectData.PlaceholderStyle.LETTER:
			_draw_letter(canvas)
		HiddenObjectData.PlaceholderStyle.DIARY:
			_draw_diary(canvas)
		HiddenObjectData.PlaceholderStyle.TEDDY_BEAR:
			_draw_teddy_bear(canvas)
		HiddenObjectData.PlaceholderStyle.WRISTBAND:
			_draw_wristband(canvas)
		HiddenObjectData.PlaceholderStyle.FILM_NEGATIVES:
			_draw_film_negatives(canvas)
		HiddenObjectData.PlaceholderStyle.MUSIC_BOX:
			_draw_music_box(canvas)
		HiddenObjectData.PlaceholderStyle.RAIN_BOOTS:
			_draw_rain_boots(canvas)
		HiddenObjectData.PlaceholderStyle.POCKET_WATCH:
			_draw_pocket_watch(canvas)
		HiddenObjectData.PlaceholderStyle.NEWSPAPER:
			_draw_newspaper(canvas)
		HiddenObjectData.PlaceholderStyle.SMALL_KEY:
			_draw_small_key(canvas)
		HiddenObjectData.PlaceholderStyle.DOCUMENT:
			_draw_document(canvas)
		HiddenObjectData.PlaceholderStyle.LEDGER:
			_draw_ledger(canvas)
		HiddenObjectData.PlaceholderStyle.CHILD_DRAWING:
			_draw_child_drawing(canvas)
		HiddenObjectData.PlaceholderStyle.SPECTACLES:
			_draw_spectacles(canvas)
		HiddenObjectData.PlaceholderStyle.LOCKET:
			_draw_locket(canvas)
		HiddenObjectData.PlaceholderStyle.TELEGRAM:
			_draw_telegram(canvas)
		_:
			# Chapters Four to Eight keep their drawings in scripts/object_art/.
			if StaircaseObjects.draw(canvas, style) or WashroomObjects.draw(canvas, style) \
					or LivingRoomObjects.draw(canvas, style) or KitchenObjects.draw(canvas, style) \
					or StudyObjects.draw(canvas, style) or JettyObjects.draw(canvas, style) \
					or BoatShedObjects.draw(canvas, style) or LoftObjects.draw(canvas, style):
				return
			for art in _later_chapter_art():
				if art.draw(canvas, style):
					return
			draw_generic(canvas)


## Builds the outline points of an ellipse (Godot has no draw_ellipse function).
static func ellipse_points(center: Vector2, radius_x: float, radius_y: float, segments: int = 24) -> PackedVector2Array:
	var points := PackedVector2Array()
	for i in range(segments):
		var angle := TAU * i / segments
		points.append(center + Vector2(cos(angle) * radius_x, sin(angle) * radius_y))
	return points


static func draw_ellipse(canvas: CanvasItem, center: Vector2, radius_x: float, radius_y: float, color: Color) -> void:
	canvas.draw_colored_polygon(ellipse_points(center, radius_x, radius_y), color)


# ---------------------------------------------------------------------------
# Individual drawings
# ---------------------------------------------------------------------------

static func _draw_key(c: CanvasItem) -> void:
	var rust := Color(0.62, 0.36, 0.19)
	var rust_dark := Color(0.38, 0.21, 0.12)
	var rust_light := Color(0.82, 0.55, 0.32)
	draw_ellipse(c, Vector2(2, 9), 30, 4, Color(0, 0, 0, 0.35))
	# Shaft
	c.draw_rect(Rect2(-10, -3, 38, 7), rust_dark)
	c.draw_rect(Rect2(-10, -3, 38, 3), rust)
	# Teeth (with a cleaned, shiny edge - part of the clue)
	c.draw_rect(Rect2(17, 3, 5, 8), rust_dark)
	c.draw_rect(Rect2(24, 3, 4, 6), rust_dark)
	c.draw_line(Vector2(17, 9), Vector2(22, 9), Color(0.92, 0.82, 0.66), 1.5)
	c.draw_line(Vector2(24, 7), Vector2(28, 7), Color(0.92, 0.82, 0.66), 1.5)
	# Collar and bow (the ring you hold)
	c.draw_rect(Rect2(-10, -5, 4, 11), rust_dark)
	c.draw_arc(Vector2(-19, 0), 9, 0, TAU, 24, rust_dark, 6, true)
	c.draw_arc(Vector2(-19, 0), 9, PI, PI * 1.6, 10, rust_light, 2, true)
	# Rust spots
	c.draw_circle(Vector2(3, 0), 1.6, rust_light)
	c.draw_circle(Vector2(11, 1), 1.3, rust_dark)
	c.draw_circle(Vector2(-24, 5), 1.5, rust_light)


static func _draw_photograph(c: CanvasItem) -> void:
	var paper := Color(0.88, 0.84, 0.74)
	var sepia := Color(0.52, 0.42, 0.3)
	var figure := Color(0.28, 0.21, 0.15)
	c.draw_rect(Rect2(-21, -26, 46, 56), Color(0, 0, 0, 0.35))
	c.draw_rect(Rect2(-24, -29, 46, 56), paper)
	# Faded picture area
	c.draw_rect(Rect2(-19, -24, 36, 36), sepia)
	c.draw_rect(Rect2(-19, -24, 36, 13), Color(0.64, 0.55, 0.41))
	# Two people
	c.draw_circle(Vector2(-8, -8), 4.2, figure)
	c.draw_rect(Rect2(-12.5, -4, 9, 16), figure)
	c.draw_circle(Vector2(7, -8), 4.2, figure)
	c.draw_rect(Rect2(2.5, -4, 9, 16), figure)
	# One face has been scratched out
	var scratch := Color(0.93, 0.89, 0.8)
	c.draw_line(Vector2(3, -12), Vector2(11, -4), scratch, 1.4)
	c.draw_line(Vector2(11, -12), Vector2(3, -4), scratch, 1.4)
	c.draw_line(Vector2(2, -8), Vector2(12, -9), scratch, 1.2)
	# Bent corner and caption
	c.draw_colored_polygon(PackedVector2Array([Vector2(22, 19), Vector2(22, 27), Vector2(14, 27)]), Color(0.7, 0.66, 0.56))
	c.draw_line(Vector2(-15, 19), Vector2(6, 19), Color(0.35, 0.3, 0.25, 0.7), 1.2)


static func _draw_letter(c: CanvasItem) -> void:
	var paper := Color(0.91, 0.86, 0.72)
	var torn_paper := PackedVector2Array([
		Vector2(-29, -19), Vector2(20, -19), Vector2(25, -13), Vector2(19, -7),
		Vector2(26, -1), Vector2(20, 5), Vector2(27, 12), Vector2(22, 20), Vector2(-29, 20),
	])
	var shadow := PackedVector2Array()
	for point in torn_paper:
		shadow.append(point + Vector2(3, 3))
	c.draw_colored_polygon(shadow, Color(0, 0, 0, 0.35))
	c.draw_colored_polygon(torn_paper, paper)
	# Fold crease with one slightly shaded half
	c.draw_colored_polygon(PackedVector2Array([Vector2(-29, -19), Vector2(-4, -19), Vector2(-4, 20), Vector2(-29, 20)]), Color(0, 0, 0, 0.06))
	c.draw_line(Vector2(-4, -19), Vector2(-4, 20), Color(0.68, 0.61, 0.48), 1.5)
	# Handwriting lines
	for i in range(5):
		var y := -12.0 + i * 6.0
		c.draw_line(Vector2(-24, y), Vector2(-9, y), Color(INK, 0.75), 1.2)
		c.draw_line(Vector2(1, y), Vector2(15.0 - (i % 2) * 5.0, y), Color(INK, 0.75), 1.2)
	# Red wax seal
	c.draw_circle(Vector2(-21, 13), 4.5, Color(0.55, 0.14, 0.12))
	c.draw_circle(Vector2(-22, 12), 1.5, Color(0.75, 0.3, 0.25))


static func _draw_diary(c: CanvasItem) -> void:
	var leather := Color(0.36, 0.2, 0.17)
	var leather_dark := Color(0.22, 0.12, 0.1)
	var gold := Color(0.86, 0.68, 0.32)
	c.draw_rect(Rect2(-20, -27, 44, 58), Color(0, 0, 0, 0.35))
	# Pages peeking out at the side and bottom
	c.draw_rect(Rect2(-19, -27, 41, 56), Color(0.86, 0.8, 0.66))
	# Cover and spine
	c.draw_rect(Rect2(-23, -30, 42, 57), leather)
	c.draw_rect(Rect2(-23, -30, 8, 57), leather_dark)
	# Gold tooled border and title plate
	c.draw_rect(Rect2(-11, -25, 26, 47), Color(gold, 0.55), false, 1.0)
	c.draw_rect(Rect2(-7, -16, 18, 11), Color(0.84, 0.75, 0.55))
	c.draw_line(Vector2(-4, -12), Vector2(8, -12), Color(INK, 0.8), 1.0)
	c.draw_line(Vector2(-3, -8), Vector2(6, -8), Color(INK, 0.8), 1.0)
	# Strap and clasp
	c.draw_rect(Rect2(11, -3, 12, 8), leather_dark)
	c.draw_rect(Rect2(16, -5, 5, 12), gold)
	# Scuffs
	c.draw_circle(Vector2(-4, 14), 2.5, Color(1, 1, 1, 0.08))
	c.draw_circle(Vector2(8, 18), 1.8, Color(1, 1, 1, 0.08))


static func _draw_teddy_bear(c: CanvasItem) -> void:
	var fur := Color(0.6, 0.43, 0.28)
	var fur_dark := Color(0.4, 0.27, 0.17)
	var muzzle := Color(0.84, 0.72, 0.54)
	var eye := Color(0.1, 0.08, 0.08)
	draw_ellipse(c, Vector2(0, 30), 22, 4, Color(0, 0, 0, 0.3))
	# Legs, body and arms
	draw_ellipse(c, Vector2(-11, 24), 9, 7, fur_dark)
	draw_ellipse(c, Vector2(11, 24), 9, 7, fur_dark)
	draw_ellipse(c, Vector2(0, 9), 16, 18, fur)
	draw_ellipse(c, Vector2(0, 12), 9, 10, muzzle)
	draw_ellipse(c, Vector2(-17, 5), 6, 10, fur_dark)
	draw_ellipse(c, Vector2(17, 5), 6, 10, fur_dark)
	# Stitched note on the belly (the hidden clue)
	c.draw_rect(Rect2(-4, 9, 8, 7), Color(0.95, 0.93, 0.86))
	c.draw_line(Vector2(-5, 8), Vector2(-3, 10), INK, 1.0)
	c.draw_line(Vector2(3, 8), Vector2(5, 10), INK, 1.0)
	# Ears and head
	c.draw_circle(Vector2(-12, -24), 7, fur_dark)
	c.draw_circle(Vector2(12, -24), 7, fur_dark)
	c.draw_circle(Vector2(-12, -24), 3.5, muzzle)
	c.draw_circle(Vector2(12, -24), 3.5, muzzle)
	c.draw_circle(Vector2(0, -13), 15, fur)
	# Face: muzzle, nose, one normal eye and one old button eye
	draw_ellipse(c, Vector2(0, -8), 7, 5, muzzle)
	draw_ellipse(c, Vector2(0, -10), 2.6, 2, eye)
	c.draw_line(Vector2(0, -8), Vector2(0, -5), eye, 1.0)
	c.draw_circle(Vector2(-6, -16), 2.2, eye)
	c.draw_circle(Vector2(6, -16), 3.0, Color(0.25, 0.27, 0.33))
	c.draw_circle(Vector2(5, -16), 0.7, muzzle)
	c.draw_circle(Vector2(7, -16), 0.7, muzzle)
	# A patched stitch on the head
	c.draw_line(Vector2(-9, -23), Vector2(-4, -21), fur_dark, 1.2)


# --- Chapter Two objects ----------------------------------------------------

static func _draw_wristband(c: CanvasItem) -> void:
	var plastic := Color(0.8, 0.83, 0.8)
	# Hanging loop of the band
	var loop := ellipse_points(Vector2(0, 2), 11, 17, 28)
	loop.append(loop[0])
	c.draw_polyline(loop, Color(0, 0, 0, 0.35), 7.0, true)
	c.draw_polyline(loop, plastic, 4.5, true)
	# Name label with tiny writing
	c.draw_rect(Rect2(-10, 9, 20, 12), Color(0.95, 0.95, 0.92))
	c.draw_rect(Rect2(-10, 9, 20, 12), Color(0.5, 0.5, 0.5), false, 1.0)
	c.draw_line(Vector2(-7, 13), Vector2(6, 13), Color(INK, 0.85), 1.0)
	c.draw_line(Vector2(-7, 17), Vector2(3, 17), Color(INK, 0.85), 1.0)
	# Snap button and the hook it hangs from
	c.draw_circle(Vector2(0, -15), 2.5, Color(0.6, 0.62, 0.6))
	c.draw_line(Vector2(0, -23), Vector2(0, -17), Color(0.35, 0.33, 0.3), 2.0)


static func _draw_film_negatives(c: CanvasItem) -> void:
	var film := Color(0.42, 0.26, 0.13, 0.95)
	c.draw_rect(Rect2(-10, -30, 24, 64), Color(0, 0, 0, 0.3))
	c.draw_rect(Rect2(-12, -32, 24, 64), film)
	# Sprocket holes along both edges
	for i in range(8):
		var y := -29.0 + i * 8.0
		c.draw_rect(Rect2(-11, y, 3, 4), Color(0.1, 0.07, 0.05))
		c.draw_rect(Rect2(8, y, 3, 4), Color(0.1, 0.07, 0.05))
	# Three frames: two identical faces in each (inverted colours, like a negative)
	for frame in range(3):
		var top := -28.0 + frame * 20.0
		c.draw_rect(Rect2(-6, top, 12, 16), Color(0.62, 0.48, 0.3))
		c.draw_circle(Vector2(-2.5, top + 6), 2.0, Color(0.92, 0.88, 0.8))
		c.draw_circle(Vector2(2.5, top + 6), 2.0, Color(0.92, 0.88, 0.8))
		c.draw_rect(Rect2(-4.5, top + 9, 9, 5), Color(0.86, 0.8, 0.7))
	# Wooden clothes-peg at the top
	c.draw_rect(Rect2(-3, -38, 6, 10), Color(0.62, 0.5, 0.34))


static func _draw_music_box(c: CanvasItem) -> void:
	var wood := Color(0.45, 0.24, 0.2)
	var wood_light := Color(0.6, 0.35, 0.28)
	var brass := Color(0.78, 0.62, 0.32)
	c.draw_rect(Rect2(-19, -9, 42, 28), Color(0, 0, 0, 0.35))
	c.draw_rect(Rect2(-22, -4, 40, 22), wood)
	# Lid
	c.draw_rect(Rect2(-23, -14, 42, 11), wood_light)
	c.draw_rect(Rect2(-23, -4, 42, 2), Color(0, 0, 0, 0.3))
	# Inlaid flower and brass corners
	c.draw_circle(Vector2(-2, -9), 3.0, Color(0.9, 0.82, 0.62))
	for petal in range(5):
		c.draw_circle(Vector2(-2, -9) + Vector2.from_angle(TAU * petal / 5.0) * 4.0, 1.6, Color(0.86, 0.72, 0.6))
	c.draw_rect(Rect2(-23, -14, 4, 4), brass)
	c.draw_rect(Rect2(15, -14, 4, 4), brass)
	c.draw_rect(Rect2(-4, 4, 6, 6), brass)
	# Winding key on the side
	c.draw_line(Vector2(18, 6), Vector2(23, 6), brass, 2.0)
	c.draw_circle(Vector2(23, 3), 2.5, brass)
	c.draw_circle(Vector2(23, 9), 2.5, brass)


static func _draw_rain_boots(c: CanvasItem) -> void:
	var rubber := Color(0.44, 0.2, 0.18)
	var rubber_light := Color(0.58, 0.28, 0.24)
	var mud := Color(0.27, 0.2, 0.13)
	draw_ellipse(c, Vector2(0, 19), 24, 4, Color(0, 0, 0, 0.4))
	for offset_x: float in [-12.0, 10.0]:
		# Shaft and foot of one boot
		c.draw_rect(Rect2(offset_x - 7, -18, 13, 30), rubber)
		c.draw_rect(Rect2(offset_x - 7, 6, 21, 12), rubber)
		c.draw_rect(Rect2(offset_x - 7, -18, 13, 4), rubber_light)
		c.draw_line(Vector2(offset_x - 5, -12), Vector2(offset_x - 5, 4), Color(1, 1, 1, 0.12), 2.0)
		# Wet mud on the sole and toes
		c.draw_rect(Rect2(offset_x - 7, 14, 21, 4), mud)
		draw_ellipse(c, Vector2(offset_x + 8, 12), 5, 3, mud)
		c.draw_circle(Vector2(offset_x - 2, 9), 1.5, Color(0.55, 0.6, 0.7, 0.6))


static func _draw_pocket_watch(c: CanvasItem) -> void:
	var gold := Color(0.72, 0.58, 0.3)
	var gold_dark := Color(0.48, 0.37, 0.18)
	# Chain
	c.draw_arc(Vector2(-6, -16), 9, PI * 0.9, PI * 1.9, 10, gold_dark, 1.5, true)
	# Case, crown and face
	c.draw_circle(Vector2(1, 6), 15, Color(0, 0, 0, 0.35))
	c.draw_rect(Rect2(-3, -17, 6, 6), gold_dark)
	c.draw_circle(Vector2(0, 4), 15, gold)
	c.draw_circle(Vector2(0, 4), 12, Color(0.93, 0.89, 0.8))
	for hour in range(12):
		var direction := Vector2.from_angle(TAU * hour / 12.0)
		c.draw_line(Vector2(0, 4) + direction * 9.5, Vector2(0, 4) + direction * 11.0, INK, 1.0)
	c.draw_line(Vector2(0, 4), Vector2(0, -3), INK, 1.5)
	c.draw_line(Vector2(0, 4), Vector2(5, 7), INK, 1.5)
	c.draw_arc(Vector2(0, 4), 13.5, PI * 1.1, PI * 1.5, 8, Color(1, 1, 1, 0.45), 1.5, true)


static func _draw_newspaper(c: CanvasItem) -> void:
	var paper := Color(0.78, 0.76, 0.68)
	var clipping := PackedVector2Array([
		Vector2(-27, -21), Vector2(25, -21), Vector2(27, -10), Vector2(24, 0),
		Vector2(27, 10), Vector2(25, 21), Vector2(-27, 21),
	])
	var shadow := PackedVector2Array()
	for point in clipping:
		shadow.append(point + Vector2(3, 3))
	c.draw_colored_polygon(shadow, Color(0, 0, 0, 0.35))
	c.draw_colored_polygon(clipping, paper)
	# Bold headline, a small photo of a lake and two text columns
	c.draw_rect(Rect2(-23, -17, 44, 5), Color(INK, 0.9))
	c.draw_rect(Rect2(-23, -8, 18, 14), Color(0.42, 0.45, 0.48))
	c.draw_line(Vector2(-23, 0), Vector2(-5, 0), Color(0.6, 0.64, 0.68), 2.0)
	for i in range(5):
		var y := -7.0 + i * 5.0
		c.draw_line(Vector2(-1, y), Vector2(20, y), Color(INK, 0.6), 1.0)
	for i in range(2):
		c.draw_line(Vector2(-23, 11.0 + i * 5.0), Vector2(20, 11.0 + i * 5.0), Color(INK, 0.6), 1.0)


# --- Chapter Three objects --------------------------------------------------

static func _draw_small_key(c: CanvasItem) -> void:
	var brass := Color(0.78, 0.63, 0.3)
	var brass_dark := Color(0.52, 0.4, 0.18)
	draw_ellipse(c, Vector2(1, 6), 17, 2.5, Color(0, 0, 0, 0.35))
	# Ornate bow (a clover of three small rings)
	for ring_center: Vector2 in [Vector2(-13, -3), Vector2(-13, 3), Vector2(-17, 0)]:
		c.draw_arc(ring_center, 3.5, 0, TAU, 14, brass_dark, 2.5, true)
	c.draw_circle(Vector2(-12, 0), 2.5, brass)
	# Shaft and tiny bit
	c.draw_rect(Rect2(-10, -1.5, 26, 3), brass)
	c.draw_line(Vector2(-10, -1.5), Vector2(16, -1.5), Color(1, 0.95, 0.75, 0.6), 1.0)
	c.draw_rect(Rect2(11, 1, 3, 5), brass_dark)
	c.draw_rect(Rect2(15, 1, 2, 4), brass_dark)


static func _draw_document(c: CanvasItem) -> void:
	var paper := Color(0.86, 0.8, 0.64)
	c.draw_rect(Rect2(-20, -26, 44, 56), Color(0, 0, 0, 0.35))
	c.draw_rect(Rect2(-23, -29, 44, 56), paper)
	# Folded thirds
	c.draw_line(Vector2(-23, -10), Vector2(21, -10), Color(0.62, 0.55, 0.42), 1.2)
	c.draw_line(Vector2(-23, 9), Vector2(21, 9), Color(0.62, 0.55, 0.42), 1.2)
	# Gothic heading ("Last Will and Testament") and text lines
	c.draw_rect(Rect2(-15, -24, 28, 4), Color(INK, 0.9))
	for i in range(6):
		var y := -15.0 + i * 5.0
		if y > -11.0 and y < -8.0:
			continue
		c.draw_line(Vector2(-18, y), Vector2(15.0 - (i % 3) * 4.0, y), Color(INK, 0.6), 1.0)
	# Signature and a black ribbon with a wax seal
	c.draw_polyline(PackedVector2Array([Vector2(-16, 19), Vector2(-11, 15), Vector2(-7, 20), Vector2(-2, 15)]), Color(INK, 0.85), 1.2)
	c.draw_line(Vector2(8, 13), Vector2(4, 30), Color(0.1, 0.1, 0.12), 2.5)
	c.draw_line(Vector2(12, 13), Vector2(16, 30), Color(0.1, 0.1, 0.12), 2.5)
	c.draw_circle(Vector2(10, 15), 5, Color(0.5, 0.12, 0.1))
	c.draw_circle(Vector2(9, 14), 1.6, Color(0.72, 0.28, 0.22))


static func _draw_ledger(c: CanvasItem) -> void:
	var cloth := Color(0.22, 0.3, 0.24)
	var cloth_dark := Color(0.14, 0.2, 0.16)
	draw_ellipse(c, Vector2(2, 18), 28, 4, Color(0, 0, 0, 0.35))
	# A book lying flat: page block, then the cover
	c.draw_rect(Rect2(-26, -15, 54, 32), Color(0.85, 0.8, 0.66))
	c.draw_rect(Rect2(-28, -19, 54, 32), cloth)
	c.draw_rect(Rect2(-28, -19, 9, 32), cloth_dark)
	# Corner protectors and a paper label reading "ACCOUNTS"
	c.draw_colored_polygon(PackedVector2Array([Vector2(26, -19), Vector2(26, -11), Vector2(18, -19)]), Color(0.45, 0.32, 0.2))
	c.draw_colored_polygon(PackedVector2Array([Vector2(26, 13), Vector2(26, 5), Vector2(18, 13)]), Color(0.45, 0.32, 0.2))
	c.draw_rect(Rect2(-10, -10, 26, 12), Color(0.83, 0.77, 0.6))
	c.draw_line(Vector2(-6, -4), Vector2(12, -4), Color(INK, 0.85), 1.2)
	# A loose receipt sticking out
	c.draw_rect(Rect2(14, -24, 9, 8), Color(0.9, 0.88, 0.82))


static func _draw_child_drawing(c: CanvasItem) -> void:
	var paper := Color(0.92, 0.9, 0.84)
	c.draw_rect(Rect2(-23, -18, 50, 40), Color(0, 0, 0, 0.3))
	c.draw_rect(Rect2(-26, -21, 50, 40), paper)
	# Pin at the top
	c.draw_circle(Vector2(-1, -18), 2.5, Color(0.7, 0.15, 0.12))
	# Crayon lake, sun and three stick figures (two small, one tall)
	draw_ellipse(c, Vector2(-1, 11), 20, 5, Color(0.3, 0.45, 0.75, 0.8))
	c.draw_circle(Vector2(16, -12), 4, Color(0.95, 0.75, 0.2))
	for figure_x: float in [-16.0, -8.0]:
		c.draw_circle(Vector2(figure_x, -6), 2.5, Color(0.85, 0.3, 0.4))
		c.draw_line(Vector2(figure_x, -4), Vector2(figure_x, 3), Color(0.85, 0.3, 0.4), 1.5)
	# The tall figure is coloured over in black
	c.draw_circle(Vector2(8, -9), 3, Color(0.1, 0.1, 0.1))
	c.draw_line(Vector2(8, -6), Vector2(8, 5), Color(0.1, 0.1, 0.1), 3.0)
	c.draw_line(Vector2(4, -2), Vector2(12, -2), Color(0.1, 0.1, 0.1), 2.0)


static func _draw_spectacles(c: CanvasItem) -> void:
	var wire := Color(0.62, 0.6, 0.55)
	draw_ellipse(c, Vector2(1, 6), 19, 2.5, Color(0, 0, 0, 0.3))
	for lens_x: float in [-10.0, 10.0]:
		draw_ellipse(c, Vector2(lens_x, 0), 8, 6, Color(0.75, 0.82, 0.88, 0.25))
		c.draw_arc(Vector2(lens_x, 0), 7.5, 0, TAU, 20, wire, 1.6, true)
	c.draw_arc(Vector2(0, 1), 3, PI * 1.1, PI * 1.9, 6, wire, 1.6, true)
	c.draw_line(Vector2(-17, -1), Vector2(-21, -5), wire, 1.4)
	c.draw_line(Vector2(17, -1), Vector2(21, -5), wire, 1.4)
	# One cracked lens
	c.draw_line(Vector2(6, -3), Vector2(13, 3), Color(1, 1, 1, 0.7), 1.0)
	c.draw_line(Vector2(10, 0), Vector2(14, -2), Color(1, 1, 1, 0.6), 1.0)


static func _draw_locket(c: CanvasItem) -> void:
	var silver := Color(0.78, 0.8, 0.84)
	var silver_dark := Color(0.5, 0.52, 0.56)
	# Chain looping up
	c.draw_arc(Vector2(0, -12), 9, PI, TAU, 12, silver_dark, 1.3, true)
	c.draw_line(Vector2(0, -12), Vector2(0, -5), silver_dark, 1.3)
	# Oval locket, opened a little to show two tiny portraits
	draw_ellipse(c, Vector2(1, 9), 11, 13, Color(0, 0, 0, 0.35))
	draw_ellipse(c, Vector2(0, 7), 11, 13, silver)
	draw_ellipse(c, Vector2(0, 7), 8, 10, silver_dark)
	draw_ellipse(c, Vector2(-3, 7), 3.5, 6, Color(0.8, 0.72, 0.58))
	draw_ellipse(c, Vector2(3, 7), 3.5, 6, Color(0.8, 0.72, 0.58))
	c.draw_line(Vector2(0, -3), Vector2(0, 17), silver_dark, 1.0)
	c.draw_arc(Vector2(0, 7), 10, PI * 1.1, PI * 1.45, 6, Color(1, 1, 1, 0.6), 1.5, true)


static func _draw_telegram(c: CanvasItem) -> void:
	var paper := Color(0.9, 0.84, 0.6)
	c.draw_rect(Rect2(-24, -14, 54, 34), Color(0, 0, 0, 0.35))
	c.draw_rect(Rect2(-27, -17, 54, 34), paper)
	c.draw_rect(Rect2(-27, -17, 54, 7), Color(0.55, 0.3, 0.18))
	c.draw_line(Vector2(-22, -14), Vector2(8, -14), Color(0.95, 0.85, 0.6), 1.5)
	# Typed strips of text pasted on
	for i in range(3):
		var y := -5.0 + i * 7.0
		c.draw_rect(Rect2(-23, y - 2, 42.0 - i * 9.0, 5), Color(0.97, 0.95, 0.88))
		c.draw_line(Vector2(-21, y), Vector2(17.0 - i * 9.0, y), Color(INK, 0.8), 1.0)
	c.draw_line(Vector2(-27, 3), Vector2(27, 4), Color(0.7, 0.62, 0.4), 1.0)


## A question mark in a circle (used for unknown styles and hidden riddle icons).
static func draw_generic(c: CanvasItem) -> void:
	c.draw_circle(Vector2.ZERO, 18, BEIGE_DARK)
	c.draw_arc(Vector2.ZERO, 18, 0, TAU, 32, WOOD_DARK, 2, true)
	c.draw_string(ThemeDB.fallback_font, Vector2(-6, 8), "?", HORIZONTAL_ALIGNMENT_LEFT, -1, 24, WOOD_DARK)
