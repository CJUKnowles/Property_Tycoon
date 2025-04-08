extends Buyable_Space
class_name Property_Space

var rent: int
var rent_prices:Array[int]
var colorGroup: String
var housePrice: int = 50
var houses: int = 0
var hotel: bool = false

var color_dict = {	"Brown": 	Color(.5,.4,.2,1),
					"Blue": 	Color(.8,.9,1,1),
					"Purple": 	Color(1,0,1,1),
					"Orange": 	Color(.9,.6,.3,1),
					"Red": 		Color(1,0,0,1),
					"Yellow": 	Color(1,1,0,1),
					"Green": 	Color(.1,.8, .3,1),
					"Indigo": 	Color(0,.5,.7,1),
					"BLACK":	Color(0,0,0,1)}

@export var color_header:Sprite2D

func _ready():
	super._ready()
	type = Space.SpaceType.PROPERTY

func on_land():
	super()
	var player = gameManager.get_current_player()
	
	if bought: 
		if !isMortgaged and landlord != null and landlord != player:
			print("Landed on a property owned by ", landlord.name, ". Attempting to charge rent: ")
			player.charge(rent) # Charges rent if the player does 

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
		
func set_color(color:String):
	colorGroup = color
	print("Color: " + str(color_header.modulate))
	
	if color_dict.has(color):
		color_header.modulate = color_dict[color]
	else:
		color_header.modulate = color_dict["BLACK"]
		
func get_color():
	return color_dict[colorGroup]
