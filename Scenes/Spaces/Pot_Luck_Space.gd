extends Space
class_name Pot_Luck_Space

var deck : Deck

func _ready():
	type = Space.SpaceType.POT_LUCK
	super._ready()
	
# called when the player lands on this space
func on_land():
	if deck != null:
		print("Drawing a card")
		deck.draw_card()
	else:
		print("ERROR: Deck is null. Skipping draw.")
