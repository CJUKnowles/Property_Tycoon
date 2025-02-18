extends Node2D
class_name Player

@export var playerName: String
@export var money: int = 1500
@export var currentSpace: Space= null
@export var doubleCount: int=0
@export var inJail: bool=false
@export var jailTurns: int = 0
var gameManager

func _ready():
	print("Player is being setup!")

func move(toMove: int):
	if currentSpace == null:
		currentSpace = gameManager.board.head
	else:
		currentSpace.playersOnSpace.erase(self) #removes player from current position
		for i in range(toMove):
			if currentSpace.next:
				currentSpace = currentSpace.next
	
	currentSpace.playersOnSpace.append(self)
	currentSpace.on_land()
	
func moveTo(target: Space):
	while currentSpace != target:
		if currentSpace.next == null: 
			print("Error: Target space not found.")
			return
		currentSpace = currentSpace.next

func goToJail():
	inJail = true
	var jail = gameManager.board.findSpace("Jail")
	moveTo(jail)
	print(playerName, " was sent to jail!")
	
func exitJail():
	inJail = false
	jailTurns = 0
	print(playerName + " has been moved to 'Just Visiting'")
	
func payBail():
	if money >= 50:
		money -= 50
		print(playerName + " paid £50 to leave jail. The money goes to Free Parking.")
		exitJail()
	else:
		print(playerName + " cannot afford to pay to leave jail!")
		print(playerName + " stays in jail and loses this turn. (" + str(jailTurns) + "/2)")
		
	
func stayInJail():
	print(playerName + " stays in jail and loses this turn. (" + str(jailTurns) + "/2)")

	
func takeTurn():
	if inJail:
		print(playerName, " is in jail.")
		print("jail time: ", str(jailTurns), "/2")
		jailTurns += 1
		if jailTurns > 2:  # Misses two turns, then gets released
			exitJail()
	
	if !inJail:
		print("jail: ",inJail)
		var rollResult = Die.roll()
		var die1 = rollResult[0]
		var die2 = rollResult[1]
		var total = rollResult[2]
		print("die1: ",die1,", die2: ",die2,", total: ",total)
		
		if die1 == die2: # We rolled a double
			doubleCount += 1
			print(playerName, " rolled a double and gets another turn!")
			if doubleCount == 3:
				doubleCount = 0 #reset count
				goToJail()
			else: 
				move(total)
				takeTurn()
		else: # We did not roll a double
			move(total)
			doubleCount = 0 #reset count
			
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass
func report():
	print(playerName + " is currently at " + currentSpace.name + " with $" + str(money))
	
