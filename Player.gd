extends Node
class_name Player

@export var playerName: String
@export var money: int = 1500
@export var position: Space = null

func move(toMove: int, board: Board):
	if position == null:
		position = board.head
	else:
		for i in range(toMove):
			if position.nextSpace:
				position = position.nextSpace
	
	position.playersOnSpace.append(self)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
