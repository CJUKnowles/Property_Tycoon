extends Space
class_name Free_Parking_Space

@export var money = 0

func _ready():
	type = Space.SpaceType.FREE_PARKING
	super._ready()

func on_land():
	print("This is a free parking space! Child class")
