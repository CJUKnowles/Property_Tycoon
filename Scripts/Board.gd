extends Node2D

class_name Board

var head: Space = null 

func initialize():
	# put your board reading stuff here Conor!
	# Temporary board generation code: ----------------------------
	var go:Space = Go_Space.new()
	addSpace(go)
	
	var property1:Space = Property_Space.new()
	addSpace(property1)
	
	var jail_space:Space = load("res://Scenes/Spaces/Jail_Space.tscn").instantiate()
	add_child(jail_space)
	addSpace(jail_space)
	
	var free_parking:Space = Free_Parking_Space.new()
	addSpace(free_parking)
	
	var go_to_jail:Space = Go_To_Jail_Space.new()
	addSpace(go_to_jail)
	
	var opportunity_knocks:Space = Opportunity_Knocks_Space.new()
	addSpace(opportunity_knocks)
	
	var pot_luck:Space = Pot_Luck_Space.new()
	addSpace(pot_luck)
	
	var station:Space = Station_Space.new()
	addSpace(station)
	
	var tax:Space = Tax_Space.new()
	addSpace(tax)
	
	var utility:Space = Utility_Space.new()
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
		
