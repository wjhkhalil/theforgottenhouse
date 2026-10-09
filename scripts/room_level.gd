extends Node2D
## The script used by EVERY chapter room (bedroom.tscn, basement.tscn, ...).
## It connects the pieces together with signals:
##
##   HiddenObject --collected--> GameManager (counts progress)
##   GameManager --object_collected--> here --> HUD checkmark, notification, save
##   GameManager --progress_changed--> HUD counter
##   GameManager --room_completed--> here --> save, victory screen, final letter
##   HUD --hint_requested / pause_requested--> here
##   OpenableContainer --opened--> here --> notification, save
##   OpenableContainer --locked_clicked--> here --> "it is locked" notification
##   OpenableContainer --code_requested--> here --> keypad --> container opens
##
## Restart and Replay reload this scene, which gives a completely fresh room.
## Optional pieces (keypad lock) are only used if assigned. Every room gets a
## RoomCamera for zooming; rooms that don't have one in their scene get one here.
## ROOM EFFECTS: nodes in the "room_effects" group (lantern darkness, steam,
## power cuts, tide water, bats) are started when searching begins (start_effect) and faded out
## when the room is complete (fade_out).

const MAIN_MENU_SCENE := "res://scenes/main_menu.tscn"
## Wait a moment after the last object so the player can read its clue.
const VICTORY_DELAY_SECONDS := 2.5
## Time between the victory screen appearing and the letter opening.
const LETTER_DELAY_SECONDS := 1.2

## Story text, difficulty and chapter id for this room.
@export var level_data: LevelData
## Optional: a keypad for the entry code and for code-locked containers.
@export var keypad_lock: KeypadLock
## The zooming / scrolling camera. Rooms taller than the screen (Chapter Four)
## set their own in the scene; every other room gets a 1280 x 720 one automatically.
@export var room_camera: RoomCamera

@onready var game_manager: GameManager = %GameManager
@onready var hidden_objects_root: Node2D = %HiddenObjects
@onready var hint_highlight: HintHighlight = %HintHighlight
@onready var hud: Hud = %HUD
@onready var notification_popup: NotificationPopup = %Notification
@onready var pause_menu: PauseMenu = %PauseMenu
@onready var letter_popup: LetterPopup = %LetterPopup
@onready var victory_screen: VictoryScreen = %VictoryScreen

var _containers: Array[OpenableContainer] = []
## The container whose code is being typed, or null when the keypad is for the entry door.
var _keypad_container: OpenableContainer = null


func _ready() -> void:
	# A restarted room must never start paused.
	get_tree().paused = false
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	if level_data == null:
		level_data = LevelData.new()

	_enable_mouse_picking()
	_apply_difficulty()
	_setup_camera()

	var objects := _find_hidden_objects()
	_containers = _find_containers()
	hud.setup(level_data.room_name, objects, level_data.objective_riddles)

	game_manager.object_collected.connect(_on_object_collected)
	game_manager.progress_changed.connect(hud.update_progress)
	game_manager.room_completed.connect(_on_room_completed)
	hud.hint_requested.connect(_on_hint_requested)
	hud.pause_requested.connect(_open_pause_menu)
	pause_menu.restart_requested.connect(restart_room)
	pause_menu.main_menu_requested.connect(go_to_main_menu)
	victory_screen.continue_requested.connect(_go_to_next_chapter)
	victory_screen.read_letter_requested.connect(_reveal_final_letter)
	victory_screen.replay_requested.connect(restart_room)
	victory_screen.main_menu_requested.connect(go_to_main_menu)
	for container in _containers:
		container.opened.connect(_on_container_opened)
		container.chipped.connect(_on_container_chipped)
		container.locked_clicked.connect(_on_container_locked)
		container.code_requested.connect(_on_container_code_requested)
	if keypad_lock != null:
		keypad_lock.unlocked.connect(_on_keypad_unlocked)
		keypad_lock.main_menu_requested.connect(go_to_main_menu)
		keypad_lock.cancelled.connect(_on_keypad_cancelled)
	for effect in get_tree().get_nodes_in_group("room_effects"):
		if effect is PowerCuts:
			(effect as PowerCuts).power_changed.connect(_on_power_changed)
		elif effect is TideWater:
			(effect as TideWater).reach_blocked.connect(_on_reach_blocked)
		elif effect is BatColony:
			var bats := effect as BatColony
			bats.stirred.connect(_on_bats_stirred)
			bats.swarm_started.connect(_on_bats_woke)
			bats.click_blocked.connect(_on_bats_in_the_way)
		# Any other effect can show a message by emitting
		# notice(title: String, message: String, wrong_sound: bool).
		if effect.has_signal("notice"):
			effect.connect("notice", _on_effect_notice)

	# Load what the player already found in an earlier session.
	var progress := SaveManager.get_room_progress(_chapter_id())
	game_manager.register_objects(objects, progress["collected"])
	for object_id in game_manager.collected_ids:
		hud.mark_collected(object_id)
	for container in _containers:
		if progress["opened"].has(String(container.container_id)):
			container.restore_opened()

	if _needs_entry_code():
		_show_keypad()
	else:
		_start_searching()
	AudioManager.play_music()


func _unhandled_input(event: InputEvent) -> void:
	if game_manager.is_room_complete:
		return
	if keypad_lock != null and keypad_lock.is_open():
		return  # The keypad handles its own keys.
	if event.is_action_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		_open_pause_menu()
		return
	# Keyboard shortcuts: P = pause, H = hint
	var key_event := event as InputEventKey
	if key_event != null and key_event.pressed and not key_event.echo:
		if key_event.keycode == KEY_P:
			get_viewport().set_input_as_handled()
			_open_pause_menu()
		elif key_event.keycode == KEY_H:
			get_viewport().set_input_as_handled()
			_on_hint_requested()


## Restart = forget this room's saved progress and load it again.
func restart_room() -> void:
	SaveManager.clear_room_progress(_chapter_id())
	_reload_scene()


## Loads this room again from scratch.
func _reload_scene() -> void:
	get_tree().paused = false
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	get_tree().reload_current_scene()


## Going to the menu KEEPS the progress, so "Continue" brings the player back here.
func go_to_main_menu() -> void:
	get_tree().paused = false
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	get_tree().change_scene_to_file(MAIN_MENU_SCENE)


func _chapter_id() -> String:
	return String(level_data.chapter_id)


## Area2D nodes only receive mouse clicks when "physics picking" is on.
## first_only + sort = only the top-most object under the mouse gets the click.
func _enable_mouse_picking() -> void:
	var viewport := get_viewport()
	viewport.physics_object_picking = true
	viewport.physics_object_picking_sort = true
	viewport.physics_object_picking_first_only = true


func _setup_camera() -> void:
	if room_camera == null:
		room_camera = RoomCamera.new()
		room_camera.name = "RoomCamera"
		add_child(room_camera)
	# In rooms with darkness, steam or power cuts, one finger moves the light
	# or wipes the steam on a phone, so looking around needs two fingers.
	room_camera.one_finger_pan = true
	for effect in get_tree().get_nodes_in_group("room_effects"):
		if effect is LanternDarkness or effect is SteamFog or effect is PowerCuts:
			room_camera.one_finger_pan = false
		# Effects that follow the finger (a light, a cloth...) say so with needs_pointer().
		elif effect.has_method("needs_pointer") and effect.call("needs_pointer"):
			room_camera.one_finger_pan = false


## A short reminder of the touch controls, added to the intro on phones.
func _phone_tip() -> String:
	if not ScreenSettings.is_phone():
		return ""
	if room_camera.one_finger_pan:
		return "\n\nTip: drag to look around, pinch to zoom."
	return "\n\nTip: drag with TWO fingers to look around, pinch to zoom."


## Difficulty values come from the LevelData resource, so each chapter can differ.
func _apply_difficulty() -> void:
	hud.hint_cooldown_seconds = level_data.hint_cooldown_seconds
	hint_highlight.radius = level_data.hint_area_radius
	hint_highlight.max_offset = level_data.hint_area_offset


func _find_hidden_objects() -> Array[HiddenObject]:
	var objects: Array[HiddenObject] = []
	for child in hidden_objects_root.get_children():
		if child is HiddenObject:
			objects.append(child as HiddenObject)
	return objects


func _find_containers() -> Array[OpenableContainer]:
	var containers: Array[OpenableContainer] = []
	for child in hidden_objects_root.get_children():
		if child is OpenableContainer:
			containers.append(child as OpenableContainer)
	return containers


# ---------------------------------------------------------------------------
# Entry keypad (only for rooms whose LevelData has an entry_code)
# ---------------------------------------------------------------------------

func _entry_flag_name() -> String:
	return "door_unlocked_" + _chapter_id()


func _needs_entry_code() -> bool:
	return keypad_lock != null and level_data.entry_code != "" and not SaveManager.get_flag(_entry_flag_name())


func _show_keypad() -> void:
	_set_searching_enabled(false)
	_keypad_container = null
	keypad_lock.open(level_data.entry_title, level_data.entry_prompt, level_data.entry_code,
			level_data.entry_hint_first, level_data.entry_hint_second,
			level_data.entry_hint_first_after, level_data.entry_hint_second_after)


func _on_keypad_unlocked() -> void:
	if _keypad_container != null:
		# The code of a container (such as a safe) was typed.
		var container := _keypad_container
		_keypad_container = null
		_set_searching_enabled(true)
		container.unlock_with_code()
		container.open()
		return
	SaveManager.set_flag(_entry_flag_name())
	_start_searching()


## "Step Back" on a container's keypad.
func _on_keypad_cancelled() -> void:
	_keypad_container = null
	_set_searching_enabled(true)


func _on_container_code_requested(container: OpenableContainer) -> void:
	if keypad_lock == null or game_manager.is_room_complete:
		return
	_set_searching_enabled(false)
	_keypad_container = container
	keypad_lock.open(container.code_title, container.code_prompt, container.required_code,
			container.code_hint_first, container.code_hint_second,
			container.code_hint_first_after, container.code_hint_second_after, "Step Back")


## Turns the Hint/Pause buttons and camera scrolling on or off.
func _set_searching_enabled(enabled: bool) -> void:
	hud.set_gameplay_enabled(enabled)
	room_camera.scroll_enabled = enabled


func _start_searching() -> void:
	_set_searching_enabled(true)
	for effect in get_tree().get_nodes_in_group("room_effects"):
		if effect.has_method("start_effect"):
			effect.start_effect()
	var found := game_manager.get_found_count()
	if found > 0:
		notification_popup.show_message("Welcome back", "Your progress was saved: %d of %d objects already found." % [found, game_manager.get_total_count()], 4.0)
	else:
		notification_popup.show_message(level_data.room_name, level_data.intro_message + _phone_tip(), 6.0)


# ---------------------------------------------------------------------------
# Gameplay events
# ---------------------------------------------------------------------------

func _open_pause_menu() -> void:
	if game_manager.is_room_complete:
		return
	pause_menu.open()


func _save_room_progress() -> void:
	if game_manager.is_room_complete:
		return  # complete_chapter() takes care of saving.
	var opened_ids: Array[String] = []
	for container in _containers:
		if container.is_open:
			opened_ids.append(String(container.container_id))
	SaveManager.save_room_progress(_chapter_id(), game_manager.get_collected_ids_for_save(), opened_ids)


func _on_object_collected(object_data: HiddenObjectData) -> void:
	hud.mark_collected(object_data.object_id)
	hint_highlight.hide_area()
	notification_popup.show_message(object_data.collection_message, object_data.clue_text, 4.5)
	AudioManager.play_sfx("collect")
	_save_room_progress()


func _on_container_opened(container: OpenableContainer) -> void:
	hint_highlight.hide_area()
	notification_popup.show_message(container.open_title, container.open_message, 3.5)
	AudioManager.play_sfx("open")
	_save_room_progress()


func _on_container_locked(container: OpenableContainer) -> void:
	notification_popup.show_message(container.locked_title, container.locked_message, 3.5)
	AudioManager.play_sfx("wrong")


func _on_power_changed(is_on: bool) -> void:
	if not is_on:
		notification_popup.show_message("The lights go out!", "Keep searching by the light of a match. The power will come back.", 3.0)


func _on_reach_blocked() -> void:
	notification_popup.show_message("It's under the water", "You can't reach it while the slip is flooded. Wait for the water to drain out.", 3.0)
	AudioManager.play_sfx("wrong")


func _on_effect_notice(title: String, message: String, wrong_sound: bool) -> void:
	notification_popup.show_message(title, message, 3.0)
	if wrong_sound:
		AudioManager.play_sfx("wrong")


## A container that needs several clicks (a block of ice) was hit but is not open yet.
func _on_container_chipped(container: OpenableContainer, hits_left: int) -> void:
	var message := container.chip_message if container.chip_message != "" else "Keep going: %d more." % hits_left
	notification_popup.show_message(container.chip_title, message, 2.0)
	AudioManager.play_sfx("click")


func _on_bats_stirred() -> void:
	notification_popup.show_message("The bats stir...", "Careful! Clicking on empty spots disturbs them. Once more and they'll wake.", 3.0)
	AudioManager.play_sfx("wrong")


func _on_bats_woke() -> void:
	notification_popup.show_message("The bats wake up!", "They swoop all around the loft. Wait for them to settle before you pick anything up.", 3.5)
	AudioManager.play_sfx("wrong")


func _on_bats_in_the_way() -> void:
	notification_popup.show_message("The bats are in the way!", "Wait a moment for them to settle back under the beam.", 2.0)


func _on_hint_requested() -> void:
	if game_manager.is_room_complete or get_tree().paused:
		return
	var target := game_manager.get_next_hint_object()
	if target == null:
		return
	notification_popup.show_message("Hint", target.data.hint_text, 5.0)
	hint_highlight.show_area(target.get_hint_position())
	room_camera.focus_on(target.get_hint_position())
	AudioManager.play_sfx("hint")


func _on_room_completed() -> void:
	SaveManager.complete_chapter(_chapter_id())
	_set_searching_enabled(false)
	hint_highlight.hide_area()
	# Reward: darkness, steam and power cuts go away, the whole room becomes visible.
	for effect in get_tree().get_nodes_in_group("room_effects"):
		if effect.has_method("fade_out"):
			effect.fade_out()
	# Timers connected to this node's methods are disconnected automatically
	# if the room is closed before they finish, so this is always safe.
	get_tree().create_timer(VICTORY_DELAY_SECONDS).timeout.connect(_show_victory_screen)


func _show_victory_screen() -> void:
	notification_popup.hide_now()
	AudioManager.play_sfx("complete")
	var next_chapter := SaveManager.get_next_chapter(_chapter_id())
	var next_title: String = next_chapter.get("title", "")
	var house := SaveManager.get_house(_chapter_id())
	if not next_chapter.is_empty() and next_chapter["house"] != house.get("id", ""):
		# The next chapter is in a new house: the button says "Continue: House Two".
		next_title = SaveManager.get_house(next_chapter["id"]).get("title", next_title)
	var more_coming: bool = next_chapter.is_empty() and not house.get("finished", true)
	victory_screen.show_victory(level_data.chapter_title, level_data.chapter_hook,
			game_manager.get_found_count(), game_manager.get_total_count(), next_title, more_coming)
	get_tree().create_timer(LETTER_DELAY_SECONDS).timeout.connect(_reveal_final_letter)


func _reveal_final_letter() -> void:
	if letter_popup.is_open():
		return
	game_manager.final_letter_revealed = true
	letter_popup.open(level_data.final_letter_title, level_data.final_letter_text, level_data.final_letter_signature)


func _go_to_next_chapter() -> void:
	var next_chapter := SaveManager.get_next_chapter(_chapter_id())
	if next_chapter.is_empty():
		return
	get_tree().paused = false
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	get_tree().change_scene_to_file(next_chapter["scene"])
