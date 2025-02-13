extends Node
class_name GameManager

@export var playerCount:int = 4 # Number of players in the game
var players:Array[Player] = [];
var roundCounter = 0 # increments once all players have had a turn
var turnCounter = 0 # increments after each player's turn. Resets to 0 on a new round.
var board:Board # board reference

func _ready():
	print("This code is running")
	
	# Permanent code. Generate a board to play the game on.
	board = Board.new()
	# board.generate? # This will run Conor's board reading code
	# for now, we are going to generate some default spaces.
	# Temporary board generation code: ----------------------------
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
	# -------------------------------------------------------------
	
	# Permanent code: Generate example players via playerCount ---------------
	for i in playerCount:
		var newPlayer = Player.new()
		newPlayer.playerName = ("Player_" + str(i))
		newPlayer.position = board.head
		players.append(newPlayer) # add the generated player to the players array
	
	print("List of players:")
	for player in players:
		print(player.playerName)
	# ------------------------------------------------------------------------


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# This if statement represents taking a turn.
	# It will roll the dice of the current character, print some information, and increment the turn/round
	if Input.is_action_just_pressed("ui_accept"):
		var currentPlayer = players[turnCounter]
		print("----------------")
		print(currentPlayer.playerName + "'s turn:")
		var roll = Die.roll()
		print(str(roll) + " was rolled")
		currentPlayer.move(roll)
		print(currentPlayer.playerName + " moved to " + currentPlayer.position.name)
		print("Ending turn.")
		print("----------------\n")
		
		turnCounter += 1
		if turnCounter == playerCount:
			turnCounter = 0
			roundCounter += 1
			print("\nBEGINNING ROUND " + str(roundCounter) + ": \n")
		
		
