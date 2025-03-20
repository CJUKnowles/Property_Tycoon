extends Node2D

@export var x_scale_ratio:float
@export var y_scale_ratio:float

func _process(delta: float) -> void:
	var window_size = get_viewport().get_visible_rect().size
	
	# determines whether the board scale should depend on the window width or height
	var new_scale = minf(window_size.y * y_scale_ratio, window_size.x * x_scale_ratio) *.01
	scale = Vector2(new_scale, new_scale)
