class_name WindGusts
extends Node2D
## House Two, Chapter Eight (The Lamp Room): the storm howls in through a
## smashed window pane. Every 10 to 14 seconds a gust comes. First there is a
## short warning (the pane rattles and rain sprays in), then the wind blows
## Agnes's LOOSE PAPERS across the room to new spots. A paper can't be caught
## while it is flying; once it lands it can be picked up as normal.
##
## HOW IT WORKS: a countdown picks the time of the next gust. When a gust
## blows, every paper that hasn't been collected gets a free landing spot (two
## papers never share a spot) and flies there along a curve, spinning. While
## it flies the paper is made unclickable (set_reachable), and a small
## invisible "catcher" area follows it, so a click on it explains why.
##
## Place this node AFTER HiddenObjects in the scene, so the wind is drawn on top
## and the catchers sit in front of the papers.

## Shown to the player (the room displays it): the warning, the first gust and
## clicks on a flying paper.
signal notice(title: String, message: String, wrong_sound: bool)

## The loose papers the wind can blow about (HiddenObjects).
@export var papers: Array[NodePath] = []
## Where a paper can land (room positions). Keep them in the free part of the
## room, away from the HUD, and have more spots than papers.
@export var landing_spots: PackedVector2Array = PackedVector2Array()
## The smashed window pane the wind comes in through (room rectangle).
@export var broken_pane: Rect2 = Rect2(14, 62, 150, 134)
## Shortest and longest wait between two gusts (seconds).
@export var min_gap_seconds: float = 10.0
@export var max_gap_seconds: float = 14.0
## How long the pane rattles before the gust arrives.
@export var warning_seconds: float = 1.5
## How long a paper takes to fly to its new spot.
@export var flight_seconds: float = 1.0

enum State { WAITING, WARNING, GUSTING, STOPPED }

var state: State = State.WAITING
var _active: bool = false
var _calm: bool = false
var _time: float = 0.0
## Seconds until the next warning starts (while WAITING), or until the gust (while WARNING).
var _countdown: float = 12.0
## How long the current gust has been blowing (for drawing the streaks).
var _gust_time: float = 0.0
var _gust_count: int = 0
var _last_blocked_notice: float = -10.0
var _rng := RandomNumberGenerator.new()
## Each paper's landing spot index (-1 = not on a spot yet).
var _spot_of: Dictionary = {}
## Papers in the air: paper -> its Tween.
var _flights: Dictionary = {}
## Papers in the air: paper -> where it will land.
var _targets: Dictionary = {}
## One invisible click catcher per paper: paper -> Area2D.
var _catchers: Dictionary = {}


func _ready() -> void:
	add_to_group("room_effects")
	_rng.randomize()
	_countdown = _rng.randf_range(min_gap_seconds, max_gap_seconds)
	for paper in get_papers():
		_spot_of[paper] = _nearest_spot(paper.global_position)
		var catcher := Area2D.new()
		catcher.input_pickable = false
		var shape := RectangleShape2D.new()
		shape.size = Vector2(70, 70)
		var collision := CollisionShape2D.new()
		collision.shape = shape
		catcher.add_child(collision)
		add_child(catcher)
		catcher.input_event.connect(_on_flying_paper_clicked)
		_catchers[paper] = catcher


## Called by the room when the player can start searching.
func start_effect() -> void:
	_active = true


## Called when the room is complete: the wind dies down and nothing is blocked any more.
func fade_out() -> void:
	_active = false
	_land_all_now()
	state = State.STOPPED


## The loose papers (only the ones that exist in the scene).
func get_papers() -> Array[HiddenObject]:
	var found: Array[HiddenObject] = []
	for path in papers:
		var paper := get_node_or_null(path) as HiddenObject
		if paper != null:
			found.append(paper)
	return found


## True while the wind is blowing and papers are in the air.
func is_gusting() -> bool:
	return state == State.GUSTING


## True during the short warning before a gust.
func is_warning() -> bool:
	return state == State.WARNING


## True while this paper is flying (it can't be picked up).
func is_flying(paper: HiddenObject) -> bool:
	return _flights.has(paper)


## TEST HELPER: blows a gust straight away, without the warning.
func gust_now() -> void:
	if state == State.STOPPED:
		return
	_blow()


## TEST HELPER: starts the 1.5-second warning straight away (the gust follows).
func warn_now() -> void:
	if state == State.STOPPED or state == State.GUSTING:
		return
	_start_warning()


## TEST HELPER: calm(true) stops all gusts (any paper in the air lands at once).
## This is the "safe" state: every paper can be collected with plain clicks.
## calm(false) lets the wind blow again.
func calm(enabled: bool) -> void:
	_calm = enabled
	if enabled:
		_land_all_now()
		if state != State.STOPPED:
			state = State.WAITING
	_countdown = _rng.randf_range(min_gap_seconds, max_gap_seconds)


func _process(delta: float) -> void:
	_time += delta
	match state:
		State.WAITING:
			if _active and not _calm:
				_countdown -= delta
				if _countdown <= 0.0:
					_start_warning()
		State.WARNING:
			_countdown -= delta
			if _countdown <= 0.0:
				_blow()
		State.GUSTING:
			_gust_time += delta
			if _flights.is_empty() and _gust_time >= flight_seconds + 0.4:
				state = State.WAITING
				_countdown = _rng.randf_range(min_gap_seconds, max_gap_seconds)
	# The catchers follow their papers through the air.
	for paper: HiddenObject in _flights:
		(_catchers[paper] as Area2D).global_position = paper.global_position
	queue_redraw()


func _start_warning() -> void:
	state = State.WARNING
	_countdown = warning_seconds
	notice.emit("A gust is coming!", "The broken window is rattling. The wind will blow Agnes's loose papers somewhere else.", false)
	AudioManager.play_sfx("click")


## The gust: every loose paper still lying about flies to a new free spot.
func _blow() -> void:
	state = State.GUSTING
	_gust_time = 0.0
	_gust_count += 1
	var moved := false
	for paper in get_papers():
		if paper.is_collected or not paper.visible or _flights.has(paper):
			continue
		var spot := _pick_free_spot(paper)
		if spot < 0:
			continue
		_spot_of[paper] = spot
		_fly(paper, landing_spots[spot])
		moved = true
	AudioManager.play_sfx("paper")
	if moved and _gust_count == 1:
		notice.emit("Whoosh!", "The wind blew Agnes's loose papers across the room. Look around: they have landed somewhere new.", false)


## A free landing spot for `paper`: not its own spot, and not taken by (or close to) another paper.
func _pick_free_spot(paper: HiddenObject) -> int:
	var free: Array[int] = []
	for i in range(landing_spots.size()):
		if i == _spot_of.get(paper, -1):
			continue
		var taken := false
		for other in get_papers():
			if other == paper or other.is_collected:
				continue
			var other_spot: Vector2 = _targets.get(other, other.global_position)
			if _spot_of.get(other, -1) == i or other_spot.distance_to(landing_spots[i]) < 40.0:
				taken = true
				break
		if not taken:
			free.append(i)
	if free.is_empty():
		return -1
	return free[_rng.randi_range(0, free.size() - 1)]


## Sends one paper on a curving, spinning flight to `target`.
func _fly(paper: HiddenObject, target: Vector2) -> void:
	paper.set_reachable(false)
	var start := paper.global_position
	# The curve bulges up and away from the straight line, as if lifted by the wind.
	var middle := start.lerp(target, 0.5)
	var side := (target - start).orthogonal().normalized()
	if side.y > 0.0:
		side = -side
	var control := middle + side * clampf(start.distance_to(target) * 0.4, 60.0, 180.0)
	var start_rotation := paper.rotation
	var end_rotation := _rng.randf_range(-0.6, 0.6)
	var turns := TAU * (1.0 if _rng.randf() < 0.5 else -1.0) * _rng.randi_range(1, 2)
	var tween := create_tween()
	tween.tween_method(_fly_step.bind(paper, start, control, target, start_rotation, end_rotation + turns), 0.0, 1.0,
			flight_seconds).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_callback(_land.bind(paper))
	_flights[paper] = tween
	_targets[paper] = target
	(_catchers[paper] as Area2D).global_position = start
	(_catchers[paper] as Area2D).input_pickable = true


## One step of a flight: a point `t` (0 to 1) along a curve from `start` to `target`.
func _fly_step(t: float, paper: HiddenObject, start: Vector2, control: Vector2, target: Vector2,
		start_rotation: float, end_rotation: float) -> void:
	var a := start.lerp(control, t)
	var b := control.lerp(target, t)
	paper.global_position = a.lerp(b, t)
	paper.rotation = lerpf(start_rotation, end_rotation, t)


## A paper has landed: it can be picked up again.
func _land(paper: HiddenObject) -> void:
	if _targets.has(paper):
		paper.global_position = _targets[paper]
	paper.rotation = wrapf(paper.rotation, -PI, PI)
	_flights.erase(paper)
	_targets.erase(paper)
	(_catchers[paper] as Area2D).input_pickable = false
	if not paper.is_collected:
		paper.set_reachable(true)


## Ends every flight at once (calm and fade_out): each paper drops on its spot.
func _land_all_now() -> void:
	for paper: HiddenObject in _flights.keys():
		(_flights[paper] as Tween).kill()
		_land(paper)


func _nearest_spot(at: Vector2) -> int:
	for i in range(landing_spots.size()):
		if landing_spots[i].distance_to(at) < 8.0:
			return i
	return -1


func _on_flying_paper_clicked(_viewport: Node, event: InputEvent, _shape_index: int) -> void:
	var click := event as InputEventMouseButton
	if click == null or not click.pressed or click.button_index != MOUSE_BUTTON_LEFT:
		return
	if _time - _last_blocked_notice < 2.5:
		return  # Don't repeat the same message on every click.
	_last_blocked_notice = _time
	notice.emit("It's blowing away!", "You can't catch a paper in the wind. Wait for it to land, then pick it up.", true)


func _draw() -> void:
	if state == State.STOPPED:
		return
	var pane := broken_pane
	var gusting := state == State.GUSTING and _gust_time < flight_seconds + 0.4
	var warning := state == State.WARNING
	# A little drizzle always blows in through the hole; much more just before a gust.
	var drops := 30 if warning or gusting else 6
	for i in range(drops):
		var t := fmod(i * 0.137 + _time * (2.2 if warning or gusting else 0.8), 1.0)
		var start := Vector2(pane.position.x + fmod(i * 37.0, pane.size.x), pane.position.y + fmod(i * 53.0, pane.size.y))
		var at := start + Vector2(t * 120.0, t * 60.0)
		draw_line(at, at + Vector2(10, 7), Color(0.8, 0.88, 1.0, 0.55 * (1.0 - t)), 1.5)
	if warning:
		# The frame rattles: shaking marks round the pane and loose shards jiggling.
		var shake := sin(_time * 60.0) * 3.0
		for i in range(6):
			var y := pane.position.y + 12.0 + i * 22.0
			draw_line(Vector2(pane.end.x + 12 + shake, y), Vector2(pane.end.x + 22 + shake, y - 4), Color(1, 1, 1, 0.7), 2.0)
			draw_line(Vector2(pane.position.x - 4 - shake, y), Vector2(pane.position.x - 12 - shake, y - 4), Color(1, 1, 1, 0.5), 2.0)
		var shard := pane.position + Vector2(pane.size.x - 28 + shake, 26)
		draw_primitive(PackedVector2Array([shard, shard + Vector2(14, 4), shard + Vector2(4, 18)]),
			PackedColorArray([Color(0.9, 0.95, 1, 0.8), Color(0.9, 0.95, 1, 0.8), Color(0.9, 0.95, 1, 0.8)]), PackedVector2Array())
	if gusting:
		# Long streaks of wind pouring out of the pane and sweeping across the room.
		var strength := clampf(1.0 - _gust_time / (flight_seconds + 0.4), 0.0, 1.0)
		for i in range(16):
			# Each streak follows its own lane, fanning out from the pane down across the room.
			var slope := 0.04 + (i % 8) * 0.07
			var progress := fmod(_gust_time * 1.4 + i * 0.29, 1.0)
			var start := pane.get_center() + Vector2(0, (i % 5 - 2) * 18.0)
			var head := start + Vector2(progress * 1000.0, progress * 1000.0 * slope)
			var points := PackedVector2Array()
			for step in range(10):
				var back := float(step) * 26.0
				points.append(head - Vector2(back, back * slope) + Vector2(0, sin(head.x * 0.015 + step * 0.8) * 6.0))
			draw_polyline(points, Color(0.92, 0.96, 1.0, 0.6 * strength), 3.0, true)
			draw_polyline(points, Color(1, 1, 1, 0.5 * strength), 1.0, true)
