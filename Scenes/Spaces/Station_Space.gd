extends Buyable_Space
class_name Station_Space

var charge = 0

func _ready():
	type = Space.SpaceType.UTILITY
	super._ready()

func on_land():
	var player = gameManager.get_current_player()
	if bought: 
		if landlord != null and landlord != player:
			print("Landed on a station owned by ", landlord.name, ". Attempting to charge player: ")
			# player.charge(rent) # Charges rent if the player does 
			# Charge 25, 50, 100, 200 based on number of stations owned
			if charge > player.money:
				var debt = charge - player.money
				player.cantAfford(debt)
	else:
		print("Landed on an unowned Station. Attempting to purchase: ")
		purchase()
