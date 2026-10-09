class_name VictoryScreen
extends CanvasLayer
## The "chapter complete" screen shown after every object is found.

signal continue_requested
signal read_letter_requested
signal replay_requested
signal main_menu_requested

@onready var _root: Control = %Root
@onready var _title_label: Label = %TitleLabel
@onready var _summary_label: Label = %SummaryLabel
@onready var _hook_label: Label = %HookLabel
@onready var _continue_button: Button = %ContinueButton
@onready var _read_letter_button: Button = %ReadLetterButton
@onready var _replay_button: Button = %ReplayButton
@onready var _main_menu_button: Button = %MainMenuButton
@onready var _continued_label: Label = $Root/Center/Panel/VBox/ToBeContinued


func _ready() -> void:
	_root.hide()
	_continue_button.pressed.connect(_on_continue_pressed)
	_read_letter_button.pressed.connect(_on_read_letter_pressed)
	_replay_button.pressed.connect(_on_replay_pressed)
	_main_menu_button.pressed.connect(_on_main_menu_pressed)


func is_open() -> bool:
	return _root.visible


## `next_chapter_title` is empty for the last chapter (then there is no Continue button).
## `more_coming`: the last chapter so far, but its house has more chapters to come.
func show_victory(title: String, hook: String, found_count: int, total_count: int, next_chapter_title: String = "",
		more_coming: bool = false) -> void:
	_title_label.text = title
	_continue_button.visible = next_chapter_title != ""
	_continue_button.text = "Continue: " + next_chapter_title.get_slice(":", 0)
	_continue_button.tooltip_text = next_chapter_title
	if next_chapter_title != "":
		_continued_label.text = "To be continued..."
	elif more_coming:
		_continued_label.text = "To be continued... more chapters coming soon."
	else:
		_continued_label.text = "THE END"
	_hook_label.text = hook
	_summary_label.text = "Objects Found: %d / %d" % [found_count, total_count]
	_root.show()
	_root.modulate.a = 0.0
	create_tween().tween_property(_root, "modulate:a", 1.0, 0.8)
	if _continue_button.visible:
		_continue_button.grab_focus()
	else:
		_replay_button.grab_focus()


func _on_continue_pressed() -> void:
	AudioManager.play_sfx("click")
	continue_requested.emit()


func _on_read_letter_pressed() -> void:
	AudioManager.play_sfx("click")
	read_letter_requested.emit()


func _on_replay_pressed() -> void:
	AudioManager.play_sfx("click")
	replay_requested.emit()


func _on_main_menu_pressed() -> void:
	AudioManager.play_sfx("click")
	main_menu_requested.emit()
