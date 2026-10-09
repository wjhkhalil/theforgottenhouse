extends Node
## SaveManager (autoload): remembers the player's progress between sessions.
##
## Why an autoload? Progress must survive scene changes AND closing the game,
## so it lives outside the rooms and is written to a file.
##
## WHAT IS SAVED (in user://savegame.cfg, a simple text file):
##   - which chapters are completed (this also unlocks the next chapter)
##   - objects found in an unfinished room, and containers already opened
##   - one-time flags, such as "the basement door code was entered"
##   - the sound on/off setting
## The game saves automatically after every important change.
##
## ADDING A NEW CHAPTER: add a line to CHAPTERS below, in play order, and give
## the room's LevelData the same chapter_id. Menus pick it up automatically.
## ADDING A NEW HOUSE: add a line to HOUSES, then give its chapters that "house" id.

## The houses of the game. Each chapter belongs to one house (its "house" id).
## "finished": false means more chapters are still to come for that house, so
## its last chapter says "more chapters coming soon" instead of THE END.
const HOUSES: Array[Dictionary] = [
	{"id": "ashworth_manor", "title": "House One: Ashworth Manor", "finished": true},
	{"id": "blackwater_boathouse", "title": "House Two: The Blackwater Boathouse", "finished": true},
]

const CHAPTERS: Array[Dictionary] = [
	{"id": "bedroom", "house": "ashworth_manor", "title": "Chapter One: The Old Bedroom", "scene": "res://scenes/bedroom.tscn"},
	{"id": "basement", "house": "ashworth_manor", "title": "Chapter Two: The Basement", "scene": "res://scenes/basement.tscn"},
	{"id": "attic", "house": "ashworth_manor", "title": "Chapter Three: The Attic", "scene": "res://scenes/attic.tscn"},
	{"id": "staircase", "house": "ashworth_manor", "title": "Chapter Four: The Grand Staircase", "scene": "res://scenes/staircase.tscn"},
	{"id": "washroom", "house": "ashworth_manor", "title": "Chapter Five: The Washroom", "scene": "res://scenes/washroom.tscn"},
	{"id": "living_room", "house": "ashworth_manor", "title": "Chapter Six: The Living Room", "scene": "res://scenes/living_room.tscn"},
	{"id": "kitchen", "house": "ashworth_manor", "title": "Chapter Seven: The Kitchen", "scene": "res://scenes/kitchen.tscn"},
	{"id": "study", "house": "ashworth_manor", "title": "Chapter Eight: The Study", "scene": "res://scenes/study.tscn"},
	{"id": "jetty", "house": "blackwater_boathouse", "title": "Chapter One: The Jetty", "scene": "res://scenes/jetty.tscn"},
	{"id": "boat_shed", "house": "blackwater_boathouse", "title": "Chapter Two: The Boat Shed", "scene": "res://scenes/boat_shed.tscn"},
	{"id": "loft", "house": "blackwater_boathouse", "title": "Chapter Three: The Loft", "scene": "res://scenes/loft.tscn"},
	{"id": "workshop", "house": "blackwater_boathouse", "title": "Chapter Four: The Workshop", "scene": "res://scenes/workshop.tscn"},
	{"id": "sunken_boat", "house": "blackwater_boathouse", "title": "Chapter Five: The Sunken Boat", "scene": "res://scenes/sunken_boat.tscn"},
	{"id": "ice_house", "house": "blackwater_boathouse", "title": "Chapter Six: The Ice House", "scene": "res://scenes/ice_house.tscn"},
	{"id": "lighthouse_steps", "house": "blackwater_boathouse", "title": "Chapter Seven: The Lighthouse Steps", "scene": "res://scenes/lighthouse_steps.tscn"},
	{"id": "lamp_room", "house": "blackwater_boathouse", "title": "Chapter Eight: The Lamp Room", "scene": "res://scenes/lamp_room.tscn"},
	{"id": "island_chapel", "house": "blackwater_boathouse", "title": "Chapter Nine: The Island Chapel", "scene": "res://scenes/island_chapel.tscn"},
	{"id": "vane_cottage", "house": "blackwater_boathouse", "title": "Chapter Ten: Dr Vane's Cottage", "scene": "res://scenes/vane_cottage.tscn"},
]

## The house a chapter belongs to (an entry of HOUSES), or {} if unknown.
func get_house(chapter_id: String) -> Dictionary:
	for chapter in CHAPTERS:
		if chapter["id"] == chapter_id:
			for house in HOUSES:
				if house["id"] == chapter["house"]:
					return house
	return {}


## Where the save file is written. (The automated test changes this so it
## never touches your real save.)
var save_path: String = "user://savegame.cfg"
var sound_muted: bool = false

var _completed_chapters: Array = []  # chapter ids, e.g. ["bedroom"]
var _room_progress: Dictionary = {}  # chapter id -> {"collected": [...], "opened": [...]}
var _flags: Dictionary = {}          # flag name -> value


func _ready() -> void:
	load_game()


# ---------------------------------------------------------------------------
# Loading and saving the file
# ---------------------------------------------------------------------------

func load_game() -> void:
	_completed_chapters = []
	_room_progress = {}
	_flags = {}
	sound_muted = false
	var config := ConfigFile.new()
	if config.load(save_path) != OK:
		return  # No save file yet (first time playing) - start fresh.
	_completed_chapters = config.get_value("progress", "completed_chapters", [])
	_room_progress = config.get_value("progress", "room_progress", {})
	_flags = config.get_value("progress", "flags", {})
	sound_muted = config.get_value("settings", "sound_muted", false)


func save_game() -> void:
	var config := ConfigFile.new()
	config.set_value("progress", "completed_chapters", _completed_chapters)
	config.set_value("progress", "room_progress", _room_progress)
	config.set_value("progress", "flags", _flags)
	config.set_value("settings", "sound_muted", sound_muted)
	var error := config.save(save_path)
	if error != OK:
		push_warning("Could not write the save file (error %d)." % error)


## Erases all chapter progress (the sound setting is kept).
func reset_progress() -> void:
	_completed_chapters = []
	_room_progress = {}
	_flags = {}
	save_game()


## True if there is anything worth "continuing".
func has_progress() -> bool:
	return not _completed_chapters.is_empty() or not _room_progress.is_empty()


# ---------------------------------------------------------------------------
# Chapters
# ---------------------------------------------------------------------------

func get_chapter_index(chapter_id: String) -> int:
	for i in range(CHAPTERS.size()):
		if CHAPTERS[i]["id"] == chapter_id:
			return i
	return -1


func is_chapter_completed(chapter_id: String) -> bool:
	return _completed_chapters.has(chapter_id)


## The first chapter is always unlocked; every other chapter unlocks when
## the chapter before it is completed.
func is_chapter_unlocked(chapter_id: String) -> bool:
	var index := get_chapter_index(chapter_id)
	if index <= 0:
		return index == 0
	return is_chapter_completed(CHAPTERS[index - 1]["id"])


func complete_chapter(chapter_id: String) -> void:
	if not _completed_chapters.has(chapter_id):
		_completed_chapters.append(chapter_id)
	_room_progress.erase(chapter_id)  # Replaying a finished chapter starts fresh.
	save_game()


## The chapter after `chapter_id`, or an empty Dictionary if it was the last one.
func get_next_chapter(chapter_id: String) -> Dictionary:
	var index := get_chapter_index(chapter_id)
	if index < 0 or index + 1 >= CHAPTERS.size():
		return {}
	return CHAPTERS[index + 1]


## Where "Continue" should go: the first chapter that is not completed yet,
## or the last chapter if everything is finished.
func get_continue_chapter() -> Dictionary:
	for chapter in CHAPTERS:
		if not is_chapter_completed(chapter["id"]):
			return chapter
	return CHAPTERS[CHAPTERS.size() - 1]


# ---------------------------------------------------------------------------
# Progress inside an unfinished room
# ---------------------------------------------------------------------------

## Returns {"collected": [object ids], "opened": [container ids]} for a room.
func get_room_progress(chapter_id: String) -> Dictionary:
	var saved: Dictionary = _room_progress.get(chapter_id, {})
	return {
		"collected": saved.get("collected", []),
		"opened": saved.get("opened", []),
	}


func save_room_progress(chapter_id: String, collected_ids: Array, opened_ids: Array) -> void:
	_room_progress[chapter_id] = {"collected": collected_ids, "opened": opened_ids}
	save_game()


func clear_room_progress(chapter_id: String) -> void:
	_room_progress.erase(chapter_id)
	save_game()


# ---------------------------------------------------------------------------
# One-time flags and settings
# ---------------------------------------------------------------------------

func get_flag(flag_name: String) -> bool:
	return _flags.get(flag_name, false)


func set_flag(flag_name: String, value: bool = true) -> void:
	_flags[flag_name] = value
	save_game()


func set_sound_muted(muted: bool) -> void:
	sound_muted = muted
	save_game()
