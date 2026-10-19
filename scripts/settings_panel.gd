class_name SettingsPanel
extends Control
## The Settings screen: music and effects volume, all sound on/off, and
## vibration. Used by the main menu and by the pause menu (the same scene).
## Every change takes effect at once and is written to the save file.

signal closed

@onready var _music_slider: HSlider = %MusicSlider
@onready var _music_value: Label = %MusicValue
@onready var _sfx_slider: HSlider = %SfxSlider
@onready var _sfx_value: Label = %SfxValue
@onready var _sound_check: CheckButton = %SoundCheck
@onready var _vibration_check: CheckButton = %VibrationCheck
@onready var _vibration_note: Label = %VibrationNote
@onready var _privacy_button: Button = %PrivacyButton
@onready var _privacy_policy: PrivacyPolicy = %PrivacyPolicy
@onready var _back_button: Button = %BackButton

var _dragging: bool = false


func _ready() -> void:
	hide()
	_music_slider.value_changed.connect(_on_music_changed)
	_sfx_slider.value_changed.connect(_on_sfx_changed)
	for slider in [_music_slider, _sfx_slider]:
		slider.drag_started.connect(func() -> void: _dragging = true)
		slider.drag_ended.connect(_on_drag_ended)
	_sound_check.toggled.connect(_on_sound_toggled)
	_vibration_check.toggled.connect(_on_vibration_toggled)
	_privacy_button.pressed.connect(_on_privacy_pressed)
	_privacy_policy.closed.connect(_privacy_button.grab_focus)
	_back_button.pressed.connect(close)
	_vibration_note.visible = not Haptics.is_available()


func is_open() -> bool:
	return visible


func open() -> void:
	# Show the saved values without triggering the "changed" handlers' saves.
	_music_slider.set_value_no_signal(SaveManager.music_volume * 100.0)
	_sfx_slider.set_value_no_signal(SaveManager.sfx_volume * 100.0)
	_music_value.text = _percent(_music_slider.value)
	_sfx_value.text = _percent(_sfx_slider.value)
	_sound_check.set_pressed_no_signal(not AudioManager.is_muted)
	_vibration_check.set_pressed_no_signal(SaveManager.vibration_enabled)
	show()
	_back_button.grab_focus()


func close() -> void:
	if not visible:
		return
	AudioManager.play_sfx("click")
	hide()
	closed.emit()


func _unhandled_input(event: InputEvent) -> void:
	if visible and event.is_action_pressed("ui_cancel"):
		if _privacy_policy.is_open():
			return
		get_viewport().set_input_as_handled()
		close()


func _percent(value: float) -> String:
	return "%d%%" % int(round(value))


func _on_music_changed(value: float) -> void:
	_music_value.text = _percent(value)
	AudioManager.set_music_volume(value / 100.0)
	if not _dragging:
		SaveManager.set_music_volume(value / 100.0)


func _on_sfx_changed(value: float) -> void:
	_sfx_value.text = _percent(value)
	AudioManager.set_sfx_volume(value / 100.0)
	if not _dragging:
		SaveManager.set_sfx_volume(value / 100.0)
		AudioManager.play_sfx("click")


## Saving once at the end of a drag, instead of at every pixel, keeps the file writes few.
func _on_drag_ended(_changed: bool) -> void:
	_dragging = false
	SaveManager.set_music_volume(_music_slider.value / 100.0)
	SaveManager.set_sfx_volume(_sfx_slider.value / 100.0)
	AudioManager.play_sfx("click")


func _on_sound_toggled(on: bool) -> void:
	AudioManager.set_muted(not on)
	SaveManager.set_sound_muted(not on)
	AudioManager.play_sfx("click")


func _on_vibration_toggled(on: bool) -> void:
	SaveManager.set_vibration_enabled(on)
	if on:
		Haptics.tap()


func _on_privacy_pressed() -> void:
	AudioManager.play_sfx("click")
	_privacy_policy.open()
