extends Card

var player = gameManager.get_current_player()
# Called when the node enters the scene tree for the first time.
func on_draw():
	#TODO remove from list
	player.getOutOfJailFreeCard = true
	
func use():
	if player.inJail == true:
		print("You have used your 'get out of jail free card' ! ")
		player.exitJail()
		player.getOutOfJailFreeCard = false
		#TODO add back to list
	else:
		print("You are not in Jail")
