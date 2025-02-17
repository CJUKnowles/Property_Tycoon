extends Node2D

class_name Board

var head: Space = null 

func initialize():
	# put your board reading stuff here Conor!
	# Temporary board generation code: ----------------------------
	var go_space:Space = load("res://Scenes/Spaces/go_space.tscn").instantiate()
	add_child(go_space)
	addSpace(go_space)
	
	var property:Space = load("res://Scenes/Spaces/property_space.tscn").instantiate()
	add_child(property)
	addSpace(property)
	
	var jail_space:Space = load("res://Scenes/Spaces/jail_space.tscn").instantiate()
	add_child(jail_space)
	addSpace(jail_space)

	var free_parking:Space = load("res://Scenes/Spaces/free_parking_space.tscn").instantiate()
	add_child(free_parking)
	addSpace(free_parking)
	
	var go_to_jail:Space = load("res://Scenes/Spaces/go_to_jail_space.tscn").instantiate()
	add_child(go_to_jail)
	addSpace(go_to_jail)
	
	var opportunity_knocks:Space = load("res://Scenes/Spaces/opportunity_knocks_space.tscn").instantiate()
	add_child(opportunity_knocks)
	addSpace(opportunity_knocks)
	
	var pot_luck:Space = load("res://Scenes/Spaces/pot_luck_space.tscn").instantiate()
	add_child(pot_luck)
	addSpace(pot_luck)
	
	var station:Space = load("res://Scenes/Spaces/station_space.tscn").instantiate()
	add_child(station)
	addSpace(station)
	
	var tax:Space = load("res://Scenes/Spaces/tax_space.tscn").instantiate()
	add_child(tax)
	addSpace(tax)
	
	var utility:Space = load("res://Scenes/Spaces/utility_space.tscn").instantiate()
	add_child(utility)
	addSpace(utility)
	# -------------------------------------------------------------

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
		
