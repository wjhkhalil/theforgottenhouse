class_name SteamValves
extends Node2D
## House Three, Chapter Four (The Boiler Room): three jets of scalding steam
## hiss down from the overhead pipes. Nothing inside a jet can be touched.
##
## Each jet has a red valve wheel beside it. Clicking a wheel shuts its jet
## (click again to open it). But the old boiler will only stand `max_shut`
## jets shut at once: shut one more, and the one that has been shut longest
## blows open again. The player has to choose which part of the room to clear.
##
## HOW IT WORKS: every jet is a rectangle (`jet_zones`). While a jet is open, an
## invisible click area the size of its zone catches every click there, so the
## objects and containers behind it never get them. This node comes AFTER
## HiddenObjects in the scene, so those areas (and the valve wheels) sit on top.
##
## Place this node AFTER HiddenObjects and RoomForeground in the scene.

## Shown by the room as a notification (see room_level.gd).
signal notice(title: String, message: String, wrong_sound: bool)

## The part of the room each jet fills (room coordinates).
@export var jet_zones: Array[Rect2] = [Rect2(60, 100, 240, 460), Rect2(370, 100, 240, 460), Rect2(680, 100, 240, 460)]
## Where each jet's valve wheel is (same order as `jet_zones`).
@export var valve_positions: PackedVector2Array = PackedVector2Array([Vector2(335, 300), Vector2(645, 300), Vector2(955, 300)])
## How many jets may be shut at the same time.
@export var max_shut: int = 2
## Radius of a valve wheel (and of its click area).
@export var valve_radius: float = 24.0
## Seconds before the same "scalding steam" message may be shown again.
@export var notice_cooldown: float = 2.5

const STEAM := Color(0.92, 0.94, 0.96)
const VALVE_RED := Color(0.72, 0.12, 0.1)
const PUFFS_PER_JET := 22

var _shut: Array[bool] = []
## The jets that are shut, oldest first.
var _shut_order: Array[int] = []
## How hard each jet is blowing: 1 = full, 0 = shut (animated for the drawing).
var _strength: Array[float] = []
## How far each wheel is turned (animated for the drawing).
var _wheel_turn: Array[float] = []
## True while the test holds every jet shut.
var _all_shut: bool = false
## True once the room is complete: the boiler is let down and the steam stops.
var _faded: bool = false
var _time: float = 0.0
var _last_notice_time: float = -100.0
var _blockers: Array[Area2D] = []


func _ready() -> void:
	add_to_group("room_effects")
	for i in range(jet_zones.size()):
		_shut.append(false)
		_strength.append(1.0)
		_wheel_turn.append(0.0)
		var blocker := Area2D.new()
		blocker.name = "Jet%d" % i
		var shape := RectangleShape2D.new()
		shape.size = jet_zones[i].size
		var collision := CollisionShape2D.new()
		collision.shape = shape
		blocker.add_child(collision)
		add_child(blocker)
		blocker.position = jet_zones[i].get_center()
		blocker.input_event.connect(_on_steam_clicked)
		_blockers.append(blocker)
	# The wheels are added after the jets, so they are on top for clicks.
	for i in range(mini(valve_positions.size(), jet_zones.size())):
		var valve := Area2D.new()
		valve.name = "Valve%d" % i
		var circle := CircleShape2D.new()
		circle.radius = valve_radius
		var collision := CollisionShape2D.new()
		collision.shape = circle
		valve.add_child(collision)
		add_child(valve)
		valve.position = valve_positions[i]
		valve.input_event.connect(_on_valve_clicked.bind(i))
	_update_jets()


## Called when the room is complete: the steam dies away and nothing is blocked.
func fade_out() -> void:
	_faded = true
	_update_jets()


# ---------------------------------------------------------------------------
# Helpers (also used by the automated test)
# ---------------------------------------------------------------------------

func jet_count() -> int:
	return jet_zones.size()


## True while jet `index` is shut off.
func is_shut(index: int) -> bool:
	return _all_shut or _faded or (index >= 0 and index < _shut.size() and _shut[index])


## Where valve wheel `index` is (room position).
func get_valve_position(index: int) -> Vector2:
	return to_global(valve_positions[index])


## True if `world_position` is inside a jet that is blowing right now.
func is_in_steam(world_position: Vector2) -> bool:
	var local := to_local(world_position)
	for i in range(jet_zones.size()):
		if not is_shut(i) and jet_zones[i].has_point(local):
			return true
	return false


## Turns valve wheel `index`: shuts its jet if it is open, opens it if it is shut.
func turn_valve(index: int) -> void:
	if index < 0 or index >= _shut.size() or _faded:
		return
	AudioManager.play_sfx("click")
	if _shut[index]:
		_shut[index] = false
		_shut_order.erase(index)
	else:
		if _shut_order.size() >= max_shut:
			# Too much pressure: the jet that has been shut longest blows open again.
			var blown: int = _shut_order.pop_front()
			_shut[blown] = false
			notice.emit("The boiler groans!", "It will only stand %d jets shut at once. The first one you shut has blown open again." % max_shut, true)
		_shut[index] = true
		_shut_order.append(index)
	_update_jets()


## The test's "safe" state: every jet is shut, whatever the boiler thinks of it.
func shut_everything(enabled: bool) -> void:
	_all_shut = enabled
	_update_jets()


func _process(delta: float) -> void:
	_time += delta
	for i in range(_strength.size()):
		_strength[i] = move_toward(_strength[i], 0.0 if is_shut(i) else 1.0, delta * 2.5)
		_wheel_turn[i] = move_toward(_wheel_turn[i], 1.0 if (_shut[i] or _all_shut) else 0.0, delta * 3.0)
	queue_redraw()


func _update_jets() -> void:
	for i in range(_blockers.size()):
		_blockers[i].input_pickable = not is_shut(i)


func _on_valve_clicked(_viewport: Node, event: InputEvent, _shape_index: int, index: int) -> void:
	var click := event as InputEventMouseButton
	if click == null or not click.pressed or click.button_index != MOUSE_BUTTON_LEFT or get_tree().paused:
		return
	turn_valve(index)


func _on_steam_clicked(_viewport: Node, event: InputEvent, _shape_index: int) -> void:
	var click := event as InputEventMouseButton
	if click == null or not click.pressed or click.button_index != MOUSE_BUTTON_LEFT or get_tree().paused:
		return
	# Don't repeat the same message over and over.
	if _time - _last_notice_time < notice_cooldown:
		return
	_last_notice_time = _time
	notice.emit("Scalding steam!", "You can't reach through the jet. Shut it with the red valve wheel beside it.", true)


func _draw() -> void:
	for i in range(jet_zones.size()):
		if _strength[i] > 0.01:
			_draw_jet(jet_zones[i], _strength[i], i)
	for i in range(mini(valve_positions.size(), jet_zones.size())):
		_draw_valve(valve_positions[i], _wheel_turn[i], is_shut(i))


## A jet: a white haze over its whole zone, with puffs rolling down from the nozzle.
func _draw_jet(zone: Rect2, strength: float, index: int) -> void:
	draw_rect(zone, Color(STEAM, 0.3 * strength))
	# A hard white cone straight under the nozzle
	var nozzle := Vector2(zone.get_center().x, zone.position.y)
	draw_colored_polygon(PackedVector2Array([nozzle + Vector2(-8, 0), nozzle + Vector2(8, 0),
		nozzle + Vector2(zone.size.x * 0.42, zone.size.y * 0.55), nozzle + Vector2(-zone.size.x * 0.42, zone.size.y * 0.55)]),
		Color(STEAM, 0.22 * strength))
	var rng := RandomNumberGenerator.new()
	rng.seed = 400 + index
	for puff in range(PUFFS_PER_JET):
		var fall := fposmod(rng.randf() + _time * rng.randf_range(0.18, 0.34), 1.0)
		var spread := lerpf(0.08, 0.5, fall)
		var x := zone.get_center().x + (rng.randf() * 2.0 - 1.0) * zone.size.x * spread
		var y := zone.position.y + fall * zone.size.y
		var radius := lerpf(16.0, 52.0, fall) * rng.randf_range(0.7, 1.2)
		x = clampf(x, zone.position.x + radius * 0.6, zone.end.x - radius * 0.6)
		draw_circle(Vector2(x, y), radius, Color(STEAM, 0.16 * strength * (1.0 - fall * 0.5)))


## A red hand wheel on a pipe stub. Shut = turned a quarter round, with a green tag.
func _draw_valve(at: Vector2, turn: float, shut: bool) -> void:
	draw_circle(at, valve_radius + 3.0, Color(0, 0, 0, 0.35))
	draw_arc(at, valve_radius - 3.0, 0.0, TAU, 32, VALVE_RED, 6.0, true)
	for spoke in range(4):
		var direction := Vector2.from_angle(turn * PI * 0.75 + spoke * PI / 2.0)
		draw_line(at - direction * 3.0, at + direction * (valve_radius - 4.0), VALVE_RED.darkened(0.15), 4.0)
	draw_circle(at, 5.0, Color(0.75, 0.6, 0.3))
	draw_arc(at, valve_radius - 3.0, -2.5, -1.4, 8, Color(1, 1, 1, 0.45), 2.0, true)
	# A little tag under the wheel says which way it is.
	var tag := Rect2(at.x - 19, at.y + valve_radius + 5, 38, 13)
	draw_rect(tag, Color(0.2, 0.5, 0.25) if shut else Color(0.15, 0.13, 0.12))
	var text := "SHUT" if shut else "OPEN"
	var font := ThemeDB.fallback_font
	var width := font.get_string_size(text, HORIZONTAL_ALIGNMENT_LEFT, -1, 9).x
	draw_string(font, Vector2(at.x - width / 2.0, tag.position.y + 10), text, HORIZONTAL_ALIGNMENT_LEFT, -1, 9, Color(0.95, 0.92, 0.8))
