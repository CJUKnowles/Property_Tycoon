extends Space
class_name Go_Space

var pass_value # amount of money given when you pass GO

func _ready():
	type = Space.SpaceType.GO
	
func on_land():
	print("This is a go space! Child class")
