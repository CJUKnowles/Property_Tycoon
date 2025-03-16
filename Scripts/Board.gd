extends Node2D

class_name Board

var head: Space = null 
var board_data_path = "res://Data/BoardData.json"
var potluck_path = "res://Data/PotLuckCards.json"
var oppknocks_path = "res://Data/OpportunityKnocksCards.json"
var gameManager:GameManager
var potLuckPile:Deck = null
var oppKnocksPile:Deck = null
var freeParking:Free_Parking_Space



var SPACE_OFFSET = 450
var SPACE_EXTRA_OFFSET = 160

func initialize():
	var j = 0
	# Import external BoardData.json as a dictionary
	var tile_dict = {}
	tile_dict = import_json(board_data_path)
	for i in tile_dict:
		j += 1
		# Create and reference tiles from dictionary as tiles on the board
		var new_space:Space = createAndGetSpace(tile_dict[i]["tile_type"])
		# Create blank default space in case of undefined tile_type
		if new_space == null:
			createAndGetSpace("space")
		else:
			# Import data from dictionary depending on tile_type
			new_space.name = tile_dict[i]["tile_name"]
			new_space.gameManager = gameManager
			if tile_dict[i]["tile_type"] == "go_space":
				new_space.pass_value = int(tile_dict[i]["value"])
			elif tile_dict[i]["tile_type"] == "property_space":
				new_space.rent = int(tile_dict[i]["value"])
				new_space.rent_prices.append(int(tile_dict[i]["rent_up1"]))
				new_space.rent_prices.append(int(tile_dict[i]["rent_up2"]))
				new_space.rent_prices.append(int(tile_dict[i]["rent_up3"]))
				new_space.rent_prices.append(int(tile_dict[i]["rent_up4"]))
				new_space.rent_prices.append(int(tile_dict[i]["rent_final"]))
				new_space.price = int(tile_dict[i]["cost"])
				new_space.colorGroup = tile_dict[i]["tile_group"]
			elif tile_dict[i]["tile_type"] == "tax_space":
				new_space.amount = int(tile_dict[i]["value"])
			elif tile_dict[i]["tile_type"] == "station_space":
				new_space.price = int(tile_dict[i]["cost"])
			elif tile_dict[i]["tile_type"] == "utility_space":
				new_space.price = int(tile_dict[i]["cost"])
			elif tile_dict[i]["tile_type"] == "free_parking_space":
				freeParking = new_space
			var length = tile_dict.size()
			var oneside = length/4
			print("J: ", j)
			
			var current_offset = SPACE_OFFSET
			
			if j ==1 or j ==11 or j==21 or j ==31:
				current_offset += SPACE_EXTRA_OFFSET
			if j ==2 or j ==12 or j==22 or j ==32:
				current_offset += SPACE_EXTRA_OFFSET
			
			if j <= 11:
				new_space.position = new_space.previous.position + Vector2(-current_offset, 0)
			elif j <= 21:
				new_space.position = new_space.previous.position + Vector2(0, -current_offset)
			elif j <= 31:
				new_space.position = new_space.previous.position + Vector2(current_offset, 0)
			elif j <= 41:
				new_space.position = new_space.previous.position + Vector2(0, current_offset)
			if j<=10:
				new_space.rotation = deg_to_rad(0)
			elif j<=20:
				new_space.rotation = deg_to_rad(90)
			elif j<=30:
				new_space.rotation = deg_to_rad(180)
			elif j<=40:
				new_space.rotation = deg_to_rad(270)

# Instantiates and returns a Space scene of the specified type
func createAndGetSpace(space_type: String):
	var path = "res://Scenes/Spaces/" + space_type + ".tscn"
	if FileAccess.file_exists(path):
		var newSpace:Space = load(path).instantiate()
		add_child(newSpace)
		addSpace(newSpace) 
		return newSpace
	else:
		return null

func addSpace(new_space: Space):
	if head == null:
		head = new_space
		head.next = head
	else:
		var current = head
		while current.next != head:
			current = current.next 
		current.next = new_space
		new_space.previous = current
		new_space.next = head
		head.previous = new_space

func findSpace(toFind: String):
	var found: bool = false
	var target : Space = head
	while not found :
		if target.name == toFind:
			found = true
		else:
			# print(target)
			target = target.next
	return target

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
		
