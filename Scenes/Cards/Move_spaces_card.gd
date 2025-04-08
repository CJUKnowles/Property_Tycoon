extends Card
class_name Move_spaces_card

## Move_spaces_card class
##
## This class inherits from the Card class. It contains the functionality for a specific
## kind of card where the player is moved a certain number of spaces.

var distance : int = 0

func on_draw():
	var player = gameManager.get_current_player()
	player.move(distance)
	return
