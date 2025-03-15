extends Buyable_Space
class_name Property_Space

var rent: int
var rent_prices:Array[int]
var colorGroup: String
var housePrice: int = 50
var houses: int = 0
var hotel: bool = false
var isMortgaged: bool = false

func _ready():
	super._ready()
	type = Space.SpaceType.PROPERTY

func on_land():
	var player = gameManager.get_current_player()
	
	if bought: 
		if !isMortgaged and landlord != null and landlord != player:
			print("Landed on a property owned by ", landlord.name, ". Attempting to charge rent: ")
			player.charge(rent) # Charges rent if the player does 
	else:
		print("Landed on an unowned property. Attempting to purchase: ")
		purchase()

func toggle_mortgage():
	if isMortgaged:
		var mortgagePaid = gameManager.get_current_player().charge(price/2)
		if mortgagePaid:
			isMortgaged = false
			
	else:
		isMortgaged = true
		landlord.pay(price/2)


func buy_house():
	if houses < 5:
		var purchased_house = landlord.charge(housePrice)
		if(purchased_house):
			houses += 1
			if houses == 5:
				print("Hotel Purchased!")
			else:
				print("House purchased!")
		else:
			print("Could not afford to purchase house!")
		
