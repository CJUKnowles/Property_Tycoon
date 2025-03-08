extends Card
class_name Go_to_jail_card

var player = gameManager.get_current_player()
var inDeck : bool = true
# Called when the node enters the scene tree for the first time.
func on_draw():
	player.getOutOfJailFreeCard = true
	inDeck = false
	
func use():
	if player.inJail == true:
		print("You have used your 'get out of jail free card' ! ")
		player.exitJail()
		player.getOutOfJailFreeCard = false
		inDeck = true
	else:
		print("You are not in Jail")
