extends Node2D
class_name Player

@export var money: int = 1500
@export var move_speed: float = 30.0
@export var rotate_speed: float = 10
@export var spaceMoveThreshold = 16 # The distance the player piece needs to be to a space before moving to the next

var id_number = -1
var currentSpace: Space= null
var currentVisualSpace: Space = null
var doubleCount: int=0
var inJail: bool=false
var jailTurns: int = 0
var getOutOfJailFreeCard: bool=false
var collectFromGO: bool=true
var bankrupt = false
var gameManager
var owned_spaces:Array[Space] = []
var bank : Bank
var freeParking: Free_Parking_Space
var turn_over = false # is true when the player is out of rolls
var inDebt = false
var Debt = 0
var rollResult
var is_human

func _ready():
	print("Player is being setup!")
	
func _process(delta: float) -> void:
	animate_player(delta)

func animate_player(delta: float) -> void:
	if currentVisualSpace == null or currentSpace == null:
		return
	
	if currentVisualSpace != currentSpace and global_position.distance_squared_to(currentVisualSpace.get_landing_position(id_number)) < spaceMoveThreshold:
		currentVisualSpace = currentVisualSpace.next
	
	global_position = lerp(global_position, currentVisualSpace.get_landing_position(id_number), move_speed * delta)
	rotation = lerp(rotation, currentVisualSpace.rotation, rotate_speed * delta)

func move(toMove: int):
	if currentSpace == null:
		currentSpace = gameManager.board.head
		currentVisualSpace = currentSpace
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
	print("humanPlayer and AIPlayer should override this. If this is being printed, something has gone wrong.")
			
func report():
	print(name + " is currently at " + currentSpace.name + " with $" + str(money))
	
# Attempts to charge the player the specified amount, otherwise go bankrupt
# Returns true if successfully charged, false otherwise
func charge(amount: int):
	if money < amount:
		print(name, " cannot afford the £", str(amount), " charge!")
		var debt = amount - money
		cantAfford(debt)  
		return false

	money -= amount
	print(name, " was charged $", str(amount), " and now has $", money, " remaining.")
	return true


func pay(amount: int):
	money += amount
	print(name, " was paid £", str(amount), " and now has £", money, " remaining.")

func fine(amount):
	if money < amount:
			print(name, " cannot afford the £", str(amount), " fine!")
			var debt = amount - money
			cantAfford(debt)

	else:
		money -= amount
		freeParking.money += amount
		print(name, " was fined £", str(amount), " and now has £", money, " remaining.")



func cantAfford(debt: int):
	if owned_spaces.is_empty():
			bankrupt = true
			print("cbankrupt")
			declareBankrupt()
	else:
		inDebt = true
		Debt = debt
	

func enoughMoney():
	print("caled")
	if money >= Debt:
		print("You now have enough money to pay off your debts!")
		Debt = 0
		inDebt = false
		return true
	elif money < Debt and !owned_spaces.is_empty():
		print("You still need more money to pay off your debts!")
		return false
	else:
		if owned_spaces.is_empty():
			bankrupt = true
			print("cbankrupt")
		return false
	print("called enough mon")
	
func declareBankrupt():
	for property in owned_spaces:
		property.landlord = null
	owned_spaces.clear()
	bankrupt = true
	print(name + " is bankrupt!")
	
func forfeit():
	for property in owned_spaces:
		property.landlord = null
	owned_spaces.clear()
	bankrupt = true
	print(name + " forfeited!")
	
