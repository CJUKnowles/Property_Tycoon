extends Card
class_name Get_out_of_jail_free_card

var inDeck : bool = true
# Called when the node enters the scene tree for the first time.
func on_draw():
	var player = gameManager.get_current_player()
	inDeck = false
	player.getOutOfJailFreeCard = true
	
func use():
	var player = gameManager.get_current_player()
	if player.inJail == true:
		print("You have used your 'get out of jail free card' ! ")
		player.exitJail()
		player.getOutOfJailFreeCard = false
		inDeck = true
	else:
		print("You are not in Jail")
