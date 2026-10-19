class_name MissCatcher
extends Area2D
## Counts taps that hit nothing. The room puts this huge invisible area BEHIND
## everything else; physics picking gives a click to the top-most area only, so
## this one receives exactly the clicks that no object, container or button
## wanted. A quick tap counts; a drag (looking around on a phone) does not.
##
## While `enabled` is false (keypad open, room complete) nothing is counted.

## Emitted for every wrong tap, with the screen position of the tap.
signal missed(screen_position: Vector2)

## A tap that moves further than this (in screen pixels) is a drag, not a tap.
@export var tap_tolerance: float = 14.0
var enabled: bool = true

var _press_position: Vector2 = Vector2.INF


func _ready() -> void:
	name = "MissCatcher"
	input_pickable = true
	var shape := RectangleShape2D.new()
	shape.size = Vector2(8000, 8000)
	var collision := CollisionShape2D.new()
	collision.shape = shape
	add_child(collision)
	input_event.connect(_on_input_event)


func _on_input_event(_viewport: Node, event: InputEvent, _shape_index: int) -> void:
	var click := event as InputEventMouseButton
	if click == null or click.button_index != MOUSE_BUTTON_LEFT or get_tree().paused:
		return
	if click.pressed:
		_press_position = click.position if enabled else Vector2.INF
	elif _press_position != Vector2.INF:
		if enabled and click.position.distance_to(_press_position) <= tap_tolerance:
			missed.emit(click.position)
		_press_position = Vector2.INF
