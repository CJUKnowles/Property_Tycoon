extends Card
class_name Charge_per_building_card

## Charge_per_building_card class
##
## This class inherits from the Card class. It contains the functionality for a specific
## kind of card where the player is charged a certain amount based on how many buildings
## they own.

# default values, overriden when card is initialised
var houseVal: int = 0
var hotelVal: int  = 0

# Called when the node enters the scene tree for the first time.
func on_draw():
	#search through player's properties and add to their total charge for each building they own
	var player = gameManager.get_current_player()
	var toPay = 0
	for property in player.owned_spaces:
		if property is Property_Space:
			toPay = property.houses * houseVal
			if property.hotel:
				toPay += hotelVal
	
	player.charge(toPay)
