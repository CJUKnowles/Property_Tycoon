extends Space
class_name Jail_Space

@export var rent: int
@export var colorGroup: String
@export var houses: int = 0
@export var hotel: bool = false
@export var isMortgaged: bool = false

func _ready():
	type = Space.SpaceType.JAIL
	print("JAIL IS BEING INITIALIZED HUZZAh")
	
func on_land():
	print("This is a jail space! Child class")
