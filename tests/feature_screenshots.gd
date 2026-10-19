extends SceneTree
## Dev tool: screenshots of the tutorial, completion screen with stars, the
## Chapters list, the Journal, Settings and the pause menu. Run with:
##   godot --path . -s res://tests/feature_screenshots.gd -- --out=/some/folder
## Add --phone (and for example --resolution 800x360) for the phone layout.

var _out := "user://feature_shots"
var _save: Node


func _initialize() -> void:
	for argument in OS.get_cmdline_user_args():
		if argument.begins_with("--out="):
			_out = argument.trim_prefix("--out=")
	_run.call_deferred()


func _shot(name: String, seconds: float = 0.6) -> void:
	await create_timer(seconds).timeout
	await process_frame
	root.get_texture().get_image().save_png(_out + "/" + name + ".png")
	print("shot ", name)


func _run() -> void:
	_save = root.get_node("SaveManager")
	_save.save_path = "user://feature_shots.cfg"
	_save.reset_progress()
	_save.set_flag("tutorial_done", false)

	# --- Bedroom with the tutorial ---------------------------------------
	change_scene_to_file("res://scenes/bedroom.tscn")
	await _shot("10_tutorial_step1", 1.5)
	var room: Node = current_scene
	var tutorial: Node = room.tutorial
	print("tutorial running: ", tutorial != null and tutorial.is_running(), " step ", tutorial.get_step() if tutorial else -1)
	var objects: Array = room.game_manager.hidden_objects
	objects[0].collect()
	await _shot("11_tutorial_step2", 1.0)
	print("step after find: ", tutorial.get_step())
	tutorial.get_node("%GotItButton").pressed.emit()
	await _shot("12_tutorial_step3_hint", 0.8)
	tutorial.get_node("%GotItButton").pressed.emit()
	await _shot("13_tutorial_step4_zoom", 0.8)
	tutorial.get_node("%GotItButton").pressed.emit()
	await _shot("14_tutorial_step5", 0.8)
	# A wrong tap, so the counter shows in the result.
	room._count_wrong_tap()
	tutorial.get_node("%GotItButton").pressed.emit()
	await _shot("15_tutorial_done", 0.8)
	print("tutorial flag: ", _save.get_flag("tutorial_done"), " running: ", tutorial.is_running())

	# --- Pause menu with Journal and Settings --------------------------------
	room.pause_menu.open()
	await _shot("20_pause_menu", 0.5)
	room.pause_menu.get_node("%SettingsButton").pressed.emit()
	await _shot("21_settings_from_pause", 0.5)
	room.pause_menu.get_node("%SettingsPanel").close()
	room.pause_menu.get_node("%JournalButton").pressed.emit()
	await _shot("22_journal_from_pause_partial", 0.5)
	room.pause_menu.get_node("%Journal").close()
	room.pause_menu.close()

	# --- Finish the room: stars ----------------------------------------------------
	for hidden_object in objects:
		hidden_object.collect()
		await create_timer(0.1).timeout
	await _shot("30_victory_stars", 4.5)
	room.letter_popup.close()
	await _shot("31_victory_stars_only", 0.3)
	print("stars on screen: ", room.victory_screen.get_stars(), "  stats: ", room.victory_screen.get_stats_text())
	print("saved result: ", _save.get_result("bedroom"))

	# --- Main menu: chapters with stars, journal, settings --------------------------
	change_scene_to_file("res://scenes/main_menu.tscn")
	await _shot("40_main_menu", 0.8)
	current_scene._on_chapters_pressed()
	await _shot("41_chapters_stars", 0.5)
	current_scene._on_chapters_back_pressed()
	current_scene._on_journal_pressed()
	await _shot("42_journal", 0.6)
	print("journal entries: ", current_scene.get_node("%Journal").get_entry_count(), " clues: ", current_scene.get_node("%Journal").get_clue_count())
	current_scene.get_node("%Journal").close()
	current_scene._on_settings_pressed()
	await _shot("43_settings", 0.5)
	current_scene.get_node("%SettingsPanel").close()
	# Empty journal on a fresh save.
	_save.reset_progress()
	current_scene._on_journal_pressed()
	await _shot("44_journal_empty", 0.5)
	quit()
