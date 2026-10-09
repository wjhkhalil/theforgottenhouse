@tool
class_name HiddenObject
extends Area2D
## A clickable hidden object (reusable in any room).
##
## HOW COLLECTION WORKS
##   1. Godot's "physics picking" sends mouse clicks that land inside the
##      CollisionShape2D to _on_input_event().
##   2. collect() marks the object as collected (so it can never be collected
##      twice), turns off clicking, plays a small effect and emits `collected`.
##   3. The room's GameManager listens to `collected` and updates the progress.
##
## HOW TO REPLACE THE PLACEHOLDER ART
##   Open this object's data file (res://resources/objects/*.tres) and assign a
##   picture to "Texture". The procedural drawing is hidden automatically and
##   the click area resizes to fit the picture. Use "Texture Scale" and
##   "Texture Offset" on this node (in the room scene) to fit the picture.

## Emitted once, when the player clicks this object for the first time.
signal collected(hidden_object: HiddenObject)

## All the text and artwork for this object lives in this resource.
@export var data: HiddenObjectData:
	set(value):
		data = value
		_refresh_visuals()

@export_group("Replacement Art Placement")
## Scale applied to the texture (only used when the data has a texture).
@export var texture_scale: Vector2 = Vector2.ONE:
	set(value):
		texture_scale = value
		_refresh_visuals()
## Moves the texture (and its click area) relative to this node.
@export var texture_offset: Vector2 = Vector2.ZERO:
	set(value):
		texture_offset = value
		_refresh_visuals()
## Size of the clickable rectangle. Leave at (0, 0) to size it automatically from the artwork.
@export var click_size: Vector2 = Vector2.ZERO:
	set(value):
		click_size = value
		_refresh_visuals()
## Extra pixels around the artwork that still count as a click.
@export var click_padding: float = 4.0:
	set(value):
		click_padding = value
		_refresh_visuals()

## True after the player has found this object.
var is_collected: bool = false
## While this object is still hidden (for example inside a closed trunk),
## hints point at this node instead. Set by OpenableContainer.
var hint_anchor: Node2D = null

var _is_hovered: bool = false
# Goes from 0.0 to 1.0 while the sparkle-ring effect plays. -1.0 means "not playing".
var _effect_progress: float = -1.0

@onready var _visual_root: Node2D = $VisualRoot
@onready var _placeholder_visual: PlaceholderVisual = $VisualRoot/PlaceholderVisual
@onready var _texture_sprite: Sprite2D = $VisualRoot/TextureSprite
@onready var _collision_shape: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	_refresh_visuals()
	if Engine.is_editor_hint():
		return  # In the editor we only want to show the artwork.

	add_to_group("hidden_objects")
	input_event.connect(_on_input_event)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

	if data == null:
		push_warning("HiddenObject '%s' has no data resource assigned." % name)
	else:
		visible = data.starts_visible
	input_pickable = visible


func _exit_tree() -> void:
	# Never leave the "hand" cursor behind when the room is closed.
	if _is_hovered and not Engine.is_editor_hint():
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)


## Shows an object that started hidden (for future puzzles).
func reveal() -> void:
	if is_collected:
		return
	show()
	input_pickable = true


## Marks the object as already found WITHOUT any effect or signal.
## Used when a saved game is loaded.
func restore_collected() -> void:
	is_collected = true
	input_pickable = false
	hide()


## Collects the object. Safe to call many times: only the first call does anything.
func collect() -> void:
	if is_collected:
		return  # Already found - this prevents duplicate collection events.
	if not is_visible_in_tree() or get_tree().paused:
		return

	is_collected = true
	input_pickable = false  # The object stops receiving mouse clicks.
	_set_hovered(false)
	collected.emit(self)
	_play_collect_effect()


## Called every frame by TideWater: false while the object is under water.
func set_reachable(reachable: bool) -> void:
	if Engine.is_editor_hint():
		return
	input_pickable = reachable and visible and not is_collected
	if not input_pickable:
		_set_hovered(false)


## The position used by the hint system to point at this object.
func get_hint_position() -> Vector2:
	if not visible and hint_anchor != null:
		return hint_anchor.global_position
	return global_position


func _on_input_event(_viewport: Node, event: InputEvent, _shape_index: int) -> void:
	var mouse_event := event as InputEventMouseButton
	if mouse_event == null:
		return
	if mouse_event.button_index == MOUSE_BUTTON_LEFT and mouse_event.pressed:
		collect()


func _on_mouse_entered() -> void:
	if not is_collected and not get_tree().paused:
		_set_hovered(true)


func _on_mouse_exited() -> void:
	_set_hovered(false)


## Hover feedback: brighten the object and show a pointing-hand cursor.
func _set_hovered(hovered: bool) -> void:
	_is_hovered = hovered
	var alpha := _visual_root.modulate.a
	if hovered:
		_visual_root.modulate = Color(1.3, 1.25, 1.12, alpha)
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	else:
		_visual_root.modulate = Color(1, 1, 1, alpha)
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)


## Pop the object up, fade it out and draw an expanding sparkle ring, then hide it.
func _play_collect_effect() -> void:
	var tween := create_tween()
	tween.set_parallel(true)
	tween.tween_property(_visual_root, "scale", Vector2(1.5, 1.5), 0.45).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(_visual_root, "position", Vector2(0, -30), 0.6)
	tween.tween_property(_visual_root, "modulate:a", 0.0, 0.45).set_delay(0.15)
	tween.tween_method(_set_effect_progress, 0.0, 1.0, 0.6)
	tween.chain().tween_callback(hide)


func _set_effect_progress(value: float) -> void:
	_effect_progress = value
	queue_redraw()


func _draw() -> void:
	if _effect_progress < 0.0:
		return
	var radius := lerpf(8.0, 70.0, _effect_progress)
	var alpha := 1.0 - _effect_progress
	var glow := Color(1.0, 0.86, 0.55, alpha)
	draw_arc(Vector2.ZERO, radius, 0.0, TAU, 48, glow, 3.0, true)
	for i in range(8):
		var direction := Vector2.from_angle(TAU * i / 8.0)
		draw_circle(direction * radius * 0.75, 3.0 * alpha + 0.5, glow)


## Updates the artwork and the click area from `data` and the export settings.
func _refresh_visuals() -> void:
	# Setters can run before the child nodes exist, so wait until the node is ready.
	if not is_node_ready():
		return

	var has_texture := data != null and data.texture != null
	_texture_sprite.visible = has_texture
	_placeholder_visual.visible = not has_texture
	if has_texture:
		_texture_sprite.texture = data.texture
		_texture_sprite.scale = texture_scale
		_texture_sprite.position = texture_offset
	else:
		_texture_sprite.texture = null
		if data != null:
			_placeholder_visual.style = data.placeholder_style

	# Make the click area match the artwork (plus a little padding).
	var shape := RectangleShape2D.new()
	shape.size = _get_artwork_size() + Vector2(click_padding, click_padding) * 2.0
	_collision_shape.shape = shape
	_collision_shape.position = texture_offset if has_texture else Vector2.ZERO


func _get_artwork_size() -> Vector2:
	if click_size != Vector2.ZERO:
		return click_size
	if data != null and data.texture != null:
		return data.texture.get_size() * texture_scale.abs()
	if data != null:
		return PlaceholderArt.get_style_size(data.placeholder_style)
	return Vector2(40, 40)
