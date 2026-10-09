class_name PatrolLantern
extends Node2D
## House Two, Chapter Ten (Dr Vane's Cottage): Vane is outside, pacing up and
## down the garden path with a lantern. Every so often he comes past the front
## windows and holds his lantern up to look in.
##
## THE CYCLE:
##   WAITING  - he is somewhere down the garden. Search freely.
##   WARNING  - footsteps on the gravel: his lantern glow comes up the path
##              outside the windows (about 2.5 seconds). Search freely, but get ready.
##   LOOKING  - his lantern looks in (about 3 seconds): a yellow wash sweeps
##              across the room. Keep still! ANY click now (an object, a
##              container or an empty spot) means he saw you move.
##   HIDING   - you duck down for 5 seconds: the room goes dark, your heart
##              pounds, and nothing can be clicked. Then he walks on.
##
## HOW IT WORKS: an invisible "blocker" area covers the whole room. It is a
## child of this node, and this node comes AFTER HiddenObjects in the scene, so
## the blocker sits on top of every object for clicks. It only catches clicks
## while he is looking in (or while you hide), so those clicks never collect or
## open anything. While hiding, every object and container is also switched
## off with set_reachable(false).
##
## Place this node AFTER HiddenObjects (and after RoomForeground) in the scene.

## Shown by the room as a notification (see room_level.gd).
signal notice(title: String, message: String, wrong_sound: bool)

## The two front windows, in room coordinates (they must match the room art).
@export var window_rects: Array[Rect2] = [Rect2(482, 160, 116, 196), Rect2(642, 160, 116, 196)]
## The shortest and longest wait (seconds) between two visits.
@export var min_wait: float = 16.0
@export var max_wait: float = 22.0
## How long the footsteps warning lasts before he looks in.
@export var warning_seconds: float = 2.5
## How long his lantern looks in.
@export var look_seconds: float = 3.0
## How long the player stays hidden after being seen.
@export var hide_seconds: float = 5.0
## Time between two heartbeats while hiding.
@export var heartbeat_seconds: float = 0.8

enum State { WAITING, WARNING, LOOKING, HIDING, CALM }

const LANTERN := Color(1.0, 0.82, 0.38)

var state: State = State.WAITING
var _active: bool = false
## True once the room is complete: Vane never comes back.
var _gone: bool = false
## Seconds left until the next visit (while WAITING).
var _wait_left: float = 18.0
## Seconds spent in the current state.
var _state_time: float = 0.0
var _time: float = 0.0
var _last_heartbeat: float = -10.0
## When the last "stay hidden" message was shown (so it isn't repeated too often).
var _last_hidden_notice: float = -10.0
## Which way he walks this time: 1 = from right to left, -1 = from left to right.
var _direction: float = 1.0
var _blocker: Area2D
var _rng := RandomNumberGenerator.new()


func _ready() -> void:
	add_to_group("room_effects")
	_rng.randomize()
	_wait_left = _rng.randf_range(min_wait, max_wait)
	# One invisible area over the whole room. It is our child, and we come after
	# HiddenObjects, so it is on top of every object when it is switched on.
	_blocker = Area2D.new()
	_blocker.name = "LookBlocker"
	_blocker.input_pickable = false
	var shape := RectangleShape2D.new()
	shape.size = Vector2(4000, 4000)
	var collision := CollisionShape2D.new()
	collision.shape = shape
	_blocker.add_child(collision)
	add_child(_blocker)
	_blocker.input_event.connect(_on_blocker_input)


## Called by the room when the player can start searching.
func start_effect() -> void:
	_active = true


## Called when the room is complete: the police have him, and he never looks in again.
func fade_out() -> void:
	calm(true)
	_gone = true


# ---------------------------------------------------------------------------
# Helpers (also used by the automated test)
# ---------------------------------------------------------------------------

## True while his lantern is looking in through the window.
func is_looking() -> bool:
	return state == State.LOOKING


## True while the player is hiding (nothing can be clicked).
func is_hiding() -> bool:
	return state == State.HIDING


## True during the footsteps warning, before he looks in.
func is_warning() -> bool:
	return state == State.WARNING


## Starts the footsteps warning now (he looks in by himself when it ends).
func start_warning() -> void:
	if _gone or state == State.CALM:
		return
	_end_hiding_quietly()
	_set_state(State.WARNING)
	_direction = 1.0 if _rng.randf() < 0.5 else -1.0
	notice.emit("Footsteps on the gravel...", "Vane is coming past the window. Keep still when his lantern looks in!", false)


## Skips the warning: his lantern looks in right now.
func start_look() -> void:
	if _gone or state == State.CALM:
		return
	_end_hiding_quietly()
	_set_state(State.LOOKING)
	notice.emit("Keep still!", "His lantern is shining in through the window. Don't click anything until he walks on.", false)


## Ends the look now: he walks on down the path.
func end_look() -> void:
	if state == State.LOOKING:
		_go_back_to_waiting()


## Ends the hiding now: you can search again.
func stop_hiding() -> void:
	if state == State.HIDING:
		_end_hiding_quietly()
		_go_back_to_waiting()


## calm(true): Vane stops patrolling (the safe state). Any look or hiding ends
## at once, and every object can be clicked. calm(false): he patrols again.
func calm(enabled: bool) -> void:
	if enabled:
		_end_hiding_quietly()
		_set_state(State.CALM)
	elif state == State.CALM and not _gone:
		_go_back_to_waiting()


# ---------------------------------------------------------------------------

func _set_state(new_state: State) -> void:
	state = new_state
	_state_time = 0.0
	# The blocker catches every click while he looks in, or while you hide.
	_blocker.input_pickable = new_state == State.LOOKING or new_state == State.HIDING
	queue_redraw()


func _go_back_to_waiting() -> void:
	_wait_left = _rng.randf_range(min_wait, max_wait)
	_set_state(State.WAITING)


## He saw you move: duck down and hide.
func _caught() -> void:
	_set_state(State.HIDING)
	_last_heartbeat = -10.0
	_set_everything_reachable(false)
	notice.emit("He saw you move!", "You duck down and hide until he walks on.", true)


## Switches every object and container back on (only if we were hiding).
func _end_hiding_quietly() -> void:
	if state == State.HIDING:
		_set_everything_reachable(true)


func _set_everything_reachable(reachable: bool) -> void:
	for node in get_tree().get_nodes_in_group("hidden_objects") + get_parent().find_children("*", "OpenableContainer", true, false):
		if node.has_method("set_reachable"):
			node.call("set_reachable", reachable)


func _process(delta: float) -> void:
	_time += delta
	_state_time += delta
	match state:
		State.WAITING:
			if _active and not _gone:
				_wait_left -= delta
				if _wait_left <= 0.0:
					start_warning()
		State.WARNING:
			if _state_time >= warning_seconds:
				start_look()
		State.LOOKING:
			if _state_time >= look_seconds:
				_go_back_to_waiting()
		State.HIDING:
			# A heartbeat thump, over and over, while you crouch in the dark.
			if _time - _last_heartbeat >= heartbeat_seconds:
				_last_heartbeat = _time
				AudioManager.play_sfx("open")
			if _state_time >= hide_seconds:
				_end_hiding_quietly()
				_go_back_to_waiting()
				notice.emit("He walks on...", "His footsteps fade down the garden path. Carry on searching, quietly.", false)
	if state != State.WAITING and state != State.CALM:
		queue_redraw()


func _on_blocker_input(_viewport: Node, event: InputEvent, _shape_index: int) -> void:
	var click := event as InputEventMouseButton
	if click == null or not click.pressed or click.button_index != MOUSE_BUTTON_LEFT or get_tree().paused:
		return
	# This click never reaches anything below the blocker.
	get_viewport().set_input_as_handled()
	if state == State.LOOKING:
		_caught()
	elif state == State.HIDING and _time - _last_hidden_notice > 2.5:
		_last_hidden_notice = _time
		notice.emit("Stay hidden!", "Wait until his footsteps fade away.", false)


# ---------------------------------------------------------------------------
# Drawing
# ---------------------------------------------------------------------------

## Where his lantern is, outside the windows (room coordinates).
func _lantern_position() -> Vector2:
	var first := window_rects[0].get_center().x
	var last := window_rects[window_rects.size() - 1].get_center().x
	# Coming from the right, he reaches the right-hand window first.
	var near_x := last if _direction > 0.0 else first
	var far_x := first if _direction > 0.0 else last
	var start_x := near_x + _direction * 260.0
	var y := window_rects[0].position.y + window_rects[0].size.y * 0.62
	match state:
		State.WARNING:
			# Coming up the path, swinging a little with every step.
			var t := clampf(_state_time / warning_seconds, 0.0, 1.0)
			return Vector2(lerpf(start_x, near_x, t), y + sin(_state_time * 7.0) * 4.0)
		State.LOOKING:
			# Held up to the glass, moving slowly from one window to the other as he peers in.
			var t := clampf(_state_time / look_seconds, 0.0, 1.0)
			return Vector2(lerpf(near_x, far_x, t), y - 34.0)
	return Vector2(-1000, -1000)


func _draw() -> void:
	match state:
		State.WARNING:
			_draw_window_glow(_lantern_position(), 0.5 + 0.3 * clampf(_state_time / warning_seconds, 0.0, 1.0))
		State.LOOKING:
			_draw_look()
		State.HIDING:
			_draw_hiding()


## A soft glow seen through the window panes only (it is outside the house).
func _draw_window_glow(lantern: Vector2, strength: float) -> void:
	var cell := 8.0
	for rect in window_rects:
		var y := rect.position.y
		while y < rect.end.y:
			var x := rect.position.x
			while x < rect.end.x:
				var distance := Vector2(x + cell / 2.0, y + cell / 2.0).distance_to(lantern)
				var glow := clampf(1.0 - distance / 150.0, 0.0, 1.0)
				if glow > 0.0:
					draw_rect(Rect2(x, y, minf(cell, rect.end.x - x), minf(cell, rect.end.y - y)), Color(LANTERN, glow * glow * 0.75 * strength))
				x += cell
			y += cell
		# The lantern itself, when it is behind this window.
		if rect.grow(-4).has_point(lantern):
			draw_circle(lantern, 9.0, Color(1.0, 0.95, 0.75, 0.9 * strength))
			draw_circle(lantern, 4.0, Color(1, 1, 0.92))
			draw_line(lantern + Vector2(0, -9), lantern + Vector2(0, -20), Color(0.1, 0.08, 0.06), 2.0)


## His lantern looks in: a yellow wash sweeps from the windows across the room.
func _draw_look() -> void:
	var t := clampf(_state_time / look_seconds, 0.0, 1.0)
	# Fades in quickly and out at the end.
	var fade := clampf(_state_time / 0.3, 0.0, 1.0) * clampf((look_seconds - _state_time) / 0.4, 0.0, 1.0)
	var lantern := _lantern_position()
	_draw_window_glow(lantern, 1.0)
	# A faint yellow wash over the whole room.
	draw_rect(Rect2(-200, -200, 1680, 1120), Color(LANTERN, 0.12 * fade))
	# The beam: a wide fan from the window that sweeps across the floor.
	var sweep_x := lerpf(1100.0, 180.0, t) if _direction > 0.0 else lerpf(180.0, 1100.0, t)
	var points := PackedVector2Array([lantern + Vector2(-26, -10), lantern + Vector2(26, -10),
		Vector2(sweep_x + 260.0, 720.0), Vector2(sweep_x - 260.0, 720.0)])
	var bright := Color(1.0, 0.88, 0.5, 0.42 * fade)
	var dim := Color(1.0, 0.82, 0.4, 0.1 * fade)
	draw_polygon(points, PackedColorArray([bright, bright, dim, dim]))
	# A brighter pool of light where the beam lands.
	PlaceholderArt.draw_ellipse(self, Vector2(sweep_x, 650.0), 210.0, 50.0, Color(1.0, 0.9, 0.55, 0.16 * fade))
	PlaceholderArt.draw_ellipse(self, Vector2(sweep_x, 650.0), 120.0, 28.0, Color(1.0, 0.92, 0.6, 0.14 * fade))


## Hiding: the room goes dark and a heartbeat pulses at the edges of the screen.
func _draw_hiding() -> void:
	var fade_in := clampf(_state_time / 0.4, 0.0, 1.0)
	var fade_out_amount := clampf((hide_seconds - _state_time) / 0.5, 0.0, 1.0)
	var amount := fade_in * fade_out_amount
	draw_rect(Rect2(-200, -200, 1680, 1120), Color(0.0, 0.0, 0.02, 0.6 * amount))
	# Heartbeat: two quick pulses every beat (lub-dub).
	var beat := fmod(_time, heartbeat_seconds) / heartbeat_seconds
	var pulse := maxf(exp(-beat * 18.0), exp(-absf(beat - 0.22) * 18.0) * 0.7)
	var edge := Color(0.45, 0.02, 0.04, (0.25 + 0.35 * pulse) * amount)
	var clear := Color(0.45, 0.02, 0.04, 0.0)
	var band := 90.0 + 40.0 * pulse
	for side in [Rect2(0, 0, 1280, band), Rect2(0, 720 - band, 1280, band)]:
		var top := edge if side.position.y == 0.0 else clear
		var bottom := clear if side.position.y == 0.0 else edge
		draw_polygon(PackedVector2Array([side.position, Vector2(side.end.x, side.position.y), side.end, Vector2(side.position.x, side.end.y)]),
			PackedColorArray([top, top, bottom, bottom]))
	for side in [Rect2(0, 0, band, 720), Rect2(1280 - band, 0, band, 720)]:
		var left := edge if side.position.x == 0.0 else clear
		var right := clear if side.position.x == 0.0 else edge
		draw_polygon(PackedVector2Array([side.position, Vector2(side.end.x, side.position.y), side.end, Vector2(side.position.x, side.end.y)]),
			PackedColorArray([left, right, right, left]))
	# His lantern still glows faintly at the window as he stands there.
	if _state_time < hide_seconds - 1.5:
		_draw_window_glow(Vector2(window_rects[0].end.x + 20.0, window_rects[0].get_center().y + 30.0), 0.5)
