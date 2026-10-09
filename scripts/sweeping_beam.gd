class_name SweepingBeam
extends Node2D
## House Two, Chapter Seven (The Lighthouse Steps): the great lamp at the top
## of the tower turns, and its beam sweeps through the windows. A wide, soft
## band of light crosses the whole stairwell from left to right, again and
## again. The rest of the tower stays dim.
##
## A few objects (listed in `beam_objects`) are almost invisible in the dim
## light. They can only be clicked while the beam is lighting them. Every
## other object and container can always be clicked.
##
## HOW IT WORKS: every frame the beam's centre moves to the right (and jumps
## back to the left when it has left the room). Each beam object is told
## whether it is lit (set_reachable), and is faded in or out to match. Over
## each beam object sits a small invisible "too dark" area: while the object
## is dark, that area catches the click and the player is told to wait for
## the beam.
##
## Place this node AFTER HiddenObjects and RoomForeground in the scene, so the
## dimness covers everything and the "too dark" areas sit on top for clicks.

## Shown when the player clicks a beam object in the dark.
signal notice(title: String, message: String, wrong_sound: bool)

## The objects that can only be seen and clicked while the beam lights them.
@export var beam_objects: Array[NodePath] = []
## Size of the whole room (the tower is two screens tall).
@export var room_size: Vector2 = Vector2(1280, 1440)
## Seconds for the beam to come round again.
@export var period_seconds: float = 9.0
## Where the beam's centre starts each sweep (off the left edge)...
@export var sweep_start_x: float = -320.0
## ...and where it ends (off the right edge).
@export var sweep_end_x: float = 1600.0
## Objects closer than this to the beam's centre (sideways) count as lit.
## With the default speed that lights each spot for about 2.4 seconds.
@export var lit_half_width: float = 250.0
## The light fades out softly between these two distances from the centre.
@export var soft_inner: float = 150.0
@export var soft_outer: float = 320.0
## How dark the room is away from the beam (0 = no shade, 1 = black).
@export var darkness: float = 0.55
## The colour of the light in the middle of the beam.
@export var beam_color: Color = Color(0.86, 0.9, 1.0, 0.16)
## Windows the beam shines in through: they flare up as it passes.
@export var windows: PackedVector2Array = PackedVector2Array()
## A beam object in the dark is drawn with this colour (very hard to see).
@export var dark_modulate: Color = Color(0.3, 0.32, 0.42, 0.22)
## Seconds before the same "too dark" message may be shown again.
@export var notice_cooldown: float = 2.5

## Seconds into the current sweep (exposed for the automated test).
var cycle_time: float = 2.4

var _active: bool = false
var _holding: bool = false
var _all_lit: bool = false
var _faded: bool = false
## 1.0 while the room is dimmed; goes to 0.0 when the room is complete.
var _shade: float = 1.0
var _beam_x: float = 0.0
var _last_notice_time: float = -100.0
var _time: float = 0.0
var _objects: Array[Node] = []
## One "too dark" click area per beam object (same order as _objects).
var _blockers: Array[Area2D] = []


func _ready() -> void:
	add_to_group("room_effects")
	for path in beam_objects:
		var node := get_node_or_null(path)
		if node != null:
			_objects.append(node)
	# The hidden objects are ready before this node (they come first in the
	# scene), but wait one moment so their click shapes have their final size.
	_build_blockers.call_deferred()
	_update_beam()


## Called by the room when the player can start searching.
func start_effect() -> void:
	_active = true


## Called when the room is complete: the lamp's light fills the tower and
## nothing is blocked any more.
func fade_out() -> void:
	_active = false
	_faded = true
	var tween := create_tween()
	tween.tween_property(self, "_shade", 0.0, 2.0)
	_update_objects()


## Where the middle of the beam is right now (room x).
func get_beam_x() -> float:
	return _beam_x


## Puts the middle of the beam at `world_x` straight away (used by the test).
func set_beam_x(world_x: float) -> void:
	var speed := (sweep_end_x - sweep_start_x) / period_seconds
	cycle_time = clampf((world_x - sweep_start_x) / speed, 0.0, period_seconds)
	_update_beam()


## Freezes the beam where it is (true) or lets it turn again (false). Used by the test.
func hold(enabled: bool) -> void:
	_holding = enabled


## True if `world_position` is in the light right now.
## After light_everything(true), or once the room is complete, everything counts as lit.
func is_lit(world_position: Vector2) -> bool:
	if _all_lit or _faded:
		return true
	return absf(world_position.x - _beam_x) < lit_half_width


## The objects that can only be clicked while the beam lights them.
func get_beam_objects() -> Array[Node]:
	return _objects.duplicate()


## The test's "safe" state: every object counts as lit and the beam stops turning.
## light_everything(false) goes back to normal (the beam stays held until hold(false)).
func light_everything(enabled: bool) -> void:
	_all_lit = enabled
	if enabled:
		_holding = true
	_update_objects()


func _process(delta: float) -> void:
	_time += delta
	if _active and not _holding:
		cycle_time = fmod(cycle_time + delta, period_seconds)
		_update_beam()
	queue_redraw()


func _update_beam() -> void:
	_beam_x = lerpf(sweep_start_x, sweep_end_x, cycle_time / period_seconds)
	_update_objects()


## How brightly the beam lights a spot: 1 in the middle, 0 outside it.
func _light_at(world_x: float) -> float:
	if _all_lit or _faded:
		return 1.0
	return 1.0 - smoothstep(soft_inner, soft_outer, absf(world_x - _beam_x))


## Tells every beam object whether it can be clicked, and fades it in or out.
func _update_objects() -> void:
	for i in range(_objects.size()):
		var area := _objects[i] as Area2D
		if area == null:
			continue
		var lit := is_lit(area.global_position)
		if area.has_method("set_reachable"):
			area.call("set_reachable", lit)
		# Lit objects glow a little; dark ones almost disappear into the shadows.
		var light := _light_at(area.global_position.x)
		var bright := Color(1.12, 1.1, 1.02, 1.0) if not (_all_lit or _faded) else Color.WHITE
		area.modulate = dark_modulate.lerp(bright, light)
		if i < _blockers.size():
			_blockers[i].input_pickable = not lit and area.visible and not _is_collected(area)


func _is_collected(node: Node) -> bool:
	var hidden_object := node as HiddenObject
	return hidden_object != null and hidden_object.is_collected


## Makes one invisible click area over each beam object, the same size and
## angle as the object's own click area.
func _build_blockers() -> void:
	for node in _objects:
		var area := node as Area2D
		var blocker := Area2D.new()
		blocker.name = "TooDark" + String(node.name)
		blocker.input_pickable = false
		var collision := CollisionShape2D.new()
		var source := area.get_node_or_null("CollisionShape2D") as CollisionShape2D
		if source != null and source.shape != null:
			collision.shape = source.shape.duplicate()
			collision.position = source.position
		else:
			var shape := RectangleShape2D.new()
			shape.size = Vector2(40, 40)
			collision.shape = shape
		blocker.add_child(collision)
		add_child(blocker)
		blocker.global_transform = area.global_transform
		blocker.input_event.connect(_on_dark_object_clicked.bind(node))
		_blockers.append(blocker)
	_update_objects()


func _on_dark_object_clicked(_viewport: Node, event: InputEvent, _shape_index: int, node: Node) -> void:
	var click := event as InputEventMouseButton
	if click == null or not click.pressed or click.button_index != MOUSE_BUTTON_LEFT or get_tree().paused:
		return
	# The click's own position (not the mouse pointer's), turned into a room position.
	var world := get_viewport().get_canvas_transform().affine_inverse() * click.position
	if is_lit(world) or _is_collected(node):
		return
	# Don't repeat the same message over and over.
	if _time - _last_notice_time < notice_cooldown:
		return
	_last_notice_time = _time
	notice.emit("Too dark to make it out", "Wait for the lighthouse beam to sweep past, then click it while it's lit.", true)


func _draw() -> void:
	if _shade <= 0.001:
		return
	var top := -40.0
	var bottom := room_size.y + 40.0
	var dark := darkness * _shade
	# The dim room on both sides of the beam...
	var left_edge := _beam_x - soft_outer
	var right_edge := _beam_x + soft_outer
	if left_edge > -40.0:
		draw_rect(Rect2(-40.0, top, left_edge + 40.0, bottom - top), Color(0, 0, 0, dark))
	if right_edge < room_size.x + 40.0:
		draw_rect(Rect2(right_edge, top, room_size.x + 40.0 - right_edge, bottom - top), Color(0, 0, 0, dark))
	# ...and the soft beam itself: strips whose shade fades away towards the middle.
	var steps := 24
	for i in range(steps):
		var x0 := lerpf(left_edge, right_edge, float(i) / steps)
		var x1 := lerpf(left_edge, right_edge, float(i + 1) / steps)
		var a0 := dark * (1.0 - _light_at_raw(x0))
		var a1 := dark * (1.0 - _light_at_raw(x1))
		var l0 := beam_color.a * _light_at_raw(x0) * _shade
		var l1 := beam_color.a * _light_at_raw(x1) * _shade
		_strip(x0, x1, top, bottom, Color(0, 0, 0, a0), Color(0, 0, 0, a1))
		_strip(x0, x1, top, bottom, Color(beam_color, l0), Color(beam_color, l1))
	# A few brighter rays inside the beam, slowly shimmering.
	for k in range(3):
		var ray_x := _beam_x + (k - 1) * 70.0 + sin(_time * 0.8 + k * 2.0) * 12.0
		var ray := Color(beam_color, beam_color.a * 0.5 * _shade)
		_strip(ray_x - 18.0, ray_x, top, bottom, Color(ray, 0.0), ray)
		_strip(ray_x, ray_x + 18.0, top, bottom, ray, Color(ray, 0.0))
	# The windows flare up as the beam passes them.
	for window in windows:
		var flare := _light_at_raw(window.x) * _shade
		if flare <= 0.01:
			continue
		for ring in range(4):
			draw_circle(window, 30.0 + ring * 18.0, Color(0.9, 0.94, 1.0, 0.07 * flare))


## Like _light_at, but ignores the "everything is lit" test state (for drawing).
func _light_at_raw(world_x: float) -> float:
	return 1.0 - smoothstep(soft_inner, soft_outer, absf(world_x - _beam_x))


## A full-height strip from x0 to x1, fading from one colour to the other sideways.
func _strip(x0: float, x1: float, top: float, bottom: float, left: Color, right: Color) -> void:
	if x1 <= x0:
		return
	draw_polygon(PackedVector2Array([Vector2(x0, top), Vector2(x1, top), Vector2(x1, bottom), Vector2(x0, bottom)]),
		PackedColorArray([left, right, right, left]))
