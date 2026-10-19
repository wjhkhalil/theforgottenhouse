@tool
class_name StarRating
extends Control
## Draws up to three stars: filled amber for earned stars, a dark outline for
## the rest. Used large on the completion screen (where the stars pop in one
## by one) and small in the Chapters list.

const FILLED := Color(0.98, 0.8, 0.36)
const FILLED_EDGE := Color(0.62, 0.42, 0.14)
const EMPTY := Color(0.2, 0.19, 0.2, 0.9)
const EMPTY_EDGE := Color(0.45, 0.4, 0.34)
const GLOW := Color(1.0, 0.86, 0.5, 0.11)

## How many stars are drawn in total (three for a rating, one for a rule row).
@export_range(1, 3) var count: int = 3:
	set(value):
		count = clampi(value, 1, RoomResult.MAX_STARS)
		update_minimum_size()
		queue_redraw()
## How many stars are filled.
@export_range(0, 3) var stars: int = 0:
	set(value):
		stars = clampi(value, 0, RoomResult.MAX_STARS)
		queue_redraw()
## Width and height of one star.
@export var star_size: float = 24.0:
	set(value):
		star_size = value
		update_minimum_size()
		queue_redraw()
## Space between stars.
@export var spacing: float = 6.0:
	set(value):
		spacing = value
		update_minimum_size()
		queue_redraw()

## Scale of each star while it pops in (1.0 = normal). Index -> scale.
var _pop_scales: Array[float] = [1.0, 1.0, 1.0]
var _pop_tween: Tween


func _get_minimum_size() -> Vector2:
	return Vector2(star_size * count + spacing * (count - 1), star_size)


## Shows `earned` stars one after another, each with a little bounce and a sound.
func pop_in(earned: int, delay_between: float = 0.45) -> void:
	stars = 0
	_pop_scales = [0.0, 0.0, 0.0]
	if _pop_tween != null:
		_pop_tween.kill()
	_pop_tween = create_tween()
	for i in range(count):
		_pop_tween.tween_callback(_start_star.bind(i, i < earned))
		_pop_tween.tween_method(_set_pop_scale.bind(i), 0.0, 1.35, 0.22).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
		_pop_tween.tween_method(_set_pop_scale.bind(i), 1.35, 1.0, 0.16)
		if i < count - 1:
			_pop_tween.tween_interval(delay_between)


func _start_star(index: int, earned: bool) -> void:
	if earned:
		stars = index + 1
		if not Engine.is_editor_hint():
			AudioManager.play_sfx("star")
			Haptics.tap()


func _set_pop_scale(value: float, index: int) -> void:
	_pop_scales[index] = value
	queue_redraw()


func _draw() -> void:
	var total_width := _get_minimum_size().x
	var start_x := (size.x - total_width) / 2.0
	for i in range(count):
		var center := Vector2(start_x + star_size / 2.0 + i * (star_size + spacing), size.y / 2.0)
		var radius := star_size / 2.0 * _pop_scales[i]
		if radius <= 0.0:
			continue
		var filled := i < stars
		if filled and radius >= 20.0:
			# A soft halo: a few faint rings fading outwards (big stars only).
			for ring in range(4):
				draw_circle(center, radius * (1.05 + ring * 0.12), GLOW)
		var points := _star_points(center, radius, radius * 0.47)
		draw_colored_polygon(points, FILLED if filled else EMPTY)
		var outline := points.duplicate()
		outline.append(points[0])
		draw_polyline(outline, FILLED_EDGE if filled else EMPTY_EDGE, maxf(1.5, radius * 0.08), true)


static func _star_points(center: Vector2, outer: float, inner: float) -> PackedVector2Array:
	var points := PackedVector2Array()
	for i in range(10):
		var angle := -PI / 2.0 + i * PI / 5.0
		var radius := outer if i % 2 == 0 else inner
		points.append(center + Vector2(cos(angle), sin(angle)) * radius)
	return points
