class_name RoomCamera
extends Camera2D
## The camera of EVERY room. It lets the player zoom in and look around.
##
## ZOOM: the + and - buttons in the bottom-left corner, Ctrl + mouse wheel,
## or pinching with two fingers on a phone.
## LOOKING AROUND (when zoomed in, or in a room bigger than the screen, like
## Chapter Four's tall staircase or House Two's wide jetty):
##   * computer: mouse wheel (up/down; sideways in a wide room), arrow keys /
##     WASD, dragging with the right or middle mouse button, or holding the
##     mouse near the edge of the screen;
##   * phone: dragging with one finger. In rooms where the finger moves the
##     lantern light or wipes steam, drag with two fingers instead.
## Arrows on screen show when there is more room above, below, left or right.
##
## Clicking objects keeps working while zoomed or scrolled: Godot converts
## mouse positions through the camera automatically.
##
## `position` is the top-left corner of what the player sees, in room pixels.

## Size of the whole room drawing.
@export var room_size: Vector2 = Vector2(1280, 720)
## Pixels per second when scrolling with keys or the screen edges.
@export var scroll_speed: float = 650.0
## Pixels per mouse-wheel notch.
@export var wheel_step: float = 90.0
## Height of the hot zones at the top (under the HUD bar) and bottom of the screen.
@export var edge_size: float = 44.0
## How far the player can zoom in (2.5 = two and a half times bigger).
@export var max_zoom: float = 2.5
## How much one press of + or - (or one Ctrl + wheel notch) zooms.
@export var zoom_step: float = 1.25
## When false, one finger does NOT move the view on a phone (two fingers do).
## The room turns this off when a finger is needed for the lantern or steam.
@export var one_finger_pan: bool = true

## The room turns this off while a keypad or the completion screen is shown.
var scroll_enabled: bool = true

const HUD_BAR_HEIGHT := 56.0
const ZOOM_BUTTON_SIZE := 64.0

var _focus_tween: Tween
var _up_arrow: Node2D
var _down_arrow: Node2D
var _left_arrow: Node2D
var _right_arrow: Node2D
var _zoom_buttons: Control
var _zoom_in_button: Button
var _zoom_out_button: Button
## Fingers currently on the screen: finger index -> screen position.
var _touches: Dictionary = {}
## Distance between two fingers at the last pinch step.
var _pinch_distance: float = 0.0
var _dragging_with_mouse: bool = false


func _ready() -> void:
	anchor_mode = Camera2D.ANCHOR_MODE_FIXED_TOP_LEFT
	limit_left = 0
	limit_top = 0
	limit_right = int(room_size.x)
	limit_bottom = int(room_size.y)
	make_current()
	_build_arrows()
	_build_zoom_buttons()
	# On a touch screen the "mouse" stays where the finger last was, so
	# edge scrolling would never stop. Phones drag to scroll instead.
	if ScreenSettings.is_phone():
		edge_size = 0.0
	set_zoom_level(get_min_zoom())


# ---------------------------------------------------------------------------
# Zoom
# ---------------------------------------------------------------------------

## Smallest zoom: the room just fills the screen (never shows space outside it).
func get_min_zoom() -> float:
	var screen := get_viewport_rect().size
	return maxf(1.0, maxf(screen.x / room_size.x, screen.y / room_size.y))


func get_zoom_level() -> float:
	return zoom.x


## Zooms so the room point under `screen_point` stays under it.
## Without `screen_point`, the middle of the screen stays in place.
func set_zoom_level(level: float, screen_point: Vector2 = Vector2(-1, -1)) -> void:
	var screen := get_viewport_rect().size
	if screen_point.x < 0.0:
		screen_point = screen / 2.0
	var room_point := position + screen_point / zoom.x
	var new_level := clampf(level, get_min_zoom(), maxf(max_zoom, get_min_zoom()))
	zoom = Vector2(new_level, new_level)
	_move_to(room_point - screen_point / new_level)
	_update_zoom_buttons()


func zoom_in(screen_point: Vector2 = Vector2(-1, -1)) -> void:
	set_zoom_level(get_zoom_level() * zoom_step, screen_point)


func zoom_out(screen_point: Vector2 = Vector2(-1, -1)) -> void:
	set_zoom_level(get_zoom_level() / zoom_step, screen_point)


# ---------------------------------------------------------------------------
# Moving the view
# ---------------------------------------------------------------------------

## Size of the visible part of the room, in room pixels.
func get_view_size() -> Vector2:
	return get_viewport_rect().size / zoom.x


## How far down the camera can go.
func get_max_scroll() -> float:
	return maxf(room_size.y - get_view_size().y, 0.0)


## How far right the camera can go (when zoomed in, or in a wide room).
func get_max_scroll_x() -> float:
	return maxf(room_size.x - get_view_size().x, 0.0)


## True for rooms wider than the screen (House Two's jetty).
func _is_wide_room() -> bool:
	return room_size.x > get_viewport_rect().size.x + 1.0


func scroll_by(amount: float) -> void:
	pan_by(Vector2(0.0, amount))


## Moves the view by `amount` room pixels.
func pan_by(amount: Vector2) -> void:
	if _focus_tween != null:
		_focus_tween.kill()
	_move_to(position + amount)


func _move_to(top_left: Vector2) -> void:
	position = Vector2(clampf(top_left.x, 0.0, get_max_scroll_x()), clampf(top_left.y, 0.0, get_max_scroll()))


## Smoothly moves so `world_position` is in the middle of the screen (used by hints).
func focus_on(world_position: Vector2, instant: bool = false) -> void:
	var view := get_view_size()
	var target := Vector2(clampf(world_position.x - view.x / 2.0, 0.0, get_max_scroll_x()),
			clampf(world_position.y - view.y / 2.0, 0.0, get_max_scroll()))
	if _focus_tween != null:
		_focus_tween.kill()
	if instant:
		position = target
		return
	_focus_tween = create_tween()
	_focus_tween.tween_property(self, "position", target, 0.6).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)


func _process(delta: float) -> void:
	_update_arrows()
	_zoom_buttons.visible = scroll_enabled and not get_tree().paused
	if not scroll_enabled:
		return
	var direction := Vector2.ZERO
	if Input.is_key_pressed(KEY_UP) or Input.is_key_pressed(KEY_W):
		direction.y -= 1.0
	if Input.is_key_pressed(KEY_DOWN) or Input.is_key_pressed(KEY_S):
		direction.y += 1.0
	if Input.is_key_pressed(KEY_LEFT) or Input.is_key_pressed(KEY_A):
		direction.x -= 1.0
	if Input.is_key_pressed(KEY_RIGHT) or Input.is_key_pressed(KEY_D):
		direction.x += 1.0
	var screen := get_viewport_rect()
	var mouse := get_viewport().get_mouse_position()
	if edge_size > 0.0 and screen.has_point(mouse) and get_window().has_focus():
		if mouse.y > HUD_BAR_HEIGHT and mouse.y < HUD_BAR_HEIGHT + edge_size:
			direction.y -= 1.0
		elif mouse.y > screen.size.y - edge_size:
			direction.y += 1.0
		# Left and right edges only in rooms wider than the screen, and only
		# beside the middle of the screen (not over the zoom buttons).
		if _is_wide_room() and mouse.y > HUD_BAR_HEIGHT + edge_size and mouse.y < screen.size.y - 170.0:
			if mouse.x < edge_size:
				direction.x -= 1.0
			elif mouse.x > screen.size.x - edge_size:
				direction.x += 1.0
	if direction != Vector2.ZERO:
		pan_by(direction * scroll_speed * delta / zoom.x)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		_handle_touch(event)
		return
	if not scroll_enabled:
		return
	var button := event as InputEventMouseButton
	if button != null:
		_handle_mouse_button(button)
		return
	var motion := event as InputEventMouseMotion
	if motion != null and _dragging_with_mouse:
		pan_by(-motion.relative / zoom.x)


func _handle_mouse_button(button: InputEventMouseButton) -> void:
	if button.button_index == MOUSE_BUTTON_RIGHT or button.button_index == MOUSE_BUTTON_MIDDLE:
		_dragging_with_mouse = button.pressed
		return
	if not button.pressed:
		return
	var up := button.button_index == MOUSE_BUTTON_WHEEL_UP
	var down := button.button_index == MOUSE_BUTTON_WHEEL_DOWN
	if not up and not down:
		return
	var step := (-wheel_step if up else wheel_step) / zoom.x
	if button.ctrl_pressed:
		if up:
			zoom_in(button.position)
		else:
			zoom_out(button.position)
	elif button.shift_pressed or get_max_scroll() <= 0.0:
		# Shift + wheel, or a room with nothing above or below: scroll sideways.
		pan_by(Vector2(step, 0.0))
	else:
		scroll_by(step)


## Phones: one finger drags the view, two fingers pinch to zoom (and drag).
func _handle_touch(event: InputEvent) -> void:
	var touch := event as InputEventScreenTouch
	if touch != null:
		if touch.pressed:
			_touches[touch.index] = touch.position
		else:
			_touches.erase(touch.index)
		_pinch_distance = _get_pinch_distance()
		return
	var drag := event as InputEventScreenDrag
	if not _touches.has(drag.index):
		_touches[drag.index] = drag.position
	if not scroll_enabled:
		_touches[drag.index] = drag.position
		return
	if _touches.size() >= 2:
		# Two fingers: both pan (half each, so the room follows the middle)...
		pan_by(-drag.relative / 2.0 / zoom.x)
		_touches[drag.index] = drag.position
		# ...and pinch to zoom around the point between the fingers.
		var distance := _get_pinch_distance()
		if _pinch_distance > 0.0 and distance > 0.0:
			set_zoom_level(get_zoom_level() * distance / _pinch_distance, _get_pinch_center())
		_pinch_distance = distance
	else:
		_touches[drag.index] = drag.position
		if one_finger_pan:
			pan_by(-drag.relative / zoom.x)


func _get_pinch_distance() -> float:
	if _touches.size() < 2:
		return 0.0
	var points: Array = _touches.values()
	return (points[0] as Vector2).distance_to(points[1] as Vector2)


func _get_pinch_center() -> Vector2:
	var points: Array = _touches.values()
	return ((points[0] as Vector2) + (points[1] as Vector2)) / 2.0


# ---------------------------------------------------------------------------
# On-screen arrows and zoom buttons (on a screen layer, they don't move with the room)
# ---------------------------------------------------------------------------

func _build_arrows() -> void:
	var layer := CanvasLayer.new()
	layer.layer = 1
	add_child(layer)
	var screen := get_viewport_rect().size
	_up_arrow = _make_arrow(Vector2(screen.x * 0.42, HUD_BAR_HEIGHT + 22), true)
	_down_arrow = _make_arrow(Vector2(screen.x * 0.42, screen.y - 22), false)
	layer.add_child(_up_arrow)
	layer.add_child(_down_arrow)
	# Sideways arrows sit at the bottom, clear of the zoom buttons and the objective list.
	_left_arrow = _make_side_arrow(Vector2(130, screen.y - 30), true)
	_right_arrow = _make_side_arrow(Vector2(screen.x - 40, screen.y - 30), false)
	layer.add_child(_left_arrow)
	layer.add_child(_right_arrow)


func _make_arrow(at: Vector2, pointing_up: bool) -> Node2D:
	var arrow := Node2D.new()
	arrow.position = at
	var tip := -12.0 if pointing_up else 12.0
	var shape := Polygon2D.new()
	shape.polygon = PackedVector2Array([Vector2(-18, -tip * 0.6), Vector2(18, -tip * 0.6), Vector2(0, tip)])
	shape.color = Color(PlaceholderArt.WARM, 0.75)
	arrow.add_child(shape)
	var label := Label.new()
	label.text = "More above" if pointing_up else "More below"
	label.position = Vector2(26, -14)
	label.add_theme_font_size_override("font_size", 16)
	label.add_theme_color_override("font_color", Color(PlaceholderArt.WARM, 0.85))
	label.add_theme_constant_override("outline_size", 4)
	label.add_theme_color_override("font_outline_color", Color(0, 0, 0, 0.8))
	arrow.add_child(label)
	return arrow


func _make_side_arrow(at: Vector2, pointing_left: bool) -> Node2D:
	var arrow := Node2D.new()
	arrow.position = at
	var tip := -12.0 if pointing_left else 12.0
	var shape := Polygon2D.new()
	shape.polygon = PackedVector2Array([Vector2(-tip * 0.6, -18), Vector2(-tip * 0.6, 18), Vector2(tip, 0)])
	shape.color = Color(PlaceholderArt.WARM, 0.75)
	arrow.add_child(shape)
	var label := Label.new()
	label.text = "More left" if pointing_left else "More right"
	label.position = Vector2(20, -12) if pointing_left else Vector2(-108, -12)
	label.add_theme_font_size_override("font_size", 16)
	label.add_theme_color_override("font_color", Color(PlaceholderArt.WARM, 0.85))
	label.add_theme_constant_override("outline_size", 4)
	label.add_theme_color_override("font_outline_color", Color(0, 0, 0, 0.8))
	arrow.add_child(label)
	return arrow


func _update_arrows() -> void:
	if _up_arrow == null:
		return
	var show_arrows := scroll_enabled and not get_tree().paused
	_up_arrow.visible = show_arrows and position.y > 4.0
	_down_arrow.visible = show_arrows and position.y < get_max_scroll() - 4.0
	_left_arrow.visible = show_arrows and position.x > 4.0
	_right_arrow.visible = show_arrows and position.x < get_max_scroll_x() - 4.0


## The + and - buttons in the bottom-left corner.
func _build_zoom_buttons() -> void:
	var layer := CanvasLayer.new()
	layer.layer = 1
	add_child(layer)
	_zoom_buttons = VBoxContainer.new()
	_zoom_buttons.name = "ZoomButtons"
	_zoom_buttons.add_theme_constant_override("separation", 8)
	layer.add_child(_zoom_buttons)
	_zoom_in_button = _make_zoom_button("+", "Zoom in (Ctrl + mouse wheel, or pinch on a phone)")
	_zoom_in_button.pressed.connect(zoom_in)
	_zoom_out_button = _make_zoom_button("–", "Zoom out")
	_zoom_out_button.pressed.connect(zoom_out)
	var screen := get_viewport_rect().size
	_zoom_buttons.position = Vector2(14, screen.y - 14 - ZOOM_BUTTON_SIZE * 2 - 8)


func _make_zoom_button(text: String, tooltip: String) -> Button:
	var button := Button.new()
	button.text = text
	button.tooltip_text = tooltip
	button.custom_minimum_size = Vector2(ZOOM_BUTTON_SIZE, ZOOM_BUTTON_SIZE)
	button.add_theme_font_size_override("font_size", 34)
	button.focus_mode = Control.FOCUS_NONE
	_zoom_buttons.add_child(button)
	return button


func _update_zoom_buttons() -> void:
	if _zoom_in_button == null:
		return
	_zoom_in_button.disabled = get_zoom_level() >= maxf(max_zoom, get_min_zoom()) - 0.001
	_zoom_out_button.disabled = get_zoom_level() <= get_min_zoom() + 0.001
