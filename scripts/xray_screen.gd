class_name XRayScreen
extends Node2D
## House Three, Chapter Two (The X-Ray Room): a round X-ray screen on a wheeled
## stand. It rolls slowly after the pointer (on a phone: after your last tap).
## Through its green glass you can see what is sealed INSIDE things.
##
## The objects listed in `xray_objects` are hidden inside plaster, lining and
## brick. They are invisible, and cannot be clicked, until the screen is over
## them. Every other object and container can always be clicked.
##
## HOW IT WORKS: the screen moves towards the pointer at `roll_speed`, so the
## player has to wait for it to arrive. Every frame each X-ray object is faded
## in or out by its distance from the middle of the screen, and told whether
## it can be clicked (set_reachable). Over each X-ray object sits a small
## invisible area: while the object is unseen, that area catches the click and
## the player is told to bring the screen over it.
##
## Place this node AFTER HiddenObjects and RoomForeground in the scene, so the
## dark glass covers the room and the "can't see inside" areas sit on top.

## Shown by the room as a notification (see room_level.gd).
signal notice(title: String, message: String, wrong_sound: bool)

## The objects that can only be seen and clicked through the screen.
@export var xray_objects: Array[NodePath] = []
## Radius of the glass. Objects closer than this to its middle can be clicked.
@export var screen_radius: float = 105.0
## The picture fades out over this many pixels at the edge of the glass.
@export var soft_edge: float = 30.0
## How fast the stand rolls after the pointer, in pixels per second.
@export var roll_speed: float = 380.0
## Where the screen stands when the room opens.
@export var start_position: Vector2 = Vector2(660, 300)
## The floor line the stand's wheels run along.
@export var floor_y: float = 704.0
## Colour of the things seen through the glass.
@export var glow_color: Color = Color(0.72, 1.0, 0.86)
## Seconds before the same "can't see inside" message may be shown again.
@export var notice_cooldown: float = 2.5

const GLASS := Color(0.02, 0.1, 0.08, 0.8)
const STEEL := Color(0.62, 0.66, 0.68)
const STEEL_DARK := Color(0.3, 0.33, 0.35)

var _active: bool = false
var _holding: bool = false
var _reveal_all: bool = false
var _faded: bool = false
## 1.0 while the screen is in the room; goes to 0.0 when the room is complete.
var _shade: float = 1.0
var _screen_position: Vector2
var _target: Vector2
var _time: float = 0.0
var _last_notice_time: float = -100.0
var _objects: Array[Node] = []
## One "can't see inside" click area per X-ray object (same order as _objects).
var _blockers: Array[Area2D] = []


func _ready() -> void:
	add_to_group("room_effects")
	_screen_position = start_position
	_target = start_position
	for path in xray_objects:
		var node := get_node_or_null(path) as CanvasItem
		if node != null:
			_objects.append(node)
			# Drawn above the dark glass, so they glow through it.
			node.z_index = 1
	# The hidden objects are ready before this node (they come first in the
	# scene), but wait one moment so their click shapes have their final size.
	_build_blockers.call_deferred()
	_update_objects()


## Called by the room when the player can start searching.
func start_effect() -> void:
	_active = true


## Called when the room is complete: the screen is wheeled away and nothing is hidden any more.
func fade_out() -> void:
	_active = false
	_faded = true
	create_tween().tween_property(self, "_shade", 0.0, 1.5)
	_update_objects()


# ---------------------------------------------------------------------------
# Helpers (also used by the automated test)
# ---------------------------------------------------------------------------

## Where the middle of the glass is right now (room position).
func get_screen_position() -> Vector2:
	return _screen_position


## Puts the screen at `world_position` straight away.
func move_to(world_position: Vector2) -> void:
	_screen_position = world_position
	_target = world_position
	_update_objects()


## Stops the screen following the pointer (true) or lets it roll again (false).
func hold(enabled: bool) -> void:
	_holding = enabled
	if enabled:
		_target = _screen_position


## True if `world_position` can be seen through the glass right now.
## After reveal_everything(true), or once the room is complete, everything counts as seen.
func is_revealed(world_position: Vector2) -> bool:
	if _reveal_all or _faded:
		return true
	return world_position.distance_to(_screen_position) < screen_radius


## The objects that can only be clicked through the screen.
func get_xray_objects() -> Array[Node]:
	return _objects.duplicate()


## The test's "safe" state: every sealed object shows and the screen stands still.
## reveal_everything(false) hides them again (the screen stays held until hold(false)).
func reveal_everything(enabled: bool) -> void:
	_reveal_all = enabled
	if enabled:
		hold(true)
	_update_objects()


func _input(event: InputEvent) -> void:
	if not _active or _holding:
		return
	# Mouse moves and clicks (a tap on a phone arrives here as a click too).
	var mouse := event as InputEventMouse
	if mouse != null:
		_target = get_viewport().get_canvas_transform().affine_inverse() * mouse.position


func _process(delta: float) -> void:
	_time += delta
	if _active and _screen_position != _target:
		_screen_position = _screen_position.move_toward(_target, roll_speed * delta)
		_update_objects()
	queue_redraw()


## How clearly the glass shows a spot: 1 in the middle, 0 outside it.
func _picture_at(world_position: Vector2) -> float:
	if _reveal_all or _faded:
		return 1.0
	return 1.0 - smoothstep(screen_radius - soft_edge, screen_radius, world_position.distance_to(_screen_position))


## Tells every X-ray object whether it can be clicked, and fades it in or out.
func _update_objects() -> void:
	for i in range(_objects.size()):
		var area := _objects[i] as Area2D
		if area == null:
			continue
		var seen := is_revealed(area.global_position)
		if area.has_method("set_reachable"):
			area.call("set_reachable", seen)
		var plain := _reveal_all or _faded
		area.modulate = Color(Color.WHITE if plain else glow_color, _picture_at(area.global_position))
		if i < _blockers.size():
			_blockers[i].input_pickable = not seen and area.visible and not _is_collected(area)


func _is_collected(node: Node) -> bool:
	var hidden_object := node as HiddenObject
	return hidden_object != null and hidden_object.is_collected


## Makes one invisible click area over each X-ray object, the same size and
## angle as the object's own click area.
func _build_blockers() -> void:
	for node in _objects:
		var area := node as Area2D
		var blocker := Area2D.new()
		blocker.name = "Sealed" + String(node.name)
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
		blocker.input_event.connect(_on_sealed_spot_clicked.bind(node))
		_blockers.append(blocker)
	_update_objects()


func _on_sealed_spot_clicked(_viewport: Node, event: InputEvent, _shape_index: int, node: Node) -> void:
	var click := event as InputEventMouseButton
	if click == null or not click.pressed or click.button_index != MOUSE_BUTTON_LEFT or get_tree().paused:
		return
	if is_revealed((node as Node2D).global_position) or _is_collected(node):
		return
	# Don't repeat the same message over and over.
	if _time - _last_notice_time < notice_cooldown:
		return
	_last_notice_time = _time
	notice.emit("You can't see inside it", "Something may be sealed in here. Wait for the X-ray screen to roll over it, then look again.", true)


func _draw() -> void:
	if _shade <= 0.001:
		return
	var center := to_local(_screen_position)
	var steel := Color(STEEL, _shade)
	var steel_dark := Color(STEEL_DARK, _shade)
	# The stand: a pole down to a wheeled foot on the floor.
	var foot_y := maxf(floor_y, center.y + screen_radius + 20.0)
	draw_line(center + Vector2(0, screen_radius), Vector2(center.x, foot_y), steel_dark, 7.0)
	draw_line(center + Vector2(-1.5, screen_radius), Vector2(center.x - 1.5, foot_y), steel, 2.0)
	draw_rect(Rect2(center.x - 46, foot_y - 4, 92, 7), steel_dark)
	for wheel_x: float in [-40.0, 40.0]:
		draw_circle(Vector2(center.x + wheel_x, foot_y + 7), 6.0, Color(0.08, 0.08, 0.09, _shade))
		draw_circle(Vector2(center.x + wheel_x, foot_y + 7), 2.0, steel)
	# The dark green glass, with a faint glow and slow scan lines.
	draw_circle(center, screen_radius, Color(GLASS, GLASS.a * _shade))
	for ring in range(4):
		draw_circle(center, screen_radius * (0.9 - ring * 0.2), Color(0.2, 0.9, 0.6, 0.035 * _shade))
	for line in range(9):
		var offset := fposmod(line * 24.0 + _time * 18.0, screen_radius * 2.0) - screen_radius
		var half_width := sqrt(maxf(screen_radius * screen_radius - offset * offset, 0.0))
		draw_line(center + Vector2(-half_width, offset), center + Vector2(half_width, offset), Color(0.4, 1.0, 0.75, 0.06 * _shade), 1.0)
	# The steel rim and its two handles
	draw_arc(center, screen_radius, 0.0, TAU, 64, steel_dark, 9.0, true)
	draw_arc(center, screen_radius + 2.0, -2.6, -1.2, 16, steel, 2.0, true)
	for side: float in [-1.0, 1.0]:
		draw_rect(Rect2(center.x + side * (screen_radius + 4.0) - 5.0, center.y - 16, 10, 32), steel_dark)
		draw_rect(Rect2(center.x + side * (screen_radius + 4.0) - 2.0, center.y - 12, 3, 24), steel)
