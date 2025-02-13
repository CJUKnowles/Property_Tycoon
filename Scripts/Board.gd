extends Resource

class_name Board

var head: Space = null 

func initialize():
	# put your board reading stuff here Conor!
	# Temporary board generation code: ----------------------------
	var go = Space.new()
	go.type = Space.SpaceType.GO 
	go.name = "GO"
	
	var prop1 = Property.new()
	prop1.name = "brighton"
	
	var property1 = Space.new()
	property1.type = Space.SpaceType.PROPERTY
	property1.name = "PROPERTY 1" 
	property1.property = prop1
	
	addSpace(go)
	addSpace(property1)
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
