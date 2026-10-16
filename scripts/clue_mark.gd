@tool
class_name ClueMark
extends Node2D
## Writing that a painted background needs but does not have: a chalked time, a
## carved date, a painted sign, a wall calendar with one day ringed.
##
## Several keypad codes are read off the room itself. When a room's background
## is a painting, the painting may not show that writing, so this node draws it
## on top. Place it right after RoomBackground, so it sits behind the objects.
## Move, rotate and scale the node to fit the surface it is written on.

## Each entry is one line of writing.
@export var lines: PackedStringArray = PackedStringArray():
	set(value):
		lines = value
		queue_redraw()
## The size of each line (the last size is reused for any further lines).
@export var sizes: PackedInt32Array = PackedInt32Array([14]):
	set(value):
		sizes = value
		queue_redraw()
@export var ink: Color = Color(0.9, 0.9, 0.84, 0.85):
	set(value):
		ink = value
		queue_redraw()
## Draws every line twice, slightly offset in a darker colour, so it looks cut into wood.
@export var carved: bool = false:
	set(value):
		carved = value
		queue_redraw()
## Draws the writing as letters cut into stone: a dark groove with a pale lip
## along its lower edge, where the light catches the cut.
@export var engraved: bool = false:
	set(value):
		engraved = value
		queue_redraw()
## Space between lines, as a share of the line's size.
@export var line_spacing: float = 1.15:
	set(value):
		line_spacing = value
		queue_redraw()

@export_group("Paper")
## Size of a sheet of paper drawn behind the writing. (0, 0) = no paper.
@export var paper_size: Vector2 = Vector2.ZERO:
	set(value):
		paper_size = value
		queue_redraw()
@export var paper_color: Color = Color(0.8, 0.75, 0.62):
	set(value):
		paper_color = value
		queue_redraw()

@export_group("Calendar")
## Number of days in a month grid drawn on the paper under the first line. 0 = no grid.
@export var calendar_days: int = 0:
	set(value):
		calendar_days = value
		queue_redraw()
## Which column the 1st falls in (0 = first column).
@export var first_day_column: int = 0:
	set(value):
		first_day_column = value
		queue_redraw()
## The day ringed in red. 0 = none.
@export var ringed_day: int = 0:
	set(value):
		ringed_day = value
		queue_redraw()
@export var ring_color: Color = Color(0.72, 0.12, 0.1):
	set(value):
		ring_color = value
		queue_redraw()


func _draw() -> void:
	var font := ThemeDB.fallback_font
	if paper_size != Vector2.ZERO:
		draw_rect(Rect2(Vector2(2, 3), paper_size), Color(0, 0, 0, 0.35))
		draw_rect(Rect2(Vector2.ZERO, paper_size), paper_color)
		draw_rect(Rect2(Vector2.ZERO, Vector2(paper_size.x, 3)), paper_color.darkened(0.35))
	var y := 0.0
	for i in range(lines.size()):
		var size := sizes[mini(i, sizes.size() - 1)] if sizes.size() > 0 else 14
		y += size * (1.0 if i == 0 else line_spacing)
		var x := 4.0 if paper_size != Vector2.ZERO else 0.0
		if i == 0 and calendar_days > 0:
			_write(font, Vector2(x, y + 3), lines[i], size)
			y = _draw_calendar(font, y + 8)
			continue
		_write(font, Vector2(x, y + (3 if paper_size != Vector2.ZERO else 0)), lines[i], size)


func _write(font: Font, at: Vector2, text: String, size: int) -> void:
	if engraved:
		_write_engraved(font, at, text, size)
		return
	if carved:
		draw_string(font, at + Vector2(1, 1), text, HORIZONTAL_ALIGNMENT_LEFT, -1, size, Color(0, 0, 0, 0.55))
	draw_string(font, at, text, HORIZONTAL_ALIGNMENT_LEFT, -1, size, ink)


## The pale lip first, a little below, then the dark groove over it, then a
## softer shadow just inside the groove's top edge.
func _write_engraved(font: Font, at: Vector2, text: String, size: int) -> void:
	var depth := size / 14.0
	var lip := Color(1.0, 0.96, 0.88, ink.a * 0.45)
	draw_string(font, at + Vector2(0.3, 1.0) * depth, text, HORIZONTAL_ALIGNMENT_LEFT, -1, size, lip)
	draw_string(font, at, text, HORIZONTAL_ALIGNMENT_LEFT, -1, size, ink)
	draw_string(font, at + Vector2(0, -0.4) * depth, text, HORIZONTAL_ALIGNMENT_LEFT, -1, size, Color(0, 0, 0, ink.a * 0.35))


## Draws the month grid below `top` and returns where it ends.
func _draw_calendar(font: Font, top: float) -> float:
	var cell := Vector2((paper_size.x - 6.0) / 7.0, 7.0)
	var bottom := top
	for day in range(1, calendar_days + 1):
		var slot := day - 1 + first_day_column
		var at := Vector2(3.0 + (slot % 7) * cell.x, top + (slot / 7) * cell.y)
		draw_string(font, at + Vector2(0.5, cell.y - 1.0), str(day), HORIZONTAL_ALIGNMENT_LEFT, -1, 4, ink)
		if day == ringed_day:
			draw_arc(at + cell / 2.0 + Vector2(-0.5, 0.5), cell.y * 0.62, 0.0, TAU, 14, ring_color, 1.2)
		bottom = at.y + cell.y
	return bottom + 1.0
