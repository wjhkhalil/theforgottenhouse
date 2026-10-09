class_name PowerCuts
extends Node
## Chapter Six: the lights fail at RANDOM moments.
## During a power cut the room goes dark except for a small match flame around
## the mouse (the `darkness_layer`, a LanternDarkness node). Each gap between
## cuts and each cut's length is picked at random, so every play is different.

signal power_changed(is_on: bool)

## The darkness shown during a power cut (hidden while the lights are on).
@export var darkness_layer: LanternDarkness
@export var min_seconds_between: float = 12.0
@export var max_seconds_between: float = 24.0
@export var min_cut_seconds: float = 3.0
@export var max_cut_seconds: float = 5.5

var is_power_on: bool = true
## Seconds until the next change (exposed for the automated test).
var time_left: float = 0.0

var _active: bool = false
var _rng := RandomNumberGenerator.new()


func _ready() -> void:
	add_to_group("room_effects")
	_rng.randomize()
	if darkness_layer != null:
		darkness_layer.hide()


## Called by the room when the player can start searching.
func start_effect() -> void:
	_active = true
	time_left = _rng.randf_range(min_seconds_between, max_seconds_between)


## Called when the room is complete: the lights stay on for good.
func fade_out() -> void:
	_active = false
	if not is_power_on:
		restore_power()


func _process(delta: float) -> void:
	if not _active:
		return
	time_left -= delta
	if time_left <= 0.0:
		if is_power_on:
			cut_power()
		else:
			restore_power()


func cut_power() -> void:
	is_power_on = false
	time_left = _rng.randf_range(min_cut_seconds, max_cut_seconds)
	if darkness_layer != null:
		# The bulbs flicker twice, then die.
		darkness_layer.show()
		darkness_layer.modulate.a = 0.0
		var tween := create_tween()
		tween.tween_property(darkness_layer, "modulate:a", 0.8, 0.08)
		tween.tween_property(darkness_layer, "modulate:a", 0.1, 0.1)
		tween.tween_property(darkness_layer, "modulate:a", 0.9, 0.08)
		tween.tween_property(darkness_layer, "modulate:a", 0.3, 0.12)
		tween.tween_property(darkness_layer, "modulate:a", 1.0, 0.15)
	AudioManager.play_sfx("power_down")
	power_changed.emit(false)


func restore_power() -> void:
	is_power_on = true
	time_left = _rng.randf_range(min_seconds_between, max_seconds_between)
	if darkness_layer != null:
		darkness_layer.hide()
	AudioManager.play_sfx("power_up")
	power_changed.emit(true)
