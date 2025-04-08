extends Card
class_name Draw_or_pay_card

var value : int = 0
var payToParking: bool = true
var parking : Free_Parking_Space
var deck_name

var potLuckDeck: Deck
var opportunityKnocksDeck: Deck

func fine():
	var player = gameManager.get_current_player()
			
	if payToParking:
		player.money -= value
		parking.money += value
	else:
		player.charge(value)

func getMoney():
	var player = gameManager.get_current_player()
	player+= value
	
func drawCard():
	var deck = null
	match deck_name:
		"POT_LUCK":
			deck = potLuckDeck
		"OPPORTUNITY_KNOCK":
			deck = opportunityKnocksDeck
		_:
			print("Error: Unknown deck name - " + deck_name)
	if deck != null:
		deck.draw_card()

# Called when the node enters the scene tree for the first time.
func on_draw():
	var player = gameManager.get_current_player()
	for i in range(gameManager.numOfPlayers):
		var toGive = gameManager.players[i]
		if  toGive != player:
			toGive.charge(value)
			player.money += value
