extends Node2D
class_name Die

static func roll():
	var die1 = randi_range(1,6)
	var die2 = randi_range(1,6)
	#code for visuals
	#return [2,2,4] #Doubles testing
	return [die1,die2,die1+die2]

#extends Node2D
#class_name Die
#
#static var dice_roll_display: DiceRollDisplay
#
#static func initialize(dice_display_instance: DiceRollDisplay):
	#dice_roll_display = dice_display_instance
#
#static func roll():
	## Show rolling animation
	#dice_roll_display.roll_dice()
	#
	## Wait a bit for animation
	#await dice_roll_display.get_tree().create_timer(1.0).timeout
	#
	## Get final values
	#var die1 = randi_range(1,6)
	#var die2 = randi_range(1,6)
	#
	## Show final faces
	#dice_roll_display.show_final_values([die1, die2])
	#
	## Wait a moment before returning
	#await dice_roll_display.get_tree().create_timer(0.5).timeout
	#
	#return [die1, die2, die1+die2]
