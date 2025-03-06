@tool
extends ColorRect
@export var dark : bool = false:
	set(v):
		dark = v
		color = Color.AQUA if dark else Color.DARK_GREEN
