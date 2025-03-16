extends Card
class_name Go_to_jail_card

var player = gameManager.get_current_player()

# Called when the node enters the scene tree for the first time.
func on_draw():
	player.goToJail()
