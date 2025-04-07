extends Card
class_name Payout_card

var value: int = 0 # payout amount
var payToParking: bool = true # target of payout
var bank: Bank
var freeParking: Free_Parking_Space

func on_draw():
	var player = gameManager.get_current_player()
	if value < 0:
		value = value * -1
		if payToParking:
			player.money -= value
			freeParking.money += value
		else:
			bank.receive_payment(player, value)
		
	else:
		bank.pay_player(player, value)
	pass
