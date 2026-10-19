extends Control
## Splash screen shown once at launch. It shows the main menu's painting, with
## the title easing in over it, holds for a moment, then fades out into the
## main menu. The engine boot splash is the same painting, so launch reads as
## one picture on which the title appears. Any tap, click or key skips
## straight to the menu.
##
## The viewport is let grow to the real shape of the screen while the splash
## is up, so the painting covers it edge to edge even where the game itself
## keeps a fixed 16:9 playfield (on computers). The previous setting is put
## back just before the menu opens.

const MAIN_MENU_SCENE := "res://scenes/main_menu.tscn"

## The title fades in and settles from slightly larger over this long.
const TITLE_IN := 1.2
const TITLE_START_SCALE := 1.12
## How long the finished picture stays before fading into the menu.
const HOLD := 1.8
const FADE_OUT := 0.8
const SKIP_FADE_OUT := 0.25
## The title glows a little brighter and back, over and over, while held.
const GLOW := Color(1.18, 1.14, 1.06)
const GLOW_PERIOD := 1.4

@onready var _title: TextureRect = %Title

var _tween: Tween
var _glow: Tween
var _leaving: bool = false
var _previous_aspect: Window.ContentScaleAspect


func _ready() -> void:
	_previous_aspect = get_window().content_scale_aspect
	get_window().content_scale_aspect = Window.CONTENT_SCALE_ASPECT_EXPAND
	_title.modulate.a = 0.0
	_title.scale = Vector2.ONE * TITLE_START_SCALE
	_title.resized.connect(_center_title_pivot)
	_center_title_pivot()
	_tween = create_tween().set_parallel(true)
	_tween.tween_property(_title, "modulate:a", 1.0, TITLE_IN)
	_tween.tween_property(_title, "scale", Vector2.ONE, TITLE_IN) \
			.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	_tween.chain().tween_callback(_start_glow)
	_tween.chain().tween_interval(HOLD)
	_tween.chain().tween_callback(_leave.bind(FADE_OUT))


## Keeps the title growing and shrinking about its middle.
func _center_title_pivot() -> void:
	_title.pivot_offset = _title.size / 2.0


func _start_glow() -> void:
	_glow = create_tween().set_loops()
	_glow.tween_property(_title, "modulate", GLOW, GLOW_PERIOD / 2.0) \
			.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	_glow.tween_property(_title, "modulate", Color.WHITE, GLOW_PERIOD / 2.0) \
			.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)


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
	if _glow and _glow.is_valid():
		_glow.kill()
	get_window().content_scale_aspect = _previous_aspect
	get_tree().change_scene_to_file(MAIN_MENU_SCENE)
