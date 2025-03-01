extends Card

var value: int # payout amount
var target: String # target of payout
var bank: Bank
var freeParking: Free_Parking_Space

func on_draw():
	var player = gameManager.get_current_player()
	if value < 0:
		value = value * -1
		if target == "Bank":
			bank.receive_payment(player, value)
		elif target == "Free Parking":
			player.money -= value
			freeParking.money += value
	else:
		if target == "Bank":
			bank.pay_player(player, value)
	pass
