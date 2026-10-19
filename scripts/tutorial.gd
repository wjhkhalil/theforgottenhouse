class_name Tutorial
extends CanvasLayer
## A short guided tutorial for the very first room. A card at the bottom of
## the screen explains one thing at a time, and a pointing hand taps a glowing
## marker on the thing to tap. The card never blocks the room: only its two
## buttons take input, so the player plays normally while reading.
##
## Steps advance by themselves when the player does the thing (finds an
## object, presses Hint) or by "Got it" for steps that only explain. Skip ends
## it at any time. Finishing or skipping sets the DONE_FLAG in the save file,
## so the tutorial is shown once per save.

signal finished

const DONE_FLAG := "tutorial_done"
## The marker's colours: warm gold on a dark halo, so it reads on any room.
const MARK_GOLD := Color(0.98, 0.82, 0.4)
const MARK_DARK := Color(0.08, 0.05, 0.02)
## One tap (hand bob and ripple) every this many seconds.
const MARK_PERIOD := 1.6
## Where the fingertip is in the hand picture, as a fraction of its size.
const HAND_TIP := Vector2(0.1018, 0.0625)
## The fingertip rests this far below and right of the marker's centre...
const HAND_REST := Vector2(8.0, 12.0)
## ...and lifts this far away between taps.
const HAND_LIFT := Vector2(16.0, 18.0)
## The shadow falls this far below and right of the hand.
const HAND_SHADOW := Vector2(7.0, 9.0)

enum Wait { OBJECT_FOUND, HINT_OR_GOT_IT, GOT_IT }

var _room: Node
var _steps: Array[Dictionary] = []
var _step: int = -1
var _time: float = 0.0
var _done: bool = false

@onready var _root: Control = %Root
@onready var _card: PanelContainer = %Card
@onready var _step_label: Label = %StepLabel
@onready var _title_label: Label = %TitleLabel
@onready var _body_label: Label = %BodyLabel
@onready var _got_it_button: Button = %GotItButton
@onready var _skip_button: Button = %SkipButton
@onready var _pointer: Control = %Pointer
@onready var _hand: TextureRect = %Hand
@onready var _hand_shadow: TextureRect = %HandShadow


func _ready() -> void:
	_root.hide()
	_got_it_button.pressed.connect(_on_got_it_pressed)
	_skip_button.pressed.connect(_on_skip_pressed)
	_pointer.draw.connect(_draw_pointer)


## Starts the tutorial for `room` (the RoomLevel node).
func start(room: Node) -> void:
	_room = room
	_room.game_manager.object_collected.connect(_on_object_collected)
	_room.game_manager.room_completed.connect(_on_room_completed)
	_room.hud.hint_requested.connect(_on_hint_requested)
	var phone: bool = ScreenSettings.is_phone()
	_steps = [
		{
			"title": "Find what was left behind",
			"body": "The list on the right shows every object hidden in this room. %s one in the room to pick it up. Start with the %s." % [
					"Tap" if phone else "Click", _first_object_name()],
			"wait": Wait.OBJECT_FOUND,
			"target": _first_object_position,
		},
		{
			"title": "Every object tells a story",
			"body": "Each find leaves a clue in the message at the top of the screen. All your clues and every letter you uncover are kept in the Journal, in the pause menu and on the main menu.",
			"wait": Wait.GOT_IT,
			"target": Callable(),
		},
		{
			"title": "Stuck? Ask for a hint",
			"body": "Hint circles roughly where an object is hiding. Finishing a chapter without hints earns a star, so save it for when you are truly stuck.",
			"wait": Wait.HINT_OR_GOT_IT,
			"target": _hint_button_position,
		},
		{
			"title": "Look closer",
			"body": "Pinch to zoom in on a corner, and drag to look around. Some things are very small." if phone
					else "Use the + and - buttons in the bottom-left corner, or Ctrl + mouse wheel, to zoom in. Drag with the right mouse button to look around.",
			"wait": Wait.GOT_IT,
			"target": _zoom_buttons_position if not phone else Callable(),
		},
		{
			"title": "Search carefully",
			"body": "%s on empty spots count as wrong taps. Make no more than %d and you earn the third star. That is everything: now find the rest." % [
					"Taps" if phone else "Clicks", RoomResult.MAX_WRONG_TAPS],
			"wait": Wait.GOT_IT,
			"target": Callable(),
		},
	]
	if phone:
		_use_compact_card()
	_root.show()
	_show_step(0)


## Phones have little room: a narrower card with smaller text.
func _use_compact_card() -> void:
	_card.custom_minimum_size.x = 470.0
	_card.offset_left = -235.0
	_card.offset_right = 235.0
	_body_label.custom_minimum_size.x = 426.0
	_body_label.add_theme_font_size_override("font_size", 14)
	_title_label.add_theme_font_size_override("font_size", 19)
	_got_it_button.custom_minimum_size.y = 32.0
	_skip_button.custom_minimum_size.y = 32.0


func is_running() -> bool:
	return not _done and _root.visible


func get_step() -> int:
	return _step


func _process(delta: float) -> void:
	_time += delta
	if _step < 0 or _done:
		return
	var target: Callable = _steps[_step]["target"]
	if target.is_valid():
		var at: Vector2 = target.call()
		_pointer.visible = at != Vector2.INF
		_pointer.position = at
	else:
		_pointer.visible = false
	_place_hand()
	_pointer.queue_redraw()


## The hand taps in time with the marker: it is down on the target when the
## ripple starts and lifts away in between.
func _place_hand() -> void:
	var pulse := fmod(_time, MARK_PERIOD) / MARK_PERIOD
	var lift := sin(pulse * PI)
	var tip := HAND_REST + HAND_LIFT * lift
	_hand.position = tip - HAND_TIP * _hand.size
	_hand_shadow.position = _hand.position + HAND_SHADOW * (0.6 + 0.4 * lift)


func _show_step(index: int) -> void:
	_step = index
	var step := _steps[index]
	_step_label.text = "Step %d of %d" % [index + 1, _steps.size()]
	# Bring the thing the marker points at onto the screen (phones show part of the room).
	if step["wait"] == Wait.OBJECT_FOUND:
		var hidden_object := _first_object()
		if hidden_object != null and _room.room_camera != null:
			_room.room_camera.focus_on(hidden_object.global_position)
	_title_label.text = step["title"]
	_body_label.text = step["body"]
	_got_it_button.visible = step["wait"] != Wait.OBJECT_FOUND
	_got_it_button.text = "Finish" if index == _steps.size() - 1 else "Got it"
	_skip_button.visible = index < _steps.size() - 1
	# The card slides up a little and fades in with each new step.
	_card.modulate.a = 0.0
	_card.position.y += 14.0
	var tween := create_tween().set_parallel(true)
	tween.tween_property(_card, "modulate:a", 1.0, 0.3)
	tween.tween_property(_card, "position:y", _card.position.y - 14.0, 0.3).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	if _got_it_button.visible:
		_got_it_button.grab_focus()


func _advance() -> void:
	if _done:
		return
	if _step + 1 >= _steps.size():
		_finish()
	else:
		_show_step(_step + 1)


func _finish() -> void:
	if _done:
		return
	_done = true
	SaveManager.set_flag(DONE_FLAG)
	_pointer.hide()
	var tween := create_tween()
	tween.tween_property(_root, "modulate:a", 0.0, 0.4)
	tween.tween_callback(_root.hide)
	tween.tween_callback(finished.emit)


func _on_got_it_pressed() -> void:
	AudioManager.play_sfx("click")
	_advance()


func _on_skip_pressed() -> void:
	AudioManager.play_sfx("click")
	_finish()


func _on_object_collected(_data: HiddenObjectData) -> void:
	if _step >= 0 and _steps[_step]["wait"] == Wait.OBJECT_FOUND:
		_advance()


func _on_hint_requested() -> void:
	if _step >= 0 and _steps[_step]["wait"] == Wait.HINT_OR_GOT_IT:
		_advance()


## The player finished the room on their own: nothing more to explain.
func _on_room_completed() -> void:
	_finish()


# --- Where the marker points -------------------------------------------------

func _first_object() -> HiddenObject:
	for hidden_object in _room.game_manager.hidden_objects:
		if hidden_object.data != null and hidden_object.data.is_required \
				and not hidden_object.is_collected and hidden_object.visible:
			return hidden_object
	return null


func _first_object_name() -> String:
	var hidden_object := _first_object()
	return hidden_object.data.display_name.to_lower() if hidden_object != null else "first object"


## Room positions become screen positions through the camera's transform.
func _first_object_position() -> Vector2:
	var hidden_object := _first_object()
	if hidden_object == null:
		return Vector2.INF
	return _room.get_viewport().get_canvas_transform() * hidden_object.global_position


func _hint_button_position() -> Vector2:
	return _room.hud.get_hint_button_rect().get_center()


func _zoom_buttons_position() -> Vector2:
	var screen := _room.get_viewport().get_visible_rect().size
	return Vector2(14.0 + 32.0, screen.y - 14.0 - 64.0)


# --- Drawing the marker ----------------------------------------------------------

func _draw_pointer() -> void:
	var pulse := fmod(_time, MARK_PERIOD) / MARK_PERIOD
	var breath := 0.5 + 0.5 * sin(_time * 2.4)
	# A soft golden halo around the spot, slowly breathing.
	for i in range(6):
		var radius := 46.0 - i * 6.0
		var alpha := 0.035 + 0.025 * breath
		_pointer.draw_circle(Vector2.ZERO, radius, Color(MARK_GOLD, alpha))
	# The ripple: a ring that spreads out from the tap and fades away.
	var ripple := clampf((pulse - 0.15) / 0.85, 0.0, 1.0)
	var ripple_ease := 1.0 - pow(1.0 - ripple, 2.0)
	var ripple_radius := 18.0 + ripple_ease * 34.0
	var ripple_alpha := (1.0 - ripple_ease) * 0.9
	_pointer.draw_arc(Vector2.ZERO, ripple_radius, 0.0, TAU, 64,
			Color(MARK_DARK, ripple_alpha * 0.5), 5.0, true)
	_pointer.draw_arc(Vector2.ZERO, ripple_radius, 0.0, TAU, 64,
			Color(MARK_GOLD, ripple_alpha), 2.5, true)
	# The steady ring, with a dark edge so it shows on light and dark alike.
	_pointer.draw_arc(Vector2.ZERO, 18.0, 0.0, TAU, 48, Color(MARK_DARK, 0.55), 5.0, true)
	_pointer.draw_arc(Vector2.ZERO, 18.0, 0.0, TAU, 48, Color(MARK_GOLD, 0.95), 2.5, true)
	# The tap: a dot that lands in the middle of the ring and then melts away.
	var tap := clampf(pulse / 0.35, 0.0, 1.0)
	var tap_size := 7.0 * (1.0 - pow(1.0 - minf(tap * 2.0, 1.0), 3.0))
	var tap_alpha := 1.0 - clampf((tap - 0.5) * 2.0, 0.0, 1.0)
	if tap_alpha > 0.0:
		_pointer.draw_circle(Vector2.ZERO, tap_size + 2.0, Color(MARK_DARK, tap_alpha * 0.5))
		_pointer.draw_circle(Vector2.ZERO, tap_size, Color(MARK_GOLD, tap_alpha))
