class_name HintHighlight
extends Node2D
## A soft, pulsing circle that marks the GENERAL area of a hidden object.
## It is offset a little at random, so it helps without giving away the exact spot.
## It is only drawn - it can never be clicked and never blocks clicks.

@export var radius: float = 85.0:
	set(value):
		radius = value
		queue_redraw()
## How far (in pixels) the circle centre may be from the real object.
@export var max_offset: float = 25.0

var _tween: Tween


func _ready() -> void:
	hide()


func show_area(target_position: Vector2) -> void:
	var offset := Vector2(randf_range(-max_offset, max_offset), randf_range(-max_offset, max_offset))
	global_position = target_position + offset
	show()
	if _tween != null:
		_tween.kill()
	modulate.a = 0.0
	# Pulse three times, then fade away (no animation keeps running afterwards).
	_tween = create_tween()
	for i in range(3):
		_tween.tween_property(self, "modulate:a", 1.0, 0.5)
		_tween.tween_property(self, "modulate:a", 0.35, 0.5)
	_tween.tween_property(self, "modulate:a", 0.0, 0.8)
	_tween.tween_callback(hide)


func hide_area() -> void:
	if _tween != null:
		_tween.kill()
	hide()


func _draw() -> void:
	var glow := PlaceholderArt.WARM
	draw_circle(Vector2.ZERO, radius, Color(glow, 0.1))
	draw_arc(Vector2.ZERO, radius, 0.0, TAU, 64, Color(glow, 0.9), 3.0, true)
	draw_arc(Vector2.ZERO, radius + 9.0, 0.0, TAU, 64, Color(glow, 0.35), 2.0, true)
