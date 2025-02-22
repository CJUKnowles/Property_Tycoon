extends Space
class_name Property_Space

var rent: int
var price: int
var rent_prices:Array[int];
var colorGroup: String
var houses: int = 0
var hotel: bool = false
var isMortgaged: bool = false
var landlord: Player

func on_land():
	var player = gameManager.get_current_player()
	
	if bought: 
		if landlord != null and landlord != player:
			print("Landed on a space owned by ", landlord.name, ". Attempting to charge rent: ")
			player.charge(rent) # Charges rent if the player does 
	else:
		print("Landed on an unowned property. Attempting to purchase: ")
		var propertyPurchased = player.charge(price)
		if propertyPurchased:
			print("Charge successful! Bought ", self.name)
			landlord = player
			bought = true
		else:
			pass
