extends Card
class_name Draw_or_pay_card

var value : int
var payToParking: bool
var bank : Bank
var parking : Free_Parking_Space
var player = gameManager.get_current_player()

func fine():
	if payToParking:
		parking.money += value
		player.money -= value
	else:
		bank.receive_payment(player,value)

func getMoney():
	bank.pay_player(player,value)
	
func drawOppotunityCard():
	OpportunityCardDeck.draw()
	
func drawLuckCard():
	PotLuckCardDeck.draw()
	
	



# Called when the node enters the scene tree for the first time.
func on_draw():
	var player = gameManager.get_current_player()
	for i in range(numOfPlayers):
		var toGive = gameManager.players[i]
		if  toGive != player:
			toGive.money -= value
			player.money += value
