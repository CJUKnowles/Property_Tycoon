extends Node2D
class_name Player

@export var playerName: String
@export var money: int = 1500
@export var currentSpace: Space= null
@export var doubleCount: int=0
@export var inJail: bool=false
var gameManager

func _ready():
	print("Player is being setup!")

func move(toMove: int):
	if position == null:
		position = gameManager.board.head
	else:
		for i in range(toMove):
			if currentSpace.next:
				currentSpace = currentSpace.next
	
	currentSpace.playersOnSpace.append(self)
	
func moveTo(target: Space):
	while currentSpace != target:
		currentSpace = currentSpace.next

func goToJail():
	var jail = gameManager.board.findSpace("JAIL")
	moveTo(jail)

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass
func report():
	print(playerName + " is currently at " + currentSpace.name + " with $" + str(money))
	
