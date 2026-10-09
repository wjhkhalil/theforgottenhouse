class_name Hud
extends CanvasLayer
## The in-game HUD: room name, progress counter, objective list and buttons.
##
## The HUD never changes the game state by itself. Its buttons only emit
## signals (hint_requested, pause_requested), and the room script calls
## update_progress() / mark_collected() to change what is shown.

signal hint_requested
signal pause_requested

const FOUND_COLOR := Color(0.6, 0.88, 0.55)
const NOT_FOUND_COLOR := Color(0.75, 0.7, 0.62)
## With more objects than this, the list uses smaller one-line rows so it fits.
const COMPACT_AFTER := 7

@onready var _room_label: Label = %RoomLabel
@onready var _progress_label: Label = %ProgressLabel
@onready var _hint_button: Button = %HintButton
@onready var _sound_button: Button = %SoundButton
@onready var _pause_button: Button = %PauseButton
@onready var _objective_list: VBoxContainer = %ObjectiveList
@onready var _objective_scroll: ScrollContainer = %ObjectiveScroll
@onready var _objective_panel: Control = $Root/ObjectivePanel

# object_id -> { "icon": ObjectIcon, "name_label": Label, "status_label": Label or null, "data": HiddenObjectData }
var _entries: Dictionary = {}
var _compact: bool = false
var _riddles: bool = false
## Seconds the Hint button stays disabled after use. Set by the room from its LevelData.
var hint_cooldown_seconds: float = 3.0

var _gameplay_enabled: bool = true
var _hint_cooling_down: bool = false


func _ready() -> void:
	_hint_button.pressed.connect(_on_hint_button_pressed)
	_pause_button.pressed.connect(_on_pause_button_pressed)
	_sound_button.pressed.connect(_on_sound_button_pressed)
	_update_sound_button()
	get_viewport().size_changed.connect(_fit_objective_list)


## Builds the objective list from the room's hidden objects.
## `use_riddles`: show riddles instead of names until each object is found.
func setup(room_name: String, objects: Array[HiddenObject], use_riddles: bool = false) -> void:
	_room_label.text = room_name
	for child in _objective_list.get_children():
		child.queue_free()
	_entries.clear()
	_riddles = use_riddles
	var required_count := 0
	for hidden_object in objects:
		if hidden_object.data != null and hidden_object.data.is_required:
			required_count += 1
	_compact = required_count > COMPACT_AFTER
	_objective_list.add_theme_constant_override("separation", 4 if _compact else 8)
	for hidden_object in objects:
		if hidden_object.data != null and hidden_object.data.is_required:
			_add_entry(hidden_object.data)
	_fit_objective_list.call_deferred()


## Long lists (and small phone screens) scroll instead of running off the bottom.
func _fit_objective_list() -> void:
	if not is_inside_tree():
		return
	var title_height := _objective_scroll.position.y + 24.0
	var available := get_viewport().get_visible_rect().size.y - _objective_panel.position.y - title_height - 12.0
	_objective_scroll.custom_minimum_size.y = minf(_objective_list.get_combined_minimum_size().y, maxf(available, 80.0))


## Called through the GameManager's progress_changed signal.
func update_progress(found_count: int, total_count: int) -> void:
	_progress_label.text = "Objects Found: %d / %d" % [found_count, total_count]
	if found_count > 0:
		# Short warm flash so the player notices the change.
		var tween := create_tween()
		_progress_label.modulate = PlaceholderArt.WARM * 1.3
		tween.tween_property(_progress_label, "modulate", Color.WHITE, 0.6)


## Ticks off an object in the list (checkmark + "Found" text + dimmed name).
func mark_collected(object_id: StringName) -> void:
	if not _entries.has(object_id):
		return
	var entry: Dictionary = _entries[object_id]
	var icon: ObjectIcon = entry["icon"]
	var name_label: Label = entry["name_label"]
	icon.is_collected = true
	name_label.modulate = Color(1, 1, 1, 0.6)
	# A solved riddle reveals the object's real name.
	name_label.text = (entry["data"] as HiddenObjectData).display_name
	var status_label: Label = entry["status_label"]
	if status_label != null:
		status_label.text = "Found!"
		status_label.add_theme_color_override("font_color", FOUND_COLOR)


## The text shown for an object in the list (its name, or its riddle while unsolved).
func get_entry_text(object_id: StringName) -> String:
	if not _entries.has(object_id):
		return ""
	return (_entries[object_id]["name_label"] as Label).text


## Turns the Hint and Pause buttons on/off (they are turned off after victory).
func set_gameplay_enabled(enabled: bool) -> void:
	_gameplay_enabled = enabled
	_pause_button.disabled = not enabled
	_hint_button.disabled = not enabled or _hint_cooling_down


func _add_entry(object_data: HiddenObjectData) -> void:
	var row := HBoxContainer.new()
	row.add_theme_constant_override("separation", 10)

	var icon := ObjectIcon.new()
	icon.custom_minimum_size = Vector2(30, 30) if _compact else Vector2(44, 44)
	icon.object_data = object_data
	icon.hide_picture = _riddles
	row.add_child(icon)

	var text_column := VBoxContainer.new()
	text_column.add_theme_constant_override("separation", 0)
	text_column.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	text_column.alignment = BoxContainer.ALIGNMENT_CENTER
	row.add_child(text_column)

	var name_label := Label.new()
	name_label.text = object_data.display_name
	if _riddles:
		name_label.text = object_data.riddle_text if object_data.riddle_text != "" else "???"
		name_label.add_theme_color_override("font_color", Color(0.93, 0.85, 0.7))
	if _riddles:
		# Riddles must be read in full, so they wrap onto a second line.
		name_label.add_theme_font_size_override("font_size", 14)
		name_label.custom_minimum_size = Vector2(186, 0)
		name_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	elif _compact:
		name_label.add_theme_font_size_override("font_size", 15)
		name_label.custom_minimum_size = Vector2(186, 0)
		name_label.text_overrun_behavior = TextServer.OVERRUN_TRIM_ELLIPSIS
	text_column.add_child(name_label)

	# Compact rows have no status line; the checkmark on the icon shows "found".
	var status_label: Label = null
	if not _compact:
		status_label = Label.new()
		status_label.text = "Not found yet"
		status_label.add_theme_font_size_override("font_size", 14)
		status_label.add_theme_color_override("font_color", NOT_FOUND_COLOR)
		text_column.add_child(status_label)

	_objective_list.add_child(row)
	_entries[object_data.object_id] = {
		"icon": icon,
		"name_label": name_label,
		"status_label": status_label,
		"data": object_data,
	}


func _on_hint_button_pressed() -> void:
	AudioManager.play_sfx("click")
	hint_requested.emit()
	_hint_cooling_down = true
	_hint_button.disabled = true
	# `false` = this timer stops while the game is paused.
	get_tree().create_timer(hint_cooldown_seconds, false).timeout.connect(_on_hint_cooldown_finished)


func _on_hint_cooldown_finished() -> void:
	_hint_cooling_down = false
	_hint_button.disabled = not _gameplay_enabled


func _on_pause_button_pressed() -> void:
	AudioManager.play_sfx("click")
	pause_requested.emit()


func _on_sound_button_pressed() -> void:
	AudioManager.toggle_muted()
	AudioManager.play_sfx("click")
	_update_sound_button()


func _update_sound_button() -> void:
	_sound_button.text = "Sound: Off" if AudioManager.is_muted else "Sound: On"
