extends Player
class_name AIPlayer
###############################################################################
# This class represents an AI controlled player. By overriding the start_turn()
# and takeTurn() methods, this class is able to alter and automate the behaviour
# of the player. It does not currently support all features - some situations may
# cause the game to hang until support is added here. Any new features involving
# the player will need to be supported here.
###############################################################################

@export var roll_delay:float # time delay in seconds between each roll
@export var turn_delay:float # time delay in seconds before releasing control to the next player
@export var instant_turns_DEBUG:bool = false

# the bulk of the AI - repeatedly tells the game manager to take the current
# turn on a time delay. This results in takeTurn() getting called 1-3 times per 
# player turn.
func start_turn():
	if instant_turns_DEBUG:
		roll_delay = 0
		turn_delay = 0
	
	while(!turn_over):
		await get_tree().create_timer(roll_delay).timeout
		gameManager.take_current_turn()
	await get_tree().create_timer(turn_delay).timeout
	gameManager.end_turn()

# attempts to roll the dice and take a turn. Perhaps rollDice() would have been
# a better name, as a single turn can encompass up to 3 calls of this method if 
# doubles are rolled consecutively. This method is usually called by gameManager
# when the player clicks "roll dice" or the AI player decides to move.
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
		print("start money: " , money)
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
		print("end money: " , money)
