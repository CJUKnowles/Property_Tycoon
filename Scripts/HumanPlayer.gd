extends Player
class_name HumanPlayer

func takeTurn():
	#var player = gameManager.get_current_player()
	#player.move(5)
	
#var target : String =   "Go"# space the player is moving to
	#var player = gameManager.get_current_player()
	#var target_space = gameManager.board.findSpace(target)
	#player.moveTo(target_space)

	


	if bankrupt:
		print("skipping turn, player is bankrupt")
		return
	if inJail:
		print(name, " is in jail.")
		print("Rolling to get out of jail.....")
		rollResult = Die.roll()
		var die1 = rollResult[0]
		var die2 = rollResult[1]
		print("Dice 1: ",die1,", Dice 2: ", die2)
		if die1 == die2:
			print("Rolled doubles! you can leave jail")
			exitJail()
		else:
			print("Uh oh! you can't leave yet")
			jailTurns += 1
			print("jail time: ", str(jailTurns), "/2")
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
