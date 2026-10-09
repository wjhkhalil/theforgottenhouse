class_name NotificationPopup
extends CanvasLayer
## Shows a short message at the top of the screen that fades away by itself.
## Every node in this scene ignores the mouse, so a notification can never
## block a click on a hidden object.

## How long a message stays fully visible (seconds).
@export var default_duration: float = 4.0

var _tween: Tween

@onready var _panel: Control = %Panel
@onready var _title_label: Label = %TitleLabel
@onready var _body_label: Label = %BodyLabel


func _ready() -> void:
	_panel.hide()


## Shows `title` and an optional `body`. A new message replaces the old one.
func show_message(title: String, body: String = "", duration: float = -1.0) -> void:
	if duration <= 0.0:
		duration = default_duration
	_title_label.text = title
	_body_label.text = body
	_body_label.visible = body != ""

	if _tween != null:
		_tween.kill()
	_panel.show()
	_panel.modulate.a = 0.0
	_tween = create_tween()
	_tween.tween_property(_panel, "modulate:a", 1.0, 0.25)
	_tween.tween_interval(duration)
	_tween.tween_property(_panel, "modulate:a", 0.0, 0.6)
	_tween.tween_callback(_panel.hide)


func hide_now() -> void:
	if _tween != null:
		_tween.kill()
	_panel.hide()


func is_showing() -> bool:
	return _panel.visible


func get_title() -> String:
	return _title_label.text
