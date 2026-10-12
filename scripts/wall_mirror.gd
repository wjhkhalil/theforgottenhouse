class_name WallMirror
extends Node2D
## House Three, Chapter Six (The Matron's Office): a tall swing mirror shows the
## half of the room BEHIND the player. It tilts three ways: up (the picture
## rail and the top of the wardrobe), level (the wall and the door) and down
## (the floor). The arrows above and below the glass tilt it.
##
## The objects listed in `mirror_objects` exist only in the reflection. Each
## belongs to one tilt (`object_views`: 0 = up, 1 = level, 2 = down) and can
## only be seen and clicked while the mirror is tilted that way.
##
## HOW IT WORKS: the reflection is one tall painting of three panels, each as
## big as the glass. It hangs inside a clipping shape the size of the glass
## (arched at the top if `arch_height` is set) and
## slides up or down when the mirror tilts. The mirror objects stay where they
## are in the scene (inside the glass rectangle): they are faded in for their
## own tilt and switched off (set_reachable) for the others.
##
## Place this node AFTER HiddenObjects and RoomForeground in the scene. The
## room art must leave `glass_rect` plain: the reflection is painted over it.

## The glass of the mirror (room coordinates).
@export var glass_rect: Rect2 = Rect2(120, 150, 170, 290)
## How far the top of the glass arches above its corners (0 = a square top).
@export var arch_height: float = 0.0
## The colour of the glass itself, laid thinly over the reflection so it sits in the painting.
@export var glass_tint: Color = Color(0.1, 0.16, 0.17, 0.22)
## The objects that exist only in the reflection.
@export var mirror_objects: Array[NodePath] = []
## Which tilt shows each object (same order): 0 = up, 1 = level, 2 = down.
@export var object_views: PackedInt32Array = PackedInt32Array()
## How far above and below the glass the tilt arrows are.
@export var arrow_gap: float = 24.0
## Seconds the reflection takes to slide to a new tilt.
@export var tilt_seconds: float = 0.35

const VIEW_COUNT := 3
## The size the reflection is drawn at. It is scaled to fit `glass_rect`.
const DESIGN_SIZE := Vector2(170, 290)
const VIEW_NAMES: Array[String] = ["up", "level", "down"]
const WALL := Color(0.13, 0.19, 0.15)
const WALL_LIGHT := Color(0.17, 0.24, 0.19)
const WOOD := Color(0.24, 0.15, 0.09)
const WOOD_DARK := Color(0.13, 0.08, 0.05)
const WOOD_LIGHT := Color(0.36, 0.24, 0.14)
const ARROW := Color(0.92, 0.82, 0.55)

## The tilt the mirror is set to: 0 = up, 1 = level, 2 = down.
var view: int = 1

## The tilt being shown, sliding towards `view` (1.4 = between level and down).
var _shown: float = 1.0
## True while the test shows every mirror object at once.
var _show_all: bool = false
## True once the room is complete.
var _faded: bool = false
var _objects: Array[Node] = []
var _strip: Node2D
var _arrows: Array[Area2D] = []


func _ready() -> void:
	add_to_group("room_effects")
	for path in mirror_objects:
		var node := get_node_or_null(path) as CanvasItem
		if node != null:
			_objects.append(node)
			# Drawn above the reflection, so they seem to be in it.
			node.z_index = 1
	# A clipping shape the size of the glass, with the tall reflection inside it.
	var clip := Polygon2D.new()
	clip.name = "Glass"
	clip.position = glass_rect.position
	clip.polygon = _glass_outline()
	clip.clip_children = CanvasItem.CLIP_CHILDREN_ONLY
	add_child(clip)
	_strip = Node2D.new()
	_strip.name = "Reflection"
	clip.add_child(_strip)
	_strip.scale = glass_rect.size / DESIGN_SIZE
	_strip.draw.connect(_draw_reflection)
	# The glass over the reflection: a thin tint, darker towards the frame.
	var sheen := Node2D.new()
	sheen.name = "Sheen"
	clip.add_child(sheen)
	sheen.draw.connect(_draw_glass.bind(sheen))
	# The two tilt arrows: index 0 tilts up, index 1 tilts down.
	for direction: int in [-1, 1]:
		var arrow := Area2D.new()
		arrow.name = "TiltUp" if direction < 0 else "TiltDown"
		var circle := CircleShape2D.new()
		circle.radius = 20.0
		var collision := CollisionShape2D.new()
		collision.shape = circle
		arrow.add_child(collision)
		add_child(arrow)
		arrow.position = _arrow_position(direction)
		arrow.input_event.connect(_on_arrow_clicked.bind(direction))
		_arrows.append(arrow)
	_apply_view()


## Called when the room is complete: nothing is hidden any more.
func fade_out() -> void:
	_faded = true
	_apply_view()


# ---------------------------------------------------------------------------
# Helpers (also used by the automated test)
# ---------------------------------------------------------------------------

## The objects that exist only in the reflection.
func get_mirror_objects() -> Array[Node]:
	return _objects.duplicate()


## Which tilt shows `node` (0 = up, 1 = level, 2 = down), or -1.
func view_of(node: Node) -> int:
	var index := _objects.find(node)
	return object_views[index] if index >= 0 and index < object_views.size() else -1


## Where the tilt arrow is (room position). `up` = the arrow above the glass.
func get_arrow_position(up: bool) -> Vector2:
	return to_global(_arrow_position(-1 if up else 1))


## Tilts the mirror one step: -1 = up, +1 = down. Does nothing at the end of its swing.
func tilt(direction: int) -> void:
	var target := clampi(view + direction, 0, VIEW_COUNT - 1)
	if target == view or _faded:
		return
	view = target
	AudioManager.play_sfx("click")
	create_tween().tween_property(self, "_shown", float(view), tilt_seconds).set_trans(Tween.TRANS_SINE)
	_apply_view()


## Sets the tilt straight away, without the slide.
func set_view(new_view: int) -> void:
	view = clampi(new_view, 0, VIEW_COUNT - 1)
	_shown = float(view)
	_apply_view()


## The test's "safe" state: every mirror object shows at once, whatever the tilt.
func show_all(enabled: bool) -> void:
	_show_all = enabled
	_apply_view()


func _process(_delta: float) -> void:
	_strip.position.y = -_shown * glass_rect.size.y
	_fade_objects()
	queue_redraw()


## The shape of the glass, measured from its top-left corner: a rectangle, arched at the top.
func _glass_outline() -> PackedVector2Array:
	var size := glass_rect.size
	var points := PackedVector2Array()
	if arch_height <= 0.0:
		points.append(Vector2.ZERO)
		points.append(Vector2(size.x, 0))
	else:
		for step in range(17):
			var angle := PI - step * PI / 16.0
			points.append(Vector2(size.x * 0.5 + cos(angle) * size.x * 0.5, arch_height - sin(angle) * arch_height))
	points.append(size)
	points.append(Vector2(0, size.y))
	return points


## The glass itself, over the reflection: tinted, and shadowed where it meets the frame.
func _draw_glass(sheen: Node2D) -> void:
	var size := glass_rect.size
	sheen.draw_rect(Rect2(Vector2.ZERO, size), glass_tint)
	var dark := Color(0, 0, 0, 0.45)
	var clear := Color(0, 0, 0, 0)
	var edge := minf(size.x * 0.16, 18.0)
	sheen.draw_polygon(PackedVector2Array([Vector2.ZERO, Vector2(edge, 0), Vector2(edge, size.y), Vector2(0, size.y)]),
		PackedColorArray([dark, clear, clear, dark]))
	sheen.draw_polygon(PackedVector2Array([Vector2(size.x - edge, 0), Vector2(size.x, 0), size, Vector2(size.x - edge, size.y)]),
		PackedColorArray([clear, dark, dark, clear]))
	sheen.draw_polygon(PackedVector2Array([Vector2.ZERO, Vector2(size.x, 0), Vector2(size.x, arch_height + edge), Vector2(0, arch_height + edge)]),
		PackedColorArray([dark, dark, clear, clear]))
	sheen.draw_polygon(PackedVector2Array([Vector2(0, size.y - edge), Vector2(size.x, size.y - edge), size, Vector2(0, size.y)]),
		PackedColorArray([clear, clear, dark, dark]))


func _arrow_position(direction: int) -> Vector2:
	var middle_x := glass_rect.get_center().x
	if direction < 0:
		return Vector2(middle_x, glass_rect.position.y - arrow_gap)
	return Vector2(middle_x, glass_rect.end.y + arrow_gap)


## Tells every mirror object whether it can be clicked at this tilt.
func _apply_view() -> void:
	for i in range(_objects.size()):
		var area := _objects[i] as Area2D
		if area != null and area.has_method("set_reachable"):
			area.call("set_reachable", _show_all or _faded or view_of(area) == view)
	_fade_objects()


## Fades each mirror object in as its own panel slides into the glass.
func _fade_objects() -> void:
	for node in _objects:
		var item := node as CanvasItem
		var alpha := 1.0
		if not (_show_all or _faded):
			alpha = clampf(1.0 - absf(_shown - view_of(node)) * 2.5, 0.0, 1.0)
		item.modulate.a = alpha


func _on_arrow_clicked(_viewport: Node, event: InputEvent, _shape_index: int, direction: int) -> void:
	var click := event as InputEventMouseButton
	if click == null or not click.pressed or click.button_index != MOUSE_BUTTON_LEFT or get_tree().paused:
		return
	tilt(direction)


func _draw() -> void:
	if _faded:
		return
	for direction: int in [-1, 1]:
		var at := _arrow_position(direction)
		var usable := (direction < 0 and view > 0) or (direction > 0 and view < VIEW_COUNT - 1)
		var colour := ARROW if usable else Color(ARROW, 0.25)
		draw_circle(at, 17.0, Color(0, 0, 0, 0.55))
		draw_arc(at, 17.0, 0.0, TAU, 28, colour, 1.5, true)
		draw_colored_polygon(PackedVector2Array([at + Vector2(0, direction * 9.0), at + Vector2(-9, -direction * 6.0),
			at + Vector2(9, -direction * 6.0)]), colour)
	# A small word under the bottom arrow says which way the mirror is tilted.
	var font := ThemeDB.fallback_font
	var text := "tilted " + VIEW_NAMES[view] if view != 1 else "level"
	var width := font.get_string_size(text, HORIZONTAL_ALIGNMENT_LEFT, -1, 11).x
	# On a dark plate, so it can be read whatever is painted behind it.
	var plate := StyleBoxFlat.new()
	plate.bg_color = Color(0, 0, 0, 0.6)
	plate.set_corner_radius_all(7)
	draw_style_box(plate, Rect2(_arrow_position(1) + Vector2(-width / 2.0 - 7, 22), Vector2(width + 14, 16)))
	draw_string(font, _arrow_position(1) + Vector2(-width / 2.0, 34), text, HORIZONTAL_ALIGNMENT_LEFT, -1, 11, Color(ARROW, 0.95))


# ---------------------------------------------------------------------------
# The reflection: three panels, each as big as the glass, stacked top to bottom.
# Drawn on the sliding strip, so (0, 0) is the top-left corner of the top panel.
# ---------------------------------------------------------------------------

func _draw_reflection() -> void:
	var w := DESIGN_SIZE.x
	var h := DESIGN_SIZE.y
	_draw_view_up(Vector2(0, 0), w, h)
	_draw_view_level(Vector2(0, h), w, h)
	_draw_view_down(Vector2(0, h * 2.0), w, h)
	# A soft diagonal shine across each panel, like old glass.
	for panel in range(VIEW_COUNT):
		var top := panel * h
		_strip.draw_colored_polygon(PackedVector2Array([Vector2(w * 0.55, top), Vector2(w * 0.8, top),
			Vector2(w * 0.3, top + h), Vector2(w * 0.05, top + h)]), Color(1, 1, 1, 0.035))


## Tilted up: the ceiling, the picture rail (right) and the top of the wardrobe (left).
func _draw_view_up(origin: Vector2, w: float, h: float) -> void:
	var c := _strip
	c.draw_rect(Rect2(origin, Vector2(w, h)), WALL)
	# Ceiling and cornice
	c.draw_rect(Rect2(origin, Vector2(w, 26)), Color(0.3, 0.28, 0.24))
	c.draw_rect(Rect2(origin + Vector2(0, 26), Vector2(w, 7)), Color(0.4, 0.37, 0.3))
	# The picture rail, and a framed print hanging from it on two cords
	c.draw_rect(Rect2(origin + Vector2(60, 62), Vector2(w - 60, 6)), WOOD_LIGHT)
	c.draw_rect(Rect2(origin + Vector2(60, 68), Vector2(w - 60, 2)), WOOD_DARK)
	c.draw_line(origin + Vector2(92, 68), origin + Vector2(104, 120), Color(0.6, 0.5, 0.3), 1.0)
	c.draw_line(origin + Vector2(150, 68), origin + Vector2(138, 120), Color(0.6, 0.5, 0.3), 1.0)
	c.draw_rect(Rect2(origin + Vector2(88, 120), Vector2(66, 86)), WOOD_LIGHT)
	c.draw_rect(Rect2(origin + Vector2(94, 126), Vector2(54, 74)), Color(0.5, 0.52, 0.45))
	c.draw_circle(origin + Vector2(121, 156), 12.0, Color(0.34, 0.36, 0.32))
	# The top of the wardrobe, with its carved cornice
	c.draw_rect(Rect2(origin + Vector2(0, 62), Vector2(64, h - 62)), WOOD)
	c.draw_rect(Rect2(origin + Vector2(0, 58), Vector2(70, 8)), WOOD_LIGHT)
	c.draw_rect(Rect2(origin + Vector2(0, 66), Vector2(66, 4)), WOOD_DARK)
	c.draw_rect(Rect2(origin + Vector2(8, 84), Vector2(48, h - 84)), WOOD_DARK, false, 2.0)
	# Dust on top of it
	c.draw_rect(Rect2(origin + Vector2(4, 55), Vector2(60, 3)), Color(0.7, 0.68, 0.62, 0.35))


## Level: the wardrobe (left), a strip of wall, and the door with its peg (right).
func _draw_view_level(origin: Vector2, w: float, h: float) -> void:
	var c := _strip
	c.draw_rect(Rect2(origin, Vector2(w, h)), WALL)
	for stripe in range(5):
		c.draw_rect(Rect2(origin + Vector2(64 + stripe * 9.0, 0), Vector2(3, h)), WALL_LIGHT)
	# Wardrobe body with a long door and a brass knob
	c.draw_rect(Rect2(origin, Vector2(64, h)), WOOD)
	c.draw_rect(Rect2(origin + Vector2(8, 0), Vector2(48, h)), WOOD_DARK, false, 2.0)
	c.draw_circle(origin + Vector2(50, h * 0.5), 3.0, Color(0.8, 0.62, 0.3))
	# A nail in the wall for the calendar
	c.draw_circle(origin + Vector2(85, 82), 2.0, Color(0.1, 0.1, 0.1))
	# The door behind you, with two panels and a coat peg
	c.draw_rect(Rect2(origin + Vector2(98, 0), Vector2(w - 98, h)), WOOD_DARK)
	c.draw_rect(Rect2(origin + Vector2(104, 0), Vector2(w - 110, h)), WOOD)
	c.draw_rect(Rect2(origin + Vector2(112, 10), Vector2(w - 126, 110)), WOOD_DARK, false, 2.0)
	c.draw_rect(Rect2(origin + Vector2(112, 200), Vector2(w - 126, 80)), WOOD_DARK, false, 2.0)
	c.draw_rect(Rect2(origin + Vector2(116, 134), Vector2(18, 5)), Color(0.8, 0.62, 0.3))
	c.draw_circle(origin + Vector2(125, 142), 3.5, Color(0.8, 0.62, 0.3))


## Tilted down: the skirting board, the floorboards and the edge of the carpet.
func _draw_view_down(origin: Vector2, w: float, h: float) -> void:
	var c := _strip
	# The foot of the wall, the wardrobe and the door
	c.draw_rect(Rect2(origin, Vector2(w, 70)), WALL)
	c.draw_rect(Rect2(origin, Vector2(64, 76)), WOOD)
	c.draw_rect(Rect2(origin + Vector2(0, 70), Vector2(68, 8)), WOOD_DARK)
	c.draw_rect(Rect2(origin + Vector2(104, 0), Vector2(w - 110, 70)), WOOD)
	c.draw_rect(Rect2(origin + Vector2(64, 56), Vector2(40, 14)), WOOD_LIGHT)
	# Floorboards running away from you
	c.draw_rect(Rect2(origin + Vector2(0, 78), Vector2(w, h - 78)), Color(0.3, 0.2, 0.12))
	for board in range(7):
		var x := board * w / 6.0
		c.draw_line(origin + Vector2(w * 0.5 + (x - w * 0.5) * 0.6, 78), origin + Vector2(x, h), WOOD_DARK, 1.2)
	# The fringe and corner of the patterned carpet
	c.draw_colored_polygon(PackedVector2Array([origin + Vector2(20, 150), origin + Vector2(w, 130), origin + Vector2(w, h),
		origin + Vector2(0, h), origin + Vector2(0, 190)]), Color(0.36, 0.1, 0.1))
	c.draw_polyline(PackedVector2Array([origin + Vector2(30, 162), origin + Vector2(w, 144)]), Color(0.75, 0.6, 0.3, 0.6), 2.0)
	for tassel in range(9):
		var start := (origin + Vector2(20, 150)).lerp(origin + Vector2(w, 130), tassel / 8.0)
		c.draw_line(start, start + Vector2(-2, -7), Color(0.8, 0.72, 0.5), 1.0)
