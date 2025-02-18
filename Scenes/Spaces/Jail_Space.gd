extends Space
class_name Jail_Space

func _ready():
	type = Space.SpaceType.JAIL
	print("JAIL IS BEING INITIALIZED HUZZAh")
	
func on_land():
	print("This is a jail space! Child class")
