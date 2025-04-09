extends AnimationPlayer

##################################
# This class just exists to assign the default animation to the player pieces on the board
#################################
@export var animation:Animation

func _ready() -> void:
	current_animation = "soft_pulsate"
