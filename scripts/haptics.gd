extends Node
## Haptics (autoload): short vibrations on phones.
##
## Each function is one named "feel", so the rest of the game never has to
## know durations: Haptics.found() when an object is picked up, Haptics.wrong()
## for a tap that hit nothing, and so on. Nothing happens when vibration is
## turned off in Settings, and computers simply ignore the call.

## Milliseconds of each pulse.
const FOUND_MS := 35
const OPEN_MS := 25
const WRONG_MS := 60
const TAP_MS := 12
const COMPLETE_MS := 120


## True when the device can vibrate and the player has not turned it off.
func is_available() -> bool:
	return OS.has_feature("mobile") or OS.has_feature("web")


## An object was found.
func found() -> void:
	_pulse(FOUND_MS)


## A drawer, box or cupboard opened.
func open() -> void:
	_pulse(OPEN_MS)


## A tap on nothing, a locked container or a wrong code.
func wrong() -> void:
	_pulse(WRONG_MS)


## A light tick, for example when a star pops in.
func tap() -> void:
	_pulse(TAP_MS)


## The chapter is complete.
func complete() -> void:
	_pulse(COMPLETE_MS)


func _pulse(milliseconds: int) -> void:
	if not SaveManager.vibration_enabled:
		return
	Input.vibrate_handheld(milliseconds)
