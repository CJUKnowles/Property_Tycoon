extends Node
class_name Deck

#array containing Card objects
var deck = []
var pointer = 0

var jailCard : Get_out_of_jail_free_card

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func draw_card() -> Card:
	if deck[pointer] == jailCard and !jailCard.inDeck:
		if pointer == deck.length() - 1:
			pointer = 0
		pointer += 1
	var drawn = deck[pointer]
	if pointer == deck.length() - 1:
			pointer = 0
	pointer += 1
	return drawn
	
