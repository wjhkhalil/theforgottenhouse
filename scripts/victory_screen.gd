class_name VictoryScreen
extends CanvasLayer
## The "chapter complete" screen shown after every object is found.

signal continue_requested
signal read_letter_requested
signal replay_requested
signal main_menu_requested

@onready var _root: Control = %Root
@onready var _center: Control = $Root/Center
@onready var _title_label: Label = %TitleLabel
@onready var _summary_label: Label = %SummaryLabel
@onready var _stars: StarRating = %Stars
@onready var _stats_label: Label = %StatsLabel
@onready var _best_label: Label = %BestLabel
@onready var _rules_box: VBoxContainer = %RulesBox
@onready var _hook_label: Label = %HookLabel
@onready var _continue_button: Button = %ContinueButton
@onready var _read_letter_button: Button = %ReadLetterButton
@onready var _replay_button: Button = %ReplayButton
@onready var _main_menu_button: Button = %MainMenuButton
@onready var _continued_label: Label = $Root/Center/Panel/VBox/ToBeContinued


func _ready() -> void:
	_root.hide()
	_root.resized.connect(_fit_panel)
	_continue_button.pressed.connect(_on_continue_pressed)
	_read_letter_button.pressed.connect(_on_read_letter_pressed)
	_replay_button.pressed.connect(_on_replay_pressed)
	_main_menu_button.pressed.connect(_on_main_menu_pressed)


func is_open() -> bool:
	return _root.visible


## `next_chapter_title` is empty for the last chapter (then there is no Continue button).
## `more_coming`: the last chapter so far, but its house has more chapters to come.
## `result`: the room's score, as made by RoomLevel: {"stars", "seconds", "hints",
## "wrong_taps", "first", "new_best_stars", "new_best_time", "best_time"}.
## Without it the score part of the screen stays hidden.
func show_victory(title: String, hook: String, found_count: int, total_count: int, next_chapter_title: String = "",
		more_coming: bool = false, result: Dictionary = {}) -> void:
	_title_label.text = title
	_show_result(result)
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
	_fit_panel.call_deferred()
	_root.modulate.a = 0.0
	create_tween().tween_property(_root, "modulate:a", 1.0, 0.8)
	if _continue_button.visible:
		_continue_button.grab_focus()
	else:
		_replay_button.grab_focus()


## The panel is drawn smaller when the screen (a phone) is too short for all of it.
func _fit_panel() -> void:
	if not is_inside_tree():
		return
	var needed := _center.get_combined_minimum_size()
	if needed.x <= 0.0 or needed.y <= 0.0:
		return
	var fit := minf(1.0, minf(_root.size.x / (needed.x + 24.0), _root.size.y / (needed.y + 24.0)))
	_center.pivot_offset = _root.size / 2.0
	_center.scale = Vector2(fit, fit)


## The number of stars shown (what the test reads).
func get_stars() -> int:
	return _stars.stars


func get_stats_text() -> String:
	return _stats_label.text


func _show_result(result: Dictionary) -> void:
	var has_result := not result.is_empty()
	_stars.visible = has_result
	_stats_label.visible = has_result
	_rules_box.visible = has_result
	_best_label.visible = false
	for child in _rules_box.get_children():
		child.queue_free()
	if not has_result:
		return
	var hints: int = result.get("hints", 0)
	var wrong_taps: int = result.get("wrong_taps", 0)
	_stats_label.text = "Time %s   ·   Hints %d   ·   Wrong taps %d" % [
			RoomResult.format_time(result.get("seconds", 0.0)), hints, wrong_taps]
	for rule in RoomResult.star_rules(hints, wrong_taps):
		_rules_box.add_child(_make_rule_row(rule["text"], rule["earned"]))
	if result.get("first", false):
		_best_label.text = "First time through!"
		_best_label.visible = true
	elif result.get("new_best_stars", false):
		_best_label.text = "New best: more stars than before!"
		_best_label.visible = true
	elif result.get("new_best_time", false):
		_best_label.text = "New best time!"
		_best_label.visible = true
	# The stars pop in after the panel has faded in.
	get_tree().create_timer(0.9).timeout.connect(_stars.pop_in.bind(int(result.get("stars", 0))))


func _make_rule_row(text: String, earned: bool) -> Control:
	var row := HBoxContainer.new()
	row.add_theme_constant_override("separation", 10)
	row.alignment = BoxContainer.ALIGNMENT_CENTER
	var star := StarRating.new()
	star.count = 1
	star.star_size = 18.0
	star.stars = 1 if earned else 0
	row.add_child(star)
	var label := Label.new()
	label.text = text
	label.add_theme_font_size_override("font_size", 16)
	label.add_theme_color_override("font_color", Color(0.93, 0.88, 0.77) if earned else Color(0.6, 0.57, 0.52))
	row.add_child(label)
	return row


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
