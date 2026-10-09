class_name PauseMenu
extends CanvasLayer
## Pause menu. This CanvasLayer uses process_mode = Always, so it keeps working
## while the rest of the game is paused with get_tree().paused = true.
## While it is open, a dark full-screen panel blocks all clicks on the room.

signal restart_requested
signal main_menu_requested

@onready var _root: Control = %Root
@onready var _resume_button: Button = %ResumeButton
@onready var _restart_button: Button = %RestartButton
@onready var _main_menu_button: Button = %MainMenuButton


func _ready() -> void:
	_root.hide()
	_resume_button.pressed.connect(_on_resume_pressed)
	_restart_button.pressed.connect(_on_restart_pressed)
	_main_menu_button.pressed.connect(_on_main_menu_pressed)


func is_open() -> bool:
	return _root.visible


func open() -> void:
	if is_open():
		return
	get_tree().paused = true  # Stops hidden objects, tweens and timers.
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	_root.show()
	_resume_button.grab_focus()
	AudioManager.play_sfx("pause")


func close() -> void:
	_root.hide()
	get_tree().paused = false


func _unhandled_input(event: InputEvent) -> void:
	if is_open() and event.is_action_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		close()


func _on_resume_pressed() -> void:
	AudioManager.play_sfx("click")
	close()


func _on_restart_pressed() -> void:
	AudioManager.play_sfx("click")
	_root.hide()
	restart_requested.emit()


func _on_main_menu_pressed() -> void:
	AudioManager.play_sfx("click")
	_root.hide()
	main_menu_requested.emit()
