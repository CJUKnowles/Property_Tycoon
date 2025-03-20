extends Node2D

@export var scale_ratio:float

func _process(delta: float) -> void:
	var window_size = get_viewport().get_visible_rect().size
	scale = Vector2(window_size.y * scale_ratio * .01, window_size.y * scale_ratio * .01)
