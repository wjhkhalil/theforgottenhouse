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
##   - the best result of every finished chapter (stars, best time)
##   - the clues found in each chapter, for the Journal
##   - the settings: sound on/off, music and effects volume, vibration
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
	{"id": "hollowmere_sanatorium", "title": "House Three: Hollowmere Sanatorium", "finished": true},
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
	{"id": "gate_lodge", "house": "hollowmere_sanatorium", "title": "Chapter One: The Gate Lodge", "scene": "res://scenes/gate_lodge.tscn"},
	{"id": "xray_room", "house": "hollowmere_sanatorium", "title": "Chapter Two: The X-Ray Room", "scene": "res://scenes/xray_room.tscn"},
	{"id": "laundry", "house": "hollowmere_sanatorium", "title": "Chapter Three: The Laundry", "scene": "res://scenes/laundry.tscn"},
	{"id": "boiler_room", "house": "hollowmere_sanatorium", "title": "Chapter Four: The Boiler Room", "scene": "res://scenes/boiler_room.tscn"},
	{"id": "dispensary", "house": "hollowmere_sanatorium", "title": "Chapter Five: The Dispensary", "scene": "res://scenes/dispensary.tscn"},
	{"id": "matrons_office", "house": "hollowmere_sanatorium", "title": "Chapter Six: The Matron's Office", "scene": "res://scenes/matrons_office.tscn"},
	{"id": "ward_seven", "house": "hollowmere_sanatorium", "title": "Chapter Seven: Ward Seven", "scene": "res://scenes/ward_seven.tscn"},
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
## Volumes go from 0.0 (silent) to 1.0 (full).
var music_volume: float = 0.8
var sfx_volume: float = 1.0
## Short vibrations on phones when something is found or a tap misses.
var vibration_enabled: bool = true

var _completed_chapters: Array = []  # chapter ids, e.g. ["bedroom"]
var _room_progress: Dictionary = {}  # chapter id -> {"collected": [...], "opened": [...], "stats": {...}}
var _flags: Dictionary = {}          # flag name -> value
var _results: Dictionary = {}        # chapter id -> {"stars": int, "best_time": float, "hints": int, "wrong_taps": int}
var _journal_clues: Dictionary = {}  # chapter id -> [[object name, clue text], ...]


func _ready() -> void:
	load_game()


# ---------------------------------------------------------------------------
# Loading and saving the file
# ---------------------------------------------------------------------------

func load_game() -> void:
	_completed_chapters = []
	_room_progress = {}
	_flags = {}
	_results = {}
	_journal_clues = {}
	sound_muted = false
	music_volume = 0.8
	sfx_volume = 1.0
	vibration_enabled = true
	var config := ConfigFile.new()
	if config.load(save_path) != OK:
		return  # No save file yet (first time playing) - start fresh.
	_completed_chapters = config.get_value("progress", "completed_chapters", [])
	_room_progress = config.get_value("progress", "room_progress", {})
	_flags = config.get_value("progress", "flags", {})
	_results = config.get_value("progress", "results", {})
	_journal_clues = config.get_value("progress", "journal_clues", {})
	sound_muted = config.get_value("settings", "sound_muted", false)
	music_volume = clampf(config.get_value("settings", "music_volume", 0.8), 0.0, 1.0)
	sfx_volume = clampf(config.get_value("settings", "sfx_volume", 1.0), 0.0, 1.0)
	vibration_enabled = config.get_value("settings", "vibration_enabled", true)


func save_game() -> void:
	var config := ConfigFile.new()
	config.set_value("progress", "completed_chapters", _completed_chapters)
	config.set_value("progress", "room_progress", _room_progress)
	config.set_value("progress", "flags", _flags)
	config.set_value("progress", "results", _results)
	config.set_value("progress", "journal_clues", _journal_clues)
	config.set_value("settings", "sound_muted", sound_muted)
	config.set_value("settings", "music_volume", music_volume)
	config.set_value("settings", "sfx_volume", sfx_volume)
	config.set_value("settings", "vibration_enabled", vibration_enabled)
	var error := config.save(save_path)
	if error != OK:
		push_warning("Could not write the save file (error %d)." % error)


## Erases all chapter progress, results and journal (the settings are kept).
func reset_progress() -> void:
	_completed_chapters = []
	_room_progress = {}
	_flags = {}
	_results = {}
	_journal_clues = {}
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

## Returns {"collected": [object ids], "opened": [container ids], "stats": {...}} for a room.
## "stats" holds the room clock and counters: {"elapsed": float, "hints": int, "wrong_taps": int}.
func get_room_progress(chapter_id: String) -> Dictionary:
	var saved: Dictionary = _room_progress.get(chapter_id, {})
	return {
		"collected": saved.get("collected", []),
		"opened": saved.get("opened", []),
		"stats": saved.get("stats", {}),
	}


func save_room_progress(chapter_id: String, collected_ids: Array, opened_ids: Array, stats: Dictionary = {}) -> void:
	_room_progress[chapter_id] = {"collected": collected_ids, "opened": opened_ids, "stats": stats}
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


func set_music_volume(volume: float) -> void:
	music_volume = clampf(volume, 0.0, 1.0)
	save_game()


func set_sfx_volume(volume: float) -> void:
	sfx_volume = clampf(volume, 0.0, 1.0)
	save_game()


func set_vibration_enabled(enabled: bool) -> void:
	vibration_enabled = enabled
	save_game()


# ---------------------------------------------------------------------------
# Chapter results (stars and best time)
# ---------------------------------------------------------------------------

## Remembers a finished chapter's result, keeping the best stars and the best
## time ever achieved. Returns what improved:
##   {"first": true the first time, "new_best_stars": bool, "new_best_time": bool}
func record_result(chapter_id: String, stars: int, seconds: float, hints: int, wrong_taps: int) -> Dictionary:
	var previous: Dictionary = _results.get(chapter_id, {})
	var first := previous.is_empty()
	var new_best_stars := first or stars > int(previous.get("stars", 0))
	var new_best_time := first or seconds < float(previous.get("best_time", INF))
	_results[chapter_id] = {
		"stars": maxi(stars, int(previous.get("stars", 0))),
		"best_time": minf(seconds, float(previous.get("best_time", INF))),
		"hints": hints,
		"wrong_taps": wrong_taps,
	}
	save_game()
	return {"first": first, "new_best_stars": new_best_stars, "new_best_time": new_best_time}


## The best result of a chapter, or {} if it was never finished.
func get_result(chapter_id: String) -> Dictionary:
	return (_results.get(chapter_id, {}) as Dictionary).duplicate()


## Best stars of every chapter added up.
func get_total_stars() -> int:
	var total := 0
	for chapter_id in _results:
		total += int(_results[chapter_id].get("stars", 0))
	return total


## The most stars the game can give (three per chapter).
func get_max_stars() -> int:
	return CHAPTERS.size() * 3


# ---------------------------------------------------------------------------
# Journal: clues found and letters read
# ---------------------------------------------------------------------------

## Keeps a found object's clue for the Journal. The same object is never listed twice.
func record_clue(chapter_id: String, object_name: String, clue_text: String) -> void:
	if clue_text.strip_edges() == "":
		return
	var clues: Array = _journal_clues.get(chapter_id, [])
	for clue in clues:
		if clue[0] == object_name:
			return
	clues.append([object_name, clue_text])
	_journal_clues[chapter_id] = clues
	save_game()


## The clues found in a chapter so far, oldest first: [[object name, clue text], ...].
func get_clues(chapter_id: String) -> Array:
	return (_journal_clues.get(chapter_id, []) as Array).duplicate()


## The level file of a chapter (res://resources/levels/<id>_level.tres), or null.
func load_level_data(chapter_id: String) -> LevelData:
	var path := "res://resources/levels/%s_level.tres" % chapter_id
	if not ResourceLoader.exists(path):
		return null
	return load(path) as LevelData


## Everything the Journal shows, in play order: one entry per chapter that is
## completed or has clues. Each entry is a Dictionary with: "chapter_id",
## "title", "house_title", "completed", "letter_title", "letter_text",
## "signature" and "clues".
func get_journal_entries() -> Array[Dictionary]:
	var entries: Array[Dictionary] = []
	for chapter in CHAPTERS:
		var chapter_id: String = chapter["id"]
		var completed := is_chapter_completed(chapter_id)
		var clues := get_clues(chapter_id)
		if not completed and clues.is_empty():
			continue
		var level := load_level_data(chapter_id)
		entries.append({
			"chapter_id": chapter_id,
			"title": chapter["title"],
			"house_title": get_house(chapter_id).get("title", ""),
			"completed": completed,
			"letter_title": level.final_letter_title if level != null else "",
			"letter_text": level.final_letter_text if level != null else "",
			"signature": level.final_letter_signature if level != null else "",
			"clues": clues,
		})
	return entries
