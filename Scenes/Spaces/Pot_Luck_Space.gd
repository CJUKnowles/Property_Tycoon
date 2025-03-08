extends Space
class_name Pot_Luck_Space

var deck : PotLuckDeck

func _ready():
	type = Space.SpaceType.POT_LUCK
	super._ready()
	
func on_land():
	deck.draw_card()
