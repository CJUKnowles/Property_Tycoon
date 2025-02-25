extends Space
class_name Opportunity_Knocks_Space

func _ready():
	type = Space.SpaceType.OPPORTUNITY_KNOCKS
	super._ready()
	
func on_land():
	print("This is an opportunity knocks space! Child class")
