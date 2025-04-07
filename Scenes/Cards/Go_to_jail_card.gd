extends Card
class_name Go_to_jail_card

# Called when the node enters the scene tree for the first time.
func on_draw():
	gameManager.get_current_player().goToJail()
