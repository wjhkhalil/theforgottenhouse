class_name Journal
extends CanvasLayer
## The Journal: every letter found so far and the clues of each chapter.
## Opened from the main menu and from the pause menu (the same scene).
##
## The left column lists the chapters, grouped by house. The right side shows
## the chapter's letter on paper, like the in-room letter, followed by the clues
## found there. Entries come from SaveManager.get_journal_entries().

signal closed

const SELECTED_COLOR := Color(0.95, 0.76, 0.48)
const HEADING_COLOR := Color(0.95, 0.76, 0.48)
const INK := Color(0.17, 0.14, 0.2)
const INK_DARK := Color(0.4, 0.2, 0.15)

@onready var _root: Control = %Root
@onready var _entry_list: VBoxContainer = %EntryList
@onready var _empty_label: Label = %EmptyLabel
@onready var _paper: Control = %Paper
@onready var _letter_title: Label = %LetterTitle
@onready var _letter_body: Label = %LetterBody
@onready var _signature: Label = %Signature
@onready var _clues_title: Label = %CluesTitle
@onready var _clues_list: VBoxContainer = %CluesList
@onready var _page_scroll: ScrollContainer = %PageScroll
@onready var _close_button: Button = %CloseButton

var _entries: Array[Dictionary] = []
var _buttons: Array[Button] = []
var _selected: int = -1


func _ready() -> void:
	_root.hide()
	_close_button.pressed.connect(close)


func is_open() -> bool:
	return _root.visible


func get_entry_count() -> int:
	return _entries.size()


func get_letter_text() -> String:
	return _letter_body.text


func get_clue_count() -> int:
	return _clues_list.get_child_count()


func open() -> void:
	_entries = SaveManager.get_journal_entries()
	_build_list()
	var has_entries := not _entries.is_empty()
	_empty_label.visible = not has_entries
	_paper.visible = has_entries
	if has_entries:
		_select(_entries.size() - 1)  # The newest letter first.
	_root.show()
	_root.modulate.a = 0.0
	create_tween().tween_property(_root, "modulate:a", 1.0, 0.3)
	_close_button.grab_focus()
	AudioManager.play_sfx("paper")


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


func _build_list() -> void:
	for child in _entry_list.get_children():
		child.queue_free()
	_buttons.clear()
	var current_house := ""
	for i in range(_entries.size()):
		var entry := _entries[i]
		if entry["house_title"] != current_house:
			current_house = entry["house_title"]
			var heading := Label.new()
			heading.text = current_house
			heading.add_theme_font_size_override("font_size", 15)
			heading.add_theme_color_override("font_color", HEADING_COLOR)
			heading.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
			_entry_list.add_child(heading)
		var button := Button.new()
		button.text = entry["title"]
		button.alignment = HORIZONTAL_ALIGNMENT_LEFT
		button.custom_minimum_size = Vector2(0, 38)
		button.add_theme_font_size_override("font_size", 15)
		button.text_overrun_behavior = TextServer.OVERRUN_TRIM_ELLIPSIS
		button.mouse_filter = Control.MOUSE_FILTER_PASS  # a finger can still scroll the list
		if not entry["completed"]:
			button.tooltip_text = "Chapter not finished yet: only its clues so far."
		button.pressed.connect(_on_entry_pressed.bind(i))
		_entry_list.add_child(button)
		_buttons.append(button)


func _on_entry_pressed(index: int) -> void:
	AudioManager.play_sfx("paper")
	_select(index)


func _select(index: int) -> void:
	_selected = index
	for i in range(_buttons.size()):
		if i == index:
			_buttons[i].add_theme_color_override("font_color", SELECTED_COLOR)
		else:
			_buttons[i].remove_theme_color_override("font_color")
	var entry := _entries[index]
	if entry["completed"]:
		_letter_title.text = entry["letter_title"]
		_letter_body.text = entry["letter_text"]
		_signature.text = entry["signature"]
		_signature.visible = entry["signature"] != ""
	else:
		_letter_title.text = "No letter yet"
		_letter_body.text = "Finish this chapter to read what was left behind."
		_signature.visible = false
	for child in _clues_list.get_children():
		child.queue_free()
	var clues: Array = entry["clues"]
	_clues_title.text = "Clues found here" if not clues.is_empty() else "No clues found here yet"
	for clue in clues:
		_clues_list.add_child(_make_clue_row(clue[0], clue[1]))
	_page_scroll.scroll_vertical = 0


func _make_clue_row(object_name: String, clue_text: String) -> Control:
	var box := VBoxContainer.new()
	box.add_theme_constant_override("separation", 2)
	var name_label := Label.new()
	name_label.text = object_name
	name_label.add_theme_font_size_override("font_size", 17)
	name_label.add_theme_color_override("font_color", INK_DARK)
	name_label.add_theme_color_override("font_shadow_color", Color.TRANSPARENT)
	box.add_child(name_label)
	var text_label := Label.new()
	text_label.text = clue_text
	text_label.add_theme_font_size_override("font_size", 16)
	text_label.add_theme_color_override("font_color", INK)
	text_label.add_theme_color_override("font_shadow_color", Color.TRANSPARENT)
	text_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	box.add_child(text_label)
	return box
