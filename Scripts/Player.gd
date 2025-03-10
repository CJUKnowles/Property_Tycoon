extends Node2D
class_name Player

@export var money: int = 1500
@export var move_speed: float = 10
@export var rotate_speed: float = 10

var currentSpace: Space= null
var doubleCount: int=0
var inJail: bool=false
var jailTurns: int = 0
var getOutOfJailFreeCard: bool=false
var collectFromGO: bool=true
var bankrupt = false
var gameManager
var owned_spaces:Array[Space] = []
var bank : Bank

func _ready():
	print("Player is being setup!")
	
func _process(delta: float) -> void:
	position = lerp(position, currentSpace.position, move_speed * delta)
	rotation = lerp(rotation, currentSpace.rotation, rotate_speed * delta)

func move(toMove: int):
	if currentSpace == null:
		currentSpace = gameManager.board.head
	else:
		currentSpace.playersOnSpace.erase(self) #removes player from current position
		
		if toMove > 0:
			for i in range(toMove):
				if currentSpace.next:
					currentSpace = currentSpace.next
		elif toMove < 0:
			for i in range(abs(toMove)):
				if currentSpace.previous:
					currentSpace = currentSpace.previous
	currentSpace.playersOnSpace.append(self)
	currentSpace.on_land()
	
func moveTo(target: Space):
	if currentSpace:
		currentSpace.playersOnSpace.erase(self)
		
	while currentSpace != target:
		if currentSpace.next == null: 
			print("Error: Target space not found.")
			return
			
		if collectFromGO and currentSpace == Go_Space:
			bank.pay_player(self, 200)
			print(name, " has passed GO and collected £200.")
		currentSpace = currentSpace.next
		
	currentSpace.playersOnSpace.append(self)
	currentSpace.on_land()

func goToJail():
	inJail = true
	var jail = gameManager.board.findSpace("Jail")
	moveTo(jail)
	print(name, " was sent to jail!")
	
func exitJail():
	inJail = false
	jailTurns = 0
	print(name + " has been moved to 'Just Visiting'")
	
func payBail():
	if money >= 50:
		money -= 50
		print(name + " paid £50 to leave jail. The money goes to Free Parking.")
		exitJail()
	else:
		print(name + " cannot afford to pay to leave jail!")
		print(name + " stays in jail and loses this turn. (" + str(jailTurns) + "/2)")
		
	
func stayInJail():
	print(name + " stays in jail and loses this turn. (" + str(jailTurns) + "/2)")

	
func takeTurn():
	if inJail:
		print(name, " is in jail.")
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
			print(name, " rolled a double and gets another turn!")
			if doubleCount == 3:
				doubleCount = 0 #reset count
				goToJail()
			else: 
				move(total)
				takeTurn()
		else: # We did not roll a double
			move(total)
			doubleCount = 0 #reset count
			
func report():
	print(name + " is currently at " + currentSpace.name + " with $" + str(money))
	
# Attempts to charge the player the specified amount, otherwise go bankrupt
# Returns true if successfully charged, false otherwise
func charge(amount: int):
	if money > amount:
		money -= amount
		print(name, " was charged $", str(amount), " and now has $", money, " remaining.")
		return true
	else:
		print(name, " cannot afford the $", str(amount), " charge!")
		return false
		# TODO: go bankrupt, or offer chance to sell/mortgage

func pay(amount: int):
	money += amount
	print(name, " was paid £", str(amount), " and now has £", money, " remaining.")

func fine(amount):
	if money > amount:
		money -= amount
		# TODO: add fine to free parking space funds
		print(name, " was fined £", str(amount), " and now has £", money, " remaining.")
		return true
	else:
		print(name, " cannot afford the £", str(amount), " fine!")
		return false
