extends SceneTree
## Dev tool: screenshots of the phone layout. Run with:
##   godot --path . --resolution 1200x540 -s res://tests/phone_screenshots.gd -- --phone --out=/some/folder

var _out := "user://phone_shots"


func _initialize() -> void:
	for argument in OS.get_cmdline_user_args():
		if argument.begins_with("--out="):
			_out = argument.trim_prefix("--out=")
	_run.call_deferred()


func _shot(name: String) -> void:
	for i in range(90):
		await process_frame
	root.get_texture().get_image().save_png(_out + "/" + name + ".png")


func _run() -> void:
	var save_manager: Node = root.get_node("SaveManager")
	save_manager.save_path = "user://phone_shots.cfg"
	save_manager.reset_progress()
	print("viewport visible size: ", root.get_visible_rect().size)
	change_scene_to_file("res://scenes/main_menu.tscn")
	await _shot("00_menu")
	current_scene._on_chapters_pressed()
	await _shot("01_chapters")
	for chapter in save_manager.CHAPTERS:
		change_scene_to_file(chapter["scene"])
		await _shot(chapter["id"])
		if chapter["id"] == "jetty":
			for x in [1280.0, 2560.0]:
				current_scene.room_camera.focus_on(Vector2(x, 360), true)
				await _shot("jetty_%d" % x)
			current_scene.room_camera.focus_on(Vector2(0, 360), true)
			current_scene.get_node("%HiddenObjects/DockLocker").code_requested.emit(current_scene.get_node("%HiddenObjects/DockLocker"))
			await _shot("jetty_locker")
		if chapter["id"] == "boat_shed":
			var water: TideWater = current_scene.get_node("TideWater")
			water.set_tide_low(true)
			current_scene.notification_popup.hide_now()
			await _shot("boat_shed_low")
			for container in current_scene.find_children("*", "OpenableContainer", true, false):
				container.restore_opened()
			await _shot("boat_shed_open")
		if chapter["id"] == "loft":
			current_scene.notification_popup.hide_now()
			current_scene.get_node("BatColony").wake()
			await _shot("loft_bats")
			for container in current_scene.find_children("*", "OpenableContainer", true, false):
				container.restore_opened()
			current_scene.get_node("BatColony").settle_now()
			await _shot("loft_open")
		if chapter["id"] == "basement":
			current_scene._reveal_final_letter()
			await _shot("basement_letter")
		if chapter["id"] == "bedroom":
			var room: Node = current_scene
			print("camera min zoom: ", room.room_camera.get_min_zoom(), " view: ", room.room_camera.get_view_size())
			room.room_camera.zoom_in()
			room.room_camera.zoom_in()
			await _shot("bedroom_zoomed")
			room.pause_menu.open()
			await _shot("bedroom_pause")
			room.pause_menu.close()
			room._set_searching_enabled(false)
			room.victory_screen.show_victory(room.level_data.chapter_title, room.level_data.chapter_hook, 5, 5, "Chapter Two: The Basement")
			await _shot("bedroom_victory")
			room._reveal_final_letter()
			await _shot("bedroom_letter")
			paused = false
	DirAccess.remove_absolute(ProjectSettings.globalize_path("user://phone_shots.cfg"))
	quit()
