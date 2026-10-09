extends Node
## Automated gameplay test. It plays the game by sending REAL mouse clicks.
##
## Run it from a terminal (inside the project folder):
##   godot --headless --path . res://tests/gameplay_test.tscn
## Add "-- --screenshots=<folder>" (without --headless) to also save screenshots.
##
## The test node stays alive while scenes change, so it can follow the player
## from the menu, into the room, through restarts and back to the menu.
## It uses its own save file (user://test_save.cfg), so your real save is never touched.

const MENU_SCENE := "res://scenes/main_menu.tscn"
const BEDROOM_SCENE := "res://scenes/bedroom.tscn"
const BASEMENT_SCENE := "res://scenes/basement.tscn"
const ATTIC_SCENE := "res://scenes/attic.tscn"
const STAIRCASE_SCENE := "res://scenes/staircase.tscn"
const WASHROOM_SCENE := "res://scenes/washroom.tscn"
const LIVING_ROOM_SCENE := "res://scenes/living_room.tscn"
const KITCHEN_SCENE := "res://scenes/kitchen.tscn"
const STUDY_SCENE := "res://scenes/study.tscn"
const JETTY_SCENE := "res://scenes/jetty.tscn"
const BOAT_SHED_SCENE := "res://scenes/boat_shed.tscn"
const LOFT_SCENE := "res://scenes/loft.tscn"
const TEST_SAVE_PATH := "user://test_save.cfg"

var _failures: Array[String] = []
var _passes: int = 0
var _completed_signal_count: int = 0
var _screenshot_folder: String = ""


func _ready() -> void:
	for argument in OS.get_cmdline_user_args():
		if argument.begins_with("--screenshots="):
			_screenshot_folder = argument.trim_prefix("--screenshots=")
	_run.call_deferred()


func _run() -> void:
	var tree := get_tree()
	# Ignore the REAL mouse so it cannot interfere with the simulated clicks.
	if DisplayServer.get_name() != "headless":
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_MOUSE_PASSTHROUGH, true)
	SaveManager.save_path = TEST_SAVE_PATH
	SaveManager.reset_progress()
	# Let the test node survive scene changes: make the menu the "current scene".
	var menu: Node = load(MENU_SCENE).instantiate()
	tree.root.add_child(menu)
	tree.current_scene = menu
	await _wait_frames(5)
	await _screenshot("01_main_menu")

	_check_difficulty_curve()

	# --- Main menu -------------------------------------------------------
	_check(menu.get_node("%PlayButton").visible, "Main menu shows a New Game button")
	menu.get_node("%ChaptersButton").pressed.emit()
	await _wait_frames(2)
	_check(_chapter_button_texts(menu) == _expected_chapter_texts("Unlocked", "Locked"), "Chapters: only Chapter One is unlocked at first (%d chapters)" % SaveManager.CHAPTERS.size())
	var heading := menu.get_node("%ChapterList").get_child(0) as Label
	_check(heading != null and heading.text == "House One: Ashworth Manor", "Chapters list starts with the house name")
	menu.get_node("%ChaptersBackButton").pressed.emit()
	_check(not menu.get_node("%ContinueButton").visible, "No Continue button without a save")
	_check(menu.get_node("%AboutButton").visible, "Main menu shows an About button")
	menu.get_node("%AboutButton").pressed.emit()
	_check(menu.get_node("%AboutLayer").visible, "About panel opens")
	await _screenshot("02_about")
	menu.get_node("%AboutBackButton").pressed.emit()
	_check(not menu.get_node("%AboutLayer").visible, "About panel closes")

	menu.get_node("%PlayButton").pressed.emit()
	await _wait_frames(6)
	var room := tree.current_scene
	_check(room != null and room.scene_file_path == BEDROOM_SCENE, "Play button opens the bedroom")
	await _wait_frames(10)
	await _screenshot("03_bedroom_start")

	var manager: GameManager = room.get_node("%GameManager")
	var hud: Node = room.get_node("%HUD")
	var objects := _get_objects(room)
	_check(objects.size() == 5, "Five hidden objects exist (found %d)" % objects.size())
	for hidden_object in objects:
		_check(hidden_object.visible and not hidden_object.is_collected, "%s starts visible and not collected" % hidden_object.data.object_id)
	_check(_progress_text(room) == "Objects Found: 0 / 5", "Counter starts at 0 / 5 (got '%s')" % _progress_text(room))
	_check(hud.get_node("%ObjectiveList").get_child_count() == 5, "Objective list has 5 entries")
	var ids: Array[StringName] = []
	for hidden_object in objects:
		ids.append(hidden_object.data.object_id)
	_check(ids.size() == 5 and not _has_duplicates(ids), "All object ids are unique")

	# --- Clicking empty space ---------------------------------------------
	await _click(Vector2(200, 650))
	await _click(Vector2(480, 300))
	_check(manager.get_found_count() == 0, "Clicking empty space collects nothing")

	# --- Clicking on UI above the room does nothing to objects --------------
	await _click(Vector2(1100, 200))  # objective panel
	_check(manager.get_found_count() == 0, "Clicking the objective panel collects nothing")

	# --- Hint ---------------------------------------------------------------
	var notification_popup: NotificationPopup = room.get_node("%Notification")
	room.get_node("%HUD").get_node("%HintButton").pressed.emit()
	await _wait_frames(3)
	_check(notification_popup.is_showing() and notification_popup.get_title() == "Hint", "Hint button shows a hint notification")
	_check(room.get_node("%HintHighlight").visible, "Hint highlights an area")
	_check(manager.get_found_count() == 0, "Hint does not collect anything")
	await _screenshot("04_hint")
	var first_hint := manager.get_next_hint_object()
	var second_hint := manager.get_next_hint_object()
	_check(first_hint != second_hint, "Consecutive hints point to different objects")

	# --- Collect the key with a real click ----------------------------------
	var key := _find(objects, &"rusty_key")
	await _click(key.global_position)
	_check(key.is_collected, "Clicking the rusty key collects it")
	_check(manager.get_found_count() == 1, "Progress is 1 after the key")
	_check(_progress_text(room) == "Objects Found: 1 / 5", "Counter shows 1 / 5")
	_check(_status_text(hud, 0) == "Found!", "Objective list marks the key as Found!")
	_check(notification_popup.is_showing() and notification_popup.get_title() == "You found the rusty key!", "Collection notification appears")
	await _screenshot("05_key_collected")
	await _click(key.global_position)
	_check(manager.get_found_count() == 1, "Clicking the collected key again does not add progress")
	await _wait_seconds(1.0)
	_check(not key.visible, "Collected key disappears from the room")
	await _wait_seconds(5.0)
	_check(not notification_popup.is_showing(), "Notification disappears by itself")

	# --- Pause blocks interaction --------------------------------------------
	room.get_node("%HUD").get_node("%PauseButton").pressed.emit()
	await _wait_frames(2)
	var pause_menu: PauseMenu = room.get_node("%PauseMenu")
	_check(tree.paused and pause_menu.is_open(), "Pause button pauses the game and opens the menu")
	await _screenshot("06_paused")
	var photo := _find(objects, &"old_photograph")
	await _click(photo.global_position)
	_check(not photo.is_collected and manager.get_found_count() == 1, "Objects cannot be collected while paused")
	pause_menu.get_node("%ResumeButton").pressed.emit()
	await _wait_frames(2)
	_check(not tree.paused and not pause_menu.is_open(), "Resume unpauses the game")

	# --- Escape key toggles pause ---------------------------------------------
	await _press_key(KEY_ESCAPE)
	_check(tree.paused and pause_menu.is_open(), "Esc opens the pause menu")
	await _press_key(KEY_ESCAPE)
	_check(not tree.paused and not pause_menu.is_open(), "Esc closes the pause menu")

	# --- Restart from the pause menu ------------------------------------------
	await _click(photo.global_position)
	_check(manager.get_found_count() == 2, "Second object collected before restart")
	room.get_node("%HUD").get_node("%PauseButton").pressed.emit()
	await _wait_frames(2)
	pause_menu.get_node("%RestartButton").pressed.emit()
	await _wait_frames(6)
	room = tree.current_scene
	manager = room.get_node("%GameManager")
	hud = room.get_node("%HUD")
	objects = _get_objects(room)
	_check(not tree.paused, "Restart unpauses the game")
	_check(manager.get_found_count() == 0 and _progress_text(room) == "Objects Found: 0 / 5", "Restart resets progress to 0 / 5")
	var all_restored := true
	for hidden_object in objects:
		if hidden_object.is_collected or not hidden_object.visible:
			all_restored = false
	_check(all_restored, "Restart restores every object")
	_check(_status_text(hud, 0) == "Not found yet", "Restart resets the objective list")

	# --- Collect everything ----------------------------------------------------
	manager.room_completed.connect(func() -> void: _completed_signal_count += 1)
	for hidden_object in objects:
		await _click(hidden_object.global_position)
		_check(hidden_object.is_collected, "Clicking %s collects it" % hidden_object.data.object_id)
		await _wait_frames(2)
	_check(manager.get_found_count() == 5 and _progress_text(room) == "Objects Found: 5 / 5", "All five objects found: counter 5 / 5")
	for hidden_object in objects:
		await _click(hidden_object.global_position)
	_check(_completed_signal_count == 1, "room_completed fired exactly once (fired %d)" % _completed_signal_count)
	_check(manager.is_room_complete, "Room is marked complete")

	await _wait_seconds(4.5)
	var victory: VictoryScreen = room.get_node("%VictoryScreen")
	var letter: LetterPopup = room.get_node("%LetterPopup")
	_check(victory.is_open(), "Victory screen appears")
	_check(letter.is_open(), "Final letter opens")
	_check(letter.get_letter_text().contains("never supposed to return"), "Letter shows the final story message")
	_check(SaveManager.is_chapter_completed("bedroom"), "Save file marks Chapter One completed")
	_check(victory.get_node("%ContinueButton").visible, "Victory screen offers Continue to Chapter Two")
	_check(manager.final_letter_revealed, "Game state records that the letter was revealed")
	await _wait_seconds(0.8)
	await _screenshot("07_letter")
	letter.get_node("%CloseButton").pressed.emit()
	await _wait_frames(2)
	_check(not letter.is_open() and victory.is_open(), "Closing the letter returns to the completion screen")
	await _screenshot("08_victory")
	victory.get_node("%ReadLetterButton").pressed.emit()
	await _wait_frames(2)
	_check(letter.is_open(), "Read the Letter button reopens the letter")
	letter.get_node("%CloseButton").pressed.emit()
	await _press_key(KEY_ESCAPE)
	_check(not tree.paused, "Esc does not pause after the room is complete")

	# --- Replay -----------------------------------------------------------------
	victory.get_node("%ReplayButton").pressed.emit()
	await _wait_frames(6)
	room = tree.current_scene
	manager = room.get_node("%GameManager")
	_check(room.scene_file_path == BEDROOM_SCENE and manager.get_found_count() == 0 and not manager.is_room_complete, "Replay starts a fresh room")
	_check(not room.get_node("%VictoryScreen").is_open(), "Replay hides the victory screen")

	# --- Zoom (every chapter) ---------------------------------------------------------
	await _check_zoom(room)
	room = tree.current_scene

	# --- Main menu from pause -------------------------------------------------------
	room.get_node("%HUD").get_node("%PauseButton").pressed.emit()
	await _wait_frames(2)
	room.get_node("%PauseMenu").get_node("%MainMenuButton").pressed.emit()
	await _wait_frames(6)
	menu = tree.current_scene
	_check(menu.scene_file_path == MENU_SCENE, "Pause > Main Menu returns to the menu")
	_check(not tree.paused, "Main menu is not paused")
	_check(menu.get_node("%ContinueButton").visible, "Continue button appears once there is progress")

	# === CHAPTER TWO ==============================================================
	menu.get_node("%ContinueButton").pressed.emit()
	await _wait_frames(8)
	room = tree.current_scene
	_check(room.scene_file_path == BASEMENT_SCENE, "Continue opens Chapter Two (the basement)")
	manager = room.get_node("%GameManager")
	hud = room.get_node("%HUD")
	objects = _get_objects(room)
	var keypad: KeypadLock = room.get_node("KeypadLock")
	var trunk: OpenableContainer = room.get_node("%HiddenObjects/OldTrunk")
	var clipping := _find(objects, &"newspaper_clipping")
	var wristband := _find(objects, &"hospital_wristband")
	await _screenshot("11_keypad")
	_check(keypad.is_open(), "Basement starts with the keypad lock")
	_check(hud.get_node("%HintButton").disabled, "Hints are disabled while the keypad is open")
	await _click(wristband.global_position)
	_check(not wristband.is_collected, "Objects cannot be clicked through the keypad")

	# Two wrong codes typed with the keypad buttons -> first hint appears
	for attempt in range(2):
		for digit in ["1", "2", "3", "4"]:
			keypad.get_node("%ButtonGrid").get_node("Key" + digit).pressed.emit()
		keypad.get_node("%ButtonGrid").get_node("KeyEnter").pressed.emit()
	_check(keypad.is_open() and keypad.wrong_attempts == 2, "Wrong codes keep the door locked")
	_check((keypad.get_node("%Message") as Label).text.contains("something soft"), "After 2 wrong tries the keypad gives a hint")
	await _screenshot("12_keypad_hint")
	# Correct code typed on the keyboard
	for code_key: Key in [KEY_0, KEY_4, KEY_1, KEY_7, KEY_ENTER]:
		await _press_key(code_key)
	_check(not keypad.is_open(), "Typing 0417 + Enter opens the door")
	_check(SaveManager.get_flag("door_unlocked_basement"), "Solved door is saved")
	_check(not hud.get_node("%HintButton").disabled, "Hints work after the door opens")

	_check(objects.size() == 6, "Basement has six hidden objects")
	_check(_progress_text(room) == "Objects Found: 0 / 6", "Basement counter starts at 0 / 6")
	_check(room.get_node("LanternDarkness").visible, "The basement is dark (lantern effect)")
	_check(not clipping.visible, "Newspaper clipping starts hidden inside the trunk")
	var points_at_trunk := false
	for i in range(6):
		var hinted := manager.get_next_hint_object()
		if hinted == clipping and hinted.get_hint_position() == trunk.global_position:
			points_at_trunk = true
	_check(points_at_trunk, "The hint for the hidden clipping points at the trunk")
	clipping.collect()
	_check(not clipping.is_collected, "The hidden clipping cannot be collected before the trunk is opened")
	await _wait_seconds(0.5)
	await _screenshot("13_basement_dark")

	# Collect two objects, then leave to the menu: progress must be saved
	var boots := _find(objects, &"muddy_boots")
	await _click(wristband.global_position)
	await _click(boots.global_position)
	_check(wristband.is_collected and boots.is_collected, "Wristband and boots can be found in the dark")
	_check(SaveManager.get_room_progress("basement")["collected"].size() == 2, "Found objects are saved immediately")
	room.get_node("%HUD").get_node("%PauseButton").pressed.emit()
	await _wait_frames(2)
	room.get_node("%PauseMenu").get_node("%MainMenuButton").pressed.emit()
	await _wait_frames(6)
	tree.current_scene.get_node("%ContinueButton").pressed.emit()
	await _wait_frames(8)
	room = tree.current_scene
	manager = room.get_node("%GameManager")
	hud = room.get_node("%HUD")
	objects = _get_objects(room)
	trunk = room.get_node("%HiddenObjects/OldTrunk")
	clipping = _find(objects, &"newspaper_clipping")
	_check(not room.get_node("KeypadLock").is_open(), "The keypad does not return after it was solved")
	_check(manager.get_found_count() == 2 and _progress_text(room) == "Objects Found: 2 / 6", "Continue restores the saved progress (2 / 6)")
	_check(_find(objects, &"hospital_wristband").is_collected and not _find(objects, &"hospital_wristband").visible, "Restored objects stay found and hidden")
	_check(_status_text(hud, 0) == "Found!", "Restored objects are ticked in the list")

	# Open the trunk
	await _click(trunk.global_position + Vector2(0, 22))
	await _wait_seconds(0.6)
	_check(trunk.is_open and clipping.visible, "Clicking the trunk opens it and reveals the clipping")
	_check(SaveManager.get_room_progress("basement")["opened"].has("old_trunk"), "Opened trunk is saved")
	await _screenshot("14_trunk_open")

	# Restart clears this room's progress (but not the solved door)
	room.get_node("%HUD").get_node("%PauseButton").pressed.emit()
	await _wait_frames(2)
	room.get_node("%PauseMenu").get_node("%RestartButton").pressed.emit()
	await _wait_frames(8)
	room = tree.current_scene
	manager = room.get_node("%GameManager")
	objects = _get_objects(room)
	trunk = room.get_node("%HiddenObjects/OldTrunk")
	_check(manager.get_found_count() == 0 and not trunk.is_open, "Restart resets the basement (0 found, trunk closed)")
	_check(not room.get_node("KeypadLock").is_open(), "Restart does not ask for the door code again")

	# Find everything
	_completed_signal_count = 0
	manager.room_completed.connect(func() -> void: _completed_signal_count += 1)
	await _click(trunk.global_position + Vector2(0, 22))
	await _wait_seconds(0.6)
	for hidden_object in objects:
		await _click(hidden_object.global_position)
		_check(hidden_object.is_collected, "Clicking %s collects it" % hidden_object.data.object_id)
		await _wait_frames(2)
	_check(_progress_text(room) == "Objects Found: 6 / 6" and _completed_signal_count == 1, "Basement completes exactly once at 6 / 6")
	await _wait_seconds(4.5)
	victory = room.get_node("%VictoryScreen")
	letter = room.get_node("%LetterPopup")
	_check(victory.is_open() and letter.is_open(), "Chapter Two victory screen and letter appear")
	_check(letter.get_letter_text().contains("do not trust"), "Chapter Two letter shows Mara's warning")
	_check(victory.get_node("%ContinueButton").visible, "Chapter Two victory offers Continue to Chapter Three")
	_check(SaveManager.is_chapter_completed("basement") and SaveManager.get_room_progress("basement")["collected"].is_empty(), "Chapter Two completion is saved")
	await _wait_seconds(0.8)
	await _screenshot("15_basement_letter")
	letter.get_node("%CloseButton").pressed.emit()
	await _wait_frames(2)
	await _screenshot("16_basement_victory")

	# === CHAPTER THREE ============================================================
	victory.get_node("%ContinueButton").pressed.emit()
	await _wait_frames(8)
	room = tree.current_scene
	_check(room.scene_file_path == ATTIC_SCENE, "Continue on the Chapter Two screen opens Chapter Three (the attic)")
	manager = room.get_node("%GameManager")
	hud = room.get_node("%HUD")
	objects = _get_objects(room)
	keypad = room.get_node("KeypadLock")
	_check(keypad.is_open(), "The attic starts with the keypad lock")
	# Harder keypad: no hint after 2 wrong tries, a hint after 3.
	for attempt in range(2):
		for code_key: Key in [KEY_0, KEY_4, KEY_1, KEY_7, KEY_ENTER]:
			await _press_key(code_key)
	_check(keypad.wrong_attempts == 2 and not (keypad.get_node("%Message") as Label).text.contains("clipping"), "Attic keypad gives no hint after only 2 wrong tries")
	for code_key: Key in [KEY_1, KEY_1, KEY_1, KEY_1, KEY_ENTER]:
		await _press_key(code_key)
	_check((keypad.get_node("%Message") as Label).text.contains("clipping"), "Attic keypad hint appears after 3 wrong tries")
	await _screenshot("18_attic_keypad")
	for code_key: Key in [KEY_1, KEY_9, KEY_8, KEY_7, KEY_ENTER]:
		await _press_key(code_key)
	_check(not keypad.is_open() and SaveManager.get_flag("door_unlocked_attic"), "Typing 1987 opens the attic hatch and is saved")

	var jewellery_box: OpenableContainer = room.get_node("%HiddenObjects/JewelleryBox")
	var hat_box: OpenableContainer = room.get_node("%HiddenObjects/HatBox")
	var brass_key := _find(objects, &"brass_key")
	var locket := _find(objects, &"silver_locket")
	var telegram := _find(objects, &"telegram")
	_check(objects.size() == 7 and _progress_text(room) == "Objects Found: 0 / 7", "Attic has seven objects (0 / 7)")
	_check(hud.hint_cooldown_seconds == 20.0, "Attic hint cooldown is 20 seconds")
	var attic_lantern: LanternDarkness = room.get_node("LanternDarkness")
	_check(attic_lantern.visible and attic_lantern.flicker_strength > 0.0, "The attic is dark and the lantern flickers")
	_check(not locket.visible and not telegram.visible, "Locket and telegram start hidden in containers")
	await _wait_seconds(0.5)
	await _screenshot("19_attic_dark")

	# The jewellery box stays shut until the brass key is found.
	await _click(jewellery_box.global_position + Vector2(0, 8))
	_check(not jewellery_box.is_open and not locket.visible, "The jewellery box will not open without the brass key")
	_check(notification_popup_title(room) == "The jewellery box is locked.", "Clicking the locked box says it is locked")
	await _screenshot("20_attic_locked_box")
	await _click(hat_box.global_position + Vector2(0, 12))
	await _wait_seconds(0.6)
	_check(hat_box.is_open and telegram.visible, "Clicking the hat box opens it and reveals the telegram")
	await _click(brass_key.global_position)
	_check(brass_key.is_collected, "The brass key can be found")
	await _click(jewellery_box.global_position + Vector2(0, 8))
	await _wait_seconds(0.6)
	_check(jewellery_box.is_open and locket.visible, "With the key, the jewellery box opens and reveals the locket")
	await _screenshot("21_attic_boxes_open")

	# Leave and continue: both opened containers and the key must be restored.
	room.get_node("%HUD").get_node("%PauseButton").pressed.emit()
	await _wait_frames(2)
	room.get_node("%PauseMenu").get_node("%MainMenuButton").pressed.emit()
	await _wait_frames(6)
	tree.current_scene.get_node("%ContinueButton").pressed.emit()
	await _wait_frames(8)
	room = tree.current_scene
	manager = room.get_node("%GameManager")
	objects = _get_objects(room)
	_check(room.scene_file_path == ATTIC_SCENE and not room.get_node("KeypadLock").is_open(), "Continue returns to the attic without the keypad")
	_check(room.get_node("%HiddenObjects/JewelleryBox").is_open and room.get_node("%HiddenObjects/HatBox").is_open and _find(objects, &"brass_key").is_collected, "Opened boxes and the found key are restored")
	_check(_find(objects, &"silver_locket").visible and _find(objects, &"telegram").visible, "Revealed objects are restored")

	# Find everything else
	_completed_signal_count = 0
	manager.room_completed.connect(func() -> void: _completed_signal_count += 1)
	for hidden_object in objects:
		if hidden_object.is_collected:
			continue
		await _click(hidden_object.global_position)
		_check(hidden_object.is_collected, "Clicking %s collects it" % hidden_object.data.object_id)
		await _wait_frames(2)
	_check(_progress_text(room) == "Objects Found: 7 / 7" and _completed_signal_count == 1, "Attic completes exactly once at 7 / 7")
	await _wait_seconds(4.5)
	victory = room.get_node("%VictoryScreen")
	letter = room.get_node("%LetterPopup")
	_check(victory.is_open() and letter.is_open() and letter.get_letter_text().contains("Tonight I finish this"), "Chapter Three victory screen and letter appear")
	_check(victory.get_node("%ContinueButton").visible, "Chapter Three victory offers Continue to Chapter Four")
	_check(SaveManager.is_chapter_completed("attic"), "Chapter Three completion is saved")
	await _wait_seconds(0.8)
	await _screenshot("22_attic_letter")
	letter.get_node("%CloseButton").pressed.emit()
	await _wait_frames(2)
	await _screenshot("23_attic_victory")

	victory = await _play_chapters_four_to_eight(victory)

	# --- Chapter select and reset ------------------------------------------------
	victory.get_node("%MainMenuButton").pressed.emit()
	await _wait_frames(6)
	menu = tree.current_scene
	menu.get_node("%ChaptersButton").pressed.emit()
	await _wait_frames(2)
	_check(_chapter_button_texts(menu) == _expected_chapter_texts("Completed", "Completed"), "Chapters screen shows all chapters completed")
	await _screenshot("17_chapters")
	menu.get_node("%ResetButton").pressed.emit()
	_check(SaveManager.has_progress(), "Reset needs a second click (nothing erased yet)")
	menu.get_node("%ResetButton").pressed.emit()
	await _wait_frames(2)
	_check(not SaveManager.has_progress() and _only_first_chapter_unlocked(), "Second click erases all progress and locks every chapter after the first")
	menu.get_node("%ChaptersBackButton").pressed.emit()

	# --- Window resize (only meaningful with a real window) ----------------------
	if DisplayServer.get_name() != "headless":
		DisplayServer.window_set_size(Vector2i(960, 720))
		await _wait_frames(10)
		await _screenshot("09_menu_resized")
		tree.current_scene.get_node("%PlayButton").pressed.emit()
		await _wait_frames(10)
		room = tree.current_scene
		objects = _get_objects(room)
		var bear := _find(objects, &"teddy_bear")
		# Convert the bear's room position into a window position for the click.
		var window_position: Vector2 = room.get_viewport().get_screen_transform() * room.get_global_transform_with_canvas() * bear.position
		await _click(window_position)
		_check(bear.is_collected, "Objects are still clickable in a resized window")
		await _screenshot("10_room_resized")
		DisplayServer.window_set_size(Vector2i(1280, 720))

	DirAccess.remove_absolute(ProjectSettings.globalize_path(TEST_SAVE_PATH))
	_finish()


# ---------------------------------------------------------------------------
# Difficulty curve: every chapter must be harder than the one before it.
# This check runs over SaveManager.CHAPTERS, so a new chapter is checked too.
# Lighting is NOT part of the rule: each room picks its own lighting for mood.
# ---------------------------------------------------------------------------

func _check_difficulty_curve() -> void:
	var previous: Dictionary = {}
	var last_code_hint_after := 0
	for chapter in SaveManager.CHAPTERS:
		var stats := _chapter_stats(chapter)
		if not previous.is_empty():
			var name: String = "%s vs %s" % [stats["title"], previous["title"]]
			_check(stats["objects"] >= previous["objects"], "Difficulty: never fewer objects (%s)" % name)
			_check(stats["cooldown"] > previous["cooldown"], "Difficulty: longer hint cooldown (%s)" % name)
			_check(stats["radius"] > previous["radius"] and stats["offset"] > previous["offset"], "Difficulty: vaguer hint circle (%s)" % name)
			_check(stats["layers"] >= previous["layers"], "Difficulty: never fewer locked-away objects (%s)" % name)
			_check(stats["objects"] > previous["objects"] or stats["layers"] > previous["layers"] or stats["area"] > previous["area"],
					"Difficulty: more objects, more locks or a bigger room (%s)" % name)
			if stats["code_hint_after"] > 0:
				_check(stats["code_hint_after"] >= last_code_hint_after, "Difficulty: code hints come no earlier (%s)" % name)
		if stats["code_hint_after"] > 0:
			last_code_hint_after = stats["code_hint_after"]
		previous = stats


## Numbers that describe how hard a chapter is, read straight from its scene.
func _chapter_stats(chapter: Dictionary) -> Dictionary:
	var room: Node = load(chapter["scene"]).instantiate()
	var level: LevelData = room.level_data
	var background: RoomArt = room.get_node("RoomBackground")
	var stats := {
		"title": chapter["title"],
		"objects": 0,
		# Every container is one "layer"; a container that also needs a key or code counts twice.
		"layers": 0,
		"cooldown": level.hint_cooldown_seconds,
		"radius": level.hint_area_radius,
		"offset": level.hint_area_offset,
		"area": background.room_size.x * background.room_size.y,
		"code_hint_after": level.entry_hint_first_after if level.entry_code != "" else 0,
	}
	for child in room.get_node("HiddenObjects").get_children():
		if child is HiddenObject and child.data.is_required:
			stats["objects"] += 1
		elif child is OpenableContainer:
			stats["layers"] += 1
			if child.required_object != null or child.required_code != "":
				stats["layers"] += 1
			if child.required_code != "":
				stats["code_hint_after"] = maxi(stats["code_hint_after"], child.code_hint_first_after)
	room.free()
	return stats


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

# ---------------------------------------------------------------------------
# Chapters Four to Eight
# ---------------------------------------------------------------------------

func _play_chapters_four_to_eight(victory: VictoryScreen) -> VictoryScreen:
	# --- Chapter Four: the tall staircase that scrolls -------------------------
	# Park the REAL mouse away from the edges first, so it can't scroll the room as it loads.
	await _move_mouse_to(Vector2(40, 600))
	var room := await _continue_to(victory, STAIRCASE_SCENE, "Chapter Four (the grand staircase)")
	var camera: RoomCamera = room.room_camera
	# The REAL mouse near the window edge would scroll the room during the test,
	# so edge scrolling is switched off here (wheel and keys are still tested).
	camera.edge_size = 0.0
	_check(camera != null and camera.position.y == 0.0 and camera.get_max_scroll() > 0.0, "Staircase is taller than the screen and starts at the top")
	_check_not_dark(room, "Staircase")
	var lowest := 0.0
	for hidden_object in _get_objects(room):
		lowest = maxf(lowest, hidden_object.global_position.y)
	_check(lowest > 720.0, "Some staircase objects are below the first screen")
	await _move_mouse_to(Vector2(40, 600))  # Keep the cursor away from the scrolling edges.
	await _wait_frames(5)
	await _wheel(Vector2(500, 400), MOUSE_BUTTON_WHEEL_DOWN, 3)
	_check(camera.position.y > 0.0, "Mouse wheel scrolls the staircase down")
	await _press_key(KEY_UP)
	await _wheel(Vector2(500, 400), MOUSE_BUTTON_WHEEL_UP, 14)
	_check(camera.position.y == 0.0, "Mouse wheel scrolls back to the top")
	await _move_mouse_to(Vector2(40, 600))  # Park the cursor away from the screen edges.
	var deepest := _find(_get_objects(room), &"telephone_cord")
	room.get_node("%GameManager")._next_hint_index = _get_objects(room).find(deepest)
	room.get_node("%HUD").get_node("%HintButton").pressed.emit()
	await _wait_seconds(1.0)
	_check(absf(camera.position.y + 360.0 - deepest.global_position.y) < 361.0 and camera.position.y > 0.0, "A hint scrolls the camera to the hinted object")
	await _screenshot("24_staircase")
	await _check_locked_containers(room)
	await _solve_room(room, 7)
	victory = await _finish_chapter(room, "twin would know", true, "staircase")

	# --- Chapter Five: the washroom full of steam -------------------------------
	room = await _continue_to(victory, WASHROOM_SCENE, "Chapter Five (the washroom)")
	var keypad: KeypadLock = room.get_node("KeypadLock")
	_check(keypad.is_open(), "Washroom starts with its door keypad")
	await _type_code("0606")
	_check(not keypad.is_open(), "Typing 0606 (Mara's birthday) opens the washroom")
	_check_not_dark(room, "Washroom")
	var steam: SteamFog = room.get_node("SteamFog")
	var duck := _find(_get_objects(room), &"rubber_duck")
	_check(steam.visible and steam.get_fog_at(duck.global_position) > 0.9, "Steam covers the washroom at the start")
	await _move_mouse_across(duck.global_position)
	_check(steam.get_fog_at(duck.global_position) < 0.2, "Moving the mouse wipes the steam away")
	await _move_mouse_to(Vector2(80, 680))
	await _wait_seconds(7.0)
	_check(steam.get_fog_at(duck.global_position) > 0.8, "The steam drifts back after a few seconds")
	await _screenshot("25_washroom_steam")
	await _check_locked_containers(room)
	await _solve_room(room, 8)
	victory = await _finish_chapter(room, "lights fail", true, "washroom")

	# --- Chapter Six: the living room with random power cuts ---------------------
	room = await _continue_to(victory, LIVING_ROOM_SCENE, "Chapter Six (the living room)")
	var power: PowerCuts = room.get_node("PowerCuts")
	var match_light: LanternDarkness = room.get_node("MatchLight")
	_check(power.is_power_on and not match_light.visible, "Living room starts with the lights on")
	_check_not_dark(room, "Living room")
	_check(power.time_left >= power.min_seconds_between - 1.0 and power.time_left <= power.max_seconds_between, "The first power cut is scheduled at a random time (in %.1f s)" % power.time_left)
	power.cut_power()
	await _wait_seconds(0.8)
	_check(not power.is_power_on and match_light.visible, "A power cut makes the room dark")
	_check(notification_popup_title(room) == "The lights go out!", "The player is told the lights went out")
	_check(power.time_left >= power.min_cut_seconds - 1.0 and power.time_left <= power.max_cut_seconds, "The power cut lasts a random time (%.1f s)" % power.time_left)
	var record := _find(_get_objects(room), &"gramophone_record")
	await _click_world(room, record.global_position)
	_check(record.is_collected, "Objects can still be found during a power cut")
	await _screenshot("26_living_room_power_cut")
	power.restore_power()
	_check(power.is_power_on and not match_light.visible, "The lights come back on")
	await _check_locked_containers(room)
	await _solve_room(room, 8)
	_check(power.is_power_on and not power._active, "No more power cuts after the room is finished")
	victory = await _finish_chapter(room, "rhymes", true, "living_room")

	# --- Chapter Seven: the kitchen with riddles --------------------------------
	room = await _continue_to(victory, KITCHEN_SCENE, "Chapter Seven (the kitchen)")
	_check_not_dark(room, "Kitchen")
	var hud: Hud = room.get_node("%HUD")
	var spoon := _find(_get_objects(room), &"wooden_spoon")
	_check(hud.get_entry_text(&"wooden_spoon") == spoon.data.riddle_text and spoon.data.riddle_text != "", "The kitchen list shows riddles instead of names")
	await _click_world(room, spoon.global_position)
	_check(hud.get_entry_text(&"wooden_spoon") == "Wooden Spoon", "A found object's riddle turns into its name")
	await _screenshot("27_kitchen_riddles")
	await _check_locked_containers(room)
	await _solve_room(room, 9)
	victory = await _finish_chapter(room, "real will", true, "kitchen")

	# --- Chapter Eight: the study and its safe ----------------------------------
	room = await _continue_to(victory, STUDY_SCENE, "Chapter Eight (the study)")
	_check_not_dark(room, "Study")
	keypad = room.get_node("KeypadLock")
	_check(not keypad.is_open(), "The study has no entry code")
	var safe: OpenableContainer = room.get_node("%HiddenObjects/WallSafe")
	var will := _find(_get_objects(room), &"real_will")
	await _click_world(room, safe.global_position)
	_check(keypad.is_open() and not safe.is_open, "Clicking the safe asks for its code")
	_check((keypad.get_node("%KeypadMenuButton") as Button).text == "Step Back", "The safe keypad can be closed with Step Back")
	await _screenshot("28_study_safe_keypad")
	keypad.get_node("%KeypadMenuButton").pressed.emit()
	await _wait_frames(2)
	_check(not keypad.is_open() and not safe.is_open and room.get_tree().current_scene == room, "Step Back closes the keypad without opening the safe")
	await _click_world(room, safe.global_position)
	await _type_code("0417")
	_check(keypad.is_open() and not safe.is_open, "A wrong safe code keeps it shut")
	await _type_code("1704")
	await _wait_seconds(0.6)
	_check(not keypad.is_open() and safe.is_open and will.visible, "Typing 1704 opens the safe and reveals the real will")
	_check(SaveManager.get_room_progress("study")["opened"].has("wall_safe"), "The opened safe is saved")
	await _check_locked_containers(room)
	await _solve_room(room, 9)
	victory = await _finish_chapter(room, "never giving up", true, "study")
	_check((victory.get_node("%ContinueButton") as Button).text == "Continue: House Two", "House One's last chapter offers Continue: House Two")
	await _screenshot("29_house_one_complete")
	return await _play_house_two(victory)


# ---------------------------------------------------------------------------
# House Two: The Blackwater Boathouse
# ---------------------------------------------------------------------------

func _play_house_two(victory: VictoryScreen) -> VictoryScreen:
	# --- Chapter One: the wide jetty with drifting objects -----------------------
	await _move_mouse_to(Vector2(400, 600))
	var room := await _continue_to(victory, JETTY_SCENE, "House Two, Chapter One (the jetty)")
	var camera: RoomCamera = room.room_camera
	camera.edge_size = 0.0
	_check_not_dark(room, "Jetty")
	_check(camera.position == Vector2.ZERO and camera.get_max_scroll_x() > 1000.0 and camera.get_max_scroll() == 0.0,
			"The jetty is two screens wide and starts at the left end")
	var rightmost := 0.0
	for hidden_object in _get_objects(room):
		rightmost = maxf(rightmost, hidden_object.global_position.x)
	_check(rightmost > 1280.0, "Some jetty objects lie beyond the first screen")
	await _wheel(Vector2(500, 400), MOUSE_BUTTON_WHEEL_DOWN, 3)
	_check(camera.position.x > 0.0 and camera.position.y == 0.0, "The mouse wheel scrolls the jetty sideways")
	await _wheel(Vector2(500, 400), MOUSE_BUTTON_WHEEL_UP, 3)
	_check(camera.position.x == 0.0, "The mouse wheel scrolls back to the left end")
	# Drifting objects move by themselves.
	var drifting: Array[HiddenObject] = []
	for hidden_object in _get_objects(room):
		if hidden_object.get_node_or_null("Drifter") != null:
			drifting.append(hidden_object)
	var before: Array[Vector2] = []
	for hidden_object in drifting:
		before.append(hidden_object.position)
	await _wait_seconds(1.0)
	var all_moved := drifting.size() == 3
	for i in range(drifting.size()):
		all_moved = all_moved and drifting[i].position.distance_to(before[i]) > 2.0
	_check(all_moved, "Three objects drift on the lake by themselves")
	await _screenshot("30_jetty")
	# The dockmaster's locker needs the boat's number.
	var locker: OpenableContainer = room.get_node("%HiddenObjects/DockLocker")
	var keypad: KeypadLock = room.get_node("KeypadLock")
	_check(not keypad.is_open(), "The jetty has no entry code")
	await _click_world(room, locker.global_position)
	_check(keypad.is_open() and not locker.is_open, "Clicking the locker asks for its code")
	await _type_code("1704")
	_check(keypad.is_open() and not locker.is_open, "A wrong locker code keeps it shut")
	await _type_code("2209")
	await _wait_seconds(0.6)
	_check(not keypad.is_open() and locker.is_open and locker.contents.visible, "Typing 2209 opens the locker")
	await _check_locked_containers(room)
	await _solve_room(room, 10)
	victory = await _finish_chapter(room, "Sink the boat", true, "jetty")
	await _screenshot("31_jetty_complete")

	# --- Chapter Two: the boat shed, where the water floods in and out ---------
	room = await _continue_to(victory, BOAT_SHED_SCENE, "House Two, Chapter Two (the boat shed)")
	_check_not_dark(room, "Boat shed")
	keypad = room.get_node("KeypadLock")
	_check(not keypad.is_open(), "The boat shed has no entry code")
	var water: TideWater = room.get_node("TideWater")
	var bell := _find(_get_objects(room), &"ship_bell")
	var strongbox: OpenableContainer = room.get_node("%HiddenObjects/Strongbox")
	water.set_tide_high()
	await _wait_frames(2)
	_check(water.is_underwater(bell.global_position) and water.is_underwater(strongbox.global_position),
			"At high water the bell and the strongbox are under the water")
	await _click_world(room, bell.global_position)
	_check(not bell.is_collected and notification_popup_title(room) == "It's under the water", "An object under the water can't be collected, and the player is told why")
	await _click_world(room, strongbox.global_position)
	_check(not strongbox.is_open, "A container under the water can't be opened")
	# The water drains by itself after a few seconds.
	water.cycle_time = water.high_seconds - 0.3
	await _wait_seconds(2.0)
	_check(water.get_level() > water.slip_rect.position.y + 40.0, "The water drains out of the slip by itself")
	await _screenshot("32_boat_shed_draining")
	water.set_tide_low(true)
	await _wait_frames(2)
	_check(not water.is_underwater(bell.global_position), "At low water the bell can be reached")
	# The tool chest needs the train time.
	var chest: OpenableContainer = room.get_node("%HiddenObjects/ToolChest")
	await _click_world(room, chest.global_position)
	_check(keypad.is_open() and not chest.is_open, "Clicking the tool chest asks for its code")
	await _type_code("2209")
	_check(keypad.is_open() and not chest.is_open, "A wrong tool chest code keeps it shut")
	await _type_code("2350")
	await _wait_seconds(0.6)
	_check(not keypad.is_open() and chest.is_open and chest.contents.visible, "Typing 2350 opens the tool chest")
	await _check_locked_containers(room)
	await _solve_room(room, 11)
	victory = await _finish_chapter(room, "kept in the loft", true, "boat_shed")
	await _screenshot("33_boat_shed_complete")

	# --- Chapter Three: the loft, where careless clicks wake the bats ----------
	room = await _continue_to(victory, LOFT_SCENE, "House Two, Chapter Three (the loft)")
	_check_not_dark(room, "Loft")
	keypad = room.get_node("KeypadLock")
	_check(not keypad.is_open(), "The loft has no entry code")
	var bats: BatColony = room.get_node("BatColony")
	var candle := _find(_get_objects(room), &"candle_stub")
	# An empty spot on the gable wall, away from every object and container.
	var empty_spot := Vector2(300, 420)
	_check(not bats.is_swarming(), "The bats start asleep under the beam")
	# Dragging to look around is not a careless click.
	await _press_and_release(room.get_viewport().get_canvas_transform() * empty_spot,
			room.get_viewport().get_canvas_transform() * (empty_spot + Vector2(80, 0)))
	await _press_and_release(room.get_viewport().get_canvas_transform() * empty_spot,
			room.get_viewport().get_canvas_transform() * (empty_spot + Vector2(80, 0)))
	_check(not bats.is_swarming(), "Dragging across the room does not wake the bats")
	await _click_world(room, empty_spot)
	_check(not bats.is_swarming() and notification_popup_title(room) == "The bats stir...", "One click on an empty spot makes the bats stir")
	await _click_world(room, empty_spot)
	_check(bats.is_swarming() and notification_popup_title(room) == "The bats wake up!", "A second careless click wakes the bats")
	await _screenshot("34_loft_bats")
	await _click_world(room, candle.global_position)
	_check(not candle.is_collected and notification_popup_title(room) == "The bats are in the way!",
			"Nothing can be picked up while the bats fly, and the player is told why")
	await _wait_seconds(bats.swarm_seconds + bats.settle_seconds + 0.5)
	_check(not bats.is_swarming(), "The bats settle again by themselves")
	await _click_world(room, candle.global_position)
	_check(candle.is_collected, "Objects can be picked up once the bats have settled")
	# Clicks on real objects never disturb the bats.
	var sea_chest: OpenableContainer = room.get_node("%HiddenObjects/SeaChest")
	await _click_world(room, sea_chest.global_position)
	_check(keypad.is_open() and not sea_chest.is_open, "Clicking the sea chest asks for its code")
	await _type_code("1987")
	_check(keypad.is_open() and not sea_chest.is_open, "A wrong sea chest code keeps it shut")
	await _type_code("1405")
	await _wait_seconds(0.6)
	_check(not keypad.is_open() and sea_chest.is_open and sea_chest.contents.visible, "Typing 1405 opens the sea chest")
	await _check_locked_containers(room)
	await _solve_room(room, 12)
	_check(not bats.is_swarming(), "Solving the loft never woke the bats")
	victory = await _finish_chapter(room, "Lady Margaret", true, "loft")
	await _screenshot("35_loft_complete")
	victory = await _play_house_two_part_two(victory)
	return victory


# ---------------------------------------------------------------------------
# House Two, Chapters Four to Ten
# ---------------------------------------------------------------------------

func _play_house_two_part_two(victory: VictoryScreen) -> VictoryScreen:
	var room: Node
	var keypad: KeypadLock
	# --- Chapter Four: the workshop, where the hull plan was torn up ----------
	room = await _continue_to(victory, "res://scenes/workshop.tscn", "House Two, Chapter Four (the workshop)")
	_check_not_dark(room, "Workshop")
	keypad = room.get_node("KeypadLock")
	_check(not keypad.is_open(), "The workshop has no entry code")
	var pieces: TornPieces = room.get_node("TornPieces")
	var hull_plan := _find(_get_objects(room), &"hull_plan")
	_check(not hull_plan.visible and pieces.get_pieces().size() == 4 and pieces.collected_count() == 0,
			"The hull plan is missing and four torn scraps lie around the workshop")
	_check(hull_plan.get_hint_position() == pieces.get_pieces()[0].global_position, "The hint for the hull plan points at a torn scrap")
	await _click_world(room, pieces.get_pieces()[0].global_position)
	_check(pieces.collected_count() == 1 and notification_popup_title(room) == "A torn piece!", "Clicking a scrap picks it up, and the player is told")
	_check(hull_plan.get_hint_position() == pieces.get_pieces()[1].global_position, "The hint moves on to the next scrap")
	await _click_world(room, pieces.get_pieces()[0].global_position)
	_check(pieces.collected_count() == 1, "A scrap can only be picked up once")
	await _click_world(room, pieces.get_pieces()[1].global_position)
	await _click_world(room, pieces.get_pieces()[2].global_position)
	_check(pieces.collected_count() == 3 and not hull_plan.visible, "Three scraps are not enough to make the plan")
	await _click_world(room, pieces.get_pieces()[3].global_position)
	_check(notification_popup_title(room) == "The plan is complete!" and hull_plan.visible, "The fourth scrap puts the plan back together on the bench")
	await _screenshot("36_workshop_plan")
	await _wait_seconds(2.0)
	_check(hull_plan.is_collected, "The finished hull plan is ticked off by itself")
	var cash_box: OpenableContainer = room.get_node("%HiddenObjects/CashBox")
	await _click_world(room, cash_box.global_position)
	_check(keypad.is_open() and not cash_box.is_open, "Clicking the cash box asks for its code")
	await _type_code("1988")
	_check(keypad.is_open() and not cash_box.is_open, "A wrong cash box code keeps it shut")
	await _type_code("0110")
	await _wait_seconds(0.6)
	_check(not keypad.is_open() and cash_box.is_open and cash_box.contents.visible, "Typing 0110 opens the cash box")
	await _check_locked_containers(room)
	pieces.collect_all()
	await _solve_room(room, 13)
	victory = await _finish_chapter(room, "pull the bungs", true, "workshop")
	await _screenshot("37_workshop_complete")

	# --- Chapter Five: the sunken boat, searching on one breath of air ---------
	room = await _continue_to(victory, "res://scenes/sunken_boat.tscn", "House Two, Chapter Five (the sunken boat)")
	keypad = room.get_node("KeypadLock")
	_check(not keypad.is_open(), "The sunken boat has no entry code")
	var lamp: LanternDarkness = room.get_node("LanternDarkness")
	_check(lamp.is_visible_in_tree(), "The wreck is dark: you search by the diving lamp")
	var air: AirSupply = room.get_node("AirSupply")
	var ship_lantern := _find(_get_objects(room), &"ship_lantern")
	var key_box: OpenableContainer = room.get_node("%HiddenObjects/KeyBox")
	var start_air := air.get_air()
	await _wait_seconds(1.0)
	_check(air.get_air() < start_air and not air.is_surfacing(), "The air gauge slowly drains while you search")
	air.set_air(0.26)
	await _wait_seconds(1.0)
	_check(notification_popup_title(room) == "Running low on air!", "At a quarter full the player is warned about the air")
	air.set_air(0.0)
	await _wait_frames(3)
	_check(air.is_surfacing() and notification_popup_title(room) == "Out of air!", "Out of air: you swim up to the surface")
	await _screenshot("38_sunken_boat_surfacing")
	await _click_world(room, ship_lantern.global_position)
	_check(not ship_lantern.is_collected and notification_popup_title(room) == "You're at the surface",
			"Nothing can be picked up while you are at the surface, and the player is told why")
	await _click_world(room, key_box.global_position)
	_check(not keypad.is_open() and not key_box.is_open, "No container can be opened while you are at the surface")
	await _wait_seconds(air.surface_seconds + 0.5)
	_check(not air.is_surfacing() and air.get_air() > 0.9, "After a breath the air is full and you dive back down")
	var air_before := air.get_air()
	await _click_world(room, ship_lantern.global_position)
	_check(ship_lantern.is_collected and air.get_air() <= air_before, "Objects can be collected again, and collecting does not refill the air")
	get_tree().paused = true
	var paused_air := air.get_air()
	await _wait_seconds(1.0)
	_check(air.get_air() == paused_air, "No air is used while the game is paused")
	get_tree().paused = false
	await _click_world(room, key_box.global_position)
	_check(keypad.is_open() and not key_box.is_open, "Clicking the key box asks for its code")
	var keypad_air := air.get_air()
	await _wait_seconds(1.0)
	_check(air.get_air() == keypad_air, "No air is used while the keypad is open")
	await _type_code("1405")
	_check(keypad.is_open() and not key_box.is_open, "A wrong key box code keeps it shut")
	await _type_code("2140")
	await _wait_seconds(0.6)
	_check(not keypad.is_open() and key_box.is_open and key_box.contents.visible, "Typing 2140 opens the key box")
	await _check_locked_containers(room)
	air.hold(true)
	await _solve_room(room, 13)
	victory = await _finish_chapter(room, "went over the side", true, "sunken_boat")
	await _screenshot("39_sunken_boat_complete")

	# --- Chapter Six: the ice house, where frost creeps back over things ------
	room = await _continue_to(victory, "res://scenes/ice_house.tscn", "House Two, Chapter Six (the ice house)")
	_check_not_dark(room, "Ice house")
	keypad = room.get_node("KeypadLock")
	_check(not keypad.is_open(), "The ice house has no entry code")
	var frost: FrostCover = room.get_node("FrostCover")
	var slate := _find(_get_objects(room), &"scratched_slate")
	var ice_pick := _find(_get_objects(room), &"ice_pick")
	frost.hold(true)  # No random frost while we test.
	frost.frost_object(slate)
	await _wait_frames(2)
	_check(frost.is_frosted(slate), "Frost can form over an object")
	await _click_world(room, slate.global_position)
	_check(not slate.is_collected and not frost.is_frosted(slate) and notification_popup_title(room) == "Frosted over",
			"The first click on a frosted object rubs the frost away, and the player is told why")
	await _click_world(room, slate.global_position)
	_check(slate.is_collected, "Once rubbed clean, the object can be picked up")
	# Blocks of ice: the big one needs the ice pick, the small one needs several blows.
	var pike_ice: OpenableContainer = room.get_node("%HiddenObjects/PikeIce")
	await _click_world(room, pike_ice.global_position)
	_check(not pike_ice.is_open and notification_popup_title(room) == pike_ice.locked_title, "The big block of ice can't be broken without the ice pick")
	await _click_world(room, ice_pick.global_position)
	_check(ice_pick.is_collected, "The ice pick can be picked up")
	var brooch_ice: OpenableContainer = room.get_node("%HiddenObjects/BroochIce")
	await _click_world(room, brooch_ice.global_position)
	_check(not brooch_ice.is_open and brooch_ice.hits_taken == 1 and notification_popup_title(room) == "The ice cracks...",
			"One blow only cracks a block of ice")
	for hit in range(brooch_ice.hits_to_open - 1):
		await _click_world(room, brooch_ice.global_position)
		await _wait_seconds(0.25)
	await _wait_seconds(0.5)
	_check(brooch_ice.is_open and brooch_ice.contents.visible, "Enough blows break the block open")
	# Frost creeps back by itself.
	frost.hold(false)
	frost.seconds_until_frost = 0.1
	await _wait_seconds(0.5)
	var frosted_count := 0
	for hidden_object in _get_objects(room):
		if frost.is_frosted(hidden_object):
			frosted_count += 1
	_check(frosted_count >= 1 and frosted_count <= 2, "Frost creeps back over one or two objects by itself")
	await _screenshot("40_ice_house_frost")
	frost.hold(true)
	frosted_count = 0
	for hidden_object in _get_objects(room):
		if frost.is_frosted(hidden_object):
			frosted_count += 1
	_check(frosted_count == 0, "Holding the frost clears it all")
	# The ice cutters' locker needs the company's year.
	var locker: OpenableContainer = room.get_node("%HiddenObjects/ToolLocker")
	await _click_world(room, locker.global_position)
	_check(keypad.is_open() and not locker.is_open, "Clicking the tool locker asks for its code")
	await _type_code("1988")
	_check(keypad.is_open() and not locker.is_open, "A wrong locker code keeps it shut")
	await _type_code("1896")
	await _wait_seconds(0.6)
	_check(not keypad.is_open() and locker.is_open and locker.contents.visible, "Typing 1896 opens the tool locker")
	await _check_locked_containers(room)
	await _solve_room(room, 14)
	victory = await _finish_chapter(room, "taking her to the lighthouse", true, "ice_house")
	await _screenshot("41_ice_house_complete")

	# --- Chapter Seven: the lighthouse steps, lit by the sweeping beam ---------
	room = await _continue_to(victory, "res://scenes/lighthouse_steps.tscn", "House Two, Chapter Seven (the lighthouse steps)")
	_check_not_dark(room, "Lighthouse steps")
	keypad = room.get_node("KeypadLock")
	_check(not keypad.is_open(), "The lighthouse has no entry code")
	var tower_camera: RoomCamera = room.room_camera
	tower_camera.edge_size = 0.0
	_check(tower_camera.position.y == 0.0 and tower_camera.get_max_scroll() > 600.0,
			"The lighthouse is two screens tall and starts at the top")
	var beam: SweepingBeam = room.get_node("SweepingBeam")
	_check(beam.get_beam_objects().size() == 5, "Five objects can only be seen in the beam")
	var beam_start := beam.get_beam_x()
	await _wait_seconds(1.0)
	_check(beam.get_beam_x() > beam_start + 100.0, "The lighthouse beam sweeps across by itself")
	beam.hold(true)
	# (_click_world scrolls the tall room's camera to each target before clicking.)
	var feather := _find(_get_objects(room), &"gull_feather")
	beam.set_beam_x(feather.global_position.x + 700.0)
	await _wait_frames(2)
	_check(not beam.is_lit(feather.global_position), "Away from the beam the feather is in the dark")
	await _click_world(room, feather.global_position)
	_check(not feather.is_collected and notification_popup_title(room) == "Too dark to make it out",
			"A beam object can't be picked up in the dark, and the player is told why")
	beam.set_beam_x(feather.global_position.x)
	await _wait_frames(2)
	await _click_world(room, feather.global_position)
	_check(feather.is_collected, "The feather can be picked up while the beam lights it")
	var barometer := _find(_get_objects(room), &"barometer")
	beam.set_beam_x(barometer.global_position.x + 800.0)
	await _click_world(room, barometer.global_position)
	_check(barometer.is_collected, "Ordinary objects can be picked up in the dark")
	await _screenshot("44_lighthouse_beam")
	# The oil locker needs the night Agnes found the girl.
	var oil_store: OpenableContainer = room.get_node("%HiddenObjects/OilStore")
	await _click_world(room, oil_store.global_position)
	_check(keypad.is_open() and not oil_store.is_open, "Clicking the oil locker asks for its code")
	await _type_code("1988")
	_check(keypad.is_open() and not oil_store.is_open, "A wrong oil locker code keeps it shut")
	await _type_code("0310")
	await _wait_seconds(0.6)
	_check(not keypad.is_open() and oil_store.is_open and oil_store.contents.visible, "Typing 0310 opens the oil locker")
	await _check_locked_containers(room)
	beam.light_everything(true)
	await _solve_room(room, 14)
	victory = await _finish_chapter(room, "Margaret I'll call her", true, "lighthouse_steps")
	await _screenshot("45_lighthouse_steps_complete")

	# --- Chapter Eight: the lamp room, where gusts blow the loose papers about ---
	room = await _continue_to(victory, "res://scenes/lamp_room.tscn", "House Two, Chapter Eight (the lamp room)")
	_check_not_dark(room, "Lamp room")
	keypad = room.get_node("KeypadLock")
	_check(not keypad.is_open(), "The lamp room has no entry code")
	var lamp_wind: WindGusts = room.get_node("WindGusts")
	var lamp_papers := lamp_wind.get_papers()
	_check(lamp_papers.size() == 5 and lamp_wind.landing_spots.size() >= 9, "The lamp room has 5 loose papers and at least 9 landing spots")
	# No random gusts while we check things; gust_now() and warn_now() still force one.
	lamp_wind.calm(true)
	_check(not lamp_wind.is_gusting(), "The wind is calm when asked")
	# A warning comes first, then the gust blows by itself.
	lamp_wind.warn_now()
	await _wait_frames(2)
	_check(lamp_wind.is_warning() and notification_popup_title(room) == "A gust is coming!", "A gust is announced before it blows")
	await _wait_seconds(lamp_wind.warning_seconds + 0.2)
	_check(lamp_wind.is_gusting(), "The gust blows after the warning")
	await _wait_seconds(lamp_wind.flight_seconds + 0.8)
	_check(not lamp_wind.is_gusting(), "The gust dies down again")
	# A forced gust: the papers fly, can't be caught in the air, and land on new, separate spots.
	var lamp_paper := lamp_papers[0]
	var lamp_other_paper := lamp_papers[1]
	var lamp_mantle_object := _find(_get_objects(room), &"lamp_mantle")
	var lamp_before := lamp_paper.global_position
	lamp_wind.gust_now()
	await _wait_frames(2)
	_check(lamp_wind.is_gusting() and lamp_wind.is_flying(lamp_paper), "A gust sends the loose papers flying")
	await _click_world(room, lamp_paper.global_position)
	_check(not lamp_paper.is_collected, "A paper can't be collected while it flies")
	await _click_world(room, lamp_mantle_object.global_position)
	_check(lamp_mantle_object.is_collected, "Objects that aren't papers can still be picked up during a gust")
	await _click_world(room, lamp_other_paper.global_position)
	_check(not lamp_other_paper.is_collected, "Another flying paper can't be caught either")
	await _wait_seconds(lamp_wind.flight_seconds + 0.6)
	_check(not lamp_wind.is_gusting() and lamp_paper.global_position.distance_to(lamp_before) > 20.0, "The gust moved the paper to a new spot")
	var lamp_spots_used: Array[int] = []
	for lamp_loose in lamp_papers:
		for i in range(lamp_wind.landing_spots.size()):
			if not lamp_loose.is_collected and lamp_loose.global_position.distance_to(lamp_wind.landing_spots[i]) < 1.0:
				lamp_spots_used.append(i)
	var lamp_unique := lamp_spots_used.size() == lamp_papers.size()
	for i in lamp_spots_used:
		lamp_unique = lamp_unique and lamp_spots_used.count(i) == 1
	_check(lamp_unique, "Every paper landed on its own landing spot")
	await _click_world(room, lamp_paper.global_position)
	_check(lamp_paper.is_collected, "A paper can be collected once it has landed")
	# Agnes's writing box needs the ferry time from the painted board.
	var lamp_writing_box: OpenableContainer = room.get_node("%HiddenObjects/WritingBox")
	await _click_world(room, lamp_writing_box.global_position)
	_check(keypad.is_open() and not lamp_writing_box.is_open, "Clicking the writing box asks for its code")
	await _type_code("1989")
	_check(keypad.is_open() and not lamp_writing_box.is_open, "A wrong writing box code keeps it shut")
	await _type_code("0640")
	await _wait_seconds(0.6)
	_check(not keypad.is_open() and lamp_writing_box.is_open and lamp_writing_box.contents.visible, "Typing 0640 opens the writing box")
	await _check_locked_containers(room)
	lamp_wind.calm(true)
	await _solve_room(room, 15)
	_check(not lamp_wind.is_gusting(), "No gust blew while the lamp room was solved in calm")
	victory = await _finish_chapter(room, "keep her safe", true, "lamp_room")
	await _screenshot("49_lamp_room_complete")

	# --- Chapter Nine: the island chapel, lit only by candles -------------------
	room = await _continue_to(victory, "res://scenes/island_chapel.tscn", "House Two, Chapter Nine (the island chapel)")
	keypad = room.get_node("KeypadLock")
	_check(not keypad.is_open(), "The island chapel has no entry code")
	var candles: CandleLights = room.get_node("CandleLights")
	var all_lit := candles.candle_count() == 6
	for i in range(candles.candle_count()):
		all_lit = all_lit and candles.is_lit(i)
	_check(all_lit, "The chapel has 6 candles, all burning at the start")
	candles.light_all(true)  # Hold: no random draughts while we test.
	var hand_bell := _find(_get_objects(room), &"hand_bell")
	# Candle 4 (the stand on the left) is the only light on the pulpit steps.
	candles.blow_out(4)
	await _wait_frames(2)
	_check(not candles.is_lit(4) and not candles.is_in_light(hand_bell.global_position), "Blowing out the left candle leaves the hand bell in the dark")
	await _screenshot("46_island_chapel_dark")
	await _click_world(room, hand_bell.global_position)
	_check(not hand_bell.is_collected and notification_popup_title(room) == "Too dark to see",
			"An object in the dark can't be picked up, and the player is told to light a candle")
	await _click_world(room, candles.get_candle_position(4))
	_check(candles.is_lit(4) and candles.is_in_light(hand_bell.global_position), "Clicking a candle that went out lights it again")
	await _click_world(room, hand_bell.global_position)
	_check(hand_bell.is_collected, "Once its candle burns again, the hand bell can be picked up")
	# A draught blows a random candle out by itself.
	candles.light_all(false)
	candles.next_draught_in(0.2)
	await _wait_seconds(0.8)
	var out := 0
	for i in range(candles.candle_count()):
		if not candles.is_lit(i):
			out += 1
	_check(out == 1 and notification_popup_title(room) == "A draught!", "A draught blows a candle out and the player is told")
	candles.light_all(true)  # The safe state: every candle lit, no more draughts.
	await _wait_frames(2)
	# The alms box needs the year Sister Margaret came to the chapel.
	var alms_box: OpenableContainer = room.get_node("%HiddenObjects/AlmsBox")
	await _click_world(room, alms_box.global_position)
	_check(keypad.is_open() and not alms_box.is_open, "Clicking the alms box asks for its code")
	await _type_code("1987")
	_check(keypad.is_open() and not alms_box.is_open, "A wrong alms box code keeps it shut")
	await _type_code("1989")
	await _wait_seconds(0.6)
	_check(not keypad.is_open() and alms_box.is_open and alms_box.contents.visible, "Typing 1989 opens the alms box")
	await _check_locked_containers(room)
	await _solve_room(room, 15)
	victory = await _finish_chapter(room, "Sister Margaret", true, "island_chapel")
	await _screenshot("47_island_chapel_complete")

	# --- Chapter Ten: Dr Vane's cottage, while he patrols the garden path -----
	room = await _continue_to(victory, "res://scenes/vane_cottage.tscn", "House Two, Chapter Ten (Dr Vane's cottage)")
	_check_not_dark(room, "Vane's cottage")
	keypad = room.get_node("KeypadLock")
	_check(not keypad.is_open(), "Vane's cottage has no entry code")
	var patrol: PatrolLantern = room.get_node("PatrolLantern")
	var cheque_book := _find(_get_objects(room), &"cheque_book")
	var decanter := _find(_get_objects(room), &"decanter")
	var desk_drawer: OpenableContainer = room.get_node("%HiddenObjects/DeskDrawer")
	# An empty spot on the wallpaper above the bookcase, away from every object.
	var cottage_empty_spot := Vector2(950, 160)
	_check(not patrol.is_warning() and not patrol.is_looking() and not patrol.is_hiding(), "Vane starts down the garden, out of sight")
	patrol.start_warning()
	await _wait_frames(2)
	_check(patrol.is_warning() and notification_popup_title(room) == "Footsteps on the gravel...", "Footsteps on the gravel warn that Vane is coming")
	await _click_world(room, cheque_book.global_position)
	_check(cheque_book.is_collected, "Objects can still be picked up during the warning")
	await _wait_seconds(patrol.warning_seconds + 0.3)
	_check(patrol.is_looking(), "After the warning, his lantern looks in by itself")
	await _screenshot("50_vane_cottage_lantern")
	await _click_world(room, decanter.global_position)
	_check(not decanter.is_collected and patrol.is_hiding() and notification_popup_title(room) == "He saw you move!",
			"A click on an object while he looks in collects nothing: he sees you and you hide")
	await _click_world(room, desk_drawer.global_position)
	_check(not desk_drawer.is_open and patrol.is_hiding(), "Nothing can be opened while you hide")
	await _wait_seconds(patrol.hide_seconds + 0.3)
	_check(not patrol.is_hiding() and not patrol.is_looking(), "Vane walks on after a few seconds")
	await _click_world(room, decanter.global_position)
	_check(decanter.is_collected, "Once he has walked on, objects can be picked up again")
	patrol.start_look()
	await _click_world(room, cottage_empty_spot)
	_check(patrol.is_hiding() and notification_popup_title(room) == "He saw you move!", "Even a click on an empty spot is seen while he looks in")
	patrol.stop_hiding()
	patrol.start_look()
	patrol.end_look()
	_check(not patrol.is_looking() and not patrol.is_hiding(), "end_look() and stop_hiding() bring the room back to normal")
	patrol.calm(true)
	# The desk safe: Vane's card by the lamp + the ringed date on the calendar.
	var desk_safe: OpenableContainer = room.get_node("%HiddenObjects/DeskSafe")
	await _click_world(room, desk_safe.global_position)
	_check(keypad.is_open() and not desk_safe.is_open, "Clicking the desk safe asks for its code")
	await _type_code("1987")
	_check(keypad.is_open() and not desk_safe.is_open, "A wrong desk safe code keeps it shut")
	await _type_code("0810")
	await _wait_seconds(0.6)
	_check(not keypad.is_open() and desk_safe.is_open and desk_safe.contents.visible, "Typing 0810 opens the desk safe")
	# The doctor's bag: the year on the forged death certificate.
	var doctors_bag: OpenableContainer = room.get_node("%HiddenObjects/DoctorsBag")
	await _click_world(room, doctors_bag.global_position)
	_check(keypad.is_open() and not doctors_bag.is_open, "Clicking the doctor's bag asks for its code")
	await _type_code("0810")
	_check(keypad.is_open() and not doctors_bag.is_open, "A wrong doctor's bag code keeps it shut")
	await _type_code("1987")
	await _wait_seconds(0.6)
	_check(not keypad.is_open() and doctors_bag.is_open and doctors_bag.contents.visible, "Typing 1987 opens the doctor's bag")
	await _check_locked_containers(room)
	await _solve_room(room, 16)
	_check(not patrol.is_hiding(), "Solving the cottage never left the player hiding")
	victory = await _finish_chapter(room, "Ashworth Manor", false, "vane_cottage")
	_check((victory.get_node("Root/Center/Panel/VBox/ToBeContinued") as Label).text == "THE END", "The last chapter ends with THE END")
	await _screenshot("51_vane_cottage_complete")
	return victory


## Presses Continue on a completion screen and returns the new room.
func _continue_to(victory: VictoryScreen, scene_path: String, description: String) -> Node:
	victory.get_node("%ContinueButton").pressed.emit()
	await _wait_frames(10)
	var room := get_tree().current_scene
	_check(room.scene_file_path == scene_path, "Continue opens %s" % description)
	return room


## Chapters Four to Eight must not be permanently dark.
func _check_not_dark(room: Node, room_title: String) -> void:
	var dark := false
	for effect in get_tree().get_nodes_in_group("room_effects"):
		if effect is LanternDarkness and (effect as LanternDarkness).is_visible_in_tree():
			dark = true
	_check(not dark, "%s is not dark" % room_title)


## Clicks every container that needs a key before the key is found: it must stay shut.
func _check_locked_containers(room: Node) -> void:
	for child in room.get_node("%HiddenObjects").get_children():
		var container := child as OpenableContainer
		if container == null or not container.is_locked() or container.is_open:
			continue
		await _click_world(room, container.global_position)
		_check(not container.is_open and notification_popup_title(room) == container.locked_title,
				"%s stays locked until its key is found" % container.name)


## Opens every container it can and clicks every visible object, repeating until done.
func _solve_room(room: Node, expected_objects: int) -> void:
	var manager: GameManager = room.get_node("%GameManager")
	var objects := _get_objects(room)
	_check(objects.size() == expected_objects and manager.get_total_count() == expected_objects, "%s has %d objects" % [room.name, expected_objects])
	_completed_signal_count = 0
	manager.room_completed.connect(func() -> void: _completed_signal_count += 1)
	for attempt in range(6):
		for child in room.get_node("%HiddenObjects").get_children():
			var container := child as OpenableContainer
			if container != null and not container.is_open and not container.is_locked() and not container.needs_code():
				# A block of ice needs several blows.
				for hit in range(maxi(container.hits_to_open - container.hits_taken, 1)):
					await _click_world(room, container.global_position)
					await _wait_seconds(0.25)
				await _wait_seconds(0.5)
				_check(container.is_open and container.contents.visible, "Clicking %s opens it" % container.name)
		for hidden_object in objects:
			if hidden_object.visible and not hidden_object.is_collected:
				await _click_world(room, hidden_object.global_position)
				_check(hidden_object.is_collected, "Clicking %s collects it" % hidden_object.data.object_id)
				await _wait_frames(2)
		if manager.is_room_complete:
			break
	_check(manager.get_found_count() == expected_objects and _completed_signal_count == 1,
			"%s completes exactly once at %d / %d" % [room.name, expected_objects, expected_objects])


func _finish_chapter(room: Node, letter_text: String, expect_continue: bool, chapter_id: String) -> VictoryScreen:
	await _wait_seconds(4.5)
	var victory: VictoryScreen = room.get_node("%VictoryScreen")
	var letter: LetterPopup = room.get_node("%LetterPopup")
	_check(victory.is_open() and letter.is_open() and letter.get_letter_text().contains(letter_text), "%s: completion screen and letter appear" % room.name)
	_check(victory.get_node("%ContinueButton").visible == expect_continue, "%s: Continue button %s" % [room.name, "offered" if expect_continue else "hidden after the last chapter"])
	_check(SaveManager.is_chapter_completed(chapter_id), "%s: completion is saved" % room.name)
	letter.get_node("%CloseButton").pressed.emit()
	await _wait_frames(2)
	return victory


## Clicks a position in the ROOM. Scrolls a tall room's camera there first.
func _click_world(room: Node, world_position: Vector2) -> void:
	var camera: RoomCamera = room.room_camera
	if camera != null:
		camera.focus_on(world_position, true)
		await _wait_frames(3)
	await _click(room.get_viewport().get_canvas_transform() * world_position)


## Presses the left button at one point and lets go somewhere else (a drag).
func _press_and_release(from: Vector2, to: Vector2) -> void:
	get_tree().root.notification(Window.NOTIFICATION_WM_MOUSE_ENTER)
	for step in [[from, true], [to, false]]:
		var motion := InputEventMouseMotion.new()
		motion.position = step[0]
		motion.global_position = step[0]
		Input.parse_input_event(motion)
		await _wait_frames(2)
		await _wait_physics(2)
		var button := InputEventMouseButton.new()
		button.button_index = MOUSE_BUTTON_LEFT
		button.pressed = step[1]
		button.position = step[0]
		button.global_position = step[0]
		Input.parse_input_event(button)
		await _wait_frames(2)
		await _wait_physics(2)


func _type_code(code: String) -> void:
	for digit in code:
		await _press_key(KEY_0 + int(digit) as Key)
	await _press_key(KEY_ENTER)


func _move_mouse_to(position: Vector2) -> void:
	# The steam reads the mouse position every frame, and Godot also polls the
	# REAL cursor, so move the real cursor too (only in this test helper).
	if DisplayServer.get_name() != "headless":
		Input.warp_mouse(position)
	var motion := InputEventMouseMotion.new()
	motion.position = position
	motion.global_position = position
	Input.parse_input_event(motion)
	await _wait_frames(2)


## Moves the mouse in a short line through a point (like wiping a mirror).
func _move_mouse_across(position: Vector2) -> void:
	get_tree().root.notification(Window.NOTIFICATION_WM_MOUSE_ENTER)
	for step in range(-3, 4):
		await _move_mouse_to(position + Vector2(step * 15.0, 0))


func _wheel(position: Vector2, button: MouseButton, notches: int) -> void:
	get_tree().root.notification(Window.NOTIFICATION_WM_MOUSE_ENTER)
	await _move_mouse_to(position)
	for i in range(notches):
		for pressed in [true, false]:
			var wheel := InputEventMouseButton.new()
			wheel.button_index = button
			wheel.pressed = pressed
			wheel.position = position
			wheel.global_position = position
			Input.parse_input_event(wheel)
			await _wait_frames(2)


func _expected_chapter_texts(first_state: String, other_state: String) -> Array[String]:
	var texts: Array[String] = []
	for i in range(SaveManager.CHAPTERS.size()):
		texts.append("%s   (%s)" % [SaveManager.CHAPTERS[i]["title"], first_state if i == 0 else other_state])
	return texts


func _only_first_chapter_unlocked() -> bool:
	for i in range(SaveManager.CHAPTERS.size()):
		if SaveManager.is_chapter_unlocked(SaveManager.CHAPTERS[i]["id"]) != (i == 0):
			return false
	return true


func notification_popup_title(room: Node) -> String:
	var popup: NotificationPopup = room.get_node("%Notification")
	return popup.get_title() if popup.is_showing() else ""


func _check(condition: bool, description: String) -> void:
	if condition:
		_passes += 1
		print("  PASS  ", description)
	else:
		_failures.append(description)
		print("  FAIL  ", description)


func _finish() -> void:
	print("")
	print("RESULT: %d passed, %d failed" % [_passes, _failures.size()])
	for failure in _failures:
		print("  failed: ", failure)
	get_tree().quit(1 if _failures.size() > 0 else 0)


func _click(position: Vector2) -> void:
	# The real OS cursor may be outside the test window. Tell Godot the mouse is
	# inside, otherwise it ignores clicks on objects (a real player's mouse does this itself).
	get_tree().root.notification(Window.NOTIFICATION_WM_MOUSE_ENTER)
	var motion := InputEventMouseMotion.new()
	motion.position = position
	motion.global_position = position
	Input.parse_input_event(motion)
	# Wait for both normal and physics frames: clicks on objects are handled in
	# the physics step, and a slow frame (e.g. a screenshot) can bunch them up.
	await _wait_frames(2)
	await _wait_physics(2)
	for pressed in [true, false]:
		var button := InputEventMouseButton.new()
		button.button_index = MOUSE_BUTTON_LEFT
		button.pressed = pressed
		button.position = position
		button.global_position = position
		Input.parse_input_event(button)
		await _wait_frames(2)
		await _wait_physics(2)


## Zoom buttons, Ctrl + wheel, a two-finger pinch and finger dragging, then
## restarts the room so no progress is left behind.
func _check_zoom(room: Node) -> void:
	var camera: RoomCamera = room.room_camera
	_check(camera != null and is_equal_approx(camera.get_zoom_level(), 1.0), "Every room has a zoom camera that starts zoomed out")
	var buttons: Array[Node] = camera.find_child("ZoomButtons", true, false).get_children()
	var zoom_in_button: Button = buttons[0]
	var zoom_out_button: Button = buttons[1]
	_check(zoom_in_button.visible and zoom_out_button.disabled, "Zoom buttons show; zoom out is off when fully zoomed out")
	zoom_in_button.pressed.emit()
	await _wait_frames(2)
	_check(camera.get_zoom_level() > 1.2 and not zoom_out_button.disabled, "The + button zooms in")
	var before_x := camera.position.x
	await _hold_key(KEY_RIGHT, 0.3)
	_check(camera.position.x > before_x, "Arrow keys look around a zoomed room")
	var bear: HiddenObject = room.get_node("HiddenObjects/TeddyBear")
	await _click_world(room, bear.global_position)
	_check(bear.is_collected, "Objects can be clicked while zoomed in")
	for i in range(8):
		zoom_in_button.pressed.emit()
	await _wait_frames(2)
	_check(is_equal_approx(camera.get_zoom_level(), camera.max_zoom) and zoom_in_button.disabled, "Zoom stops at the maximum")
	for i in range(10):
		zoom_out_button.pressed.emit()
	await _wait_frames(2)
	_check(is_equal_approx(camera.get_zoom_level(), 1.0) and camera.position == Vector2.ZERO, "The - button zooms back out to the whole room")
	# Ctrl + mouse wheel
	for pressed in [true, false]:
		var wheel := InputEventMouseButton.new()
		wheel.button_index = MOUSE_BUTTON_WHEEL_UP
		wheel.ctrl_pressed = true
		wheel.pressed = pressed
		wheel.position = Vector2(400, 400)
		wheel.global_position = wheel.position
		Input.parse_input_event(wheel)
		await _wait_frames(2)
	_check(camera.get_zoom_level() > 1.2, "Ctrl + mouse wheel zooms in")
	camera.set_zoom_level(1.0)
	# Phone gestures: pinch with two fingers, then drag with one.
	await _touch(0, Vector2(500, 400), true)
	await _touch(1, Vector2(700, 400), true)
	await _drag(1, Vector2(900, 400), Vector2(200, 0))
	_check(camera.get_zoom_level() > 1.4, "Pinching with two fingers zooms in")
	await _touch(1, Vector2(900, 400), false)
	var before := camera.position
	await _drag(0, Vector2(400, 350), Vector2(-100, -50))
	_check(camera.position.x > before.x and camera.position.y > before.y, "Dragging one finger looks around")
	await _touch(0, Vector2(400, 350), false)
	room.restart_room()
	await _wait_frames(6)


func _hold_key(keycode: Key, seconds: float) -> void:
	for pressed in [true, false]:
		var key := InputEventKey.new()
		key.keycode = keycode
		key.physical_keycode = keycode
		key.pressed = pressed
		Input.parse_input_event(key)
		if pressed:
			await _wait_seconds(seconds)
	await _wait_frames(2)


func _touch(index: int, position: Vector2, pressed: bool) -> void:
	var touch := InputEventScreenTouch.new()
	touch.index = index
	touch.position = position
	touch.pressed = pressed
	Input.parse_input_event(touch)
	await _wait_frames(2)


func _drag(index: int, position: Vector2, relative: Vector2) -> void:
	var drag := InputEventScreenDrag.new()
	drag.index = index
	drag.position = position
	drag.relative = relative
	Input.parse_input_event(drag)
	await _wait_frames(2)


func _press_key(keycode: Key) -> void:
	for pressed in [true, false]:
		var key := InputEventKey.new()
		key.keycode = keycode
		key.physical_keycode = keycode
		key.pressed = pressed
		Input.parse_input_event(key)
		await _wait_frames(2)


func _wait_frames(count: int) -> void:
	for i in range(count):
		await get_tree().process_frame


func _wait_physics(count: int) -> void:
	for i in range(count):
		await get_tree().physics_frame


func _wait_seconds(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout


func _screenshot(file_name: String) -> void:
	if _screenshot_folder == "" or DisplayServer.get_name() == "headless":
		return
	await RenderingServer.frame_post_draw
	var image := get_viewport().get_texture().get_image()
	image.save_png(_screenshot_folder.path_join(file_name + ".png"))


func _get_objects(room: Node) -> Array[HiddenObject]:
	var result: Array[HiddenObject] = []
	for child in room.get_node("%HiddenObjects").get_children():
		if child is HiddenObject:
			result.append(child as HiddenObject)
	return result


func _find(objects: Array[HiddenObject], object_id: StringName) -> HiddenObject:
	for hidden_object in objects:
		if hidden_object.data.object_id == object_id:
			return hidden_object
	return null


func _progress_text(room: Node) -> String:
	return (room.get_node("%HUD").get_node("%ProgressLabel") as Label).text


func _status_text(hud: Node, index: int) -> String:
	var row := hud.get_node("%ObjectiveList").get_child(index)
	var text_column := row.get_child(1)
	return (text_column.get_child(1) as Label).text


func _chapter_button_texts(menu: Node) -> Array[String]:
	var texts: Array[String] = []
	for button in menu.get_node("%ChapterList").get_children():
		if button is Button and not button.is_queued_for_deletion():
			texts.append((button as Button).text)
	return texts


func _has_duplicates(values: Array[StringName]) -> bool:
	for i in range(values.size()):
		if values.find(values[i]) != i:
			return true
	return false
