extends Node2D

###############################################################################
# This class ensures the board stays (roughly) the correct size based on the size of the window.
# It is attached to an Node2D that is the board's parent, acting as a pivot to scale/rotate off of.
# This approach offers flexibility in where and how the board scales, and allowed us
# to move the GO space to the bottom left, as the customer requested.
###############################################################################

@export var x_scale_ratio:float
@export var y_scale_ratio:float

# Runs every frame, scaling the board in real time
func _process(delta: float) -> void:
	# gets the size of the window as a vector2
	var window_size = get_viewport().get_visible_rect().size
	
	# determines whether the board scale should depend on the window width or height
	var new_scale = minf(window_size.y * y_scale_ratio, window_size.x * x_scale_ratio) *.01
	scale = Vector2(new_scale, new_scale)
