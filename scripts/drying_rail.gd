class_name DryingRail
extends Node2D
## House Three, Chapter Three (The Laundry): wet sheets hang from an overhead
## rail that is hauled slowly round by a chain. The sheets travel across the
## room from left to right, again and again.
##
## Whatever is behind a sheet can't be clicked until the sheet has slid past:
## the player has to wait for a gap. Things below the hem of the sheets (on
## the floor, on the tables) can always be clicked.
##
## HOW IT WORKS: every sheet is a rectangle from the rail down to
## `sheet_bottom`. Each one has an invisible click area the same size, which
## moves with it. This node comes AFTER HiddenObjects in the scene, so those
## areas sit on top of every object: a click on a sheet never reaches the
## object behind it, and the player is told to wait.
##
## Place this node AFTER HiddenObjects and RoomForeground in the scene.

## Shown by the room as a notification (see room_level.gd).
signal notice(title: String, message: String, wrong_sound: bool)

## Height of the rail, and of the hems of the sheets.
@export var rail_y: float = 120.0
@export var sheet_bottom: float = 400.0
## Width of one sheet.
@export var sheet_width: float = 130.0
## How many sheets hang on the rail.
@export var sheet_count: int = 4
## Distance from the left edge of one sheet to the left edge of the next.
## (sheet_count x sheet_spacing should be a little more than the room's width.)
@export var sheet_spacing: float = 330.0
## How fast the sheets travel, in pixels per second.
@export var speed: float = 40.0
## The rail is drawn this wide.
@export var room_width: float = 1280.0
## Seconds before the same "a sheet is in the way" message may be shown again.
@export var notice_cooldown: float = 2.5

const LINEN := Color(0.86, 0.87, 0.84, 0.97)
const LINEN_SHADE := Color(0.66, 0.69, 0.7, 0.97)
const IRON := Color(0.2, 0.2, 0.22)

## How far the line has travelled (exposed for the automated test).
var travel: float = 0.0

var _active: bool = false
var _holding: bool = false
## True while the test has pushed every sheet aside.
var _cleared: bool = false
## True once the room is complete: the sheets are taken down.
var _faded: bool = false
## 1.0 while the sheets hang; goes to 0.0 when the room is complete.
var _shade: float = 1.0
var _time: float = 0.0
var _last_notice_time: float = -100.0
var _blockers: Array[Area2D] = []


func _ready() -> void:
	add_to_group("room_effects")
	for i in range(sheet_count):
		var blocker := Area2D.new()
		blocker.name = "Sheet%d" % i
		var shape := RectangleShape2D.new()
		shape.size = Vector2(sheet_width, sheet_bottom - rail_y)
		var collision := CollisionShape2D.new()
		collision.shape = shape
		blocker.add_child(collision)
		add_child(blocker)
		blocker.input_event.connect(_on_sheet_clicked)
		_blockers.append(blocker)
	_update_sheets()


## Called by the room when the player can start searching.
func start_effect() -> void:
	_active = true


## Called when the room is complete: the sheets are taken down and nothing is hidden.
func fade_out() -> void:
	_active = false
	_faded = true
	create_tween().tween_property(self, "_shade", 0.0, 1.5)
	_update_sheets()


# ---------------------------------------------------------------------------
# Helpers (also used by the automated test)
# ---------------------------------------------------------------------------

## Where sheet `index` hangs right now (room coordinates).
func get_sheet_rect(index: int) -> Rect2:
	var loop := sheet_count * sheet_spacing
	var left := fposmod(travel + index * sheet_spacing, loop) - sheet_width
	return Rect2(left, rail_y, sheet_width, sheet_bottom - rail_y)


## True if a sheet hangs in front of `world_position` right now.
func is_covered(world_position: Vector2) -> bool:
	if _cleared or _faded:
		return false
	for i in range(sheet_count):
		if get_sheet_rect(i).has_point(to_local(world_position)):
			return true
	return false


## Stops the line (true) or lets it travel again (false).
func hold(enabled: bool) -> void:
	_holding = enabled


## Moves the line so that sheet 0's LEFT edge is at `left_x`.
func set_first_sheet_left(left_x: float) -> void:
	travel = left_x + sheet_width
	_update_sheets()


## The test's "safe" state: every sheet is pushed aside and the line stands still.
## clear_line(false) hangs them back (the line stays held until hold(false)).
func clear_line(enabled: bool) -> void:
	_cleared = enabled
	if enabled:
		_holding = true
	_update_sheets()


func _process(delta: float) -> void:
	_time += delta
	if _active and not _holding:
		travel = fposmod(travel + speed * delta, sheet_count * sheet_spacing)
		_update_sheets()
	queue_redraw()


## Moves every sheet's click area to where the sheet hangs.
func _update_sheets() -> void:
	for i in range(_blockers.size()):
		_blockers[i].position = get_sheet_rect(i).get_center()
		_blockers[i].input_pickable = not _cleared and not _faded


func _on_sheet_clicked(_viewport: Node, event: InputEvent, _shape_index: int) -> void:
	var click := event as InputEventMouseButton
	if click == null or not click.pressed or click.button_index != MOUSE_BUTTON_LEFT or get_tree().paused:
		return
	# Don't repeat the same message over and over.
	if _time - _last_notice_time < notice_cooldown:
		return
	_last_notice_time = _time
	notice.emit("A sheet is in the way", "You can't reach through the wet sheet. Wait for it to slide past.", true)


func _draw() -> void:
	# The rail, its hangers from the ceiling and the chain wheel at each end.
	draw_line(Vector2(-20, rail_y), Vector2(room_width + 20, rail_y), IRON, 5.0)
	draw_line(Vector2(-20, rail_y - 2), Vector2(room_width + 20, rail_y - 2), Color(0.45, 0.45, 0.48), 1.0)
	var hanger_x := 90.0
	while hanger_x < room_width:
		draw_line(Vector2(hanger_x, rail_y), Vector2(hanger_x, rail_y - 70), IRON, 3.0)
		hanger_x += 220.0
	for wheel_x: float in [24.0, room_width - 24.0]:
		draw_circle(Vector2(wheel_x, rail_y), 13.0, IRON)
		for spoke in range(4):
			var direction := Vector2.from_angle(_time * 0.6 * (0.0 if _holding else 1.0) + spoke * PI / 2.0)
			draw_line(Vector2(wheel_x, rail_y), Vector2(wheel_x, rail_y) + direction * 11.0, Color(0.5, 0.5, 0.52), 1.5)
	if _cleared or _shade <= 0.001:
		return
	for i in range(sheet_count):
		_draw_sheet(get_sheet_rect(i), i)


## One wet sheet: pegged to the rail, hanging in soft folds, swaying a little.
func _draw_sheet(rect: Rect2, index: int) -> void:
	var sway := sin(_time * 1.3 + index * 1.7) * 4.0
	var linen := Color(LINEN, LINEN.a * _shade)
	var shade := Color(LINEN_SHADE, LINEN_SHADE.a * _shade)
	var top_left := rect.position
	var top_right := Vector2(rect.end.x, rect.position.y)
	var bottom_right := rect.end + Vector2(sway, 0)
	var bottom_left := Vector2(rect.position.x + sway, rect.end.y)
	draw_colored_polygon(PackedVector2Array([top_left, top_right, bottom_right, bottom_left]), linen)
	# Folds: darker strips that run from the rail to the hem.
	var folds := 5
	for fold in range(folds):
		var t := (fold + 0.5) / folds
		var top := top_left.lerp(top_right, t)
		var bottom := bottom_left.lerp(bottom_right, t)
		draw_colored_polygon(PackedVector2Array([top + Vector2(-5, 0), top + Vector2(5, 0), bottom + Vector2(7, 0),
			bottom + Vector2(-3, 0)]), Color(shade, shade.a * 0.5))
	# A damp, darker hem
	draw_colored_polygon(PackedVector2Array([bottom_left + Vector2(0, -14), bottom_right + Vector2(0, -14), bottom_right,
		bottom_left]), shade)
	# Wooden pegs
	for peg in range(4):
		var peg_x := rect.position.x + 12.0 + peg * (rect.size.x - 24.0) / 3.0
		draw_rect(Rect2(peg_x - 2.5, rail_y - 7, 5, 16), Color(0.72, 0.56, 0.36, _shade))
