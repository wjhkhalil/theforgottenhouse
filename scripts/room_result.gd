class_name RoomResult
extends RefCounted
## How a finished room is scored. Kept in one place so the victory screen, the
## Chapters list and the tutorial all tell the same story.
##
## THE THREE STARS
##   1. Finish the chapter.
##   2. Use no hints.
##   3. Make at most MAX_WRONG_TAPS wrong taps (taps that hit nothing).
## Time is shown and the best time is remembered, but it never costs a star.

const MAX_STARS := 3
## Wrong taps allowed while still earning the third star.
const MAX_WRONG_TAPS := 3


## Stars for a finished room.
static func stars_for(hints_used: int, wrong_taps: int) -> int:
	var stars := 1
	if hints_used == 0:
		stars += 1
	if wrong_taps <= MAX_WRONG_TAPS:
		stars += 1
	return stars


## Each star's rule, in order, with whether it was met: [{"text": String, "earned": bool}, ...].
static func star_rules(hints_used: int, wrong_taps: int) -> Array[Dictionary]:
	return [
		{"text": "Chapter complete", "earned": true},
		{"text": "No hints used" if hints_used == 0 else "No hints used (%d used)" % hints_used, "earned": hints_used == 0},
		{"text": "At most %d wrong taps" % MAX_WRONG_TAPS if wrong_taps <= MAX_WRONG_TAPS
				else "At most %d wrong taps (%d made)" % [MAX_WRONG_TAPS, wrong_taps], "earned": wrong_taps <= MAX_WRONG_TAPS},
	]


## Seconds as "m:ss", for example 95.4 -> "1:35".
static func format_time(seconds: float) -> String:
	var whole := int(floor(maxf(seconds, 0.0)))
	return "%d:%02d" % [whole / 60, whole % 60]
