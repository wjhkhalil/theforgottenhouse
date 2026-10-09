class_name AirSupply
extends Node2D
## House Two, Chapter Five (The Sunken Boat): you are diving down to the wreck,
## and you can only hold so much air. An air gauge at the bottom of the screen
## slowly empties while you search. When it runs out you must kick up to the
## surface for a breath: for a few seconds the screen fades to dark water and
## nothing can be picked up. Then the air is full again and you dive back down.
##
## HOW IT WORKS: every frame the air goes down a little (unless the game is
## paused, the keypad is open, or the test has called hold(true)). At zero we
## start "surfacing": every hidden object and container is told it can't be
## clicked (set_reachable(false)), and an invisible area in front of
## everything catches clicks so we can explain why. After surface_seconds the
## air refills and everything can be clicked again.
## This node also draws the drifting specks and rising bubbles of the lake.
##
## Place this node AFTER HiddenObjects and RoomForeground (and before the
## LanternDarkness), so the dark-water fade covers the objects.

## Emitted to show a message (the room shows it in the notification popup).
signal notice(title: String, message: String, wrong_sound: bool)

## Seconds of searching a full breath lasts.
@export var drain_seconds: float = 45.0
## When the air falls to this fraction, the player is warned.
@export var low_fraction: float = 0.25
## How long the trip up to the surface and back takes (nothing can be clicked meanwhile).
@export var surface_seconds: float = 4.0
## The colour the screen fades to while you are up at the surface.
@export var surface_color: Color = Color(0.02, 0.07, 0.08, 1.0)
## Where bubbles rise from (the wreck still breathes out trapped air).
@export var bubble_sources: PackedVector2Array = PackedVector2Array([
	Vector2(232, 450), Vector2(640, 196), Vector2(700, 600), Vector2(930, 330),
])

## How full the air gauge is, 1.0 = full, 0.0 = empty.
var _air: float = 1.0
var _active: bool = false
var _holding: bool = false
var _surfacing: bool = false
var _surface_time: float = 0.0
var _warned_low: bool = false
var _time: float = 0.0
var _last_blocked_notice: float = -10.0
## 0 = no fade, 1 = the screen is all dark water.
var _fade: float = 0.0
var _blocker: Area2D
var _gauge: Control


func _ready() -> void:
	add_to_group("room_effects")
	# An invisible area in front of everything: it only catches clicks while surfacing.
	_blocker = Area2D.new()
	_blocker.input_pickable = false
	var shape := RectangleShape2D.new()
	shape.size = Vector2(4000, 4000)
	var collision := CollisionShape2D.new()
	collision.shape = shape
	_blocker.add_child(collision)
	add_child(_blocker)
	_blocker.input_event.connect(_on_blocker_clicked)
	_build_gauge()


## The air gauge sits in its own CanvasLayer, so it stays put when the camera zooms.
## It is bottom centre: clear of the zoom buttons (bottom left) and the object list (right).
func _build_gauge() -> void:
	var layer := CanvasLayer.new()
	layer.name = "AirGaugeLayer"
	layer.layer = 4  # above the HUD (1), below the notification popup (5) and the keypad
	add_child(layer)
	_gauge = Control.new()
	_gauge.name = "AirGauge"
	_gauge.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_gauge.set_anchors_preset(Control.PRESET_CENTER_BOTTOM)
	_gauge.offset_left = -150.0
	_gauge.offset_right = 150.0
	_gauge.offset_top = -50.0
	_gauge.offset_bottom = -10.0
	layer.add_child(_gauge)
	_gauge.draw.connect(_draw_gauge)


## Called by the room when the player can start searching.
func start_effect() -> void:
	_active = true


## Called when the room is complete: no more diving trips, nothing is blocked.
func fade_out() -> void:
	_active = false
	if _surfacing:
		_finish_surfacing(false)
	_air = 1.0
	_gauge.queue_redraw()
	create_tween().tween_property(_gauge, "modulate:a", 0.0, 1.5)


# ---------------------------------------------------------------------------
# Test helpers
# ---------------------------------------------------------------------------

## Sets how full the air is (0.0 to 1.0). At 0.0 you run out on the next frame,
## unless hold(true) is on. Setting it above the warning level re-arms the warning.
func set_air(fraction: float) -> void:
	_air = clampf(fraction, 0.0, 1.0)
	if _air > low_fraction:
		_warned_low = false
	_gauge.queue_redraw()


## Fills the air right up. If you were up at the surface, you come straight back down.
func refill() -> void:
	if _surfacing:
		_finish_surfacing(false)
	set_air(1.0)


## True while you are up at the surface catching your breath (nothing can be clicked).
func is_surfacing() -> bool:
	return _surfacing


## How full the air is, from 0.0 (empty) to 1.0 (full).
func get_air() -> float:
	return _air


## hold(true) = the SAFE state: the air is refilled and never drains, so every
## visible object can be collected with plain clicks. hold(false) = normal diving.
func hold(enabled: bool) -> void:
	_holding = enabled
	if enabled:
		refill()


# ---------------------------------------------------------------------------

func _process(delta: float) -> void:
	_time += delta
	if _active and not get_tree().paused:
		if _surfacing:
			_surface_time += delta
			_block_everything()
			if _surface_time >= surface_seconds:
				_finish_surfacing(true)
		elif not _holding and not _keypad_is_open():
			_air = maxf(_air - delta / drain_seconds, 0.0)
			if _air <= low_fraction and not _warned_low:
				_warned_low = true
				notice.emit("Running low on air!", "Your air gauge is nearly empty. Soon you'll have to swim up for a breath.", true)
			if _air <= 0.0:
				_start_surfacing()
	_update_fade()
	queue_redraw()
	_gauge.queue_redraw()


## Reading a code on the keypad takes no air: the clock stops while it is open.
func _keypad_is_open() -> bool:
	var keypad := get_parent().get_node_or_null("KeypadLock")
	return keypad != null and keypad.has_method("is_open") and keypad.call("is_open")


func _start_surfacing() -> void:
	_surfacing = true
	_surface_time = 0.0
	_block_everything()
	_blocker.input_pickable = true
	notice.emit("Out of air!", "You kick up to the surface for a breath...", true)


func _finish_surfacing(announce: bool) -> void:
	_surfacing = false
	_surface_time = 0.0
	_air = 1.0
	_warned_low = false
	_blocker.input_pickable = false
	for area in _clickables():
		area.call("set_reachable", true)
	if announce:
		notice.emit("A deep breath", "Your lungs are full again. You dive back down to the wreck.", false)


## While surfacing, nothing in the wreck can be clicked. (Called every frame,
## so even an object that appears meanwhile stays out of reach.)
func _block_everything() -> void:
	for area in _clickables():
		area.call("set_reachable", false)


func _clickables() -> Array[Node]:
	var found: Array[Node] = []
	for node in get_tree().get_nodes_in_group("hidden_objects"):
		if node.has_method("set_reachable"):
			found.append(node)
	for node in get_parent().find_children("*", "OpenableContainer", true, false):
		found.append(node)
	return found


## The fade to dark water: in over the first half second, out over the last.
func _update_fade() -> void:
	if not _surfacing:
		_fade = maxf(_fade - get_process_delta_time() * 2.0, 0.0)
		return
	var fade_in := clampf(_surface_time / 0.5, 0.0, 1.0)
	var fade_back := clampf((surface_seconds - _surface_time) / 0.6, 0.0, 1.0)
	_fade = minf(fade_in, fade_back)


func _on_blocker_clicked(_viewport: Node, event: InputEvent, _shape_index: int) -> void:
	var click := event as InputEventMouseButton
	if click == null or not click.pressed or click.button_index != MOUSE_BUTTON_LEFT or not _surfacing:
		return
	# Don't repeat the message on every click.
	if _time - _last_blocked_notice < 2.5:
		return
	_last_blocked_notice = _time
	notice.emit("You're at the surface", "Catch your breath. You'll dive back down in a moment.", false)


# ---------------------------------------------------------------------------
# Drawing
# ---------------------------------------------------------------------------

func _draw() -> void:
	_draw_specks()
	if _fade > 0.0:
		draw_rect(Rect2(-2000, -2000, 5280, 4720), Color(surface_color, surface_color.a * _fade))
	_draw_bubbles()


## Tiny specks of silt drifting slowly through the water.
func _draw_specks() -> void:
	for i in range(70):
		# Each speck has its own fixed start point and drift speed (from its index).
		var base := Vector2(fmod(i * 197.3, 1280.0), fmod(i * 131.7, 680.0) + 40.0)
		var drift := Vector2(fmod(_time * (4.0 + i % 5), 1280.0), sin(_time * 0.4 + i) * 10.0 - fmod(_time * (1.0 + i % 3), 60.0))
		var at := Vector2(fmod(base.x + drift.x, 1280.0), base.y + drift.y)
		var alpha := 0.18 + 0.12 * sin(_time * 0.8 + i * 1.3)
		draw_circle(at, 1.0 + (i % 3) * 0.5, Color(0.75, 0.8, 0.65, alpha))


## Strings of bubbles rising and wobbling. While surfacing, a rush of your own bubbles.
func _draw_bubbles() -> void:
	for s in range(bubble_sources.size()):
		for b in range(5):
			var t := fmod(_time * 0.25 + b * 0.2 + s * 0.37, 1.0)
			var at := bubble_sources[s] + Vector2(sin(_time * 3.0 + b * 2.0 + s) * 5.0 * t, -t * 260.0)
			var radius := 1.5 + b % 3 + t * 1.5
			draw_arc(at, radius, 0, TAU, 10, Color(0.8, 0.95, 0.95, 0.5 * (1.0 - t)), 1.0)
			draw_circle(at + Vector2(-radius * 0.35, -radius * 0.35), radius * 0.3, Color(1, 1, 1, 0.4 * (1.0 - t)))
	if _fade > 0.0:
		for b in range(30):
			var t := fmod(_time * 0.9 + b * 0.033, 1.0)
			var at := Vector2(640 + sin(b * 7.1) * 260.0 + sin(_time * 4.0 + b) * 8.0, 720.0 - t * 760.0)
			var radius := 3.0 + (b % 4) * 2.0
			draw_arc(at, radius, 0, TAU, 12, Color(0.8, 0.95, 0.95, 0.6 * _fade), 1.5)


## The air gauge: a little panel with a bar that empties from right to left.
func _draw_gauge() -> void:
	var rect := Rect2(Vector2.ZERO, _gauge.size)
	var font := ThemeDB.fallback_font
	var box := StyleBoxFlat.new()
	box.bg_color = Color(0.04, 0.08, 0.1, 0.82)
	box.border_color = Color(0.45, 0.62, 0.62, 0.9)
	box.set_border_width_all(2)
	box.set_corner_radius_all(8)
	_gauge.draw_style_box(box, rect)
	_gauge.draw_string(font, Vector2(12, 26), "AIR", HORIZONTAL_ALIGNMENT_LEFT, -1, 16, Color(0.85, 0.95, 0.95))
	var bar := Rect2(52, 11, rect.size.x - 64, rect.size.y - 22)
	_gauge.draw_rect(bar, Color(0.02, 0.04, 0.05))
	if _surfacing:
		# Refilling as you breathe at the surface
		var refill_amount := clampf(_surface_time / surface_seconds, 0.0, 1.0)
		_gauge.draw_rect(Rect2(bar.position, Vector2(bar.size.x * refill_amount, bar.size.y)), Color(0.35, 0.6, 0.75))
		_gauge.draw_string(font, bar.position + Vector2(8, 14), "Surfacing for air...", HORIZONTAL_ALIGNMENT_LEFT, -1, 13,
			Color(1, 1, 1, 0.9))
	else:
		var color := Color(0.45, 0.85, 0.9)
		if _air <= low_fraction:
			# Low air: the bar turns red and pulses.
			color = Color(0.95, 0.35, 0.3).lerp(Color(1, 0.7, 0.4), 0.5 + 0.5 * sin(_time * 8.0))
		elif _air <= 0.5:
			color = Color(0.9, 0.78, 0.4)
		_gauge.draw_rect(Rect2(bar.position, Vector2(bar.size.x * _air, bar.size.y)), color)
		# Tick marks every quarter
		for i in range(1, 4):
			var x := bar.position.x + bar.size.x * i / 4.0
			_gauge.draw_line(Vector2(x, bar.position.y), Vector2(x, bar.end.y), Color(0, 0, 0, 0.5), 1.0)
	_gauge.draw_rect(bar, Color(0.6, 0.75, 0.75, 0.6), false, 1.0)
