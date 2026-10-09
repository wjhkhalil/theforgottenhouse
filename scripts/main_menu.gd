extends Control
## Main menu: Continue, New Game, Chapters, About and Quit.
## Which chapters are unlocked comes from the SaveManager autoload.

@onready var _continue_button: Button = %ContinueButton
@onready var _play_button: Button = %PlayButton
@onready var _chapters_button: Button = %ChaptersButton
@onready var _about_button: Button = %AboutButton
@onready var _quit_button: Button = %QuitButton
@onready var _about_layer: Control = %AboutLayer
@onready var _about_back_button: Button = %AboutBackButton
@onready var _chapters_layer: Control = %ChaptersLayer
@onready var _chapter_list: GridContainer = %ChapterList
@onready var _chapter_scroll: ScrollContainer = %ChapterScroll
@onready var _reset_button: Button = %ResetButton
@onready var _chapters_back_button: Button = %ChaptersBackButton

# The reset button must be clicked twice, so progress is not erased by accident.
var _reset_armed: bool = false


func _ready() -> void:
	# Coming back from a paused game must never leave the game paused.
	get_tree().paused = false
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	_about_layer.hide()
	_chapters_layer.hide()
	# Quitting is not possible in a web browser, so hide the button there.
	_quit_button.visible = not OS.has_feature("web")

	_continue_button.pressed.connect(_on_continue_pressed)
	_play_button.pressed.connect(_on_new_game_pressed)
	_chapters_button.pressed.connect(_on_chapters_pressed)
	_about_button.pressed.connect(_on_about_pressed)
	_quit_button.pressed.connect(_on_quit_pressed)
	_about_back_button.pressed.connect(_on_about_back_pressed)
	_reset_button.pressed.connect(_on_reset_pressed)
	_chapters_back_button.pressed.connect(_on_chapters_back_pressed)

	_refresh_continue_button()
	AudioManager.play_music()


func _unhandled_input(event: InputEvent) -> void:
	if not event.is_action_pressed("ui_cancel"):
		return
	if _about_layer.visible:
		get_viewport().set_input_as_handled()
		_on_about_back_pressed()
	elif _chapters_layer.visible:
		get_viewport().set_input_as_handled()
		_on_chapters_back_pressed()


func _refresh_continue_button() -> void:
	_continue_button.visible = SaveManager.has_progress()
	if _continue_button.visible:
		_continue_button.tooltip_text = SaveManager.get_continue_chapter()["title"]
		_continue_button.grab_focus()
	else:
		_play_button.grab_focus()


func _start_chapter(chapter: Dictionary) -> void:
	AudioManager.play_sfx("click")
	get_tree().change_scene_to_file(chapter["scene"])


func _on_continue_pressed() -> void:
	_start_chapter(SaveManager.get_continue_chapter())


## New Game starts Chapter One from the beginning. Unlocked chapters stay unlocked.
func _on_new_game_pressed() -> void:
	var first_chapter: Dictionary = SaveManager.CHAPTERS[0]
	SaveManager.clear_room_progress(first_chapter["id"])
	_start_chapter(first_chapter)


func _on_chapters_pressed() -> void:
	AudioManager.play_sfx("click")
	_build_chapter_list()
	_reset_armed = false
	_reset_button.text = "Reset All Progress"
	_chapters_layer.show()
	_chapters_back_button.grab_focus()


## One button per chapter. Locked chapters are disabled and say how to unlock them.
func _build_chapter_list() -> void:
	# A phone screen is not tall enough for one long column, so use two.
	_chapter_list.columns = 2 if ScreenSettings.is_phone() else 1
	for child in _chapter_list.get_children():
		child.queue_free()
	var current_house := ""
	for chapter in SaveManager.CHAPTERS:
		# A heading above the first chapter of each house.
		if chapter["house"] != current_house:
			current_house = chapter["house"]
			_add_house_heading(SaveManager.get_house(chapter["id"]).get("title", ""))
		var button := Button.new()
		button.custom_minimum_size = Vector2(0, 40)
		button.alignment = HORIZONTAL_ALIGNMENT_LEFT
		button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		var chapter_id: String = chapter["id"]
		if SaveManager.is_chapter_completed(chapter_id):
			button.text = "%s   (Completed)" % chapter["title"]
		elif SaveManager.is_chapter_unlocked(chapter_id):
			button.text = "%s   (Unlocked)" % chapter["title"]
		else:
			button.text = "%s   (Locked)" % chapter["title"]
			button.disabled = true
			button.tooltip_text = "Finish the previous chapter to unlock this one."
		button.pressed.connect(_start_chapter.bind(chapter))
		_chapter_list.add_child(button)
	_fit_chapter_scroll.call_deferred()


## The list scrolls when there are more chapters than fit on the screen.
func _fit_chapter_scroll() -> void:
	var room_left := get_viewport_rect().size.y - 230.0
	_chapter_scroll.custom_minimum_size.y = minf(_chapter_list.get_combined_minimum_size().y, room_left)


func _add_house_heading(title: String) -> void:
	# Finish the current row first, so the heading starts on a new line.
	while _visible_child_count() % _chapter_list.columns != 0:
		_add_gap()
	var heading := Label.new()
	heading.text = title
	heading.add_theme_font_size_override("font_size", 20)
	heading.add_theme_color_override("font_color", Color(0.95, 0.76, 0.48))
	_chapter_list.add_child(heading)
	# Fill the rest of the row, so the chapters start on a new line.
	for i in range(_chapter_list.columns - 1):
		_add_gap()


func _add_gap() -> void:
	var gap := Control.new()
	gap.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_chapter_list.add_child(gap)


## Children of the list that are not about to be deleted (old buttons are freed at the end of the frame).
func _visible_child_count() -> int:
	var count := 0
	for child in _chapter_list.get_children():
		if not child.is_queued_for_deletion():
			count += 1
	return count


func _on_reset_pressed() -> void:
	AudioManager.play_sfx("click")
	if not _reset_armed:
		_reset_armed = true
		_reset_button.text = "Click again to erase ALL progress"
		return
	SaveManager.reset_progress()
	_reset_armed = false
	_reset_button.text = "Progress erased"
	_build_chapter_list()
	_refresh_continue_button()


func _on_chapters_back_pressed() -> void:
	AudioManager.play_sfx("click")
	_chapters_layer.hide()
	_chapters_button.grab_focus()


func _on_about_pressed() -> void:
	AudioManager.play_sfx("click")
	_about_layer.show()
	_about_back_button.grab_focus()


func _on_about_back_pressed() -> void:
	AudioManager.play_sfx("click")
	_about_layer.hide()
	_about_button.grab_focus()


func _on_quit_pressed() -> void:
	get_tree().quit()
