class_name BellBoard
extends Node2D
## House Three, Chapter One (The Gate Lodge): behind the porter's desk hangs a
## bell board. Each ward has a brass bell on a spring, and under every bell a
## numbered pigeonhole with a sprung shutter.
##
## Every few seconds one of the bells rings. Its shutter springs up and stays
## up for a few seconds, then drops again. The objects listed in `bell_objects`
## lie in the pigeonholes: each can only be taken while its own shutter is up.
## Every other object and container can always be clicked.
##
## HOW IT WORKS: bell number i belongs to the object at bell_objects[i]. The
## shutter and the bell are drawn around that object's position, so moving the
## object in the scene moves its pigeonhole too. While a shutter is down the
## object is switched off with set_reachable(false) and the shutter is drawn
## over it. A small invisible area over each shut pigeonhole catches the click
## and tells the player to wait for the bell.
##
## Place this node AFTER HiddenObjects and RoomForeground in the scene, so the
## shutters are drawn over the objects and their click areas sit on top.

## Shown by the room as a notification (see room_level.gd).
signal notice(title: String, message: String, wrong_sound: bool)

## The objects in the pigeonholes, left to right.
@export var bell_objects: Array[NodePath] = []
## The ward number painted under each bell (same order as `bell_objects`).
@export var labels: PackedStringArray = PackedStringArray(["2", "4", "7", "9", "11"])
## Size of one pigeonhole (and of its shutter).
@export var shutter_size: Vector2 = Vector2(60, 56)
## How far above its pigeonhole each bell hangs.
@export var bell_height: float = 84.0
## The shortest and longest wait (seconds) between two bells.
@export var min_wait: float = 4.0
@export var max_wait: float = 7.0
## How long a shutter stays up after its bell rings.
@export var open_seconds: float = 4.0
## Seconds before the same "shutter is down" message may be shown again.
@export var notice_cooldown: float = 2.5

const BRASS := Color(0.82, 0.64, 0.3)
const BRASS_DARK := Color(0.5, 0.36, 0.15)
const SHUTTER := Color(0.33, 0.24, 0.16)
const SHUTTER_DARK := Color(0.2, 0.14, 0.09)

var _active: bool = false
## True while the test (or calm(true)) has stopped the bells ringing by themselves.
var _calm: bool = false
var _all_open: bool = false
## True once the room is complete: every shutter stays up.
var _faded: bool = false
var _wait_left: float = 3.0
var _time: float = 0.0
var _last_notice_time: float = -100.0
var _told_first_ring: bool = false
var _objects: Array[Node] = []
## Seconds each shutter still stays up (0 = down), same order as _objects.
var _open_left: Array[float] = []
## How far each shutter is drawn up: 0 = down, 1 = fully up.
var _slide: Array[float] = []
var _blockers: Array[Area2D] = []
var _rng := RandomNumberGenerator.new()


func _ready() -> void:
	add_to_group("room_effects")
	_rng.randomize()
	for path in bell_objects:
		var node := get_node_or_null(path)
		if node != null:
			_objects.append(node)
			_open_left.append(0.0)
			_slide.append(0.0)
	_build_blockers()
	_update_objects()


## Called by the room when the player can start searching.
func start_effect() -> void:
	_active = true
	_wait_left = 3.0


## Called when the room is complete: every shutter springs up for good.
func fade_out() -> void:
	_active = false
	_faded = true
	_update_objects()


# ---------------------------------------------------------------------------
# Helpers (also used by the automated test)
# ---------------------------------------------------------------------------

func shutter_count() -> int:
	return _objects.size()


## The objects that can only be taken while their shutter is up.
func get_bell_objects() -> Array[Node]:
	return _objects.duplicate()


## True while shutter `index` is up (or its pigeonhole is already empty).
func is_open(index: int) -> bool:
	if index < 0 or index >= _objects.size():
		return false
	return _all_open or _faded or _open_left[index] > 0.0 or _is_collected(_objects[index])


## Rings bell `index` now: its shutter springs up for `open_seconds`.
func ring(index: int) -> void:
	if index < 0 or index >= _objects.size() or _faded:
		return
	_open_left[index] = open_seconds
	_update_objects()
	AudioManager.play_sfx("unlock")
	if not _told_first_ring:
		_told_first_ring = true
		notice.emit("Bell %s is ringing!" % _label(index), "Its shutter is up. Take what is inside before it drops again.", false)


## Drops every shutter at once.
func shut_all() -> void:
	for i in range(_open_left.size()):
		_open_left[i] = 0.0
	_update_objects()


## calm(true): no bell rings by itself any more (ring() still works). calm(false): back to normal.
func calm(enabled: bool) -> void:
	_calm = enabled


## The test's "safe" state: every shutter is up and no bell rings by itself.
## open_all(false) drops them again (the board stays calm until calm(false)).
func open_all(enabled: bool) -> void:
	_all_open = enabled
	if enabled:
		_calm = true
	_update_objects()


func _process(delta: float) -> void:
	_time += delta
	for i in range(_objects.size()):
		if _open_left[i] > 0.0 and not get_tree().paused:
			_open_left[i] = maxf(_open_left[i] - delta, 0.0)
			if _open_left[i] == 0.0:
				_update_objects()
		_slide[i] = move_toward(_slide[i], 1.0 if is_open(i) else 0.0, delta * 7.0)
	if _active and not _calm:
		_wait_left -= delta
		if _wait_left <= 0.0:
			_wait_left = _rng.randf_range(min_wait, max_wait)
			_ring_a_waiting_bell()
	queue_redraw()


## Rings one of the bells whose pigeonhole is still full and shut.
func _ring_a_waiting_bell() -> void:
	var waiting: Array[int] = []
	for i in range(_objects.size()):
		if not is_open(i):
			waiting.append(i)
	if not waiting.is_empty():
		ring(waiting[_rng.randi_range(0, waiting.size() - 1)])


func _label(index: int) -> String:
	return labels[index] if index < labels.size() else str(index + 1)


func _is_collected(node: Node) -> bool:
	var hidden_object := node as HiddenObject
	return hidden_object != null and hidden_object.is_collected


## Tells every pigeonhole object whether it can be clicked right now.
func _update_objects() -> void:
	for i in range(_objects.size()):
		var area := _objects[i] as Area2D
		if area == null:
			continue
		var open := is_open(i)
		if area.has_method("set_reachable"):
			area.call("set_reachable", open)
		if i < _blockers.size():
			_blockers[i].input_pickable = not open


## One invisible click area over each pigeonhole, the size of its shutter.
func _build_blockers() -> void:
	for i in range(_objects.size()):
		var blocker := Area2D.new()
		blocker.name = "Shutter%d" % i
		blocker.input_pickable = false
		var shape := RectangleShape2D.new()
		shape.size = shutter_size
		var collision := CollisionShape2D.new()
		collision.shape = shape
		blocker.add_child(collision)
		add_child(blocker)
		blocker.global_position = (_objects[i] as Node2D).global_position
		blocker.input_event.connect(_on_shutter_clicked.bind(i))
		_blockers.append(blocker)


func _on_shutter_clicked(_viewport: Node, event: InputEvent, _shape_index: int, index: int) -> void:
	var click := event as InputEventMouseButton
	if click == null or not click.pressed or click.button_index != MOUSE_BUTTON_LEFT or get_tree().paused:
		return
	if is_open(index):
		return
	# Don't repeat the same message over and over.
	if _time - _last_notice_time < notice_cooldown:
		return
	_last_notice_time = _time
	notice.emit("The shutter is down", "Wait for bell %s to ring. Its shutter springs up for a few seconds." % _label(index), true)


func _draw() -> void:
	for i in range(_objects.size()):
		var center := to_local((_objects[i] as Node2D).global_position)
		_draw_shutter(center, _slide[i])
		_draw_bell(center + Vector2(0, -bell_height), i)


## A slatted wooden shutter that slides up into the top of its pigeonhole.
func _draw_shutter(center: Vector2, slide: float) -> void:
	var top_left := center - shutter_size / 2.0
	var height := shutter_size.y * (1.0 - slide * 0.88)
	draw_rect(Rect2(top_left, Vector2(shutter_size.x, height)), SHUTTER)
	var y := top_left.y + height - 5.0
	while y > top_left.y:
		draw_line(Vector2(top_left.x + 2, y), Vector2(top_left.x + shutter_size.x - 2, y), SHUTTER_DARK, 1.0)
		y -= 7.0
	# A brass finger-pull on the bottom slat
	draw_rect(Rect2(center.x - 6, top_left.y + height - 5.0, 12, 3), BRASS)
	draw_rect(Rect2(top_left, shutter_size), SHUTTER_DARK, false, 2.0)


## A brass bell on a curled spring, with its ward number on a plate below.
func _draw_bell(at: Vector2, index: int) -> void:
	var ringing := _open_left[index] > 0.0 and not _faded
	var swing := sin(_time * 34.0) * 0.4 if ringing else 0.0
	# The curled spring it hangs from
	draw_arc(at + Vector2(0, -16), 7.0, PI * 0.5, PI * 2.3, 14, BRASS_DARK, 2.0, true)
	draw_set_transform(at + Vector2(0, -9), swing, Vector2.ONE)
	draw_line(Vector2.ZERO, Vector2(0, 6), BRASS_DARK, 2.0)
	draw_colored_polygon(PackedVector2Array([Vector2(-4, 6), Vector2(4, 6), Vector2(9, 20), Vector2(-9, 20)]), BRASS)
	draw_rect(Rect2(-10, 19, 20, 3), BRASS_DARK)
	draw_circle(Vector2(0, 24), 2.2, BRASS_DARK)
	draw_line(Vector2(-3, 8), Vector2(-6, 18), Color(1, 1, 1, 0.5), 1.0)
	draw_set_transform(Vector2.ZERO, 0.0, Vector2.ONE)
	if ringing:
		# Little sound marks on both sides
		for side: float in [-1.0, 1.0]:
			draw_arc(at + Vector2(side * 4.0, 6), 15.0, -0.5 if side > 0 else PI - 0.5, 0.5 if side > 0 else PI + 0.5, 6,
				Color(1.0, 0.9, 0.6, 0.6 + 0.4 * sin(_time * 20.0)), 1.5, true)
	# Number plate
	var plate := Rect2(at.x - 13, at.y + 22, 26, 13)
	draw_rect(plate, Color(0.9, 0.86, 0.74))
	draw_rect(plate, BRASS_DARK, false, 1.0)
	var font := ThemeDB.fallback_font
	var text := _label(index)
	var width := font.get_string_size(text, HORIZONTAL_ALIGNMENT_LEFT, -1, 10).x
	draw_string(font, Vector2(at.x - width / 2.0, at.y + 32.5), text, HORIZONTAL_ALIGNMENT_LEFT, -1, 10, Color(0.15, 0.13, 0.18))
