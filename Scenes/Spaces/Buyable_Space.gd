extends Space
class_name Buyable_Space

var price: int
var landlord: Player
var bought: bool = false

# Makes the given player attempt to purchase this property. Should maybe be moved to Player class, generalize for all property spaces
func purchase():
	var player = gameManager.get_current_player()
	var propertyPurchased = player.charge(price)
	if propertyPurchased:
		print("Charge successful! Bought ", self.name)
		landlord = player
		bought = true
		player.owned_spaces.append(self)
	else:
		print("Couldn't afford to buy the property. Moving on.")
		pass
