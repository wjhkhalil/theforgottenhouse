class_name TornPieces
extends Node2D
## House Two, Chapter Four (The Workshop): Vane tore up the Lady Margaret's hull
## plan and threw the pieces around the workshop. The plan itself (a hidden
## object that starts invisible) can only be found by collecting the four torn
## scraps first. When the last scrap is picked up, the pieces fly to the
## workbench and join up, the plan appears there and is collected by itself.
##
## HOW IT WORKS: each scrap is a small clickable Area2D made by this node. This
## node sits AFTER HiddenObjects in the scene, so the scraps are on top for
## clicks (and are drawn on top of the room, under the foreground art). While
## the plan is still missing, its hint_anchor points at the next scrap, so the
## Hint button leads the player from scrap to scrap.
##
## Place this node AFTER HiddenObjects in the scene.

## Shown by the room as a notification (connected automatically).
signal notice(title: String, message: String, wrong_sound: bool)

## The hidden object that appears when every scrap is found (the hull plan).
@export var hull_plan: HiddenObject
## Where the scraps lie in the room (one scrap per point).
@export var piece_positions: PackedVector2Array = PackedVector2Array([
	Vector2(468, 694), Vector2(222, 482), Vector2(706, 600), Vector2(452, 300),
])
## How each scrap is turned (radians), one value per scrap.
@export var piece_rotations: PackedFloat32Array = PackedFloat32Array([0.4, -0.6, 2.6, 0.15])
## How big the scraps are drawn (1.0 = the size they have inside the finished plan).
@export var piece_scale: float = 0.85
## How long the pieces take to fly to the workbench and join up.
@export var assemble_seconds: float = 1.4

## Extra pixels around a scrap that still count as a click.
const CLICK_PADDING := 6.0

var _pieces: Array[Area2D] = []
var _found: Array[bool] = []
## 0..1 while a scrap's little "picked up" effect plays, -1 when not playing.
var _pop: Array[float] = []
## 0..1 while the pieces fly together; -1 before, 2 when finished.
var _assemble: float = -1.0
var _active: bool = false


func _ready() -> void:
	add_to_group("room_effects")
	var piece_size := WorkshopObjects.HULL_PLAN_SIZE / 2.0 * piece_scale
	for i in range(piece_positions.size()):
		var area := Area2D.new()
		area.name = "TornPiece%d" % (i + 1)
		area.position = piece_positions[i]
		area.rotation = piece_rotations[i] if i < piece_rotations.size() else 0.0
		area.input_pickable = true
		var shape := RectangleShape2D.new()
		shape.size = piece_size + Vector2(CLICK_PADDING, CLICK_PADDING) * 2.0
		var collision := CollisionShape2D.new()
		collision.shape = shape
		area.add_child(collision)
		add_child(area)
		area.input_event.connect(_on_piece_input.bind(i))
		area.mouse_entered.connect(_on_piece_hovered.bind(true))
		area.mouse_exited.connect(_on_piece_hovered.bind(false))
		_pieces.append(area)
		_found.append(false)
		_pop.append(-1.0)
	_update_hint_anchor()


## Called by the room when the player can start searching. A saved game in
## which the plan was already found must not show the scraps again.
func start_effect() -> void:
	_active = true
	if hull_plan != null and hull_plan.is_collected:
		for i in range(_pieces.size()):
			_found[i] = true
			_pieces[i].input_pickable = false
		_assemble = 2.0
		_update_hint_anchor()
	queue_redraw()


## Called when the room is complete: nothing can be clicked any more.
func fade_out() -> void:
	_active = false
	for piece in _pieces:
		piece.input_pickable = false


## The clickable scraps, in order (used by the test).
func get_pieces() -> Array[Area2D]:
	return _pieces


## How many scraps the player has picked up so far.
func collected_count() -> int:
	return _found.count(true)


## True once all the scraps were found and the plan has joined up on the bench.
func is_assembled() -> bool:
	return _assemble >= 1.0


## The next scrap still lying in the room, or null when every scrap is found.
func get_next_piece() -> Area2D:
	for i in range(_pieces.size()):
		if not _found[i]:
			return _pieces[i]
	return null


## Picks up scrap `index`, as if it had been clicked. Returns false if it was already found.
func collect_piece(index: int) -> bool:
	if index < 0 or index >= _pieces.size() or _found[index] or not _active or get_tree().paused:
		return false
	_found[index] = true
	_pieces[index].input_pickable = false
	_set_cursor(false)
	# Looked up by path (not by name), so this script also compiles inside test scripts.
	var audio := get_node_or_null("/root/AudioManager")
	if audio != null:
		audio.call("play_sfx", "collect")
	var tween := create_tween()
	tween.tween_method(_set_pop.bind(index), 0.0, 1.0, 0.6)
	tween.tween_callback(_set_pop.bind(-1.0, index))
	_update_hint_anchor()
	var count := collected_count()
	if count < _pieces.size():
		notice.emit("A torn piece!", "Piece %d of %d of the hull plan. Find the rest to put it back together." % [count, _pieces.size()], false)
	else:
		notice.emit("The plan is complete!", "The torn pieces fit together on the workbench: the Lady Margaret's hull plan.", false)
		_start_assembling()
	return true


## Test helper: picks up every remaining scrap and finishes the plan straight
## away (no flying animation), so the hull plan is collected at once.
func collect_all() -> void:
	if not _active:
		start_effect()
	for i in range(_pieces.size()):
		if not _found[i]:
			_found[i] = true
			_pieces[i].input_pickable = false
	_update_hint_anchor()
	_finish_assembling()


func _start_assembling() -> void:
	if hull_plan == null or hull_plan.is_collected:
		_assemble = 2.0
		return
	# The plan appears on the bench (faintly at first) while the pieces fly to it.
	hull_plan.reveal()
	hull_plan.modulate.a = 0.0
	_assemble = 0.0
	var tween := create_tween()
	tween.tween_method(_set_assemble, 0.0, 1.0, assemble_seconds).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_callback(_finish_assembling)


## Moves scrap `index`'s pick-up effect on (-1 = finished).
func _set_pop(value: float, index: int) -> void:
	_pop[index] = value
	queue_redraw()


func _set_assemble(value: float) -> void:
	_assemble = value
	if hull_plan != null:
		hull_plan.modulate.a = clampf((value - 0.6) / 0.4, 0.0, 1.0)
	queue_redraw()


## The plan is whole: show it fully and tick it off the list.
func _finish_assembling() -> void:
	_assemble = 2.0
	queue_redraw()
	if hull_plan == null or hull_plan.is_collected:
		return
	hull_plan.modulate.a = 1.0
	hull_plan.reveal()
	hull_plan.collect()


## While the plan is missing, hints point at the next scrap.
func _update_hint_anchor() -> void:
	if hull_plan == null:
		return
	hull_plan.hint_anchor = get_next_piece()


func _on_piece_input(_viewport: Node, event: InputEvent, _shape_index: int, index: int) -> void:
	var click := event as InputEventMouseButton
	if click != null and click.pressed and click.button_index == MOUSE_BUTTON_LEFT:
		collect_piece(index)


## Hover feedback, like the hidden objects: a pointing hand over a scrap.
func _on_piece_hovered(hovered: bool) -> void:
	_set_cursor(hovered and _active and not get_tree().paused)


func _set_cursor(pointing: bool) -> void:
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND if pointing else Input.CURSOR_ARROW)


func _exit_tree() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)


func _draw() -> void:
	var target := to_local(hull_plan.global_position) if hull_plan != null else Vector2.ZERO
	var plan_scale := hull_plan.scale.x if hull_plan != null else 1.0
	for i in range(_pieces.size()):
		var quarter := i % 4
		if not _found[i]:
			# The scrap lying where Vane threw it, with a small shadow under it.
			draw_set_transform(_pieces[i].position + Vector2(2, 3), _pieces[i].rotation, Vector2.ONE * piece_scale)
			draw_rect(Rect2(-WorkshopObjects.HULL_PLAN_SIZE / 4.0, WorkshopObjects.HULL_PLAN_SIZE / 2.0), Color(0, 0, 0, 0.3))
			draw_set_transform(_pieces[i].position, _pieces[i].rotation, Vector2.ONE * piece_scale)
			WorkshopObjects.draw_hull_plan_piece(self, quarter, Vector2.ZERO)
			# Scrap 2 lies by the stove: one corner is scorched.
			if i == 1:
				draw_circle(Vector2(-10, 7), 4.0, Color(0.2, 0.12, 0.06, 0.7))
			continue
		if _pop[i] >= 0.0:
			# Picked up: the scrap lifts, grows and fades, with a ring of sparkles.
			var p := _pop[i]
			var at := _pieces[i].position + Vector2(0, -30.0 * p)
			draw_set_transform(at, _pieces[i].rotation * (1.0 - p), Vector2.ONE * piece_scale * (1.0 + 0.5 * p))
			WorkshopObjects.draw_hull_plan_piece(self, quarter, Vector2.ZERO)
			draw_set_transform(Vector2.ZERO)
			var glow := Color(1.0, 0.86, 0.55, 1.0 - p)
			draw_arc(_pieces[i].position, lerpf(8.0, 50.0, p), 0.0, TAU, 32, glow, 2.5, true)
		if _assemble >= 0.0 and _assemble < 1.0:
			# Flying from where it lay to its place in the plan on the workbench.
			var t := _assemble
			var finish := target + WorkshopObjects.piece_offset(quarter) * plan_scale
			var arc_lift := Vector2(0, -60.0 * sin(t * PI))
			var at := _pieces[i].position.lerp(finish, t) + arc_lift
			var size := lerpf(piece_scale, plan_scale, t)
			draw_set_transform(at, lerp_angle(_pieces[i].rotation, 0.0, t), Vector2.ONE * size)
			WorkshopObjects.draw_hull_plan_piece(self, quarter, Vector2.ZERO)
	draw_set_transform(Vector2.ZERO)
	if _assemble >= 0.6 and _assemble < 1.0:
		# A warm flash as the torn edges meet.
		var flash := (_assemble - 0.6) / 0.4
		draw_arc(target, lerpf(20.0, 70.0, flash), 0.0, TAU, 40, Color(1.0, 0.9, 0.6, 1.0 - flash), 3.0, true)
