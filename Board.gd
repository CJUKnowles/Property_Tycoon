extends Resource

class_name Board

const head: Space = null

func addSpace(new_space: Space):
	var current = head
	while current.next != null:
		current = current.next 
		current.next = Space
