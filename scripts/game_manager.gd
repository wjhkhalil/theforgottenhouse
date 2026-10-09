class_name GameManager
extends Node
## Keeps track of the game state for ONE room.
##
## It is a normal node inside the room scene (not an autoload), so every time
## the room is loaded or restarted, a brand-new GameManager starts from zero.
## That makes restarting very reliable: there is no old state to clean up.
##
## HOW SIGNALS UPDATE THE UI
##   HiddenObject --collected--> GameManager
##   GameManager --object_collected / progress_changed / room_completed--> room script --> HUD
## The GameManager never touches the UI directly; it only emits signals.

## Emitted every time a new object is collected.
signal object_collected(object_data: HiddenObjectData)
## Emitted when the number of found objects changes (and once at the start).
signal progress_changed(found_count: int, total_count: int)
## Emitted exactly once, when every required object has been found.
signal room_completed

## Every hidden object in the room.
var hidden_objects: Array[HiddenObject] = []
## Ids of the objects found so far.
var collected_ids: Array[StringName] = []
## True after all required objects are found.
var is_room_complete: bool = false
## True after the final letter has been shown.
var final_letter_revealed: bool = false

# Used to rotate through the remaining objects so hints don't repeat.
var _next_hint_index: int = 0


## Called by the room once, at the start. Connects to every object.
## `saved_ids` are objects found in an earlier session (from the save file);
## they are restored silently, without notifications.
func register_objects(objects: Array[HiddenObject], saved_ids: Array = []) -> void:
	hidden_objects = objects
	for hidden_object in hidden_objects:
		if hidden_object.data == null:
			continue
		hidden_object.collected.connect(_on_object_collected)
		if saved_ids.has(String(hidden_object.data.object_id)):
			hidden_object.restore_collected()
			collected_ids.append(hidden_object.data.object_id)
	progress_changed.emit(get_found_count(), get_total_count())


## Object ids as plain Strings, ready to be written to the save file.
func get_collected_ids_for_save() -> Array[String]:
	var ids: Array[String] = []
	for object_id in collected_ids:
		ids.append(String(object_id))
	return ids


## HOW PROGRESS IS CALCULATED: the number of REQUIRED objects whose id is in collected_ids.
func get_found_count() -> int:
	var count := 0
	for hidden_object in hidden_objects:
		if _is_required(hidden_object) and collected_ids.has(hidden_object.data.object_id):
			count += 1
	return count


## The number of REQUIRED objects in the room.
func get_total_count() -> int:
	var count := 0
	for hidden_object in hidden_objects:
		if _is_required(hidden_object):
			count += 1
	return count


## HOW HINTS FIND AN OBJECT:
## Make a list of required objects that are still not found, then take the next
## one in that list (wrapping around). Pressing Hint again moves to a different
## object, so the same hint is not shown twice in a row while others remain.
## Objects that are still hidden (e.g. in a closed trunk) are included: their
## hint points at the container instead. Returns null if nothing is left to find.
func get_next_hint_object() -> HiddenObject:
	var remaining: Array[HiddenObject] = []
	for hidden_object in hidden_objects:
		if _is_required(hidden_object) and not hidden_object.is_collected:
			remaining.append(hidden_object)
	if remaining.is_empty():
		return null
	var chosen := remaining[_next_hint_index % remaining.size()]
	_next_hint_index += 1
	return chosen


func _on_object_collected(hidden_object: HiddenObject) -> void:
	var object_id := hidden_object.data.object_id
	if collected_ids.has(object_id):
		return  # Safety net: an id can only ever be counted once.
	collected_ids.append(object_id)

	object_collected.emit(hidden_object.data)
	progress_changed.emit(get_found_count(), get_total_count())

	# HOW THE VICTORY STATE IS TRIGGERED:
	# when the found count reaches the total. The is_room_complete flag makes
	# sure room_completed can only be emitted once.
	if not is_room_complete and get_found_count() >= get_total_count():
		is_room_complete = true
		room_completed.emit()


func _is_required(hidden_object: HiddenObject) -> bool:
	return hidden_object.data != null and hidden_object.data.is_required
