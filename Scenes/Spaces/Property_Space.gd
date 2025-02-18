extends Space
class_name Property_Space

var rent: int
var price: int
var rent_prices:Array[Player] = [];
var colorGroup: String
var houses: int = 0
var hotel: bool = false
var isMortgaged: bool = false


func on_land():
	print("This is a property space! Child class")
