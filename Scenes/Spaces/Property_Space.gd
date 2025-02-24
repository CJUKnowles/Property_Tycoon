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
		purchase(player)

func toggle_mortgage():
	if isMortgaged:
		pass
	else:
		isMortgaged = true
		owner.pay(price/2)

# Makes the given player attempt to purchase this property. Should maybe be moved to Player class, generalize for all property spaces
func purchase(player: Player):
	var propertyPurchased = player.charge(price)
	if propertyPurchased:
		print("Charge successful! Bought ", self.name)
		landlord = player
		bought = true
	else:
		pass
