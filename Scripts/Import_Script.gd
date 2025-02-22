extends Node

var board_data = {}

var file_path = "res://Data/BoardData.json"

func _ready():
	board_data = import_json(file_path)
	for i in board_data:
		pass


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
	
	
