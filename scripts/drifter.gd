class_name Drifter
extends Node
## Makes its PARENT (a hidden object floating on water) drift slowly back and
## forth and bob up and down, so the player has to catch a moving target.
## Used in House Two's Chapter One (The Jetty).
##
## HOW TO USE: add a Drifter node as a child of a HiddenObject and set how far
## and how fast it drifts. The object's starting position is the middle of its path.

## How far the object drifts to each side of its starting position, in pixels.
@export var drift_distance: float = 120.0
## Seconds for one full trip there and back (bigger = slower).
@export var drift_period: float = 14.0
## How far the object bobs up and down, in pixels.
@export var bob_height: float = 3.0
## Seconds for one bob.
@export var bob_period: float = 2.2
## Where in its trip the object starts (0 to 1), so floating things don't move in step.
@export_range(0.0, 1.0) var start_phase: float = 0.0

var _target: Node2D
var _home: Vector2
var _time: float = 0.0


func _ready() -> void:
	_target = get_parent() as Node2D
	if _target == null:
		push_warning("Drifter '%s' needs a Node2D parent." % name)
		set_process(false)
		return
	_home = _target.position
	_time = start_phase * drift_period
	_apply()


func _process(delta: float) -> void:
	if not _target.visible:
		return  # Collected objects stop drifting.
	_time += delta
	_apply()


func _apply() -> void:
	var drift := sin(_time / drift_period * TAU) * drift_distance
	var bob := sin(_time / bob_period * TAU) * bob_height
	_target.position = _home + Vector2(drift, bob)
	# A gentle rock from side to side as the waves pass.
	_target.rotation = sin(_time / bob_period * TAU + 1.0) * 0.06
