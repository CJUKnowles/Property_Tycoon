extends Space
class_name Opportunity_Knocks_Space

var deck : OpportunityKnocksDeck 

func _ready():
	type = Space.SpaceType.OPPORTUNITY_KNOCKS
	super._ready()
	
func on_land():
	if deck != null:
		print("Drawing a card")
		deck.draw_card()
	else:
		print("ERROR: Deck is null. Skipping draw.")
