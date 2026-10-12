class_name Keepsakes
extends Node2D
## House Three, Chapter Seven (Ward Seven): seven patients sit up in seven
## beds. Each of them is missing one belonging that was taken away. Find it,
## and that patient trusts you with something they have kept hidden.
##
## For patient i: `wanted[i]` is the belonging (an ordinary hidden object
## somewhere on the ward) and `gifts[i]` is what they hand over (a hidden
## object whose data has "Starts Visible" off). The moment the belonging is
## found, the gift appears on that patient's blanket and can be picked up.
##
## Until then a thought bubble over the patient shows what they are missing,
## and clicking the patient says so in words. Hints about a gift point at the
## patient who still holds it.
##
## HOW IT WORKS: this node listens to each wanted object's `collected` signal
## and calls reveal() on the gift. Each patient has an invisible click area.
## Nothing here blocks any other click.
##
## Place this node AFTER HiddenObjects and RoomForeground in the scene.

## Shown by the room as a notification (see room_level.gd).
signal notice(title: String, message: String, wrong_sound: bool)

## Where each patient's head and shoulders are (room coordinates).
@export var patient_positions: PackedVector2Array = PackedVector2Array()
@export var patient_names: PackedStringArray = PackedStringArray()
## The belonging each patient wants back (same order as `patient_positions`).
@export var wanted: Array[NodePath] = []
## What each patient hands over once they have it.
@export var gifts: Array[NodePath] = []
## What each patient does when they get their belonging back (shown as a message).
@export var thanks: PackedStringArray = PackedStringArray()
## Size of the click area on each patient.
@export var patient_size: Vector2 = Vector2(80, 110)
## Where the thought bubble floats, measured from the patient's position.
@export var bubble_offset: Vector2 = Vector2(0, -78)
## Seconds after the belonging is found before the patient's message appears
## (so the belonging's own clue can be read first).
@export var thanks_delay: float = 2.2

var _wanted: Array[HiddenObject] = []
var _gifts: Array[HiddenObject] = []
## True once patient i has handed over their gift.
var _given: Array[bool] = []
var _areas: Array[Area2D] = []
## True once the room is complete.
var _faded: bool = false
var _time: float = 0.0


func _ready() -> void:
	add_to_group("room_effects")
	var count := mini(mini(patient_positions.size(), wanted.size()), gifts.size())
	for i in range(count):
		var want := get_node_or_null(wanted[i]) as HiddenObject
		var gift := get_node_or_null(gifts[i]) as HiddenObject
		_wanted.append(want)
		_gifts.append(gift)
		_given.append(false)
		# One click area per patient. It is also where hints about the gift point.
		var area := Area2D.new()
		area.name = "Patient%d" % i
		var shape := RectangleShape2D.new()
		shape.size = patient_size
		var collision := CollisionShape2D.new()
		collision.shape = shape
		area.add_child(collision)
		add_child(area)
		area.position = patient_positions[i]
		area.input_event.connect(_on_patient_clicked.bind(i))
		_areas.append(area)
		if gift != null:
			gift.hint_anchor = area
		if want != null:
			want.collected.connect(_on_wanted_collected.bind(i))


## Called by the room when the player can start searching. Belongings found in
## an earlier session have already been given back.
func start_effect() -> void:
	for i in range(_wanted.size()):
		if _wanted[i] != null and _wanted[i].is_collected:
			_hand_over(i, false)


## Called when the room is complete.
func fade_out() -> void:
	_faded = true
	for area in _areas:
		area.input_pickable = false


# ---------------------------------------------------------------------------
# Helpers (also used by the automated test)
# ---------------------------------------------------------------------------

func patient_count() -> int:
	return _wanted.size()


## True once patient `index` has handed over their gift.
func has_given(index: int) -> bool:
	return index >= 0 and index < _given.size() and _given[index]


## Where patient `index` is (room position).
func get_patient_position(index: int) -> Vector2:
	return to_global(patient_positions[index])


## The belonging patient `index` wants, and what they give for it.
func get_wanted(index: int) -> HiddenObject:
	return _wanted[index]


func get_gift(index: int) -> HiddenObject:
	return _gifts[index]


func _process(delta: float) -> void:
	_time += delta
	queue_redraw()


func _name_of(index: int) -> String:
	return patient_names[index] if index < patient_names.size() else "The patient"


func _on_wanted_collected(_object: HiddenObject, index: int) -> void:
	_hand_over(index, true)


## Patient `index` puts their gift on the blanket. `announce`: tell the player (after a moment).
func _hand_over(index: int, announce: bool) -> void:
	if _given[index]:
		return
	_given[index] = true
	_areas[index].input_pickable = false
	var gift := _gifts[index]
	if gift == null or gift.is_collected:
		return
	gift.reveal()
	if not announce:
		return
	# Let it pop up so the player notices it.
	gift.scale *= 0.3
	create_tween().tween_property(gift, "scale", gift.scale / 0.3, 0.4).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	get_tree().create_timer(thanks_delay).timeout.connect(_say_thanks.bind(index))


func _say_thanks(index: int) -> void:
	if _faded or _gifts[index] == null or _gifts[index].is_collected:
		return
	var message := thanks[index] if index < thanks.size() else "Something is put into your hand."
	notice.emit("%s gives you something" % _name_of(index), message, false)


func _on_patient_clicked(_viewport: Node, event: InputEvent, _shape_index: int, index: int) -> void:
	var click := event as InputEventMouseButton
	if click == null or not click.pressed or click.button_index != MOUSE_BUTTON_LEFT or get_tree().paused:
		return
	if _given[index] or _wanted[index] == null:
		return
	notice.emit("%s is waiting" % _name_of(index),
			"Missing: %s. Find it somewhere on the ward, and %s may trust you with something." % [_wanted[index].data.display_name, _name_of(index)], false)


func _draw() -> void:
	if _faded:
		return
	for i in range(_wanted.size()):
		var at := patient_positions[i] + bubble_offset + Vector2(0, sin(_time * 1.6 + i) * 2.0)
		if _given[i]:
			_draw_tick(at)
		elif _wanted[i] != null and _wanted[i].data != null:
			_draw_bubble(at, _wanted[i].data)


## A thought bubble with a small picture of what the patient is missing.
func _draw_bubble(at: Vector2, data: HiddenObjectData) -> void:
	PlaceholderArt.draw_ellipse(self, at + Vector2(1, 2), 25, 21, Color(0, 0, 0, 0.35))
	PlaceholderArt.draw_ellipse(self, at, 24, 20, Color(0.93, 0.92, 0.86, 0.95))
	draw_circle(at + Vector2(-12, 24), 4.5, Color(0.93, 0.92, 0.86, 0.95))
	draw_circle(at + Vector2(-17, 33), 2.5, Color(0.93, 0.92, 0.86, 0.95))
	var picture := data.icon_texture if data.icon_texture != null else data.texture
	if picture != null:
		var fit := minf(34.0 / picture.get_width(), 28.0 / picture.get_height())
		var fitted := picture.get_size() * fit
		draw_texture_rect(picture, Rect2(at - fitted / 2.0, fitted), false)
		return
	var art_size := PlaceholderArt.get_style_size(data.placeholder_style)
	var art_scale := minf(34.0 / art_size.x, 28.0 / art_size.y)
	draw_set_transform(at, 0.0, Vector2(art_scale, art_scale))
	PlaceholderArt.draw_object(self, data.placeholder_style)
	draw_set_transform(Vector2.ZERO, 0.0, Vector2.ONE)


## A small green tick: this patient has their belonging back.
func _draw_tick(at: Vector2) -> void:
	var tick := PackedVector2Array([at + Vector2(-8, 0), at + Vector2(-2, 7), at + Vector2(10, -8)])
	draw_polyline(tick, Color(0, 0, 0, 0.6), 6.0, true)
	draw_polyline(tick, Color(0.55, 0.85, 0.5), 3.5, true)
