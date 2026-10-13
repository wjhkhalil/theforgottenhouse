class_name LetterPopup
extends CanvasLayer
## Shows the final mysterious letter on a sheet of "paper".
## The text comes from the room's LevelData, so it can be edited in the Inspector.

signal closed

@onready var _root: Control = %Root
@onready var _paper: Control = %Paper
@onready var _scroll: ScrollContainer = %LetterScroll
@onready var _page: Control = %LetterPage
@onready var _title_label: Label = %LetterTitle
@onready var _body_label: Label = %LetterBody
@onready var _signature_label: Label = %Signature
@onready var _close_button: Button = %CloseButton


func _ready() -> void:
	_root.hide()
	# A phone screen is short, so the letter is wider there (fewer, longer lines).
	if ScreenSettings.is_phone():
		_body_label.custom_minimum_size.x = 860.0
	_close_button.pressed.connect(close)


func is_open() -> bool:
	return _root.visible


func get_letter_text() -> String:
	return _body_label.text


func open(title: String, body: String, signature: String) -> void:
	_title_label.text = title
	_body_label.text = body
	_signature_label.text = signature
	_signature_label.visible = signature != ""
	_root.show()
	_fit_scroll()
	_root.modulate.a = 0.0
	create_tween().tween_property(_root, "modulate:a", 1.0, 0.6)
	_close_button.grab_focus()
	AudioManager.play_sfx("paper")


## A long letter scrolls, so the title and the Close button always stay on screen.
func _fit_scroll() -> void:
	_scroll.scroll_vertical = 0
	_scroll.custom_minimum_size.y = 0.0
	# The text needs a moment to wrap to the width of the paper before it can be measured.
	await get_tree().process_frame
	await get_tree().process_frame
	var around_text := _paper.get_combined_minimum_size().y
	var room_left := _root.size.y - around_text - 24.0
	_scroll.custom_minimum_size.y = minf(_page.get_combined_minimum_size().y, room_left)


func close() -> void:
	if not is_open():
		return
	AudioManager.play_sfx("click")
	_root.hide()
	closed.emit()


func _unhandled_input(event: InputEvent) -> void:
	if is_open() and event.is_action_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		close()
