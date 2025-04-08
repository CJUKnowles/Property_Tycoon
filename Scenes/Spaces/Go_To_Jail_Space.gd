extends Space
class_name Go_To_Jail_Space

func _ready():
	type = Space.SpaceType.GO_TO_JAIL
	super._ready()
	
func on_land():
	gameManager.get_current_player().collectFromGO = false
	gameManager.get_current_player().goToJail()
	print("This is a go to jail space! Child class")
