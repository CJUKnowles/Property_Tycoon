extends Player
class_name AIPlayer

@export var roll_delay:float # time delay in seconds between each roll
@export var turn_delay:float # time delay in seconds before releasing control to the next player
@export var instant_turns_DEBUG:bool = false

func start_turn():
	if instant_turns_DEBUG:
		roll_delay = 0
		turn_delay = 0
	
	while(!turn_over):
		await get_tree().create_timer(roll_delay).timeout
		gameManager.take_current_turn()
	await get_tree().create_timer(turn_delay).timeout
	gameManager.end_turn()

func takeTurn():
	if bankrupt:
		print("skipping turn, player is bankrupt")
		return
	if inJail:
		print(name, " is in jail.")
		print("jail time: ", str(jailTurns), "/2")
		jailTurns += 1
		if jailTurns > 2:  # Misses two turns, then gets released
			exitJail()
	if turn_over:
		print(name + " is out of rolls.")
		return
	if !inJail:
		print("jail: ",inJail)
		rollResult = Die.roll()
		var die1 = rollResult[0]
		var die2 = rollResult[1]
		var total = rollResult[2]
		print("die1: ",die1,", die2: ",die2,", total: ",total)
		
		if die1 == die2: # We rolled a double
			doubleCount += 1
			print(name, " rolled a double and gets another turn!")
			if doubleCount == 3:
				doubleCount = 0 #reset count
				print(name, " rolled three doubles and has to go to jail!")
				goToJail()
			else: 
				move(total)
		else: # We did not roll a double
			move(total)
			doubleCount = 0 #reset count
