extends Node
class_name Bankrupt

func canAfford(player: Player, debt: int):
	while not player.bankrupt:
		mortgageOrSell(player,debt)
	declareBankrupt(player)
	
		
func sell(player: Player, property: Property_Space):
	var value = 0
	if player.owned_spaces.has(property):
		if property.isMortgaged:
			value = property.price / 2
		else:
			value = property.price
		print("Selling " + property.name + " for £" + value)
		player.money += value
		player.owned_spaces.erase(property)
		property.landlord = null
	else:
		print("Invalid property selection or property not owned.")

func mortgage( property: Property_Space):
	if property.isMortgaged:
		print("This property has already been mortgaged")
	else:
		property.toggle_mortgage()

func enoughMoney(player: Player, debt: int):
	if player.money >= debt:
		print("You now have enough money to pay off your debts!")
		return true
	else:
		if player.owned_spaces.is_empty():
			player.bankrupt = true
		return false
	
func declareBankrupt(player: Player):
	print(player.playerName + " is bankrupt!")
	for property in player.owned_spaces:
		property.landlord = null
	player.owned_spaces.clear()
	player.queue_free()
	
func mortgageOrSell(player: Player, debt: int):
	while enoughMoney(player, debt) == false and player.bankrupt == false:
		print(":(")
		#TODO add buttons for sell + mortagae
	
