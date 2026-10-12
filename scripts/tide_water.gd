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
## The inside of the slip as it is painted (room coordinates). The water is only
## drawn inside this shape, so it never covers the quay posts. Empty = all of `slip_rect`.
@export var slip_outline: PackedVector2Array = PackedVector2Array()
## The wall at the far end of the slip. The waterline runs level across it and
## slopes down along the side walls towards the player. No size = a level waterline.
@export var back_wall: Rect2 = Rect2()
## How steeply the waterline slopes along the side walls: at the top of the back wall, and at its foot.
@export var side_slopes: Vector2 = Vector2(0.16, 0.81)
## Where the lantern's reflection lies on the water (room x). 0 = no reflection.
@export var lantern_x: float = 0.0

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
	return slip_rect.has_point(world_position) and world_position.y > surface_y_at(world_position.x)


## Height of the waterline at room position `x`: level across the back wall,
## lower (nearer the player) along the side walls.
func surface_y_at(x: float) -> float:
	if not back_wall.has_area():
		return _level
	var left := back_wall.position.x
	var right := back_wall.end.x
	var slope := lerpf(side_slopes.x, side_slopes.y, clampf((_level - back_wall.position.y) / back_wall.size.y, 0.0, 1.0))
	if _level > back_wall.end.y:
		# Below the foot of the back wall: the water's edge lies on the floor of the slip.
		var spread := (_level - back_wall.end.y) / side_slopes.y
		left -= spread
		right += spread
	if x < left:
		return _level + (left - x) * slope
	if x > right:
		return _level + (x - right) * slope
	return _level


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
			area.call("set_reachable", area.global_position.y < surface_y_at(area.global_position.x))


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
	var outline := slip_outline
	if outline.size() < 3:
		outline = PackedVector2Array([slip_rect.position, Vector2(slip_rect.end.x, slip_rect.position.y), slip_rect.end,
			Vector2(slip_rect.position.x, slip_rect.end.y)])
	# The waterline, with a slow swell, and everything below it.
	var surface := PackedVector2Array()
	var x := slip_rect.position.x - 40.0
	while x <= slip_rect.end.x + 40.0:
		surface.append(Vector2(x, surface_y_at(x) + sin(x * 0.045 + _wave_time * 2.2) * 2.5))
		x += 8.0
	# Thin and clear at the waterline, dark and murky further down: bands that follow the waterline.
	var shallow := water_color.lightened(0.1)
	shallow.a = water_color.a * 0.8
	var deep := water_color.darkened(0.5)
	deep.a = minf(water_color.a + 0.08, 1.0)
	var offsets: Array[float] = [0.0, 8.0, 18.0, 32.0, 52.0, 80.0, 400.0]
	for band in range(offsets.size() - 1):
		var strip := PackedVector2Array()
		for point in surface:
			strip.append(point + Vector2(0, offsets[band]))
		for i in range(surface.size() - 1, -1, -1):
			strip.append(surface[i] + Vector2(0, offsets[band + 1]))
		for water in Geometry2D.intersect_polygons(strip, outline):
			# A sliver too thin to fill (where a band just touches the outline) is skipped.
			if Geometry2D.triangulate_polygon(water).is_empty():
				continue
			draw_colored_polygon(water, shallow.lerp(deep, band / float(offsets.size() - 2)))
	# Ripples catching the light just under the waterline, fainter further down.
	for row in range(1, 6):
		var ripple := PackedVector2Array()
		for point in surface:
			ripple.append(point + Vector2(0, row * row * 2.6 + sin(point.x * 0.07 + _wave_time * (1.4 + row * 0.3) + row) * 1.5))
		for part in Geometry2D.intersect_polyline_with_polygon(ripple, outline):
			draw_polyline(part, Color(0.6, 0.76, 0.84, 0.34 / row), 1.5, true)
	# The lantern's reflection: broken amber dashes that shiver on the water.
	if lantern_x > 0.0:
		var top := surface_y_at(lantern_x)
		for i in range(7):
			var y := top + 6.0 + i * 9.0
			if y > slip_rect.end.y:
				break
			var half := 24.0 - i * 2.2 + sin(_wave_time * 3.0 + i * 1.7) * 5.0
			var middle := lantern_x + sin(_wave_time * 1.8 + i * 0.9) * 3.0
			draw_line(Vector2(middle - half, y), Vector2(middle + half, y), Color(1.0, 0.72, 0.36, 0.5 - i * 0.06), 2.5, true)
	# A wavy, moonlit surface line with a little foam
	for part in Geometry2D.intersect_polyline_with_polygon(surface, outline):
		draw_polyline(part, Color(0.7, 0.82, 0.9, 0.55), 2.0, true)
	for i in range(6):
		var foam_x := slip_rect.position.x + fmod(i * 97.0 + _wave_time * 18.0, slip_rect.size.x)
		var foam := PackedVector2Array([Vector2(foam_x, surface_y_at(foam_x) + 4.0), Vector2(foam_x + 22.0, surface_y_at(foam_x + 22.0) + 4.0)])
		for part in Geometry2D.intersect_polyline_with_polygon(foam, outline):
			draw_polyline(part, Color(0.85, 0.9, 0.95, 0.25), 1.5)
