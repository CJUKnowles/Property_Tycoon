extends Card
class_name Payout_card

var value: int # payout amount
var PayFreeParking: bool # target of payout
var bank: Bank
var freeParking: Free_Parking_Space

func on_draw():
	var player = gameManager.get_current_player()
	if value < 0:
		value = value * -1
		if value > player.money:
			var debt = value - player.money
			player.cantAfford(debt)
		if PayFreeParking:
			player.money -= value
			freeParking.money += value
		else:
			bank.receive_payment(player, value)
		
	else:
		bank.pay_player(player, value)
	pass
