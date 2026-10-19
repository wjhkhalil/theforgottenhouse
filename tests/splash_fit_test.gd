extends SceneTree
## Checks the splash scene fills a phone-shaped window with no bars and that
## the title animates in. Run with:
##   godot --path . --resolution 1200x540 -s res://tests/splash_fit_test.gd
## and again with "-- --phone" for the phone layout.

var _failures := 0


func _initialize() -> void:
	_run.call_deferred()


func _check(name: String, ok: bool) -> void:
	print(("PASS  " if ok else "FAIL  ") + name)
	if not ok:
		_failures += 1


func _run() -> void:
	var aspect_before := root.content_scale_aspect
	change_scene_to_file("res://scenes/splash.tscn")
	for i in range(30):
		await process_frame
	var window_size: Vector2 = Vector2(DisplayServer.window_get_size())
	var view_size: Vector2 = root.get_visible_rect().size
	print("window ", window_size, " viewport ", view_size)
	_check("viewport has the window's shape (no letterbox bars)",
			absf(view_size.x / view_size.y - window_size.x / window_size.y) < 0.01)
	var background: TextureRect = current_scene.get_node("%Background")
	_check("background rect covers the whole viewport",
			background.get_global_rect().encloses(Rect2(Vector2.ZERO, view_size)))
	var title: TextureRect = current_scene.get_node("%Title")
	_check("title is still appearing after half a second (alpha %.2f)" % title.modulate.a,
			title.modulate.a > 0.0 and title.modulate.a < 1.0)
	_check("title is still settling (scale %.2f)" % title.scale.x, title.scale.x > 1.0)
	for i in range(60):
		await process_frame
	_check("title is fully shown after a second and a half (alpha %.2f)" % title.modulate.a,
			title.modulate.a >= 1.0)
	_check("title has settled at full size", title.scale.is_equal_approx(Vector2.ONE))
	_check("title sits inside the viewport",
			Rect2(Vector2.ZERO, view_size).encloses(title.get_global_rect()))
	var image: Image = root.get_texture().get_image()
	var dark := Color(0.051, 0.078, 0.106, 1)
	for x in [1, image.get_width() - 2]:
		var total := Color.BLACK
		for y in range(image.get_height()):
			total += image.get_pixel(x, y)
		var average: Color = total / image.get_height()
		_check("painting is drawn down the edge at x=%d (average %s)" % [x, average],
				average.a > 0.9 and average.get_luminance() > 0.01 and not average.is_equal_approx(dark))
	current_scene._open_menu()
	await process_frame
	_check("stretch aspect is put back as it was for the menu",
			root.content_scale_aspect == aspect_before)
	print("%d failure(s)" % _failures)
	quit(1 if _failures > 0 else 0)
