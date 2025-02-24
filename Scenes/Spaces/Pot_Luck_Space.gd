extends Space
class_name Pot_Luck_Space

func _ready():
	type = Space.SpaceType.POT_LUCK
	
func on_land():
	print("This is a pot luck space! Child class")
