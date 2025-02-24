extends Node
class_name GameManager

@export var playerCount:int = 4 # Number of players in the game
@export var playerPrefab:Node2D
var players:Array[Player] = [];
var roundCounter = 0 # increments once all players have had a turn
var turnCounter = 0 # increments after each player's turn. Resets to 0 on a new round.
var board:Board # board reference

func _ready():
	# Permanent code. Generate a board to play the game on.
	board = Board.new()
	board.gameManager = self
	board.initialize()
	add_child(board)
	
	# Permanent code: Generate example players via playerCount ---------------
	for i in playerCount:
		var newPlayer = Player.new()
		newPlayer.name = ("Player_" + str(i))
		newPlayer.currentSpace = board.head
		newPlayer.gameManager = self
		add_child(newPlayer)
		players.append(newPlayer) # add the generated player to the players array
	
	print("List of players:")
	for player in players:
		print(player.name)
	# ------------------------------------------------------------------------
	
	start_new_round()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var player = get_current_player()
	# It will roll the dice of the current character, print some information, and increment the turn/round
	if Input.is_action_just_pressed("ui_down"): #sets current player in jail (for testing)
		player.goToJail()
	if Input.is_action_just_pressed("mortgage"):
		if player.currentSpace.SpaceType == Space.SpaceType.PROPERTY:
			player.currentSpace.toggle_mortgage()
	if Input.is_action_just_pressed("ui_up"): # Sends the current player to jail
		player.goToJail()
		player.takeTurn()
		end_turn()
	if Input.is_action_just_pressed("ui_accept"): # Makes the current player take their turn
		print("\n" + player.name + "'s turn:")
		print("----------------")
		player.takeTurn()
		end_turn()

func get_current_player():
	return players[turnCounter]

func end_turn():
	print("Ending " + get_current_player().name + "'s turn.")
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
		
	
func goTo(player : Player, target: Space):
	while player.currentSpace != target:
		player.currentSpace = player.currentSpace.next
	
		
