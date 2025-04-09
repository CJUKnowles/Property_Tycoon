extends Node2D
class_name Die

static func roll():
	var die1 = randi_range(1,6)
	var die2 = randi_range(1,6)
	#code for visuals
	#return [2,2,4] #Doubles testing
	return [die1,die2,die1+die2]
