extends Space
class_name Opportunity_Knocks_Space

var deck : OpportunityKnocksDeck 

func _ready():
	type = Space.SpaceType.OPPORTUNITY_KNOCKS
	super._ready()
	
func on_land():
	deck.draw_card()
