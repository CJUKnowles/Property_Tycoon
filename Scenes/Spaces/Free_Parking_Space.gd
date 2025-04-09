extends Space
class_name Free_Parking_Space

@export var money = 0

func _ready():
	type = Space.SpaceType.FREE_PARKING
	super._ready()

# called when the player lands on this space
func on_land():
	gameManager.get_current_player().money +=money
	money = 0
