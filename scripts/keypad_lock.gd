class_name KeypadLock
extends CanvasLayer
## A 4-digit keypad: used before a room can be searched (entry lock), and for
## code-locked containers inside a room (such as a safe).
## Works with the mouse (buttons) and the keyboard (number keys, Backspace, Enter).
## After a few wrong tries it shows stronger hints, so nobody gets stuck.

signal unlocked
signal main_menu_requested
## Emitted by the "Step Back" button (only for keypads opened with a cancel text).
signal cancelled

var wrong_attempts: int = 0
## Number of wrong tries before each hint appears (set by open()).
var first_hint_after: int = 2
var second_hint_after: int = 4

var _cancel_mode: bool = false

var _code: String = ""
var _entered: String = ""
var _hint_first: String = ""
var _hint_second: String = ""

@onready var _root: Control = %Root
@onready var _title_label: Label = %KeypadTitle
@onready var _prompt_label: Label = %Prompt
@onready var _display_label: Label = %Display
@onready var _message_label: Label = %Message
@onready var _button_grid: GridContainer = %ButtonGrid
@onready var _menu_button: Button = %KeypadMenuButton


func _ready() -> void:
	_root.hide()
	_menu_button.pressed.connect(_on_menu_pressed)
	_build_buttons()
	if ScreenSettings.is_phone():
		_use_side_by_side_layout()


## A phone screen is too short for everything in one column, so the number
## buttons move to the right of the text.
func _use_side_by_side_layout() -> void:
	var column := _button_grid.get_parent()
	var panel := column.get_parent()
	var row := HBoxContainer.new()
	row.add_theme_constant_override("separation", 28)
	panel.remove_child(column)
	panel.add_child(row)
	row.add_child(column)
	_button_grid.reparent(row)
	_button_grid.size_flags_vertical = Control.SIZE_SHRINK_CENTER


func is_open() -> bool:
	return _root.visible


func open(title: String, prompt: String, code: String, hint_first: String, hint_second: String,
		hint_first_after: int = 2, hint_second_after: int = 4, cancel_text: String = "") -> void:
	# With a cancel text, the bottom button closes the keypad instead of going to the menu.
	_cancel_mode = cancel_text != ""
	_menu_button.text = cancel_text if _cancel_mode else "Back to Main Menu"
	first_hint_after = hint_first_after
	second_hint_after = hint_second_after
	_title_label.text = title
	_prompt_label.text = prompt
	_code = code
	_hint_first = hint_first
	_hint_second = hint_second
	_entered = ""
	wrong_attempts = 0
	_message_label.text = "Enter the %d-digit code." % _code.length()
	_message_label.remove_theme_color_override("font_color")
	_update_display()
	_root.show()


## Adds one digit, like pressing a key on the keypad.
func press_digit(digit: String) -> void:
	if _entered.length() >= _code.length():
		return
	_entered += digit
	AudioManager.play_sfx("keypress")
	_update_display()


func clear_entry() -> void:
	_entered = ""
	_update_display()


func submit() -> void:
	if _entered.length() < _code.length():
		_show_message("The code needs %d digits." % _code.length(), Color(0.95, 0.76, 0.48))
		return
	if _entered == _code:
		AudioManager.play_sfx("unlock")
		_root.hide()
		unlocked.emit()
		return

	wrong_attempts += 1
	AudioManager.play_sfx("wrong")
	_entered = ""
	_update_display()
	var message := "Wrong code. The lock does not move."
	if wrong_attempts >= second_hint_after and _hint_second != "":
		message = _hint_second
	elif wrong_attempts >= first_hint_after and _hint_first != "":
		message = _hint_first
	_show_message(message, Color(0.95, 0.55, 0.45))
	# Flash the display red.
	_display_label.modulate = Color(1.6, 0.6, 0.5)
	create_tween().tween_property(_display_label, "modulate", Color.WHITE, 0.5)


func _unhandled_input(event: InputEvent) -> void:
	if not is_open():
		return
	var key_event := event as InputEventKey
	if key_event == null or not key_event.pressed or key_event.echo:
		return
	var handled := true
	if key_event.keycode >= KEY_0 and key_event.keycode <= KEY_9:
		press_digit(str(key_event.keycode - KEY_0))
	elif key_event.keycode >= KEY_KP_0 and key_event.keycode <= KEY_KP_9:
		press_digit(str(key_event.keycode - KEY_KP_0))
	elif key_event.keycode == KEY_BACKSPACE:
		_entered = _entered.left(-1) if _entered.length() > 0 else ""
		_update_display()
	elif key_event.keycode == KEY_ENTER or key_event.keycode == KEY_KP_ENTER:
		submit()
	else:
		handled = false
	if handled:
		get_viewport().set_input_as_handled()


func _build_buttons() -> void:
	# Layout:  1 2 3 / 4 5 6 / 7 8 9 / Clear 0 Enter
	var labels: Array[String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "Clear", "0", "Enter"]
	for label in labels:
		var button := Button.new()
		button.text = label
		button.name = "Key" + label
		button.custom_minimum_size = Vector2(84, 54)
		button.focus_mode = Control.FOCUS_NONE
		button.add_theme_font_size_override("font_size", 22 if label.length() == 1 else 17)
		if label == "Clear":
			button.pressed.connect(clear_entry)
		elif label == "Enter":
			button.pressed.connect(submit)
		else:
			button.pressed.connect(press_digit.bind(label))
		_button_grid.add_child(button)


func _update_display() -> void:
	var shown := ""
	for i in range(_code.length()):
		shown += (_entered[i] if i < _entered.length() else "_") + " "
	_display_label.text = shown.strip_edges()


func _show_message(text: String, color: Color) -> void:
	_message_label.text = text
	_message_label.add_theme_color_override("font_color", color)


func _on_menu_pressed() -> void:
	AudioManager.play_sfx("click")
	if _cancel_mode:
		_root.hide()
		cancelled.emit()
	else:
		main_menu_requested.emit()
