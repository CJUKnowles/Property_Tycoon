extends Space
class_name Go_To_Jail_Space

func _ready():
	type = Space.SpaceType.GO_TO_JAIL
	
func on_land():
	print("This is a go to jail space! Child class")
