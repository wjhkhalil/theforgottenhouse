class_name FrostCover
extends Node2D
## House Two, Chapter Six (The Ice House): frost keeps creeping back over things.
## Every 12 to 18 seconds a white frosty patch forms over one or two of the
## objects lying about. A frosted object can't be picked up: the first click
## rubs the frost away, and then it can be collected as normal.
##
## HOW IT WORKS: a frosted object is told it can't be clicked
## (set_reachable(false)), and a small invisible click area is put on top of
## it. Clicking that area wipes the frost off (a short wipe animation), removes
## the area and makes the object clickable again. Containers never frost over.
##
## Place this node AFTER HiddenObjects in the scene, so the frost is drawn
## (and clicked) on top of the objects.

## Emitted to show a message (the room shows it in the notification popup).
signal notice(title: String, message: String, wrong_sound: bool)

## Shortest and longest wait between two frost spells (seconds).
@export var min_interval: float = 12.0
@export var max_interval: float = 18.0
## No more than this many objects are frosted at the same time.
@export var max_frosted: int = 4
## How long a new patch of frost takes to creep over an object.
@export var form_seconds: float = 1.2
## How long the wipe animation lasts.
@export var wipe_seconds: float = 0.5
## The full explanation is shown for this many wipes; after that a short one.
@export var full_messages: int = 3

## Seconds until the next frost spell (exposed for the automated test).
var seconds_until_frost: float = 15.0

var _active: bool = false
var _holding: bool = false
var _time: float = 0.0
var _wipes: int = 0
var _last_short_message: float = -100.0
var _told_about_frost: bool = false
var _rng := RandomNumberGenerator.new()
## One entry per frosted object: HiddenObject -> {"area": Area2D, "grow": 0..1, "seed": int}.
var _frosted: Dictionary = {}
## Patches being wiped away: [{"position", "rotation", "radius", "seed", "time"}].
var _wipes_playing: Array[Dictionary] = []
## The frost click area under the pointer (for the pointing-hand cursor).
var _hovered_area: Area2D = null


func _ready() -> void:
	add_to_group("room_effects")
	_rng.randomize()
	seconds_until_frost = _rng.randf_range(min_interval, max_interval)


## Called by the room when the player can start searching.
func start_effect() -> void:
	_active = true


## Called when the room is complete: all the frost melts and no more forms.
func fade_out() -> void:
	_active = false
	clear_all()


## Frosts one object straight away (also used by the test). Containers,
## hidden and collected objects are ignored.
func frost_object(obj: HiddenObject) -> void:
	if obj == null or _frosted.has(obj) or not _can_frost(obj):
		return
	_add_frost(obj, 1.0)


## True while `obj` is covered in frost and can't be picked up.
func is_frosted(obj: HiddenObject) -> bool:
	return _frosted.has(obj)


## Removes every patch of frost at once, without the wipe animation.
func clear_all() -> void:
	for obj: HiddenObject in _frosted.keys():
		_remove_frost(obj)
	_frosted.clear()
	queue_redraw()


## hold(true) = the safe state: all frost is cleared and no new frost forms
## (used by the test). hold(false) lets the frost creep back again.
func hold(enabled: bool) -> void:
	_holding = enabled
	if enabled:
		clear_all()
	else:
		seconds_until_frost = _rng.randf_range(min_interval, max_interval)


func _process(delta: float) -> void:
	_time += delta
	# Objects collected or hidden some other way lose their frost.
	for obj: HiddenObject in _frosted.keys():
		if not is_instance_valid(obj) or obj.is_collected or not obj.is_visible_in_tree():
			_remove_frost(obj)
			_frosted.erase(obj)
		else:
			_frosted[obj]["grow"] = minf(_frosted[obj]["grow"] + delta / form_seconds, 1.0)
	for i in range(_wipes_playing.size() - 1, -1, -1):
		_wipes_playing[i]["time"] += delta
		if _wipes_playing[i]["time"] >= wipe_seconds:
			_wipes_playing.remove_at(i)
	if _active and not _holding and not get_tree().paused:
		seconds_until_frost -= delta
		if seconds_until_frost <= 0.0:
			seconds_until_frost = _rng.randf_range(min_interval, max_interval)
			_frost_spell()
	queue_redraw()


## Frost forms on one or two random objects that are lying in plain view.
func _frost_spell() -> void:
	var candidates: Array[HiddenObject] = []
	for node in get_tree().get_nodes_in_group("hidden_objects"):
		var obj := node as HiddenObject
		if obj != null and not _frosted.has(obj) and _can_frost(obj):
			candidates.append(obj)
	candidates.shuffle()
	var count := mini(_rng.randi_range(1, 2), maxi(max_frosted - _frosted.size(), 0))
	for i in range(mini(count, candidates.size())):
		_add_frost(candidates[i], 0.0)
	if count > 0 and not candidates.is_empty() and not _told_about_frost:
		_told_about_frost = true
		notice.emit("The frost creeps back...", "Frost has formed over something. Click a frosted object once to rub it clean.", false)


func _can_frost(obj: HiddenObject) -> bool:
	return obj.is_visible_in_tree() and not obj.is_collected and obj.input_pickable


func _add_frost(obj: HiddenObject, grow: float) -> void:
	obj.set_reachable(false)
	# A small click area exactly over the object, on top of it.
	var area := Area2D.new()
	area.name = "Frost_" + String(obj.name)
	area.input_pickable = true
	var shape := RectangleShape2D.new()
	shape.size = _patch_size(obj)
	var collision := CollisionShape2D.new()
	collision.shape = shape
	area.add_child(collision)
	area.position = obj.global_position
	area.rotation = obj.global_rotation
	add_child(area)
	area.input_event.connect(_on_frost_clicked.bind(obj))
	area.mouse_entered.connect(_set_hovered_area.bind(area, true))
	area.mouse_exited.connect(_set_hovered_area.bind(area, false))
	_frosted[obj] = {"area": area, "grow": grow, "seed": _rng.randi()}
	queue_redraw()


## Takes the frost off `obj` and lets it be clicked again (does not erase it from _frosted).
func _remove_frost(obj: HiddenObject) -> void:
	var entry: Dictionary = _frosted[obj]
	var area: Area2D = entry["area"]
	if is_instance_valid(area):
		if area == _hovered_area:
			_set_hovered_area(area, false)
		area.queue_free()
	if is_instance_valid(obj):
		obj.set_reachable(true)


func _set_hovered_area(area: Area2D, hovered: bool) -> void:
	if hovered:
		_hovered_area = area
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	elif _hovered_area == area:
		_hovered_area = null
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)


## The size of the patch (and of its click area): the object's artwork, plus a margin.
func _patch_size(obj: HiddenObject) -> Vector2:
	var art := PlaceholderArt.get_style_size(obj.data.placeholder_style) if obj.data != null else Vector2(40, 40)
	return art * obj.global_scale.abs() + Vector2(12, 12)


func _on_frost_clicked(_viewport: Node, event: InputEvent, _shape_index: int, obj: HiddenObject) -> void:
	var click := event as InputEventMouseButton
	if click == null or not click.pressed or click.button_index != MOUSE_BUTTON_LEFT or get_tree().paused:
		return
	if not _frosted.has(obj):
		return
	get_viewport().set_input_as_handled()
	_wipe(obj)


## Rubs the frost off one object, with the wipe animation and a message.
func _wipe(obj: HiddenObject) -> void:
	var entry: Dictionary = _frosted[obj]
	var size := _patch_size(obj)
	_wipes_playing.append({"position": obj.global_position, "rotation": obj.global_rotation,
		"size": size, "seed": entry["seed"], "time": 0.0})
	_remove_frost(obj)
	_frosted.erase(obj)
	_wipes += 1
	AudioManager.play_sfx("click")
	if _wipes <= full_messages:
		notice.emit("Frosted over", "You rub the frost away. Now you can pick it up.", false)
	elif _time - _last_short_message > 20.0:
		# Later on, only a short reminder now and then.
		_last_short_message = _time
		notice.emit("Rubbed clean", "", false)


func _draw() -> void:
	for obj: HiddenObject in _frosted.keys():
		if not is_instance_valid(obj):
			continue
		var entry: Dictionary = _frosted[obj]
		draw_set_transform(obj.global_position, obj.global_rotation)
		_draw_patch(_patch_size(obj), entry["seed"], entry["grow"], 1.0)
	# Wiped patches fade out while a cloth-like streak sweeps across them.
	for wipe in _wipes_playing:
		var t: float = wipe["time"] / wipe_seconds
		var size: Vector2 = wipe["size"]
		draw_set_transform(wipe["position"], wipe["rotation"])
		_draw_patch(size, wipe["seed"], 1.0, 1.0 - t)
		var sweep_x := lerpf(-size.x * 0.6, size.x * 0.6, t)
		for i in range(3):
			var offset := (i - 1) * size.y * 0.25
			draw_line(Vector2(sweep_x - 6, -size.y * 0.4 + offset), Vector2(sweep_x + 6, size.y * 0.4 + offset),
				Color(1, 1, 1, 0.7 * (1.0 - t)), 3.0)
		# Flakes of rime flicked away
		var rng := RandomNumberGenerator.new()
		rng.seed = wipe["seed"]
		for i in range(8):
			var direction := Vector2.from_angle(rng.randf() * TAU)
			draw_circle(direction * (size.length() * 0.3 + t * 30.0), 1.8 * (1.0 - t) + 0.3, Color(1, 1, 1, 1.0 - t))
	draw_set_transform(Vector2.ZERO)


## A white, frosty patch with ice crystals, sized to cover an object.
## `grow` (0..1) is how far it has crept over; `alpha` fades it out when wiped.
func _draw_patch(size: Vector2, patch_seed: int, grow: float, alpha: float) -> void:
	var radius := size / 2.0 * (0.25 + 0.75 * grow)
	if radius.x < 3.0 or radius.y < 3.0 or alpha <= 0.0:
		return
	var rng := RandomNumberGenerator.new()
	rng.seed = patch_seed
	# The patch: a ragged blob (a star-shaped outline never crosses itself).
	var outline := PackedVector2Array()
	for i in range(18):
		var angle := TAU * i / 18.0
		var bump := rng.randf_range(0.85, 1.12)
		outline.append(Vector2(cos(angle) * radius.x * bump, sin(angle) * radius.y * bump))
	draw_colored_polygon(outline, Color(0.86, 0.93, 1.0, 0.72 * alpha))
	PlaceholderArt.draw_ellipse(self, Vector2.ZERO, radius.x * 0.7, radius.y * 0.65, Color(0.96, 0.98, 1.0, 0.4 * alpha))
	outline.append(outline[0])
	draw_polyline(outline, Color(1, 1, 1, 0.8 * alpha), 1.2, true)
	# Six-armed frost crystals scattered over it
	var crystal := Color(1, 1, 1, 0.95 * alpha)
	for i in range(int(3 + size.x / 18.0)):
		var at := Vector2(rng.randf_range(-0.6, 0.6) * radius.x, rng.randf_range(-0.6, 0.6) * radius.y)
		var arm := rng.randf_range(3.0, 6.0) * (0.4 + 0.6 * grow)
		for spoke in range(3):
			var direction := Vector2.from_angle(spoke * PI / 3.0 + 0.3) * arm
			draw_line(at - direction, at + direction, crystal, 1.0)
		draw_circle(at, 1.0, crystal)
	# Feathery ice fronds creeping in from the edge
	for i in range(4):
		var angle := rng.randf() * TAU
		var start := Vector2(cos(angle) * radius.x * 0.95, sin(angle) * radius.y * 0.95)
		var end := start * 0.45
		draw_line(start, end, Color(1, 1, 1, 0.6 * alpha), 1.0)
		var middle := start.lerp(end, 0.5)
		var side := (end - start).orthogonal().normalized() * 3.0
		draw_line(middle, middle + side + (end - start) * 0.15, Color(1, 1, 1, 0.5 * alpha), 0.8)
		draw_line(middle, middle - side + (end - start) * 0.15, Color(1, 1, 1, 0.5 * alpha), 0.8)
