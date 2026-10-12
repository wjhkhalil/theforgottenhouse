class_name TornPieces
extends Node2D
## House Two, Chapter Four (The Workshop): Vane tore up the Lady Margaret's hull
## plan and threw the pieces around the workshop. The plan itself (a hidden
## object that starts invisible) can only be found by collecting the four torn
## scraps first. When the last scrap is picked up, the pieces fly to the
## workbench and join up, the plan appears there and is collected by itself.
##
## THE ART: when the plan has a painted texture, each scrap is a quarter of that
## painting, cut along `tear_down` and `tear_across`. Without a texture the
## scraps are the drawn placeholder quarters.
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
## The tear running down the painted plan, top to bottom (texture pixels). Empty = straight down the middle.
@export var tear_down: PackedVector2Array = PackedVector2Array()
## The tear running across the painted plan, left to right (texture pixels). It
## must share one point with `tear_down`: the place where the two tears cross.
@export var tear_across: PackedVector2Array = PackedVector2Array()
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
## The painted plan, or null while the drawn placeholder is used.
var _texture: Texture2D
## Each quarter of the painted plan: its outline (texture pixels) and its middle.
var _quarters: Array[PackedVector2Array] = []
var _quarter_centres: Array[Vector2] = []
## The part of the painting that is not empty (texture pixels).
var _paper: Rect2


func _ready() -> void:
	add_to_group("room_effects")
	_cut_painted_plan()
	for i in range(piece_positions.size()):
		var piece_size := _piece_size(i % 4)
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


## Cuts the painted plan into its four quarters along the two tears.
func _cut_painted_plan() -> void:
	if hull_plan == null or hull_plan.data == null or hull_plan.data.texture == null:
		return
	_texture = hull_plan.data.texture
	var size := _texture.get_size()
	var down := tear_down
	var across := tear_across
	if down.size() < 2 or across.size() < 2:
		down = PackedVector2Array([Vector2(size.x / 2.0, 0), size / 2.0, Vector2(size.x / 2.0, size.y)])
		across = PackedVector2Array([Vector2(0, size.y / 2.0), size / 2.0, Vector2(size.x, size.y / 2.0)])
	# Where the tears cross: the point they share.
	var down_cross := 1
	var across_cross := 1
	for i in range(down.size()):
		var found := across.find(down[i])
		if found >= 0:
			down_cross = i
			across_cross = found
	var up_half := down.slice(0, down_cross + 1)        # top edge -> crossing
	var down_half := down.slice(down_cross)             # crossing -> bottom edge
	var left_half := across.slice(0, across_cross + 1)  # left edge -> crossing
	var right_half := across.slice(across_cross)        # crossing -> right edge
	var top := up_half[0]
	var bottom := down_half[down_half.size() - 1]
	var left := left_half[0]
	var right := right_half[right_half.size() - 1]
	# Each quarter: its outer corner of the sheet, then round along the two tears (clockwise).
	var top_left := PackedVector2Array([Vector2(0, 0), Vector2(top.x, 0)]) + up_half + _reversed(left_half).slice(1)
	top_left.append(Vector2(0, left.y))
	var top_right := PackedVector2Array([Vector2(top.x, 0), Vector2(size.x, 0), Vector2(size.x, right.y)])
	top_right += _reversed(right_half) + _reversed(up_half).slice(1)
	var bottom_left := PackedVector2Array([Vector2(0, left.y)]) + left_half + down_half.slice(1)
	bottom_left += PackedVector2Array([Vector2(bottom.x, size.y), Vector2(0, size.y)])
	var bottom_right := right_half + PackedVector2Array([Vector2(size.x, right.y), size, Vector2(bottom.x, size.y)])
	bottom_right += _reversed(down_half).slice(0, -1)
	_quarters = [top_left, top_right, bottom_left, bottom_right]
	# The painting has an empty margin round the paper: measure the paper, not the whole image.
	var image := _texture.get_image()
	_paper = Rect2(image.get_used_rect()) if image != null else Rect2(Vector2.ZERO, size)
	for quarter in range(_quarters.size()):
		_quarter_centres.append(_quarter_box(quarter).get_center())


static func _reversed(points: PackedVector2Array) -> PackedVector2Array:
	var result := points.duplicate()
	result.reverse()
	return result


## The paper of quarter `quarter` (texture pixels).
func _quarter_box(quarter: int) -> Rect2:
	var box := Rect2(_quarters[quarter][0], Vector2.ZERO)
	for point in _quarters[quarter]:
		box = box.expand(point)
	return box.intersection(_paper)


## How big the plan's painting is drawn inside the plan object.
func _plan_texture_scale() -> Vector2:
	return hull_plan.texture_scale if hull_plan != null else Vector2.ONE


## The size of scrap `quarter` as it lies in the room.
func _piece_size(quarter: int) -> Vector2:
	if _texture == null:
		return WorkshopObjects.HULL_PLAN_SIZE / 2.0 * piece_scale
	return _quarter_box(quarter).size * _plan_texture_scale() * piece_scale


## Where scrap `quarter` belongs, measured from the middle of the finished plan.
func _piece_offset(quarter: int, plan_scale: float) -> Vector2:
	if _texture == null:
		return WorkshopObjects.piece_offset(quarter) * plan_scale
	return (_quarter_centres[quarter] - _texture.get_size() / 2.0) * _plan_texture_scale() + hull_plan.texture_offset


## Draws scrap `quarter` at `at`. `size` is 1.0 for the size it has inside the finished plan.
func _draw_piece(quarter: int, at: Vector2, turn: float, size: float) -> void:
	if _texture == null:
		draw_set_transform(at, turn, Vector2.ONE * size)
		WorkshopObjects.draw_hull_plan_piece(self, quarter, Vector2.ZERO)
		return
	draw_set_transform(at, turn, _plan_texture_scale() * size)
	var points := PackedVector2Array()
	var uvs := PackedVector2Array()
	for point in _quarters[quarter]:
		points.append(point - _quarter_centres[quarter])
		uvs.append(point / _texture.get_size())
	var tint := hull_plan.modulate
	tint.a = 1.0
	draw_colored_polygon(points, tint, uvs, _texture)


func _draw() -> void:
	var target := to_local(hull_plan.global_position) if hull_plan != null else Vector2.ZERO
	var plan_scale := hull_plan.scale.x if hull_plan != null else 1.0
	for i in range(_pieces.size()):
		var quarter := i % 4
		if not _found[i]:
			# The scrap lying where Vane threw it.
			if _texture == null:
				# The drawn placeholder has no shadow of its own (the painting does).
				draw_set_transform(_pieces[i].position + Vector2(2, 3), _pieces[i].rotation, Vector2.ONE * piece_scale)
				draw_rect(Rect2(-WorkshopObjects.HULL_PLAN_SIZE / 4.0, WorkshopObjects.HULL_PLAN_SIZE / 2.0), Color(0, 0, 0, 0.3))
			_draw_piece(quarter, _pieces[i].position, _pieces[i].rotation, piece_scale)
			# Scrap 2 lies by the stove: one corner is scorched.
			if i == 1:
				var half := _piece_size(quarter) / 2.0
				draw_set_transform(_pieces[i].position, _pieces[i].rotation)
				draw_circle(Vector2(-half.x * 0.6, half.y * 0.5), 4.0, Color(0.2, 0.12, 0.06, 0.7))
			continue
		if _pop[i] >= 0.0:
			# Picked up: the scrap lifts, grows and fades, with a ring of sparkles.
			var p := _pop[i]
			var at := _pieces[i].position + Vector2(0, -30.0 * p)
			_draw_piece(quarter, at, _pieces[i].rotation * (1.0 - p), piece_scale * (1.0 + 0.5 * p))
			draw_set_transform(Vector2.ZERO)
			var glow := Color(1.0, 0.86, 0.55, 1.0 - p)
			draw_arc(_pieces[i].position, lerpf(8.0, 50.0, p), 0.0, TAU, 32, glow, 2.5, true)
		if _assemble >= 0.0 and _assemble < 1.0:
			# Flying from where it lay to its place in the plan on the workbench.
			var t := _assemble
			var finish := target + _piece_offset(quarter, plan_scale)
			var arc_lift := Vector2(0, -60.0 * sin(t * PI))
			var at := _pieces[i].position.lerp(finish, t) + arc_lift
			var size := lerpf(piece_scale, plan_scale, t)
			_draw_piece(quarter, at, lerp_angle(_pieces[i].rotation, 0.0, t), size)
	draw_set_transform(Vector2.ZERO)
	if _assemble >= 0.6 and _assemble < 1.0:
		# A warm flash as the torn edges meet.
		var flash := (_assemble - 0.6) / 0.4
		draw_arc(target, lerpf(20.0, 70.0, flash), 0.0, TAU, 40, Color(1.0, 0.9, 0.6, 1.0 - flash), 3.0, true)
