extends Node
class_name GameManager

@export var playerCount:int = 4 # Number of players in the game
var players:Array[Player] = [];
var roundCounter = 0 # increments once all players have had a turn
var turnCounter = 0 # increments after each player's turn. Resets to 0 on a new round.
var board:Board # board reference

func _ready():
	# Permanent code. Generate a board to play the game on.
	board = Board.new()
	board.initialize()
	
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
	
	start_new_round()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# This if statement represents taking a turn.
	# It will roll the dice of the current character, print some information, and increment the turn/round
	if Input.is_action_just_pressed("ui_accept"):
		var currentPlayer = get_current_player()
		print("\n" + currentPlayer.playerName + "'s turn:")
		print("----------------")
		var roll = Die.roll()
		print(str(roll) + " was rolled")
		currentPlayer.move(roll)
		print(currentPlayer.playerName + " moved to " + currentPlayer.position.name)
		end_turn()

func get_current_player():
	return players[turnCounter]

func end_turn():
	print("Ending " + get_current_player().playerName + "'s turn.")
	turnCounter += 1
	print("----------------")
	
	if turnCounter == playerCount:
		start_new_round()
		
func start_new_round():
	turnCounter = 0
	roundCounter += 1
	print("\n////////////////////////////////////////////////////")
	print("BEGINNING ROUND " + str(roundCounter) + ":")
	print("////////////////////////////////////////////////////")
		
