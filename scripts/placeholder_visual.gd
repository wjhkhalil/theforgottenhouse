@tool
class_name PlaceholderVisual
extends Node2D
## Draws a procedural placeholder for a hidden object.
## It is a @tool script, so you can see the drawing in the editor too.

@export var style: HiddenObjectData.PlaceholderStyle = HiddenObjectData.PlaceholderStyle.GENERIC:
	set(value):
		style = value
		queue_redraw()


func _draw() -> void:
	PlaceholderArt.draw_object(self, style)
