class_name LevelData
extends Resource
## Settings and story text for one chapter room. Each room has a .tres file in
## res://resources/levels/ that you can edit in the Inspector.

## Must match the chapter's "id" in SaveManager.CHAPTERS (used by the save file).
@export var chapter_id: StringName = &""
@export var room_name: String = "The Old Bedroom"
@export_multiline var intro_message: String = ""

@export_group("Difficulty")
## Hints the player gets for free in this room. Every hint after that costs a
## rewarded ad (see Ads); the count survives leaving and re-entering the room.
@export var free_hints: int = 1
## Seconds the Hint button stays disabled after each use.
@export var hint_cooldown_seconds: float = 3.0
## Size of the circle that marks the hint area (bigger = vaguer).
@export var hint_area_radius: float = 85.0
## How far the circle may be from the real object (bigger = vaguer).
@export var hint_area_offset: float = 25.0
## If on, the objective list shows each object's riddle instead of its name and
## picture, until the object is found.
@export var objective_riddles: bool = false

@export_group("Tutorial")
## If on, the first time this room is played a short guided tutorial is shown
## (meant for the very first chapter only).
@export var show_tutorial: bool = false

@export_group("Entry Lock")
## If not empty, a keypad asks for this code before the room can be searched.
@export var entry_code: String = ""
@export var entry_title: String = "A Locked Door"
@export_multiline var entry_prompt: String = ""
## Shown after `entry_hint_first_after` wrong attempts.
@export_multiline var entry_hint_first: String = ""
## Shown after `entry_hint_second_after` wrong attempts (should make the answer clear).
@export_multiline var entry_hint_second: String = ""
## Wrong tries before each keypad hint appears (higher = harder).
@export var entry_hint_first_after: int = 2
@export var entry_hint_second_after: int = 4

@export_group("Completion")
@export var chapter_title: String = "Chapter One Complete"
@export_multiline var chapter_hook: String = ""

@export_group("Final Letter")
@export var final_letter_title: String = "A Letter Left Behind"
@export_multiline var final_letter_text: String = ""
@export var final_letter_signature: String = ""
