extends Buyable_Space
class_name Utility_Space

var cost: int
var rent

func _ready():
	super._ready()
	type = Space.SpaceType.UTILITY

func on_land():
	var player = gameManager.get_current_player()
	var value = 0
	
	if bought: 
		if landlord != null and landlord != player:
			print("Landed on a Utility owned by ", landlord.name, ". Attempting to charge player: ")
			# player.charge(rent) # Charges rent if the player does 
			# 4 times the dice roll if 1 utility owned
			# 10 times the dice roll if 2 utilities owned
			player.charge(value)
			landlord += value

			var roll = player.rollResult[0] + player.rollResult[1]
			
			#checks how many utilities landlord owns
			var utilitiesOwned = 0
			for i in landlord.owned_spaces:
				if landlord.owned_spaces[i].type == Space.SpaceType.UTILITY:
					utilitiesOwned += 1
			
			if utilitiesOwned > 1:
				rent = 10 * roll
			else:
				rent = 4 * roll
			
			player.charge(rent) 
			
			landlord.money += value
	else:
		print("Landed on an unowned Utility. Attempting to purchase: ")
		purchase()
