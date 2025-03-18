extends Space
class_name Jail_Space

func _ready():
	type = Space.SpaceType.JAIL
	super._ready()
	
func on_land():
	print("This is a jail space! Child class")
