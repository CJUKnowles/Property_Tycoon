extends Buyable_Space
class_name Station_Space

var charge = 0

func _ready():
	type = Space.SpaceType.UTILITY
	super._ready()

# called when the player lands on this space
func on_land():
	var player = gameManager.get_current_player()
	var value = 0
	if bought: 
		if landlord != null and landlord != player:
			print("Landed on a station owned by ", landlord.name, ". Attempting to charge player: ")
			
			#var stationsOwned = 0
			value = 25
			for i in landlord.owned_spaces:
				if i.type == Space.SpaceType.STATION:
					#stationsOwned += 1
					if value == 200:
						return
					value = value * 2
			
			#if stationsOwned == 1:
				#value = 25
			#elif stationsOwned == 2:
				#value = 50
			#elif stationsOwned == 3:
				#value = 100 
			#else:
				#value = 200
				
			# Charge 25, 50, 100, 200 based on number of stations owned
			player.charge(value)
			landlord.money += value
	else:
		print("Landed on an unowned Station. Attempting to purchase: ")
		super()
