extends Node2D

class_name Board

var head: Space = null 

var tile_dict = {}
var file_path = "res://Data/BoardData.json"
var gameManager:GameManager

func initialize():
	# Import external BoardData.json as a dictionary
	tile_dict = import_json(file_path)
	for i in tile_dict:
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
				new_space.cost = int(tile_dict[i]["cost"])
			elif tile_dict[i]["tile_type"] == "utility_space":
				new_space.cost = int(tile_dict[i]["cost"])

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
		new_space.next = head

func findSpace(toFind: String):
	var found: bool = false
	var target : Space = head
	while not found :
		if target.name == toFind:
			found = true
		else:
			print(target)
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
