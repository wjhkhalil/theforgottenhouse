class_name TideWater
extends Node2D
## House Two, Chapter Two (The Boat Shed): the lake surges in through the broken
## boat doors, fills the boat slip, then drains out again, over and over.
## While the water is high it covers the objects lying in the slip: they are
## hard to see and cannot be clicked until the water drains.
##
## HOW IT WORKS: every frame the water level is worked out from a repeating
## cycle (high - draining - low - rising). Every hidden object and container
## inside the slip is told whether it is above or below the surface
## (set_reachable). Clicking the water near a covered object emits
## `reach_blocked`, so the room can tell the player to wait.
##
## Place this node AFTER HiddenObjects in the scene, so the water is drawn on top of them.

## Emitted when the player clicks the water over an object they can't reach yet.
signal reach_blocked

## The slip: the area the water fills (left, top of the highest water, width, down to the bottom).
@export var slip_rect: Rect2 = Rect2(330, 470, 520, 250)
## Water surface at low water (the slip is almost empty).
@export var low_level: float = 700.0
@export var high_seconds: float = 4.0
@export var drain_seconds: float = 5.0
@export var low_seconds: float = 6.0
@export var rise_seconds: float = 5.0
@export var water_color: Color = Color(0.07, 0.15, 0.15, 0.86)

## Seconds into the current cycle (exposed for the automated test).
var cycle_time: float = 2.0

var _active: bool = false
var _holding: bool = false
var _level: float = 0.0
var _wave_time: float = 0.0
var _blocker: Area2D
var _blocker_shape: RectangleShape2D


func _ready() -> void:
	add_to_group("room_effects")
	_level = slip_rect.position.y
	# An invisible click area over the water: it catches clicks on covered objects.
	_blocker = Area2D.new()
	_blocker.input_pickable = true
	_blocker_shape = RectangleShape2D.new()
	var collision := CollisionShape2D.new()
	collision.shape = _blocker_shape
	_blocker.add_child(collision)
	add_child(_blocker)
	_blocker.input_event.connect(_on_water_clicked)
	_update_level()


## Called by the room when the player can start searching.
func start_effect() -> void:
	_active = true


## Called when the room is complete: the water drains away for good.
func fade_out() -> void:
	_active = false
	var tween := create_tween()
	tween.tween_method(_set_level, _level, slip_rect.end.y + 10.0, 2.0)


## Height of the water surface (smaller y = higher water).
func get_level() -> float:
	return _level


func is_underwater(world_position: Vector2) -> bool:
	return slip_rect.has_point(world_position) and world_position.y > _level


## Jumps straight to low water. With `hold`, the water stays low (used by the test).
func set_tide_low(hold: bool = false) -> void:
	cycle_time = high_seconds + drain_seconds + 0.01
	_holding = hold
	_update_level()


## Jumps straight to high water (used by the test).
func set_tide_high() -> void:
	cycle_time = 0.01
	_holding = false
	_update_level()


func _process(delta: float) -> void:
	_wave_time += delta
	if _active and not _holding:
		cycle_time = fmod(cycle_time + delta, high_seconds + drain_seconds + low_seconds + rise_seconds)
		_update_level()
	queue_redraw()


func _update_level() -> void:
	var high := slip_rect.position.y
	var t := cycle_time
	var level := high
	if t < high_seconds:
		level = high
	elif t < high_seconds + drain_seconds:
		level = lerpf(high, low_level, _smooth((t - high_seconds) / drain_seconds))
	elif t < high_seconds + drain_seconds + low_seconds:
		level = low_level
	else:
		level = lerpf(low_level, high, _smooth((t - high_seconds - drain_seconds - low_seconds) / rise_seconds))
	_set_level(level)


func _set_level(level: float) -> void:
	_level = level
	var covered := Rect2(slip_rect.position.x, _level, slip_rect.size.x, maxf(slip_rect.end.y - _level, 0.0))
	_blocker_shape.size = covered.size
	_blocker.position = covered.get_center()
	_blocker.input_pickable = covered.size.y > 1.0
	for node in get_tree().get_nodes_in_group("hidden_objects") + _containers():
		var area := node as Area2D
		if area != null and slip_rect.has_point(area.global_position) and area.has_method("set_reachable"):
			area.call("set_reachable", area.global_position.y < _level)


func _containers() -> Array[Node]:
	var found: Array[Node] = []
	for node in get_parent().find_children("*", "OpenableContainer", true, false):
		found.append(node)
	return found


static func _smooth(x: float) -> float:
	return x * x * (3.0 - 2.0 * x)


func _on_water_clicked(_viewport: Node, event: InputEvent, _shape_index: int) -> void:
	var click := event as InputEventMouseButton
	if click == null or not click.pressed or click.button_index != MOUSE_BUTTON_LEFT:
		return
	# The click's own position (not the mouse pointer's), turned into a room position.
	var world := get_viewport().get_canvas_transform().affine_inverse() * click.position
	for node in get_tree().get_nodes_in_group("hidden_objects") + _containers():
		var area := node as Area2D
		if area == null or not area.visible or not is_underwater(area.global_position):
			continue
		if area is HiddenObject and (area as HiddenObject).is_collected:
			continue
		if area is OpenableContainer and (area as OpenableContainer).is_open:
			continue
		if area.global_position.distance_to(world) < 60.0:
			reach_blocked.emit()
			return


func _draw() -> void:
	if _level >= slip_rect.end.y:
		return
	var top := _level
	var rect := Rect2(slip_rect.position.x, top, slip_rect.size.x, slip_rect.end.y - top)
	draw_rect(rect, water_color)
	# Darker towards the bottom
	var deep := Color(0, 0.02, 0.03, 0.35)
	draw_polygon(PackedVector2Array([rect.position, Vector2(rect.end.x, rect.position.y), rect.end, Vector2(rect.position.x, rect.end.y)]),
		PackedColorArray([Color(deep, 0.0), Color(deep, 0.0), deep, deep]))
	# A wavy, moonlit surface line with a little foam
	var points := PackedVector2Array()
	var x := rect.position.x
	while x <= rect.end.x:
		points.append(Vector2(x, top + sin(x * 0.045 + _wave_time * 2.2) * 2.5))
		x += 8.0
	draw_polyline(points, Color(0.7, 0.82, 0.9, 0.55), 2.0, true)
	for i in range(6):
		var foam_x := rect.position.x + fmod(i * 97.0 + _wave_time * 18.0, rect.size.x)
		draw_line(Vector2(foam_x, top + 4), Vector2(foam_x + 22, top + 4), Color(0.85, 0.9, 0.95, 0.25), 1.5)
