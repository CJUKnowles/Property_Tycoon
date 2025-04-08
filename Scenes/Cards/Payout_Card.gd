extends Card
class_name Payout_card

var value: int = 0 # payout amount
var payToParking: bool = true # target of payout
var freeParking : Free_Parking_Space 

func on_draw():
	freeParking = gameManager.board.findSpace("Free Parking")
	var player = gameManager.get_current_player()
	if value < 0:
		value = value * -1
		if payToParking:
			player.money -= value
			freeParking.money += value
		else:
			player.charge(value)
		
	else:
		player.money += value
	pass
