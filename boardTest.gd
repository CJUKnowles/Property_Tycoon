extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var board = Board.new()
	
	var go = Space.new()
	go.type = Space.SpaceType.GO 
	go.name = "GO"
	
	var prop1 = Property.new()
	prop1.name = "brighton"
	
	var property1 = Space.new()
	property1.type = Space.SpaceType.PROPERTY
	property1.name = "PROPERTY 1" 
	property1.property = prop1
	
	board.addSpace(go)
	board.addSpace(property1)

	var player1 = Player.new()
	player1.position = board.head
	print(player1.position.name)
	player1.move(1, board)
	print("moved, new position: ", player1.position.name)
	
	print(player1.position.property.name , " has " , player1.position.playersOnSpace , " on it")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
