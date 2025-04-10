extends Card
class_name Get_out_of_jail_free_card

## Get_out_of_jail_free_card class
##
## This class inherits from the Card class. It contains the functionality for a specific
## kind of card that when drawn can be stored in the player's inventory to be used to 
## get out of jail when needed.

var inDeck : bool = true
# Called when the node enters the scene tree for the first time.
func on_draw():
	var player = gameManager.get_current_player()
	inDeck = false # to ensure card isn't able to be drawn again
	player.getOutOfJailFreeCard = self
	
func use():
	var player = gameManager.get_current_player()
	if player.inJail == true:
		print("You have used your 'get out of jail free card' ! ")
		player.exitJail()
		player.getOutOfJailFreeCard = null
		inDeck = true
	else:
		print("You are not in Jail")
