class_name CandleLights
extends Node2D
## House Two, Chapter Nine (The Island Chapel): the chapel is dark, lit only by
## a handful of candles. Every lit candle makes a circle of light. Things
## outside every circle are hidden in the dark and cannot be picked up.
## Every 8 to 12 seconds a draught from the door blows a candle out. Clicking
## a candle that has gone out lights it again.
##
## HOW IT WORKS:
##   * The darkness is one big rectangle with a small shader: it is dark
##     everywhere except in soft holes around the lit candles.
##   * Every frame, each hidden object and container is told whether it is
##     inside a lit candle's circle (set_reachable).
##   * Each candle has a small click area of its own, but only while it is out,
##     so a burning candle never steals a click meant for an object next to it.
##   * An invisible "dark catcher" sits BEHIND the hidden objects (like the
##     bats' miss catcher). Objects in the dark can't be clicked, so a click on
##     them falls through to the catcher, and the player is told to light a candle.
##
## Place this node AFTER RoomForeground in the scene, so the darkness covers the whole room.

## Emitted to show a message in the room's notification popup.
signal notice(title: String, message: String, wrong_sound: bool)

enum Kind { ALTAR, SCONCE, PULPIT, STAND }

## Where each candle's wick is (room position). Its flame burns just above it.
@export var positions: PackedVector2Array = PackedVector2Array([
	Vector2(715, 300), Vector2(172, 222), Vector2(470, 180), Vector2(800, 186), Vector2(300, 505), Vector2(930, 515),
])
## How far each candle's light reaches (pixels). Things inside this circle can be clicked.
@export var radii: PackedFloat32Array = PackedFloat32Array([195.0, 185.0, 175.0, 180.0, 205.0, 205.0])
## What each candle stands in (see Kind): altar candlestick, wall sconce, pulpit holder or floor stand.
@export var kinds: PackedInt32Array = PackedInt32Array([0, 2, 1, 1, 3, 3])
## How dark the unlit chapel is (0 = no darkness, 1 = black).
@export_range(0.0, 1.0) var darkness: float = 0.85
## The draught blows a candle out after a random wait between these two (seconds).
@export var draught_min_seconds: float = 8.0
@export var draught_max_seconds: float = 12.0
## The moonlit stained-glass window glows faintly through the dark (centre, radius).
@export var moon_glow: Vector3 = Vector3(640, 185, 135)
## How many draughts show the full explanation before the message gets shorter.
@export var full_messages: int = 3

const CLICK_SIZE := Vector2(34, 56)
const MAX_CANDLES := 8
const DARK_MESSAGE_SECONDS := 2.5
## A tap that moves further than this (in screen pixels) is a drag, not a click.
const TAP_TOLERANCE := 14.0

const DARKNESS_SHADER := "shader_type canvas_item;
uniform vec4 lights[8];
uniform int light_count = 0;
uniform float darkness = 0.85;
uniform vec4 moon = vec4(640.0, 185.0, 135.0, 0.45);
varying vec2 world;
void vertex() {
	world = (MODEL_MATRIX * vec4(VERTEX, 0.0, 1.0)).xy;
}
void fragment() {
	float keep = 1.0;
	for (int i = 0; i < light_count; i++) {
		vec4 l = lights[i];
		float lit = 1.0 - smoothstep(l.z * 0.8, l.z * 1.12, distance(world, l.xy));
		keep *= 1.0 - lit * l.w;
	}
	float glow = 1.0 - smoothstep(moon.z * 0.25, moon.z, distance(world, moon.xy));
	keep *= 1.0 - glow * moon.w;
	COLOR = vec4(0.01, 0.01, 0.03, darkness * keep);
}"

## True for each candle that is burning.
var _lit: Array[bool] = []
## How bright each candle's light is right now (fades in and out smoothly).
var _strength: PackedFloat32Array = PackedFloat32Array()
## When each candle last went out (for the curl of smoke).
var _out_time: PackedFloat32Array = PackedFloat32Array()
var _areas: Array[Area2D] = []
var _active: bool = false
var _holding: bool = false
var _faded: bool = false
var _time: float = 0.0
var _draught_left: float = 10.0
var _draught_count: int = 0
var _gust_time: float = -10.0
var _last_dark_message: float = -10.0
var _press_position: Vector2 = Vector2.INF
var _rng := RandomNumberGenerator.new()
var _darkness_rect: ColorRect
var _material: ShaderMaterial
var _dark_catcher: Area2D
var _containers: Array[OpenableContainer] = []


func _ready() -> void:
	add_to_group("room_effects")
	_rng.randomize()
	for i in range(candle_count()):
		_lit.append(true)
		_strength.append(1.0)
		_out_time.append(-10.0)
		_areas.append(_make_candle_area(i))
	_make_darkness()
	_draught_left = _next_draught_wait()
	# The dark catcher must sit BEHIND the hidden objects, so it goes into the
	# room just before them (the room is still being set up, so wait a moment).
	_add_dark_catcher.call_deferred()
	_check_every_object_can_be_lit.call_deferred()


## Number of candles in the chapel.
func candle_count() -> int:
	return mini(positions.size(), MAX_CANDLES)


## Called by the room when the player can start searching: the draughts begin.
func start_effect() -> void:
	_active = true


## Called when the room is complete: every candle burns, the dark lifts, nothing is blocked any more.
func fade_out() -> void:
	_active = false
	_faded = true
	for i in range(candle_count()):
		_lit[i] = true
		_areas[i].input_pickable = false
	_dark_catcher.input_pickable = false
	for node in _blockable_nodes():
		node.call("set_reachable", true)
	create_tween().tween_method(func(value: float) -> void: _material.set_shader_parameter("darkness", value),
			darkness, 0.0, 1.5)


# ---------------------------------------------------------------------------
# Test helpers (and handy for puzzles)
# ---------------------------------------------------------------------------

## Lights every candle. With `hold`, the draughts stop too, so nothing goes dark
## again (the safe state used by the automated test). Without it, draughts resume.
func light_all(hold: bool = false) -> void:
	_holding = hold
	for i in range(candle_count()):
		_set_lit(i, true)
	_draught_left = _next_draught_wait()
	_update_reach()


## Blows candle `index` out straight away (no message). Works while holding, too.
func blow_out(index: int) -> void:
	if index >= 0 and index < candle_count():
		_set_lit(index, false)
		_update_reach()


## True while candle `index` is burning.
func is_lit(index: int) -> bool:
	return index >= 0 and index < candle_count() and _lit[index]


## Where to click to relight candle `index` (a room position: use it with real clicks).
func get_candle_position(index: int) -> Vector2:
	return _click_centre(index)


## True if `world_position` (a room position) is inside a lit candle's circle.
func is_in_light(world_position: Vector2) -> bool:
	if _faded:
		return true
	for i in range(candle_count()):
		if _lit[i] and world_position.distance_to(positions[i]) <= radii[i]:
			return true
	return false


## Makes the next draught come after `seconds` (lets the test see one without a long wait).
func next_draught_in(seconds: float) -> void:
	_draught_left = seconds


# ---------------------------------------------------------------------------

func _process(delta: float) -> void:
	_time += delta
	if _active and not _holding and not _faded:
		_draught_left -= delta
		if _draught_left <= 0.0:
			_draught_left = _next_draught_wait()
			_blow_random_candle()
	# Lights fade in and out smoothly instead of snapping.
	for i in range(candle_count()):
		var target := 1.0 if _lit[i] else 0.0
		_strength[i] = move_toward(_strength[i], target, delta * (3.5 if _lit[i] else 2.5))
	if not _faded:
		_update_reach()
	_update_shader()
	queue_redraw()


func _next_draught_wait() -> float:
	return _rng.randf_range(draught_min_seconds, draught_max_seconds)


## The draught blows out one random burning candle.
func _blow_random_candle() -> void:
	var burning: Array[int] = []
	for i in range(candle_count()):
		if _lit[i]:
			burning.append(i)
	if burning.is_empty():
		return
	_set_lit(burning[_rng.randi() % burning.size()], false)
	_gust_time = _time
	_draught_count += 1
	if _draught_count <= full_messages:
		notice.emit("A draught!", "A candle has blown out. Click it to light it again.", false)
	else:
		notice.emit("A draught!", "Another candle goes out.", false)
	_update_reach()


func _set_lit(index: int, lit: bool) -> void:
	if _lit[index] == lit:
		return
	_lit[index] = lit
	if not lit:
		_out_time[index] = _time
	# Only a candle that has gone out can be clicked (to light it again).
	_areas[index].input_pickable = not lit and not _faded


## Tells every object and container whether it is inside the light.
## (Only when that changes, so the hover cursor isn't reset every frame.)
func _update_reach() -> void:
	for node in _blockable_nodes():
		var reachable := is_in_light(node.global_position)
		var pickable := node.input_pickable
		if node is HiddenObject:
			var hidden_object := node as HiddenObject
			if pickable != (reachable and hidden_object.visible and not hidden_object.is_collected):
				hidden_object.set_reachable(reachable)
		elif node is OpenableContainer:
			var container := node as OpenableContainer
			if pickable != (reachable and not container.is_open):
				container.set_reachable(reachable)


func _blockable_nodes() -> Array[Area2D]:
	var found: Array[Area2D] = []
	for node in get_tree().get_nodes_in_group("hidden_objects"):
		if node is HiddenObject:
			found.append(node as Area2D)
	for container in _containers:
		found.append(container)
	return found


## Every object and container must be inside at least one candle's circle,
## or the room could never be finished. This catches layout mistakes early.
func _check_every_object_can_be_lit() -> void:
	_containers.clear()
	for node in get_parent().find_children("*", "OpenableContainer", true, false):
		_containers.append(node as OpenableContainer)
	for node in _blockable_nodes():
		var covered := false
		for i in range(candle_count()):
			if node.global_position.distance_to(positions[i]) <= radii[i]:
				covered = true
		if not covered:
			push_error("CandleLights: %s at %s is outside every candle's light, so it can never be clicked." % [node.name, node.global_position])
	_update_reach()


# ---------------------------------------------------------------------------
# Click areas
# ---------------------------------------------------------------------------

## The middle of a candle's click area: the flame and the wax below it.
func _click_centre(index: int) -> Vector2:
	return positions[index] + Vector2(0, 2)


func _make_candle_area(index: int) -> Area2D:
	var area := Area2D.new()
	area.name = "Candle%d" % index
	area.position = _click_centre(index)
	area.input_pickable = false
	var shape := RectangleShape2D.new()
	shape.size = CLICK_SIZE
	var collision := CollisionShape2D.new()
	collision.shape = shape
	area.add_child(collision)
	add_child(area)
	area.input_event.connect(_on_candle_input.bind(index))
	return area


func _on_candle_input(_viewport: Node, event: InputEvent, _shape_index: int, index: int) -> void:
	var click := event as InputEventMouseButton
	if click == null or not click.pressed or click.button_index != MOUSE_BUTTON_LEFT or get_tree().paused:
		return
	if not _lit[index]:
		_set_lit(index, true)
		# Looked up by path (not by name), so test scripts that use this class still compile.
		var audio := get_node_or_null("/root/AudioManager")
		if audio != null:
			audio.call("play_sfx", "click")
		_update_reach()


func _make_darkness() -> void:
	_material = ShaderMaterial.new()
	var shader := Shader.new()
	shader.code = DARKNESS_SHADER
	_material.shader = shader
	_darkness_rect = ColorRect.new()
	_darkness_rect.name = "Darkness"
	# Bigger than the room, so zooming out never shows its edge.
	_darkness_rect.position = Vector2(-600, -600)
	_darkness_rect.size = Vector2(2480, 1920)
	_darkness_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_darkness_rect.material = _material
	# Drawn BEHIND this node's own drawing, so the candle flames shine on top of the dark.
	_darkness_rect.show_behind_parent = true
	add_child(_darkness_rect)
	_update_shader()


func _update_shader() -> void:
	var lights: Array[Vector4] = []
	for i in range(MAX_CANDLES):
		if i < candle_count():
			# A gentle flicker in the size of each light.
			var flicker := sin(_time * 6.1 + i * 1.9) * 2.5 + sin(_time * 13.7 + i) * 1.5
			lights.append(Vector4(positions[i].x, positions[i].y, radii[i] + flicker, _strength[i]))
		else:
			lights.append(Vector4.ZERO)
	_material.set_shader_parameter("lights", lights)
	_material.set_shader_parameter("light_count", candle_count())
	if not _faded:
		_material.set_shader_parameter("darkness", darkness)
	_material.set_shader_parameter("moon", Vector4(moon_glow.x, moon_glow.y, moon_glow.z, 0.45))


func _add_dark_catcher() -> void:
	_dark_catcher = Area2D.new()
	_dark_catcher.name = "DarkCatcher"
	_dark_catcher.input_pickable = true
	var shape := RectangleShape2D.new()
	shape.size = Vector2(4000, 4000)
	var collision := CollisionShape2D.new()
	collision.shape = shape
	_dark_catcher.add_child(collision)
	var room := get_parent()
	room.add_child(_dark_catcher)
	var hidden_objects := room.get_node_or_null("HiddenObjects")
	if hidden_objects != null:
		room.move_child(_dark_catcher, hidden_objects.get_index())
	_dark_catcher.input_event.connect(_on_dark_click)


func _input(event: InputEvent) -> void:
	# Every new press forgets the last one (see BatColony for why).
	var click := event as InputEventMouseButton
	if click != null and click.pressed and click.button_index == MOUSE_BUTTON_LEFT:
		_press_position = Vector2.INF


## A click that hit nothing clickable. If it was on an object in the dark, say why it didn't work.
## A drag (looking around on a phone) doesn't count.
func _on_dark_click(_viewport: Node, event: InputEvent, _shape_index: int) -> void:
	var click := event as InputEventMouseButton
	if click == null or click.button_index != MOUSE_BUTTON_LEFT or get_tree().paused or _faded:
		return
	if click.pressed:
		_press_position = click.position
		return
	if _press_position == Vector2.INF or click.position.distance_to(_press_position) > TAP_TOLERANCE:
		return
	_press_position = Vector2.INF
	# The click's own position (not the mouse pointer's), turned into a room position.
	var world := get_viewport().get_canvas_transform().affine_inverse() * click.position
	for node in _blockable_nodes():
		if not node.visible or is_in_light(node.global_position):
			continue
		if node is HiddenObject and (node as HiddenObject).is_collected:
			continue
		if node is OpenableContainer and (node as OpenableContainer).is_open:
			continue
		if node.global_position.distance_to(world) < 55.0:
			if _time - _last_dark_message > DARK_MESSAGE_SECONDS:
				_last_dark_message = _time
				notice.emit("Too dark to see", "Light a candle nearby first.", true)
			return


# ---------------------------------------------------------------------------
# Drawing the candles (on top of the darkness)
# ---------------------------------------------------------------------------

func _draw() -> void:
	for i in range(candle_count()):
		# A warm glow around each lit candle.
		if _strength[i] > 0.01:
			for ring in range(5):
				draw_circle(positions[i] + Vector2(0, -8), radii[i] * (0.15 + ring * 0.13),
						Color(1.0, 0.7, 0.35, 0.022 * _strength[i] * (1.0 - _fade_progress())))
	for i in range(candle_count()):
		# Unlit candles are drawn dim, but never invisible: the player must find them again.
		var shade := lerpf(0.42, 1.0, _strength[i])
		_draw_holder(i, shade)
		_draw_wax(positions[i], shade)
		if _lit[i]:
			_draw_flame(i)
		else:
			_draw_out_candle(i)


## How far the end-of-room fade has gone (0 to 1), so the glow fades with the dark.
func _fade_progress() -> float:
	if not _faded:
		return 0.0
	return 1.0 - float(_material.get_shader_parameter("darkness")) / maxf(darkness, 0.01)


## `color` dimmed for a candle that is out (it keeps its own transparency).
static func _tone(color: Color, shade: float) -> Color:
	return Color(color.r * shade, color.g * shade, color.b * shade, color.a)


## A round bar seen from the side: dark at both edges, with a highlight left of
## the middle (the light in the painting falls from the left).
func _round_bar(rect: Rect2, dark: Color, light: Color) -> void:
	var shine_x := rect.position.x + rect.size.x * 0.32
	draw_polygon(PackedVector2Array([rect.position, Vector2(shine_x, rect.position.y), Vector2(shine_x, rect.end.y),
		Vector2(rect.position.x, rect.end.y)]), PackedColorArray([dark, light, light, dark]))
	draw_polygon(PackedVector2Array([Vector2(shine_x, rect.position.y), Vector2(rect.end.x, rect.position.y), rect.end,
		Vector2(shine_x, rect.end.y)]), PackedColorArray([light, dark, dark, light]))


## A turned (lathe-made) shape: `profile` lists (distance below `top`, half width) pairs, top to bottom.
func _turned(top: Vector2, profile: PackedVector2Array, dark: Color, light: Color) -> void:
	for i in range(profile.size() - 1):
		var upper := profile[i]
		var lower := profile[i + 1]
		var shine := top.x - maxf(upper.y, lower.y) * 0.36
		var left := PackedVector2Array([top + Vector2(-upper.y, upper.x), Vector2(shine, top.y + upper.x),
			Vector2(shine, top.y + lower.x), top + Vector2(-lower.y, lower.x)])
		var right := PackedVector2Array([Vector2(shine, top.y + upper.x), top + Vector2(upper.y, upper.x),
			top + Vector2(lower.y, lower.x), Vector2(shine, top.y + lower.x)])
		draw_polygon(left, PackedColorArray([dark, light, light, dark]))
		draw_polygon(right, PackedColorArray([light, dark, dark, light]))


## The wax candle: a round, slightly see-through stick with a melted top and runs of wax.
func _draw_wax(wick: Vector2, shade: float) -> void:
	var edge := _tone(Color(0.6, 0.53, 0.4), shade)
	var body := _tone(Color(0.97, 0.93, 0.8), shade)
	_round_bar(Rect2(wick.x - 5, wick.y + 1, 10, 23), edge, body)
	# Runs of wax down the side, each ending in a bead.
	for run: Vector3 in [Vector3(-3.5, 9, 1.4), Vector3(2.5, 13, 1.6), Vector3(0.2, 5, 1.1)]:
		var top := wick + Vector2(run.x, 1)
		draw_line(top, top + Vector2(0, run.y), _tone(Color(1.0, 0.97, 0.87), shade), run.z * 1.4)
		draw_circle(top + Vector2(0, run.y), run.z, _tone(Color(1.0, 0.97, 0.87), shade))
		draw_circle(top + Vector2(0.6, run.y + 0.5), run.z * 0.6, _tone(Color(0.72, 0.65, 0.5, 0.7), shade))
	# The melted top: a rim round a little pool of wax.
	PlaceholderArt.draw_ellipse(self, wick + Vector2(0, 1), 5, 2, _tone(Color(1.0, 0.98, 0.9), shade))
	PlaceholderArt.draw_ellipse(self, wick + Vector2(0, 1.2), 3.2, 1.1, _tone(Color(0.82, 0.74, 0.56), shade))
	# A burning candle glows through its own wax near the top.
	var lit := clampf((shade - 0.42) / 0.58, 0.0, 1.0)
	if lit > 0.0:
		var warm := Color(1.0, 0.72, 0.3, 0.42 * lit)
		draw_polygon(PackedVector2Array([wick + Vector2(-5, 1), wick + Vector2(5, 1), wick + Vector2(5, 13), wick + Vector2(-5, 13)]),
			PackedColorArray([warm, warm, Color(warm, 0.0), Color(warm, 0.0)]))
	draw_line(wick + Vector2(0, 1), wick + Vector2(0.6, -4), Color(0.1, 0.08, 0.06), 1.5, true)


## The candlestick, sconce, pulpit holder or floor stand below each candle.
func _draw_holder(index: int, shade: float) -> void:
	var wick := positions[index]
	var base := wick + Vector2(0, 24)
	var brass := _tone(Color(1.0, 0.84, 0.5), shade)
	var brass_dark := _tone(Color(0.34, 0.23, 0.09), shade)
	var iron := _tone(Color(0.5, 0.48, 0.46), shade)
	var iron_dark := _tone(Color(0.09, 0.085, 0.09), shade)
	var shadow := Color(0, 0, 0, 0.38)
	match (kinds[index] if index < kinds.size() else Kind.STAND):
		Kind.ALTAR:
			# A tall turned brass candlestick standing on the altar.
			PlaceholderArt.draw_ellipse(self, base + Vector2(3, 31), 15, 3, shadow)
			_turned(base, PackedVector2Array([Vector2(3, 3), Vector2(6, 2.2), Vector2(9, 2.2), Vector2(11, 4.6), Vector2(13, 4.6),
				Vector2(15, 2.4), Vector2(20, 2.8), Vector2(23, 4.5), Vector2(27, 9.5), Vector2(30, 11), Vector2(31, 11)]), brass_dark, brass)
			# The drip pan under the candle, and the rim of the foot.
			PlaceholderArt.draw_ellipse(self, base + Vector2(0, 2), 8.5, 2.6, brass_dark)
			PlaceholderArt.draw_ellipse(self, base + Vector2(-0.5, 1.2), 7.5, 1.9, brass)
			PlaceholderArt.draw_ellipse(self, base + Vector2(0, 1.4), 5, 1.2, brass_dark)
			draw_line(base + Vector2(-10.5, 31), base + Vector2(10.5, 31), brass_dark, 1.0, true)
		Kind.PULPIT:
			# A brass chamberstick: a saucer with a short socket and a ring to carry it by.
			PlaceholderArt.draw_ellipse(self, base + Vector2(3, 5), 14, 3, shadow)
			PlaceholderArt.draw_ellipse(self, base + Vector2(0, 3), 12, 4, brass_dark)
			PlaceholderArt.draw_ellipse(self, base + Vector2(-0.6, 2), 11, 3.2, brass)
			PlaceholderArt.draw_ellipse(self, base + Vector2(0.4, 2.3), 8, 2.1, _tone(Color(0.62, 0.45, 0.2), shade))
			_turned(base + Vector2(0, -4), PackedVector2Array([Vector2(0, 6.5), Vector2(2, 6), Vector2(6, 6.3)]), brass_dark, brass)
			draw_arc(base + Vector2(13.5, 1), 4.0, -PI * 0.7, PI * 0.7, 10, brass_dark, 2.4, true)
			draw_arc(base + Vector2(13.5, 1), 4.0, -PI * 0.6, 0.0, 6, brass, 1.0, true)
		Kind.SCONCE:
			# A wrought-iron cup on a scrolled bracket, fixed to the stone by a riveted plate.
			var arm := PackedVector2Array([base + Vector2(0, 6), base + Vector2(0.5, 13), base + Vector2(3, 18),
				base + Vector2(7, 20), base + Vector2(10, 17), base + Vector2(9, 13), base + Vector2(6.5, 13.5)])
			var plate := Rect2(base.x - 4.5, base.y + 15, 9, 21)
			# Its shadow on the wall, thrown down and to the right by the flame above.
			draw_rect(Rect2(plate.position + Vector2(3, 3), plate.size), Color(0, 0, 0, 0.3))
			draw_rect(Rect2(base.x - 6, base.y + 3, 16, 5), Color(0, 0, 0, 0.25))
			_round_bar(plate, iron_dark, _tone(Color(0.3, 0.29, 0.28), shade))
			draw_rect(plate, iron_dark, false, 1.0)
			draw_circle(plate.position + Vector2(4.5, 4), 1.4, iron)
			draw_circle(plate.end - Vector2(4.5, 4), 1.4, iron)
			draw_polyline(arm, iron_dark, 3.4, true)
			draw_polyline(arm.slice(0, 4), _tone(Color(0.34, 0.33, 0.32), shade), 1.0, true)
			_turned(base, PackedVector2Array([Vector2(0, 8.5), Vector2(1.5, 8.5), Vector2(4, 6), Vector2(6.5, 2.5)]), iron_dark, iron)
			PlaceholderArt.draw_ellipse(self, base + Vector2(0, 0.6), 8.5, 2.2, iron_dark)
			PlaceholderArt.draw_ellipse(self, base + Vector2(-0.6, 0.2), 7.2, 1.5, _tone(Color(0.33, 0.32, 0.31), shade))
		_:
			# A tall wrought-iron pricket stand on three feet, standing on the floor.
			var foot := base + Vector2(0, 96)
			PlaceholderArt.draw_ellipse(self, foot + Vector2(4, 10), 24, 4, shadow)
			for side: float in [-1.0, 1.0, 0.0]:
				var leg := PackedVector2Array([foot + Vector2(0, -8), foot + Vector2(side * 6, -1), foot + Vector2(side * 13, 6 - absf(side) * 1.5),
					foot + Vector2(side * 17, 9 - absf(side) * 2)])
				if side == 0.0:
					leg = PackedVector2Array([foot + Vector2(0, -8), foot + Vector2(1, 2), foot + Vector2(2.5, 11)])
				draw_polyline(leg, iron_dark, 3.2, true)
				draw_polyline(leg, _tone(Color(0.32, 0.31, 0.3), shade), 0.9, true)
				draw_circle(leg[leg.size() - 1], 2.0, iron_dark)
			_turned(base, PackedVector2Array([Vector2(3, 2), Vector2(28, 1.8), Vector2(30, 4.2), Vector2(33, 4.2), Vector2(35, 1.8),
				Vector2(60, 2), Vector2(62, 4.6), Vector2(65, 4.6), Vector2(67, 2.2), Vector2(88, 2.6), Vector2(92, 4.5)]), iron_dark, iron)
			# The wide drip pan, with a turned-up rim.
			PlaceholderArt.draw_ellipse(self, base + Vector2(0, 2.5), 13, 3.6, iron_dark)
			PlaceholderArt.draw_ellipse(self, base + Vector2(-0.8, 1.6), 11.8, 2.6, _tone(Color(0.33, 0.32, 0.31), shade))
			PlaceholderArt.draw_ellipse(self, base + Vector2(0, 2), 8.5, 1.7, iron_dark)


## One side-to-side outline of a flame: round at the wick, drawn out to a point at the tip.
static func _flame_shape(wick: Vector2, height: float, half_width: float, lean: float) -> PackedVector2Array:
	var left := PackedVector2Array()
	var right := PackedVector2Array()
	for step in range(11):
		var u := step / 10.0
		var half := half_width * sin(minf(u / 0.3, 1.0) * PI * 0.5) * pow(1.0 - u, 0.75)
		var middle := wick + Vector2(lean * u * u, -height * u + 1.5)
		left.append(middle + Vector2(-half, 0))
		right.append(middle + Vector2(half, 0))
	right.reverse()
	return left + right.slice(1)


## An animated flame: it flickers, and leans away from the door when a draught blows.
func _draw_flame(index: int) -> void:
	var wick := positions[index] + Vector2(0, -3)
	var flicker := sin(_time * 11.0 + index * 2.3) * 0.12 + sin(_time * 23.0 + index) * 0.08
	var gust := clampf(1.0 - (_time - _gust_time) / 1.2, 0.0, 1.0)
	var lean := sin(_time * 3.0 + index) * 1.2 - gust * 6.0 * (0.6 + 0.4 * sin(_time * 20.0))
	var height := 17.0 * (1.0 + flicker) * (1.0 - gust * 0.3)
	# A soft halo round the flame.
	var heart := wick + Vector2(lean * 0.3, -height * 0.42)
	for ring in range(10):
		draw_circle(heart, 4.0 + ring * 1.8, Color(1.0, 0.72, 0.3, 0.035))
	# The flame: deep orange at the wick, yellow and thin at the tip.
	var outer := _flame_shape(wick, height, 4.6, lean)
	var colors := PackedColorArray()
	for point in outer:
		var u := clampf((wick.y + 1.5 - point.y) / height, 0.0, 1.0)
		colors.append(Color(1.0, 0.5, 0.12, 0.95).lerp(Color(1.0, 0.86, 0.4, 0.55), u))
	draw_polygon(outer, colors)
	draw_colored_polygon(_flame_shape(wick + Vector2(0, -1.5), height * 0.62, 2.7, lean * 0.6), Color(1.0, 0.96, 0.78, 0.95))
	# The dark heart round the wick, with a breath of blue.
	draw_circle(wick + Vector2(0, 0.5), 1.7, Color(0.35, 0.45, 0.95, 0.75))


## A candle that has gone out: a glowing ember on the wick, a curl of smoke,
## and a soft pulse so the player can spot it in the dark.
func _draw_out_candle(index: int) -> void:
	var wick := positions[index] + Vector2(0, -5)
	draw_circle(wick, 1.6, Color(1.0, 0.4, 0.15, 0.6 + 0.3 * sin(_time * 4.0 + index)))
	var since := _time - _out_time[index]
	if since < 4.0:
		var alpha := 0.55 * (1.0 - since / 4.0)
		var rise := since * 10.0
		var points := PackedVector2Array()
		for step in range(7):
			var y := -step * 4.0 - rise * 0.3
			points.append(wick + Vector2(sin(step * 1.1 + _time * 2.0) * 3.0, y))
		draw_polyline(points, Color(0.8, 0.8, 0.85, alpha), 1.5, true)
	var pulse := 0.5 + 0.5 * sin(_time * 3.0 + index)
	draw_arc(_click_centre(index), 20.0 + pulse * 4.0, 0, TAU, 28, Color(1.0, 0.85, 0.55, 0.12 + 0.12 * pulse), 2.0, true)
