class_name LookAlikes
extends Node2D
## House Three, Chapter Five (The Dispensary): shelf after shelf of things that
## look alike. Some hidden objects have look-alikes standing beside them: the
## same shape, but the wrong colour. Only the one that matches the picture in
## the objective list is right.
##
## Clicking a look-alike is a mistake: the player's hand shakes for
## `freeze_seconds`, and nothing at all can be picked up until it steadies.
##
## HOW IT WORKS: for every entry of `decoy_of`, this node makes a copy of that
## object's picture at `decoy_positions[i]` and recolours it with a small
## shader (`decoy_hues`, `decoy_saturations`, `decoy_tints`). The copy has its
## own click area. After a wrong pick, one big invisible area over the whole
## room catches every click until the freeze is over. Once the real object has
## been found, its look-alikes stop reacting.
##
## Place this node AFTER HiddenObjects and RoomForeground in the scene.

## Shown by the room as a notification (see room_level.gd).
signal notice(title: String, message: String, wrong_sound: bool)

## One entry per look-alike: the real object it copies.
@export var decoy_of: Array[NodePath] = []
## Where each look-alike stands (room coordinates, same order as `decoy_of`).
@export var decoy_positions: PackedVector2Array = PackedVector2Array()
## How far round the colour wheel each look-alike is turned (0 to 1; 0 = unchanged).
@export var decoy_hues: PackedFloat32Array = PackedFloat32Array()
## How colourful each look-alike is (1 = unchanged, 0 = grey).
@export var decoy_saturations: PackedFloat32Array = PackedFloat32Array()
## A colour each look-alike is multiplied by (white = unchanged).
@export var decoy_tints: PackedColorArray = PackedColorArray()
## How long the player's hand shakes after a wrong pick.
@export var freeze_seconds: float = 4.0
## Seconds before the same "steady" message may be shown again.
@export var notice_cooldown: float = 2.0

const RECOLOUR_SHADER := """shader_type canvas_item;
uniform float hue_shift = 0.0;
uniform float saturation = 1.0;
uniform vec4 tint : source_color = vec4(1.0);
void fragment() {
	const mat3 to_yiq = mat3(vec3(0.299, 0.596, 0.211), vec3(0.587, -0.274, -0.523), vec3(0.114, -0.322, 0.312));
	const mat3 to_rgb = mat3(vec3(1.0, 1.0, 1.0), vec3(0.956, -0.272, -1.106), vec3(0.621, -0.647, 1.703));
	vec3 yiq = to_yiq * COLOR.rgb;
	float angle = hue_shift * 6.2831853;
	float i = (yiq.y * cos(angle) - yiq.z * sin(angle)) * saturation;
	float q = (yiq.y * sin(angle) + yiq.z * cos(angle)) * saturation;
	COLOR = vec4(clamp(to_rgb * vec3(yiq.x, i, q), 0.0, 1.0) * tint.rgb, COLOR.a);
}
"""

var _active: bool = false
## True while the test (or steady(true)) has switched the look-alikes off.
var _steady: bool = false
## True once the room is complete.
var _faded: bool = false
## Seconds the player's hand still shakes (0 = steady).
var _freeze_left: float = 0.0
var _time: float = 0.0
var _last_notice_time: float = -100.0
var _decoys: Array[Area2D] = []
## The real object of each look-alike (same order as _decoys).
var _targets: Array[HiddenObject] = []
var _blocker: Area2D
var _shader: Shader


func _ready() -> void:
	add_to_group("room_effects")
	_shader = Shader.new()
	_shader.code = RECOLOUR_SHADER
	# The hidden objects are ready before this node (they come first in the
	# scene), but wait one moment so their click shapes have their final size.
	_build.call_deferred()


## Called by the room when the player can start searching.
func start_effect() -> void:
	_active = true
	_update_decoys()


## Called when the room is complete: no more mistakes to make.
func fade_out() -> void:
	_faded = true
	end_freeze()
	_update_decoys()


# ---------------------------------------------------------------------------
# Helpers (also used by the automated test)
# ---------------------------------------------------------------------------

func decoy_count() -> int:
	return _decoys.size()


## Where look-alike `index` stands (room position).
func get_decoy_position(index: int) -> Vector2:
	return _decoys[index].global_position


## The real object that look-alike `index` copies.
func get_decoy_target(index: int) -> HiddenObject:
	return _targets[index]


## True while the player's hand is shaking and nothing can be picked up.
func is_frozen() -> bool:
	return _freeze_left > 0.0


## Ends the shaking straight away.
func end_freeze() -> void:
	_freeze_left = 0.0
	if _blocker != null:
		_blocker.input_pickable = false


## The test's "safe" state: the look-alikes can't be clicked, so no mistake is possible.
func steady(enabled: bool) -> void:
	_steady = enabled
	if enabled:
		end_freeze()
	_update_decoys()


func _process(delta: float) -> void:
	_time += delta
	if _freeze_left > 0.0:
		_freeze_left = maxf(_freeze_left - delta, 0.0)
		if _freeze_left == 0.0:
			end_freeze()
		queue_redraw()


func _build() -> void:
	for i in range(mini(decoy_of.size(), decoy_positions.size())):
		var target := get_node_or_null(decoy_of[i]) as HiddenObject
		if target == null or target.data == null:
			continue
		var decoy := Area2D.new()
		decoy.name = "LookAlike%d" % i
		decoy.input_pickable = false
		var picture := _make_picture(target, i)
		decoy.add_child(picture)
		var collision := CollisionShape2D.new()
		var source := target.get_node_or_null("CollisionShape2D") as CollisionShape2D
		if source != null and source.shape != null:
			collision.shape = source.shape.duplicate()
			collision.position = source.position
		else:
			var shape := RectangleShape2D.new()
			shape.size = Vector2(40, 40)
			collision.shape = shape
		decoy.add_child(collision)
		add_child(decoy)
		decoy.position = decoy_positions[i]
		decoy.scale = target.scale
		decoy.rotation = target.rotation
		decoy.input_event.connect(_on_decoy_clicked.bind(i))
		target.collected.connect(func(_object: HiddenObject) -> void: _update_decoys())
		_decoys.append(decoy)
		_targets.append(target)
	# One invisible area over the whole room, on top of everything, for the freeze.
	_blocker = Area2D.new()
	_blocker.name = "ShakingHand"
	_blocker.input_pickable = false
	var room_shape := RectangleShape2D.new()
	room_shape.size = Vector2(6000, 6000)
	var room_collision := CollisionShape2D.new()
	room_collision.shape = room_shape
	_blocker.add_child(room_collision)
	add_child(_blocker)
	_blocker.input_event.connect(_on_frozen_click)
	_update_decoys()


## The recoloured copy of the real object's picture.
func _make_picture(target: HiddenObject, index: int) -> Node2D:
	var picture: Node2D
	if target.data.texture != null:
		var sprite := Sprite2D.new()
		sprite.texture = target.data.texture
		sprite.scale = target.texture_scale
		sprite.position = target.texture_offset
		picture = sprite
	else:
		var placeholder := PlaceholderVisual.new()
		placeholder.style = target.data.placeholder_style
		picture = placeholder
	var recolour := ShaderMaterial.new()
	recolour.shader = _shader
	recolour.set_shader_parameter("hue_shift", decoy_hues[index] if index < decoy_hues.size() else 0.33)
	recolour.set_shader_parameter("saturation", decoy_saturations[index] if index < decoy_saturations.size() else 1.0)
	recolour.set_shader_parameter("tint", decoy_tints[index] if index < decoy_tints.size() else Color.WHITE)
	picture.material = recolour
	return picture


## A look-alike can be clicked while its real object is still to be found.
func _update_decoys() -> void:
	for i in range(_decoys.size()):
		_decoys[i].input_pickable = _active and not _steady and not _faded and not _targets[i].is_collected


func _on_decoy_clicked(_viewport: Node, event: InputEvent, _shape_index: int, index: int) -> void:
	var click := event as InputEventMouseButton
	if click == null or not click.pressed or click.button_index != MOUSE_BUTTON_LEFT or get_tree().paused:
		return
	if is_frozen():
		return
	_freeze_left = freeze_seconds
	_blocker.input_pickable = true
	_last_notice_time = _time
	notice.emit("Not that one!", "It only looks like the %s. Compare the colour with the picture in your list. Your hand is shaking: wait a moment." % _targets[index].data.display_name, true)


func _on_frozen_click(_viewport: Node, event: InputEvent, _shape_index: int) -> void:
	var click := event as InputEventMouseButton
	if click == null or not click.pressed or click.button_index != MOUSE_BUTTON_LEFT or get_tree().paused:
		return
	if _time - _last_notice_time < notice_cooldown:
		return
	_last_notice_time = _time
	notice.emit("Steady...", "Your hand is still shaking. Wait a moment before you pick anything up.", false)


func _draw() -> void:
	if _freeze_left <= 0.0:
		return
	# The room closes in a little while the player's hand shakes.
	var pulse := 0.16 + 0.06 * sin(_time * 9.0)
	var amount := clampf(_freeze_left / 0.6, 0.0, 1.0) * pulse
	draw_rect(Rect2(-2000, -2000, 6000, 6000), Color(0.3, 0.05, 0.05, amount))
