extends Buyable_Space
class_name Station_Space

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
	else:
		print("Landed on an unowned Station. Attempting to purchase: ")
		purchase()
