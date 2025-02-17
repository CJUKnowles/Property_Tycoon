extends Space
class_name Free_Parking_Space

@export var rent: int
@export var colorGroup: String
@export var houses: int = 0
@export var hotel: bool = false
@export var isMortgaged: bool = false

func _ready():
	type = Space.SpaceType.FREE_PARKING

func on_land():
	print("This is a free parking space! Child class")
