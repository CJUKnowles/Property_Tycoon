extends Node
class_name Deck

#array containing Card objects
var deck = [Card]
var pointer = 0

var cardData_path:String
var gameManager:GameManager

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
	

func initialize():
	# Import external card data into deck objects
	var card_dict = {}
	card_dict = import_json(cardData_path)
	for i in card_dict:
		# Create and reference cards from the dictionary as cards in the deck
		var new_card:Card = createAndGetCard(card_dict[i]["card_type"])
		# Create blank default card in case of undefined card_type
		if new_card == null:
			return createAndGetCard("card")
		else:
			# Import card data from dictionary
			new_card.description = card_dict[i]["description"]
			new_card.gameManager = gameManager
			if card_dict[i]["card_type"] == "payout_card":
				new_card.value = card_dict[i]["value"]
				new_card.payToParking = card_dict[i]["pay_to_parking"]
				new_card.freeParking = gameManager.board.freeParking
			elif card_dict[i]["card_type"] == "move_player_card":
				new_card.target = card_dict[i]["target"]
				new_card.passGo = card_dict[i]["pass_go"]
			elif card_dict[i]["card_type"] == "move_spaces_card":
				new_card.distance = card_dict[i]["distance"]
			elif card_dict[i]["card_type"] == "draw_or_pay_card":
				new_card.value = card_dict[i]["value"]
				new_card.payToParking = card_dict[i]["pay_to_parking"]
				new_card.deck_name = card_dict[i]["card_list"]
			elif card_dict[i]["card_type"] == "charge_per_building_card":
				new_card.houseVal = card_dict[i]["cost_per_house"]
				new_card.hotelVal = card_dict[i]["cost_per_hotel"]
			elif card_dict[i]["card_type"] == "charge_per_player_card":
				new_card.value = card_dict[i]["value"]
			
	
# Instantiates and returns a Card scene of the specified type
func createAndGetCard(card_type: String):
	var path = "res://Scenes/Cards/" + card_type + ".tscn"
	if FileAccess.file_exists(path):
		var newCard:Card = load(path).instantiate()
		add_child(newCard)
		deck.append(newCard)
		return newCard
	else:
		return null

func import_json(path: String):
	if FileAccess.file_exists(path):
		var dataFile = FileAccess.open(path, FileAccess.READ)
		var parsedFile = JSON.parse_string(dataFile.get_as_text())
		
		if parsedFile is Dictionary:
			return parsedFile
		else:
			print("Error reading file")
	else:
		print("File doesn't exist")
