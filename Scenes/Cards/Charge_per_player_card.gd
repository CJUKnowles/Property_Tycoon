extends Card
class_name Charge_per_player_card

## Charge_per_player_card class
##
## This class inherits from the Card class. It contains the functionality for a specific
## kind of card where the player is paid a certain amount of money by all the other
## players.

var value : int = 0

# Called when the node enters the scene tree for the first time.
func on_draw():
	# loop through player list and charge each player for the amount, pay player
	var player = gameManager.get_current_player()
	for i in range(gameManager.player_count):
		var toGive = gameManager.players[i]
		if  toGive != player:
			toGive.charge(value)
			player.money += value
			
