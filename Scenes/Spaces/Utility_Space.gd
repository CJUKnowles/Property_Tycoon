extends Buyable_Space
class_name Utility_Space

var cost: int


func _ready():
	super._ready()
	type = Space.SpaceType.UTILITY

func on_land():
	var player = gameManager.get_current_player()
	var charge = 0
	if bought: 
		if landlord != null and landlord != player:
			print("Landed on a Utility owned by ", landlord.name, ". Attempting to charge player: ")
			# player.charge(rent) # Charges rent if the player does 
			# 4 times the dice roll if 1 utility owned
			# 10 times the dice roll if 2 utilities owned
			if charge > player.money:
				var debt = charge - player.money
				player.cantAfford(debt)
	else:
		print("Landed on an unowned Utility. Attempting to purchase: ")
		purchase()
