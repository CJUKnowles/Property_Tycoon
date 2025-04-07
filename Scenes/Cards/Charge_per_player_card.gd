extends Card
class_name Charge_per_player_card

var value : int = 0

# Called when the node enters the scene tree for the first time.
func on_draw():
	var player = gameManager.get_current_player()
	for i in range(gameManager.playerCount):
		var toGive = gameManager.players[i]
		if  toGive != player:
			toGive.charge(value)
			player.money += value
			
