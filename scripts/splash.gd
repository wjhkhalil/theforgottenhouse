extends Control
## Splash screen shown once at launch. It shows the same painting as the engine
## boot splash, so the two blend into one still picture, holds for a moment,
## then fades out into the main menu. Any tap, click or key skips straight to
## the menu.

const MAIN_MENU_SCENE := "res://scenes/main_menu.tscn"

const HOLD := 2.2
const FADE_OUT := 0.8
const SKIP_FADE_OUT := 0.25

var _tween: Tween
var _leaving: bool = false


func _ready() -> void:
	_tween = create_tween()
	_tween.tween_interval(HOLD)
	_tween.tween_callback(_leave.bind(FADE_OUT))


func _input(event: InputEvent) -> void:
	var pressed := (event is InputEventMouseButton or event is InputEventScreenTouch \
			or event is InputEventKey) and event.is_pressed()
	if pressed:
		get_viewport().set_input_as_handled()
		_leave(SKIP_FADE_OUT)


## Fades the whole screen out over `duration` seconds, then opens the menu.
func _leave(duration: float) -> void:
	if _leaving:
		return
	_leaving = true
	if _tween and _tween.is_valid():
		_tween.kill()
	_tween = create_tween()
	_tween.tween_property(self, "modulate:a", 0.0, duration)
	_tween.tween_callback(_open_menu)


func _open_menu() -> void:
	get_tree().change_scene_to_file(MAIN_MENU_SCENE)
