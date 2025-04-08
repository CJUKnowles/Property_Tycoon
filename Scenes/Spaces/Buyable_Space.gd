extends Space
class_name Buyable_Space

var price: int
var landlord: Player
var bought: bool = false
var isMortgaged: bool = false
@onready var disabled_overlay:Sprite2D = $disabled_space_overlay

# Makes the given player attempt to purchase this property. Should maybe be moved to Player class, generalize for all property spaces
func purchase():
	var player = gameManager.get_current_player()
	if player.money >= price:
		var propertyPurchased = player.charge(price)
		print("Charge successful! Bought ", self.name)
		landlord = player
		bought = true
		player.owned_spaces.append(self)
	
	else:
		print("Couldn't afford to buy the property. Moving on.")
		pass
		
func on_land():
	if !bought:
		if gameManager.get_current_player() is AIPlayer:
			purchase()
		else:
			print("Player landed on a buyable space! Autopurchasing for now - add a popup here")
			purchase()
		
func sell():
	if landlord == null:
		print(name + " must be owned to be sold!")
		return
		
	var sell_value = price
	if isMortgaged:
		sell_value = price/2
	else:
		sell_value = price
	print("Selling " + name + " for £" + str(sell_value))
	landlord.money += sell_value
	landlord.owned_spaces.erase(self)
	landlord.enoughMoney()
	landlord = null
	
		
func toggle_mortgage():
	if landlord == null:
		print(name + " needs an owner to be mortgaged!")
		return
	
	if isMortgaged:
		var mortgagePaid = landlord.charge(price/2)
		if mortgagePaid:
			isMortgaged = false
			print(name + " is no longer mortgaged!")
		else:
			print(landlord.name + " could not afford to mortgage " + self.name + "!")
	else:
		isMortgaged = true
		landlord.pay(price/2)
		print(name + " was mortgaged!")	
		landlord.enoughMoney()
	disabled_overlay.visible = isMortgaged
	
func set_landlord(Player):
	landlord = Player
