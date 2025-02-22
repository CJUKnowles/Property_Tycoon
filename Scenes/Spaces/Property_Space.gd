extends Space
class_name Property_Space

var rent: int
var price: int
var rent_prices:Array[int];
var colorGroup: String
var houses: int = 0
var hotel: bool = false
var isMortgaged: bool = false


func on_land():
	print("Landed on a property! Attempting to charge player:")
	# TODO: change rent price based on houses owned
	gameManager.get_current_player().charge(rent)
