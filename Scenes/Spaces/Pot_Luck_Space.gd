extends Space
class_name Pot_Luck_Space

var deck : PotLuckDeck

func _ready():
	type = Space.SpaceType.POT_LUCK
	super._ready()
	
func on_land():
	if deck != null:
		print("Drawing a card")
		deck.draw_card()
	else:
		print("ERROR: Deck is null. Skipping draw.")
