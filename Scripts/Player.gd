extends Node
class_name Player

@export var playerName: String
@export var money: int = 1500
@export var position: Space= null
var gameManager:GameManager

func _setup():
	gameManager = $gameManager

func move(toMove: int):
	if position == null:
		position = gameManager.board.head
	else:
		for i in range(toMove):
			if position.next:
				position = position.next
	
	position.playersOnSpace.append(self)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass
	
func report():
	print(playerName + " is currently at " + position.name + " with $" + str(money))
	
