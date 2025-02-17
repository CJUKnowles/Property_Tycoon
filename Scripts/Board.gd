extends Node2D

class_name Board

var head: Space = null 

func initialize():
	# put your board reading stuff here Conor!
	# Temporary board generation code: ----------------------------
	createAndGetSpace("go_space")
	createAndGetSpace("property_space")
	createAndGetSpace("jail_space")
	createAndGetSpace("free_parking_space")
	createAndGetSpace("go_to_jail_space")
	createAndGetSpace("opportunity_knocks_space")
	createAndGetSpace("pot_luck_space")
	createAndGetSpace("station_space")
	createAndGetSpace("tax_space")
	createAndGetSpace("utility_space")
	# -------------------------------------------------------------

# Instantiates and returns a Space scene of the specified type
func createAndGetSpace(space_type: String):
	var newSpace:Space = load("res://Scenes/Spaces/" + space_type + ".tscn").instantiate()
	add_child(newSpace)
	addSpace(newSpace) 
	return newSpace

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
		
