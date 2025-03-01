extends Card

var value: int # payout amount
var target: String # target of payout
var bank: Bank

func on_draw():
	var player = gameManager.get_current_player()
	player.money += value
	if target == "Bank":
		bank.receive_payment(value)
	pass
