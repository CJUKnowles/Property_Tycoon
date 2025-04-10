extends Card
class_name Draw_or_pay_card

## Draw_or_pay_card class
##
## This class inherits from the Card class. It contains the functionality for a specific
## kind of card where the player is forces to either draw a card from the a deck or pay
## a fine.

var value : int = 0
var payToParking: bool = true
var freeParking : Free_Parking_Space
var deck_name

var potLuckDeck: Deck
var opportunityKnocksDeck: Deck

func fine():
	freeParking = gameManager.board.findSpace("Free Parking")
	var player = gameManager.get_current_player()
	
	# if player chooses fine, charge them
	if payToParking:
		player.charge(value)
		freeParking.money += value
	else:
		player.charge(value)

func getMoney():
	var player = gameManager.get_current_player()
	player+= value
	
func drawCard():
	# retrieves name of deck to be drawn from and draws from it
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
	for i in range(gameManager.player_count):
		var toGive = gameManager.players[i]
		if  toGive != player:
			toGive.charge(value)
			player.money += value
