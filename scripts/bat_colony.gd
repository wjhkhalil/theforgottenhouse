class_name BatColony
extends Node2D
## House Two, Chapter Three (The Loft): a colony of bats sleeps in the rafters.
## Careless clicking wakes them. The first click on an empty spot makes them
## stir; a second one soon after sends the whole colony swooping round the
## loft. While they fly, nothing can be picked up, until they settle again.
##
## HOW IT WORKS: an invisible "miss catcher" sits BEHIND the hidden objects,
## so it only gets a click when the click hits nothing else. A quick tap counts
## as a miss; a drag (looking around on a phone) does not. While the bats fly,
## a second invisible area IN FRONT of everything catches the clicks instead.
##
## Place this node AFTER HiddenObjects in the scene, so the bats fly in front of them.

## The first careless click: the bats rustle.
signal stirred
## The bats wake up and fly round the loft.
signal swarm_started
## The player clicked while the bats were flying.
signal click_blocked

## Where the bats hang (one bat per point).
@export var roosts: PackedVector2Array = PackedVector2Array([
	Vector2(206, 118), Vector2(240, 118), Vector2(470, 118), Vector2(504, 118), Vector2(538, 118),
	Vector2(742, 118), Vector2(776, 118), Vector2(900, 118), Vector2(934, 118), Vector2(968, 118),
])
## Empty-spot clicks needed to wake the colony.
@export var misses_to_wake: int = 2
## A miss older than this (seconds) is forgotten, and the bats doze off again.
@export var forget_seconds: float = 6.0
## How long the bats fly before they start to settle.
@export var swarm_seconds: float = 4.0
## How long they take to fly back to their roosts.
@export var settle_seconds: float = 1.5
## The area of the room the bats fly around in.
@export var flight_rect: Rect2 = Rect2(80, 60, 1120, 520)
## A tap that moves further than this (in screen pixels) is a drag, not a miss.
@export var tap_tolerance: float = 14.0

enum State { ROOSTING, SWARMING, SETTLING, GONE }

var state: State = State.ROOSTING
## Times (in seconds) of the recent careless clicks.
var _misses: Array[float] = []
var _active: bool = false
var _time: float = 0.0
var _state_time: float = 0.0
var _stir_time: float = -10.0
var _press_position: Vector2 = Vector2.INF
var _bat_positions: PackedVector2Array = PackedVector2Array()
var _miss_catcher: Area2D
var _blocker: Area2D


func _ready() -> void:
	add_to_group("room_effects")
	_bat_positions = roosts.duplicate()
	_blocker = _make_area(false)
	add_child(_blocker)
	_blocker.input_event.connect(_on_blocker_clicked)
	_miss_catcher = _make_area(true)
	_miss_catcher.input_event.connect(_on_empty_spot_input)
	# The miss catcher must sit BEHIND the hidden objects, so it goes into the
	# room just before them (the room is still being set up, so wait a moment).
	_add_miss_catcher.call_deferred()


func _make_area(pickable: bool) -> Area2D:
	var area := Area2D.new()
	area.input_pickable = pickable
	var shape := RectangleShape2D.new()
	shape.size = Vector2(4000, 4000)
	var collision := CollisionShape2D.new()
	collision.shape = shape
	area.add_child(collision)
	return area


func _add_miss_catcher() -> void:
	var room := get_parent()
	_miss_catcher.name = "BatMissCatcher"
	room.add_child(_miss_catcher)
	var hidden_objects := room.get_node_or_null("HiddenObjects")
	if hidden_objects != null:
		room.move_child(_miss_catcher, hidden_objects.get_index())


## Called by the room when the player can start searching.
func start_effect() -> void:
	_active = true


## Called when the room is complete: the bats fly out of the window for good.
func fade_out() -> void:
	_active = false
	_set_state(State.GONE)
	_blocker.input_pickable = false


func is_swarming() -> bool:
	return state == State.SWARMING or state == State.SETTLING


## Wakes the whole colony at once (also used by the test).
func wake() -> void:
	if state == State.GONE:
		return
	_misses.clear()
	_set_state(State.SWARMING)
	swarm_started.emit()


## Sends the bats straight back to sleep (used by the test).
func settle_now() -> void:
	if state == State.GONE:
		return
	_misses.clear()
	_set_state(State.ROOSTING)


## Counts one careless click. Returns true if it woke the bats.
func register_miss() -> bool:
	if not _active or state != State.ROOSTING:
		return false
	_forget_old_misses()
	_misses.append(_time)
	if _misses.size() >= misses_to_wake:
		wake()
		return true
	_stir_time = _time
	stirred.emit()
	return false


func _set_state(new_state: State) -> void:
	state = new_state
	_state_time = 0.0
	_blocker.input_pickable = new_state == State.SWARMING or new_state == State.SETTLING


func _forget_old_misses() -> void:
	while not _misses.is_empty() and _time - _misses[0] > forget_seconds:
		_misses.remove_at(0)


func _process(delta: float) -> void:
	_time += delta
	_state_time += delta
	if state == State.SWARMING and _state_time >= swarm_seconds:
		_set_state(State.SETTLING)
	elif state == State.SETTLING and _state_time >= settle_seconds:
		_set_state(State.ROOSTING)
	_update_bat_positions()
	queue_redraw()


func _update_bat_positions() -> void:
	for i in range(roosts.size()):
		var flying := _flight_position(i)
		match state:
			State.ROOSTING:
				_bat_positions[i] = roosts[i]
			State.SWARMING:
				# Fly out from the roost during the first half second.
				_bat_positions[i] = roosts[i].lerp(flying, clampf(_state_time / 0.5, 0.0, 1.0))
			State.SETTLING:
				_bat_positions[i] = flying.lerp(roosts[i], clampf(_state_time / settle_seconds, 0.0, 1.0))
			State.GONE:
				# Out through the round window and away.
				var window := Vector2(640, 250)
				var t := clampf(_state_time / 1.5, 0.0, 1.0)
				_bat_positions[i] = roosts[i].lerp(window, t)


## Each bat loops round its own figure of eight across the loft.
func _flight_position(i: int) -> Vector2:
	var speed := 0.9 + (i % 4) * 0.17
	var t := _time * speed + i * 1.7
	var centre := flight_rect.get_center()
	var reach := flight_rect.size * 0.45
	return centre + Vector2(sin(t) * reach.x, sin(t * 2.0 + i) * reach.y * 0.8)


func _input(event: InputEvent) -> void:
	# Every new press forgets the last one. (_input runs before the click reaches
	# any object, so if this press lands on the miss catcher, it is stored again
	# below.) Without this, pressing on an object that disappears when clicked
	# would leave its release to the miss catcher, paired with an old press.
	var click := event as InputEventMouseButton
	if click != null and click.pressed and click.button_index == MOUSE_BUTTON_LEFT:
		_press_position = Vector2.INF


## Clicks on empty parts of the room. A quick tap is a miss; a drag is not.
func _on_empty_spot_input(_viewport: Node, event: InputEvent, _shape_index: int) -> void:
	var click := event as InputEventMouseButton
	if click == null or click.button_index != MOUSE_BUTTON_LEFT or get_tree().paused:
		return
	if click.pressed:
		_press_position = click.position
	elif _press_position != Vector2.INF:
		if click.position.distance_to(_press_position) <= tap_tolerance:
			register_miss()
		_press_position = Vector2.INF


func _on_blocker_clicked(_viewport: Node, event: InputEvent, _shape_index: int) -> void:
	var click := event as InputEventMouseButton
	if click != null and click.pressed and click.button_index == MOUSE_BUTTON_LEFT and is_swarming():
		click_blocked.emit()


func _draw() -> void:
	if state == State.GONE and _state_time > 1.5:
		return
	# The swooping bats make the loft feel darker.
	if is_swarming():
		var shade := 0.3 if state == State.SWARMING else 0.3 * (1.0 - _state_time / settle_seconds)
		draw_rect(Rect2(-200, -200, 1680, 1120), Color(0, 0, 0, shade))
	for i in range(roosts.size()):
		if state == State.ROOSTING:
			# A rustle runs through the colony for a moment after a careless click.
			var shiver := sin(_time * 40.0 + i) * 2.0 if _time - _stir_time < 1.2 else 0.0
			draw_set_transform(_bat_positions[i] + Vector2(shiver, 0), 0.0, Vector2(1.3, 1.3))
			_draw_hanging_bat(Vector2.ZERO)
		else:
			draw_set_transform(_bat_positions[i], sin(_time * 3.0 + i) * 0.25, Vector2(1.8, 1.8))
			_draw_flying_bat(Vector2.ZERO, _time * 14.0 + i)
	draw_set_transform(Vector2.ZERO)


## A sleeping bat hanging upside down, wings folded.
func _draw_hanging_bat(at: Vector2) -> void:
	var body := Color(0.1, 0.08, 0.09)
	draw_line(at + Vector2(-2, -10), at + Vector2(-2, -14), body, 1.5)
	draw_line(at + Vector2(2, -10), at + Vector2(2, -14), body, 1.5)
	draw_colored_polygon(PackedVector2Array([at + Vector2(-6, -10), at + Vector2(6, -10), at + Vector2(5, 4),
		at + Vector2(0, 9), at + Vector2(-5, 4)]), body)
	# Ears at the bottom (it hangs upside down)
	draw_colored_polygon(PackedVector2Array([at + Vector2(-4, 6), at + Vector2(-5, 12), at + Vector2(-1, 8)]), body)
	draw_colored_polygon(PackedVector2Array([at + Vector2(4, 6), at + Vector2(5, 12), at + Vector2(1, 8)]), body)
	# A thin edge of moonlight down one side
	draw_line(at + Vector2(-5, -8), at + Vector2(-4, 4), Color(0.45, 0.48, 0.58, 0.8), 1.0)


## A bat in flight, wings flapping.
func _draw_flying_bat(at: Vector2, flap_phase: float) -> void:
	var body := Color(0.06, 0.05, 0.06)
	var flap := sin(flap_phase) * 9.0
	var colors := PackedColorArray([body, body, body])
	for side in [-1.0, 1.0]:
		# Each wing is two triangles (draw_primitive never fails, even mid-flap when they go flat).
		var root := at + Vector2(side * 3, -2)
		var elbow := at + Vector2(side * 12, -6 - flap)
		var tip := at + Vector2(side * 22, -2 - flap * 0.6)
		draw_primitive(PackedVector2Array([root, elbow, tip]), colors, PackedVector2Array())
		draw_primitive(PackedVector2Array([root, tip, at + Vector2(side * 10, 3)]), colors, PackedVector2Array())
	PlaceholderArt.draw_ellipse(self, at, 4, 6, body)
	draw_circle(at + Vector2(-1.5, -3), 0.8, Color(0.8, 0.3, 0.2))
	draw_circle(at + Vector2(1.5, -3), 0.8, Color(0.8, 0.3, 0.2))
