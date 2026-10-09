@tool
class_name RoomArt
extends Node2D
## Base class for the procedural room drawings (no image files needed).
##
## Each room has its own script that extends this one (bedroom_art.gd,
## basement_art.gd) and fills in _draw_background() and _draw_foreground().
## A room uses two nodes with its art script:
##   BACKGROUND - walls, floor and furniture. Drawn BEHIND the hidden objects.
##   FOREGROUND - things that partly cover hidden objects, plus a vignette.
##
## TO USE A REAL PAINTED BACKGROUND: assign `replacement_texture` in the
## Inspector. The procedural drawing is then skipped and your image is
## stretched to `room_size`. For the foreground use a PNG with transparency.

enum Layer { BACKGROUND, FOREGROUND }

@export var layer: Layer = Layer.BACKGROUND:
	set(value):
		layer = value
		queue_redraw()

## Optional real artwork. When set, it replaces the procedural drawing.
@export var replacement_texture: Texture2D:
	set(value):
		replacement_texture = value
		queue_redraw()

## Size of the area the room fills (the game's design resolution).
@export var room_size: Vector2 = Vector2(1280, 720)


func _draw() -> void:
	if replacement_texture != null:
		draw_texture_rect(replacement_texture, Rect2(Vector2.ZERO, room_size), false)
		return
	if layer == Layer.BACKGROUND:
		_draw_background()
	else:
		_draw_foreground()


## Overridden by each room script.
func _draw_background() -> void:
	pass


## Overridden by each room script.
func _draw_foreground() -> void:
	pass


# ---------------------------------------------------------------------------
# Small drawing helpers
# ---------------------------------------------------------------------------

func _vertical_gradient(rect: Rect2, top: Color, bottom: Color) -> void:
	var points := PackedVector2Array([
		rect.position, Vector2(rect.end.x, rect.position.y), rect.end, Vector2(rect.position.x, rect.end.y),
	])
	draw_polygon(points, PackedColorArray([top, top, bottom, bottom]))


func _horizontal_gradient(rect: Rect2, left: Color, right: Color) -> void:
	var points := PackedVector2Array([
		rect.position, Vector2(rect.end.x, rect.position.y), rect.end, Vector2(rect.position.x, rect.end.y),
	])
	draw_polygon(points, PackedColorArray([left, right, right, left]))


func _polygon(points: Array[Vector2], color: Color) -> void:
	draw_colored_polygon(PackedVector2Array(points), color)


func _ellipse(center: Vector2, radius: Vector2, color: Color) -> void:
	PlaceholderArt.draw_ellipse(self, center, radius.x, radius.y, color)


func _rounded_rect(rect: Rect2, color: Color, corner_radius: int) -> void:
	var box := StyleBoxFlat.new()
	box.bg_color = color
	box.set_corner_radius_all(corner_radius)
	draw_style_box(box, rect)


func _glow(center: Vector2, start_radius: float, rings: int, step: float, color: Color) -> void:
	for i in range(rings):
		draw_circle(center, start_radius + i * step, color)


func _draw_vignette() -> void:
	# Darken the edges of the screen for a moody atmosphere (centre stays bright).
	var dark := Color(0, 0, 0, 0.5)
	var clear := Color(0, 0, 0, 0)
	_vertical_gradient(Rect2(0, 0, room_size.x, 90), dark, clear)
	_vertical_gradient(Rect2(0, room_size.y - 90, room_size.x, 90), clear, dark)
	_horizontal_gradient(Rect2(0, 0, 110, room_size.y), dark, clear)
	_horizontal_gradient(Rect2(room_size.x - 110, 0, 110, room_size.y), clear, dark)
