extends Card
class_name Go_to_jail_card

## Go_to_jail_card class
##
## This class inherits from the Card class. It contains the functionality for a specific
## kind of card where the player is sent to jail.

# Called when the node enters the scene tree for the first time.
func on_draw():
	gameManager.get_current_player().goToJail()
