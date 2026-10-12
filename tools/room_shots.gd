extends SceneTree
## Screenshots of House Three rooms, closed and with every container open.
##   godot --path . --resolution 1280x720 -s tools/room_shots.gd -- --out=DIR --rooms=gate_lodge,laundry [--zoom=2 --at=600,300] [--effects]

var _out := ""
var _rooms: PackedStringArray = []
var _zoom := 0.0
var _effects := false
var _at := Vector2.ZERO


func _initialize() -> void:
	for argument in OS.get_cmdline_user_args():
		if argument.begins_with("--out="):
			_out = argument.trim_prefix("--out=")
		if argument.begins_with("--rooms="):
			_rooms = argument.trim_prefix("--rooms=").split(",")
		if argument == "--effects":
			_effects = true
		if argument.begins_with("--zoom="):
			_zoom = float(argument.trim_prefix("--zoom="))
		if argument.begins_with("--at="):
			var parts := argument.trim_prefix("--at=").split(",")
			_at = Vector2(float(parts[0]), float(parts[1]))
	_run.call_deferred()


func _shot(name: String) -> void:
	for i in range(40):
		await process_frame
	root.get_texture().get_image().save_png(_out + "/" + name + ".png")


func _calm(scene: Node) -> void:
	# Stop the room effects hiding things, and clear the pop-up.
	if scene.get("notification_popup") != null:
		scene.notification_popup.hide_now()
	for effect in scene.get_tree().get_nodes_in_group("room_effects"):
		for method in ["show_all", "calm", "clear_line"]:
			if effect.has_method(method):
				effect.call(method, true)
	for hud in scene.find_children("HUD", "", true, false):
		hud.visible = false
	# Darkness, steam, frost and the like would hide the room: switch them off unless --effects is given.
	if not _effects:
		if scene.get("keypad_lock") != null:
			scene.keypad_lock.visible = false
		for node in scene.find_children("*", "", true, false):
			var script: Script = node.get_script()
			if script == null:
				continue
			var file := script.resource_path.get_file()
			if file in ["lantern_darkness.gd", "steam_fog.gd", "frost_cover.gd", "candle_lights.gd", "power_cuts.gd", "air_supply.gd", "patrol_lantern.gd"]:
				node.visible = false
				node.process_mode = Node.PROCESS_MODE_DISABLED
			if file == "tide_water.gd":
				node.call("set_tide_low", true)


func _run() -> void:
	var save_manager: Node = root.get_node("SaveManager")
	save_manager.save_path = "user://room_shots_%d.cfg" % OS.get_process_id()
	save_manager.reset_progress()
	for id in _rooms:
		for opened in [false, true]:
			change_scene_to_file("res://scenes/%s.tscn" % id)
			for i in range(6):
				await process_frame
			_calm(current_scene)
			if opened:
				for container in current_scene.find_children("*", "OpenableContainer", true, false):
					container.restore_opened()
				for object in current_scene.find_children("*", "HiddenObject", true, false):
					object.visible = true
					object.modulate.a = 1.0
			var suffix := "_open" if opened else ""
			var camera: Camera2D = current_scene.room_camera
			var width: float = camera.room_size.x
			if _zoom > 0.0:
				camera.set_zoom_level(_zoom)
				camera.focus_on(_at, true)
				await _shot("%s_zoom%s" % [id, suffix])
			elif width > 1300.0:
				var x := 0.0
				var index := 0
				while x < width - 1.0:
					camera.focus_on(Vector2(x + 640.0, 360), true)
					await _shot("%s_%d%s" % [id, index, suffix])
					x += 1100.0
					index += 1
			elif camera.room_size.y > 730.0:
				var y := 0.0
				var row := 0
				while y < camera.room_size.y - 1.0:
					camera.focus_on(Vector2(640, y + 360.0), true)
					await _shot("%s_%d%s" % [id, row, suffix])
					y += 620.0
					row += 1
			else:
				await _shot(id + suffix)
	quit()
