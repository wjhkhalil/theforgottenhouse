class_name LanternDarkness
extends Node2D
## Makes the room dark except for a circle of lantern light around the mouse.
##
## HOW IT WORKS: it draws dark shapes everywhere EXCEPT a circle at the mouse
## position (a ring of soft-edged pieces plus solid pieces further out).
## It only redraws when the mouse moves, so it is cheap.
## It is just a drawing: it never blocks clicks on hidden objects.

## How dark the unlit room is (0 = no darkness, 1 = black).
@export_range(0.0, 1.0) var darkness: float = 0.84
## Radius of the fully lit centre of the lantern light.
@export var light_radius: float = 105.0
## Width of the soft edge between light and darkness.
@export var soft_edge: float = 85.0
## How much the lantern flame flickers, in pixels (0 = steady light).
## A flickering light makes it harder to look at one spot for long.
@export var flicker_strength: float = 0.0
## Warm tint inside the light.
@export var light_tint: Color = Color(1.0, 0.82, 0.55, 0.06)

const SEGMENTS := 48
const FAR_DISTANCE := 3000.0

var _light_position: Vector2 = Vector2(500, 400)
var _flicker: float = 0.0
var _time: float = 0.0


func _ready() -> void:
	add_to_group("room_effects")


func _process(delta: float) -> void:
	var mouse := get_local_mouse_position()
	if mouse != _light_position:
		_light_position = mouse
		queue_redraw()
	if flicker_strength > 0.0:
		# Two sine waves at odd speeds give an uneven, flame-like flicker.
		_time += delta
		_flicker = (sin(_time * 7.3) * 0.6 + sin(_time * 17.9) * 0.4) * flicker_strength
		queue_redraw()


## Called when the room is complete: the darkness fades away.
func fade_out() -> void:
	set_process(false)
	create_tween().tween_property(self, "modulate:a", 0.0, 1.5)


func _draw() -> void:
	var dark := Color(0, 0, 0, darkness)
	var clear := Color(0, 0, 0, 0)
	var center := _light_position
	var inner := maxf(light_radius + _flicker, 10.0)
	var outer := inner + soft_edge

	draw_circle(center, inner, light_tint)
	for i in range(SEGMENTS):
		var direction_a := Vector2.from_angle(TAU * i / SEGMENTS)
		var direction_b := Vector2.from_angle(TAU * (i + 1) / SEGMENTS)
		# Soft edge: transparent on the inside, dark on the outside.
		var soft_points := PackedVector2Array([
			center + direction_a * inner, center + direction_b * inner,
			center + direction_b * outer, center + direction_a * outer,
		])
		draw_polygon(soft_points, PackedColorArray([clear, clear, dark, dark]))
		# Solid darkness from the soft edge to far outside the screen.
		var dark_points := PackedVector2Array([
			center + direction_a * outer, center + direction_b * outer,
			center + direction_b * FAR_DISTANCE, center + direction_a * FAR_DISTANCE,
		])
		draw_colored_polygon(dark_points, dark)
