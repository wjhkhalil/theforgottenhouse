@tool
class_name OpenableContainer
extends Area2D
## Something the player clicks to open (a trunk, a drawer, a box).
## Opening it reveals the hidden object assigned to `contents`.
##
## Set the contents object's data to "Starts Visible = off" so it stays
## hidden until the container is opened. Until then, hints about that object
## point at this container.
##
## LOCKED CONTAINERS (two kinds, can be combined):
##   * `required_object`: another hidden object in the room (such as a small
##     key). Until the player has found it, clicking only shows `locked_message`.
##   * `required_code`: clicking asks the room to show the keypad. When the
##     right code is typed, the room calls unlock_with_code() and open().
##
## REPLACING THE ART: assign `closed_texture` and `open_texture`.

signal opened(container: OpenableContainer)
## Emitted when the player clicks it while it still needs `required_object`.
signal locked_clicked(container: OpenableContainer)
## Emitted when the player clicks it while it still needs `required_code`.
signal code_requested(container: OpenableContainer)
## Emitted for each click on a container that needs several clicks (hits_to_open), except the last.
signal chipped(container: OpenableContainer, hits_left: int)

## Which placeholder drawing to use while no texture is assigned.
## (New styles must be added at the END so existing scenes keep their style.)
enum ContainerStyle { TRUNK, JEWELLERY_BOX, HAT_BOX, CABINET, DRAWER, SAFE, BASKET, BOX, BOOK_SPINES, ICE_BLOCK }

## Unique id used by the save file.
@export var container_id: StringName = &"trunk"
## The hidden object that appears when this is opened.
@export var contents: HiddenObject
@export var open_title: String = "The lid creaks open..."
@export_multiline var open_message: String = ""

@export_group("Lock")
## If set, this object must be found before the container can be opened.
@export var required_object: HiddenObject
@export var locked_title: String = "It is locked."
@export_multiline var locked_message: String = ""
## If not empty, a keypad asks for this code before the container opens.
@export var required_code: String = ""
@export var code_title: String = "A Combination Lock"
@export_multiline var code_prompt: String = ""
@export_multiline var code_hint_first: String = ""
@export_multiline var code_hint_second: String = ""
@export var code_hint_first_after: int = 3
@export var code_hint_second_after: int = 6

@export_group("Hard to Open")
## How many clicks it takes to open (a block of ice must be chipped away). 1 = a normal container.
@export var hits_to_open: int = 1
@export var chip_title: String = "Chip, chip..."
## Shown after each click that doesn't open it yet. Empty = "Keep going: N more."
@export_multiline var chip_message: String = ""

@export_group("Artwork")
@export var style: ContainerStyle = ContainerStyle.TRUNK:
	set(value):
		style = value
		queue_redraw()
## Main colour of the CABINET, DRAWER, SAFE, BASKET, BOX and BOOK_SPINES placeholders.
@export var tint: Color = Color(0.42, 0.29, 0.2):
	set(value):
		tint = value
		queue_redraw()
## Size of the clickable area (and of the placeholder drawing).
@export var size: Vector2 = Vector2(112, 66):
	set(value):
		size = value
		_refresh()
@export var closed_texture: Texture2D:
	set(value):
		closed_texture = value
		queue_redraw()
@export var open_texture: Texture2D:
	set(value):
		open_texture = value
		queue_redraw()

var is_open: bool = false
## Clicks so far on a container that needs several (hits_to_open).
var hits_taken: int = 0
var _is_hovered: bool = false
var _code_entered: bool = false

@onready var _collision_shape: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	_refresh()
	if Engine.is_editor_hint():
		return
	input_event.connect(_on_input_event)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	if contents != null:
		contents.hint_anchor = self


func _exit_tree() -> void:
	if _is_hovered and not Engine.is_editor_hint():
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)


## True while the required object has not been found yet.
func is_locked() -> bool:
	return required_object != null and not required_object.is_collected


## True while the code still has to be typed.
func needs_code() -> bool:
	return required_code != "" and not _code_entered


## Called by the room when the right code was typed on the keypad.
func unlock_with_code() -> void:
	_code_entered = true


## Opens the container. Only the first call does anything.
func open() -> void:
	if is_open or get_tree().paused:
		return
	if is_locked():
		locked_clicked.emit(self)
		return
	if needs_code():
		code_requested.emit(self)
		return
	if hits_taken + 1 < hits_to_open:
		hits_taken += 1
		queue_redraw()
		# A little shake for each blow.
		var start := position
		var tween := create_tween()
		tween.tween_property(self, "position", start + Vector2(4, 0), 0.04)
		tween.tween_property(self, "position", start - Vector2(4, 0), 0.06)
		tween.tween_property(self, "position", start, 0.04)
		chipped.emit(self, hits_to_open - hits_taken)
		return
	is_open = true
	input_pickable = false
	_set_hovered(false)
	queue_redraw()
	if contents != null:
		contents.reveal()
		# Let the revealed object pop up so the player notices it.
		contents.scale *= 0.3
		create_tween().tween_property(contents, "scale", contents.scale / 0.3, 0.4).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	opened.emit(self)


## Called every frame by TideWater: false while the container is under water.
func set_reachable(reachable: bool) -> void:
	if Engine.is_editor_hint():
		return
	input_pickable = reachable and not is_open
	if not input_pickable:
		_set_hovered(false)


## Opens it silently (used when loading a saved game).
func restore_opened() -> void:
	_code_entered = true
	is_open = true
	input_pickable = false
	queue_redraw()
	if contents != null:
		contents.reveal()


func _on_input_event(_viewport: Node, event: InputEvent, _shape_index: int) -> void:
	var mouse_event := event as InputEventMouseButton
	if mouse_event != null and mouse_event.button_index == MOUSE_BUTTON_LEFT and mouse_event.pressed:
		open()


func _on_mouse_entered() -> void:
	if not is_open and not get_tree().paused:
		_set_hovered(true)


func _on_mouse_exited() -> void:
	_set_hovered(false)


func _set_hovered(hovered: bool) -> void:
	_is_hovered = hovered
	modulate = Color(1.25, 1.2, 1.1) if hovered else Color.WHITE
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND if hovered else Input.CURSOR_ARROW)


func _refresh() -> void:
	queue_redraw()
	if not is_node_ready():
		return
	var shape := RectangleShape2D.new()
	shape.size = size
	_collision_shape.shape = shape


func _draw() -> void:
	var texture := open_texture if is_open else closed_texture
	if texture != null:
		draw_texture(texture, -texture.get_size() / 2.0)
		return
	match style:
		ContainerStyle.JEWELLERY_BOX:
			_draw_placeholder_jewellery_box()
		ContainerStyle.HAT_BOX:
			_draw_placeholder_hat_box()
		ContainerStyle.CABINET:
			_draw_placeholder_cabinet()
		ContainerStyle.DRAWER:
			_draw_placeholder_drawer()
		ContainerStyle.SAFE:
			_draw_placeholder_safe()
		ContainerStyle.BASKET:
			_draw_placeholder_basket()
		ContainerStyle.BOX:
			_draw_placeholder_box()
		ContainerStyle.BOOK_SPINES:
			_draw_placeholder_book_spines()
		ContainerStyle.ICE_BLOCK:
			_draw_placeholder_ice_block()
		_:
			_draw_placeholder_trunk()


## Old wooden trunk with metal bands, drawn to fit `size`.
func _draw_placeholder_trunk() -> void:
	var half := size / 2.0
	var wood := Color(0.36, 0.25, 0.17)
	var wood_dark := Color(0.22, 0.15, 0.1)
	var metal := Color(0.32, 0.33, 0.35)
	var brass := Color(0.7, 0.56, 0.3)
	var body := Rect2(-half.x, -half.y * 0.25, size.x, half.y * 1.25)
	PlaceholderArt.draw_ellipse(self, Vector2(0, half.y + 2), half.x + 6, 6, Color(0, 0, 0, 0.4))
	if is_open:
		# Lid tipped back, dark inside visible.
		draw_colored_polygon(PackedVector2Array([
			Vector2(-half.x, body.position.y), Vector2(half.x, body.position.y),
			Vector2(half.x - 6, -half.y - 8), Vector2(-half.x + 6, -half.y - 8),
		]), wood_dark)
		draw_rect(Rect2(-half.x + 6, body.position.y - 6, size.x - 12, 10), Color(0.06, 0.04, 0.03))
	else:
		# Rounded closed lid.
		draw_rect(Rect2(-half.x, -half.y, size.x, half.y * 0.75), wood_dark)
		draw_rect(Rect2(-half.x + 3, -half.y + 3, size.x - 6, half.y * 0.75 - 6), wood)
	draw_rect(body, wood)
	draw_rect(Rect2(body.position, Vector2(size.x, 4)), wood_dark)
	for band_x: float in [-half.x + 14, half.x - 22]:
		draw_rect(Rect2(band_x, -half.y if not is_open else body.position.y, 8, half.y * 2.0 if not is_open else body.size.y), metal)
	if not is_open:
		draw_rect(Rect2(-8, body.position.y - 6, 16, 18), brass)
		draw_circle(Vector2(0, body.position.y + 4), 2.5, wood_dark)


## Small velvet-lined box with a keyhole, drawn to fit `size`.
func _draw_placeholder_jewellery_box() -> void:
	var half := size / 2.0
	var wood := Color(0.3, 0.16, 0.16)
	var wood_light := Color(0.44, 0.24, 0.22)
	var gold := Color(0.78, 0.62, 0.32)
	var body := Rect2(-half.x, -half.y * 0.1, size.x, half.y * 1.1)
	PlaceholderArt.draw_ellipse(self, Vector2(0, half.y + 1), half.x + 4, 4, Color(0, 0, 0, 0.4))
	if is_open:
		draw_rect(Rect2(-half.x + 2, -half.y - 10, size.x - 4, half.y * 0.9), wood_light)
		draw_rect(Rect2(-half.x + 5, -half.y - 7, size.x - 10, half.y * 0.9 - 6), Color(0.45, 0.1, 0.14))
		draw_rect(Rect2(-half.x + 3, body.position.y - 4, size.x - 6, 7), Color(0.35, 0.06, 0.1))
	else:
		draw_rect(Rect2(-half.x, -half.y, size.x, half.y * 0.9), wood_light)
		draw_rect(Rect2(-half.x + 4, -half.y + 3, size.x - 8, 3), Color(1, 1, 1, 0.1))
	draw_rect(body, wood)
	draw_rect(Rect2(body.position, Vector2(size.x, 2)), Color(0, 0, 0, 0.35))
	for corner_x: float in [-half.x, half.x - 5]:
		draw_rect(Rect2(corner_x, body.position.y, 5, 5), gold)
	# Gold keyhole plate
	draw_rect(Rect2(-5, body.position.y + 3, 10, 11), gold)
	draw_circle(Vector2(0, body.position.y + 7), 1.8, Color(0.08, 0.05, 0.04))
	draw_rect(Rect2(-0.8, body.position.y + 7, 1.6, 4), Color(0.08, 0.05, 0.04))


## Round, striped cardboard hat box, drawn to fit `size`.
func _draw_placeholder_hat_box() -> void:
	var half := size / 2.0
	var card := Color(0.52, 0.45, 0.4)
	var stripe := Color(0.38, 0.3, 0.32)
	var lid := Color(0.6, 0.52, 0.46)
	var top_y := -half.y * 0.45
	PlaceholderArt.draw_ellipse(self, Vector2(0, half.y), half.x + 4, 7, Color(0, 0, 0, 0.4))
	draw_rect(Rect2(-half.x, top_y, size.x, half.y - top_y), card)
	for i in range(5):
		var stripe_x := -half.x + 6 + i * size.x / 5.0
		draw_rect(Rect2(stripe_x, top_y, 6, half.y - top_y), stripe)
	PlaceholderArt.draw_ellipse(self, Vector2(0, half.y), half.x, 6, card)
	if is_open:
		# Lid knocked off to the side, dark opening on top.
		PlaceholderArt.draw_ellipse(self, Vector2(0, top_y), half.x, 9, Color(0.07, 0.05, 0.05))
		PlaceholderArt.draw_ellipse(self, Vector2(half.x - 4, half.y - 4), half.x * 0.5, 7, lid)
	else:
		draw_rect(Rect2(-half.x - 3, top_y - 10, size.x + 6, 12), lid)
		PlaceholderArt.draw_ellipse(self, Vector2(0, top_y - 10), half.x + 3, 9, lid.lightened(0.1))
		# Ribbon tied around it
		draw_rect(Rect2(-3, top_y - 12, 6, half.y - top_y + 12), Color(0.45, 0.12, 0.16))
		PlaceholderArt.draw_ellipse(self, Vector2(-7, top_y - 16), 7, 4, Color(0.55, 0.15, 0.2))
		PlaceholderArt.draw_ellipse(self, Vector2(7, top_y - 16), 7, 4, Color(0.55, 0.15, 0.2))


## Cupboard with two doors (medicine cabinet, oven, clock case...), drawn to fit `size`.
func _draw_placeholder_cabinet() -> void:
	var half := size / 2.0
	var dark := tint.darkened(0.45)
	draw_rect(Rect2(-half.x + 3, -half.y + 3, size.x, size.y), Color(0, 0, 0, 0.35))
	draw_rect(Rect2(-half, size), dark)
	var inner := Rect2(-half.x + 4, -half.y + 4, size.x - 8, size.y - 8)
	if is_open:
		draw_rect(inner, Color(0.06, 0.05, 0.04))
		# Doors swung open to both sides
		draw_colored_polygon(PackedVector2Array([inner.position, inner.position + Vector2(-size.x * 0.22, 6),
			inner.position + Vector2(-size.x * 0.22, inner.size.y - 6), inner.position + Vector2(0, inner.size.y)]), tint)
		var right := Vector2(inner.end.x, inner.position.y)
		draw_colored_polygon(PackedVector2Array([right, right + Vector2(size.x * 0.22, 6),
			right + Vector2(size.x * 0.22, inner.size.y - 6), right + Vector2(0, inner.size.y)]), tint)
		draw_line(Vector2(inner.position.x, 0), Vector2(inner.end.x, 0), dark, 3.0)  # shelf
	else:
		var door_width := inner.size.x / 2.0 - 1.0
		for door in range(2):
			var door_rect := Rect2(inner.position.x + door * (door_width + 2.0), inner.position.y, door_width, inner.size.y)
			draw_rect(door_rect, tint)
			draw_rect(door_rect.grow(-4), tint.lightened(0.08), false, 1.5)
		draw_circle(Vector2(-4, 0), 2.5, PlaceholderArt.BEIGE_DARK)
		draw_circle(Vector2(4, 0), 2.5, PlaceholderArt.BEIGE_DARK)


## A single drawer front (in a desk or table), drawn to fit `size`.
func _draw_placeholder_drawer() -> void:
	var half := size / 2.0
	var dark := tint.darkened(0.45)
	if is_open:
		# Pulled out toward the viewer: we see inside it.
		draw_rect(Rect2(-half.x, -half.y - 8, size.x, size.y + 8), dark)
		draw_rect(Rect2(-half.x + 4, -half.y - 4, size.x - 8, size.y * 0.6), Color(0.08, 0.06, 0.05))
		draw_rect(Rect2(-half.x - 3, half.y * 0.2, size.x + 6, half.y * 0.8 + 4), tint)
		draw_rect(Rect2(-8, half.y * 0.5, 16, 4), PlaceholderArt.BEIGE_DARK)
	else:
		draw_rect(Rect2(-half, size), dark)
		draw_rect(Rect2(-half.x + 3, -half.y + 3, size.x - 6, size.y - 6), tint)
		draw_rect(Rect2(-8, -2, 16, 4), PlaceholderArt.BEIGE_DARK)
		draw_rect(Rect2(-2, 4, 4, 5), Color(0.1, 0.08, 0.06))  # keyhole


## Heavy iron safe with a dial, drawn to fit `size`.
func _draw_placeholder_safe() -> void:
	var half := size / 2.0
	var dark := tint.darkened(0.5)
	draw_rect(Rect2(-half.x + 4, -half.y + 4, size.x, size.y), Color(0, 0, 0, 0.4))
	draw_rect(Rect2(-half, size), dark)
	var door := Rect2(-half.x + 6, -half.y + 6, size.x - 12, size.y - 12)
	if is_open:
		draw_rect(door, Color(0.05, 0.05, 0.06))
		draw_colored_polygon(PackedVector2Array([Vector2(door.end.x, door.position.y),
			Vector2(door.end.x + size.x * 0.35, door.position.y + 8), Vector2(door.end.x + size.x * 0.35, door.end.y - 8),
			Vector2(door.end.x, door.end.y)]), tint)
	else:
		draw_rect(door, tint)
		draw_rect(door.grow(-5), tint.lightened(0.1), false, 2.0)
		draw_circle(Vector2.ZERO, minf(size.x, size.y) * 0.17, dark)
		draw_circle(Vector2.ZERO, minf(size.x, size.y) * 0.13, Color(0.75, 0.72, 0.62))
		for tick in range(10):
			var direction := Vector2.from_angle(TAU * tick / 10.0)
			draw_line(direction * minf(size.x, size.y) * 0.09, direction * minf(size.x, size.y) * 0.13, dark, 1.0)
		draw_rect(Rect2(door.end.x - 12, -10, 5, 20), Color(0.7, 0.62, 0.4))  # handle


## Wicker basket with a lid, drawn to fit `size`.
func _draw_placeholder_basket() -> void:
	var half := size / 2.0
	var dark := tint.darkened(0.35)
	var top_y := -half.y * 0.4
	PlaceholderArt.draw_ellipse(self, Vector2(0, half.y), half.x + 4, 6, Color(0, 0, 0, 0.4))
	draw_colored_polygon(PackedVector2Array([Vector2(-half.x, top_y), Vector2(half.x, top_y),
		Vector2(half.x * 0.85, half.y), Vector2(-half.x * 0.85, half.y)]), tint)
	# Woven pattern
	for row in range(int((half.y - top_y) / 8.0)):
		var y := top_y + 4.0 + row * 8.0
		draw_line(Vector2(-half.x * 0.9, y), Vector2(half.x * 0.9, y), dark, 1.5)
	for column in range(-3, 4):
		draw_line(Vector2(column * half.x * 0.28, top_y), Vector2(column * half.x * 0.24, half.y), dark, 1.0)
	if is_open:
		PlaceholderArt.draw_ellipse(self, Vector2(0, top_y), half.x, 7, Color(0.08, 0.06, 0.04))
		draw_line(Vector2(-half.x, top_y), Vector2(-half.x - 10, top_y - size.y * 0.45), tint.lightened(0.1), 6.0)
	else:
		PlaceholderArt.draw_ellipse(self, Vector2(0, top_y - 3), half.x + 3, 8, tint.lightened(0.12))
		draw_arc(Vector2(0, top_y - 6), 8, PI, TAU, 10, dark, 3.0, true)


## A box with a hinged lid (bench, cigar box, tin, bread bin...), drawn to fit `size`.
func _draw_placeholder_box() -> void:
	var half := size / 2.0
	var dark := tint.darkened(0.4)
	var lid_height := size.y * 0.3
	var body := Rect2(-half.x, -half.y + lid_height, size.x, size.y - lid_height)
	PlaceholderArt.draw_ellipse(self, Vector2(0, half.y + 1), half.x + 4, 4, Color(0, 0, 0, 0.4))
	if is_open:
		draw_colored_polygon(PackedVector2Array([Vector2(-half.x, body.position.y), Vector2(half.x, body.position.y),
			Vector2(half.x - 4, body.position.y - lid_height * 1.6), Vector2(-half.x + 4, body.position.y - lid_height * 1.6)]), dark)
		draw_rect(Rect2(-half.x + 3, body.position.y - 3, size.x - 6, 7), Color(0.06, 0.05, 0.04))
	else:
		draw_rect(Rect2(-half.x, -half.y, size.x, lid_height), tint.lightened(0.12))
		draw_line(Vector2(-half.x, -half.y + lid_height), Vector2(half.x, -half.y + lid_height), dark, 2.0)
	draw_rect(body, tint)
	draw_rect(body.grow(-3), dark, false, 1.0)
	if not is_open:
		draw_rect(Rect2(-4, body.position.y - 2, 8, 7), PlaceholderArt.BEIGE_DARK)


## A row of fake book spines that swings open like a door (secret compartment).
func _draw_placeholder_book_spines() -> void:
	var half := size / 2.0
	var rng := RandomNumberGenerator.new()
	rng.seed = 21  # Same books every time.
	if is_open:
		draw_rect(Rect2(-half, size), Color(0.05, 0.04, 0.03))
		# The row of spines swung out to the left, seen almost edge-on.
		draw_colored_polygon(PackedVector2Array([Vector2(-half.x, -half.y), Vector2(-half.x - size.x * 0.25, -half.y + 6),
			Vector2(-half.x - size.x * 0.25, half.y - 2), Vector2(-half.x, half.y)]), tint.darkened(0.3))
		return
	var x := -half.x
	while x < half.x - 4.0:
		var width := minf(rng.randf_range(7.0, 12.0), half.x - x)
		var height := size.y - rng.randf_range(0.0, size.y * 0.18)
		var shade := tint.lerp(Color(rng.randf(), rng.randf() * 0.6, rng.randf() * 0.5), 0.35)
		draw_rect(Rect2(x, half.y - height, width - 1.0, height), shade)
		draw_line(Vector2(x + 2, half.y - height + 6), Vector2(x + width - 3, half.y - height + 6), Color(0.85, 0.7, 0.4, 0.6), 1.0)
		x += width


## A block of cloudy ice with something dark frozen inside. Cracks spread with
## every blow (hits_taken); once open, only a few broken chunks are left.
func _draw_placeholder_ice_block() -> void:
	var half := size / 2.0
	var ice := Color(0.72, 0.86, 0.95, 0.82)
	var ice_dark := Color(0.45, 0.62, 0.75, 0.9)
	PlaceholderArt.draw_ellipse(self, Vector2(0, half.y + 2), half.x + 4, 5, Color(0, 0, 0, 0.35))
	if is_open:
		for chunk: Vector2 in [Vector2(-half.x * 0.6, half.y - 6), Vector2(half.x * 0.5, half.y - 4), Vector2(0, half.y - 2)]:
			draw_colored_polygon(PackedVector2Array([chunk + Vector2(-9, 4), chunk + Vector2(-4, -6), chunk + Vector2(8, -3),
				chunk + Vector2(9, 5)]), ice)
		return
	draw_rect(Rect2(-half, size), ice_dark)
	draw_rect(Rect2(-half + Vector2(3, 3), size - Vector2(6, 6)), ice)
	# The shadow of whatever is frozen inside
	PlaceholderArt.draw_ellipse(self, Vector2(0, 2), half.x * 0.45, half.y * 0.35, Color(0.2, 0.25, 0.3, 0.45))
	draw_line(Vector2(-half.x + 6, -half.y + 6), Vector2(-half.x + 6, half.y - 10), Color(1, 1, 1, 0.6), 2.0)
	# Cracks, more for every blow
	var rng := RandomNumberGenerator.new()
	rng.seed = hash(container_id)
	for i in range(hits_taken * 3):
		var start := Vector2(rng.randf_range(-half.x * 0.6, half.x * 0.6), rng.randf_range(-half.y * 0.6, half.y * 0.6))
		var middle := start + Vector2(rng.randf_range(-14, 14), rng.randf_range(-14, 14))
		draw_polyline(PackedVector2Array([start, middle, middle + Vector2(rng.randf_range(-12, 12), rng.randf_range(-12, 12))]),
			Color(1, 1, 1, 0.85), 1.2)
