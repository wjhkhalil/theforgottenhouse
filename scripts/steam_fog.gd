class_name SteamFog
extends Node2D
## Chapter Five: thick steam covers the room. Moving the mouse wipes it away,
## like wiping a misted mirror, and it slowly drifts back.
##
## HOW IT WORKS: the room is split into a grid of small cells. Each cell has a
## fog amount from 0 (clear) to 1 (thick). The mouse clears cells near it and
## every frame all cells fog over a little again. The grid is drawn as one
## small blurry image stretched over the room.
## It is only a drawing: it never blocks clicks on hidden objects.

@export var room_size: Vector2 = Vector2(1280, 720)
## Size of one grid cell in pixels (bigger = softer and faster).
@export var cell_size: float = 16.0
## How opaque the thickest steam is (0 = invisible, 1 = solid).
@export_range(0.0, 1.0) var thickness: float = 0.9
## Radius of the area the mouse wipes clear.
@export var wipe_radius: float = 75.0
## Seconds for a wiped spot to fog over completely again.
@export var return_seconds: float = 6.0
@export var steam_color: Color = Color(0.85, 0.87, 0.88)

var _grid: Vector2i
var _fog: PackedFloat32Array
var _shade: PackedByteArray  # Fixed brightness per cell, so the steam looks wispy.
var _image: Image
var _texture: ImageTexture
var _last_mouse: Vector2 = Vector2(-1000, -1000)
var _active: bool = true


func _ready() -> void:
	add_to_group("room_effects")
	_grid = Vector2i(ceili(room_size.x / cell_size), ceili(room_size.y / cell_size))
	_fog.resize(_grid.x * _grid.y)
	_fog.fill(1.0)
	var rng := RandomNumberGenerator.new()
	rng.seed = 3
	_shade.resize(_fog.size())
	for i in range(_fog.size()):
		var wave := sin(i % _grid.x * 0.35) * 0.04 + sin(i / _grid.x * 0.5) * 0.04
		_shade[i] = int(clampf(steam_color.v + wave + rng.randf_range(-0.04, 0.04), 0.0, 1.0) * 255.0)
	_image = Image.create(_grid.x, _grid.y, false, Image.FORMAT_LA8)
	_update_image()
	_texture = ImageTexture.create_from_image(_image)
	texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR


## How thick the steam is at a room position (0 = clear, 1 = thick). Used by the test.
func get_fog_at(room_position: Vector2) -> float:
	var cell := Vector2i(room_position / cell_size)
	cell = cell.clamp(Vector2i.ZERO, _grid - Vector2i.ONE)
	return _fog[cell.y * _grid.x + cell.x]


## Clears the steam around one point.
func wipe(at: Vector2) -> void:
	var cell_radius := ceili(wipe_radius / cell_size)
	var center := Vector2i(at / cell_size)
	for y in range(maxi(center.y - cell_radius, 0), mini(center.y + cell_radius + 1, _grid.y)):
		for x in range(maxi(center.x - cell_radius, 0), mini(center.x + cell_radius + 1, _grid.x)):
			var distance := (Vector2(x, y) + Vector2(0.5, 0.5)) * cell_size - at
			# Fully clear in the middle, soft towards the edge.
			var amount := clampf((distance.length() - wipe_radius * 0.55) / (wipe_radius * 0.45), 0.0, 1.0)
			var index := y * _grid.x + x
			_fog[index] = minf(_fog[index], amount)


## Called when the room is complete: the steam clears away.
func fade_out() -> void:
	_active = false
	create_tween().tween_property(self, "modulate:a", 0.0, 1.5)


func _process(delta: float) -> void:
	if not _active:
		return
	var mouse := get_local_mouse_position()
	if mouse != _last_mouse:
		# Wipe along the whole path, so fast mouse moves leave no gaps.
		var steps := maxi(ceili(_last_mouse.distance_to(mouse) / (wipe_radius * 0.4)), 1)
		if _last_mouse.x < -999.0:
			steps = 1
		for step in range(1, steps + 1):
			wipe(_last_mouse.lerp(mouse, float(step) / steps) if steps > 1 else mouse)
		_last_mouse = mouse
	# The steam drifts back.
	var regrow := delta / return_seconds
	for i in range(_fog.size()):
		if _fog[i] < 1.0:
			_fog[i] = minf(_fog[i] + regrow, 1.0)
	_update_image()
	_texture.update(_image)
	queue_redraw()


func _update_image() -> void:
	var data := PackedByteArray()
	data.resize(_fog.size() * 2)
	for i in range(_fog.size()):
		data[i * 2] = _shade[i]
		data[i * 2 + 1] = int(_fog[i] * thickness * 255.0)
	_image.set_data(_grid.x, _grid.y, false, Image.FORMAT_LA8, data)


func _draw() -> void:
	if _texture != null:
		draw_texture_rect(_texture, Rect2(Vector2.ZERO, room_size), false)
