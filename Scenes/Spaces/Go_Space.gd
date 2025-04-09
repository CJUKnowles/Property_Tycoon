extends Space
class_name Go_Space

var pass_value # amount of money given when you pass GO

func _ready():
	super._ready()
	type = Space.SpaceType.GO

# called when the player lands on this space
func on_land():
	print("This is a go space! Child class")
