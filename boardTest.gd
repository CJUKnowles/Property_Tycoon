extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var board = Board.new()
	
	var go = Space.new()
	go.type = Space.SpaceType.GO 
	
	var prop1 = Property.new()
	prop1.name = "brighton"
	
	var property1 = Space.new()
	property1.type = Space.SpaceType.PROPERTY 
	property1.property = prop1
	
	board.addSpace(go)
	board.addSpace(property1)

	var player1 = Player.new()
	print(player1.position)
	player1.move(1, board)
	print("moved, new position: ", player1.position)
	
	print( " has " , player1.position.playersOnSpace , " on it")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
