@tool
class_name ObjectIcon
extends Control
## Small picture of an object for the objective list.
## Shows (in this order of preference): data.icon_texture, data.texture,
## or the procedural placeholder drawing. Draws a checkmark when collected.

@export var object_data: HiddenObjectData:
	set(value):
		object_data = value
		queue_redraw()

@export var is_collected: bool = false:
	set(value):
		is_collected = value
		queue_redraw()

## Riddle rooms: show a question mark instead of the picture until it is found.
@export var hide_picture: bool = false:
	set(value):
		hide_picture = value
		queue_redraw()


func _draw() -> void:
	var box := Rect2(Vector2.ZERO, size)
	draw_rect(box, Color(0.85, 0.79, 0.65, 0.12))
	draw_rect(box, Color(0.45, 0.36, 0.26), false, 1.0)
	if object_data == null:
		return

	var image: Texture2D = object_data.icon_texture
	if image == null:
		image = object_data.texture

	if hide_picture and not is_collected:
		var mark_scale := minf(size.x, size.y) / 44.0
		draw_set_transform(size / 2.0, 0.0, Vector2(mark_scale, mark_scale))
		PlaceholderArt.draw_generic(self)
		draw_set_transform(Vector2.ZERO, 0.0, Vector2.ONE)
	elif image != null:
		draw_texture_rect(image, _fit_rect(image.get_size()), false)
	else:
		# Scale the placeholder drawing so it fits inside the icon box.
		var art_size := PlaceholderArt.get_style_size(object_data.placeholder_style)
		var fit_scale := minf(size.x / art_size.x, size.y / art_size.y) * 0.85
		draw_set_transform(size / 2.0, 0.0, Vector2(fit_scale, fit_scale))
		PlaceholderArt.draw_object(self, object_data.placeholder_style)
		draw_set_transform(Vector2.ZERO, 0.0, Vector2.ONE)

	if is_collected:
		# Dim the picture and draw a big checkmark (so we don't rely on colour alone).
		draw_rect(box, Color(0, 0, 0, 0.45))
		var check := PackedVector2Array([
			Vector2(size.x * 0.2, size.y * 0.55),
			Vector2(size.x * 0.42, size.y * 0.78),
			Vector2(size.x * 0.82, size.y * 0.25),
		])
		draw_polyline(check, Color(0, 0, 0, 0.8), 7.0, true)
		draw_polyline(check, Color(0.55, 0.85, 0.5), 4.0, true)


## Returns a rectangle that keeps the texture's aspect ratio inside the icon.
func _fit_rect(texture_size: Vector2) -> Rect2:
	var fit_scale := minf(size.x / texture_size.x, size.y / texture_size.y) * 0.9
	var fitted_size := texture_size * fit_scale
	return Rect2((size - fitted_size) / 2.0, fitted_size)
