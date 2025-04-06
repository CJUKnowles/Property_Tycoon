extends Card
class_name Charge_per_building_card

var houseVal: int = 0
var hotelVal: int  = 0
var bank : Bank



# Called when the node enters the scene tree for the first time.
func on_draw():
	var player = gameManager.get_current_player()
	var toPay = 0
	for property in player.owned_spaces:
		toPay = property.houses * houseVal
		if property.hotel:
			toPay += hotelVal
	
	bank.receive_payment(player,toPay)
