extends Space
class_name Tax_Space

var amount: int

func _ready():
	super._ready()
	type = Space.SpaceType.TAX
	
# called when the player lands on this space
func on_land():
	print("Landed on a tax space")
	gameManager.get_current_player().charge(amount)
