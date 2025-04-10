extends Node
class_name GameManager

############################################################################################################################################################
# This is the most important class in the project
# GameManager is responsible for managing the state of the game,
# as well as initializing the board and players.
# Almost all game behaviour stems from this script.
###################################################################################################################################################################################################

var player_count # Total number of players in the game
@export var human_count:int = 1 # Number of humans in the game
@export var AI_count:int = 3 # Number of AI players in the game
var players:Array[Player] = []; # List of all players
var roundCounter = 0 # increments once all players have had a turn
var turnCounter = 0 # increments after each player's turn. Resets to 0 on a new round.
var board:Board # board reference
@onready var UI:UI_Manager = %UI
@export var board_spawn_location:Node2D
@export var player_piece_textures:Array
@onready var space_UI = %UI.get_node("UI_Space_Manager")

# Called on game start - initializes the board, players, and starts the first turn
func _ready():
	# Generate board from file ------------------------------
	board = Board.new()
	board.gameManager = self
	board.name = "Board"
	board.initialize()
	
	# Makes board scale to window size
	board_spawn_location.add_child(board)
	board.scale = Vector2(.105,.105)
	
	# Generate example players via playerCount ---------------
	player_count = human_count + AI_count
	for i in human_count:
		createAndGetPlayer(i, true)
	for i in AI_count:
		createAndGetPlayer(i + human_count, false)
	print("List of players:")
	for player in players:
		print(player.name)
	
	# Start the game -----------------------------------------
	start_new_round()
	if get_current_player() is AIPlayer:
		get_current_player().start_turn()

# Creates a new instance HumanPlayer or AIPlayer and returns it
func createAndGetPlayer(id:int, is_human:bool):
	var path
	if is_human:
		path = "res://Scenes/Game/human_player.tscn"
	else:
		path = "res://Scenes/Game/AI_player.tscn"
	
	# Create and return the player
	if FileAccess.file_exists(path):
		var newPlayer:Player = load(path).instantiate()
		newPlayer.name = "Player_" + str(id)
		newPlayer.id_number = id
		newPlayer.currentSpace = board.head
		newPlayer.currentVisualSpace = board.head
		newPlayer.gameManager = self
		newPlayer.get_child(0).texture = player_piece_textures[id] # Automatically assign a game piece based on the id
		board.add_child(newPlayer) # Spawn the child in as a child of the board - this is done because everything the player does is in reference to the board
		players.append(newPlayer) # add the generated player to the players array
		UI.add_player_tab(newPlayer) # Create a UI tab at the top of the screen for each player
		return newPlayer
	else:
		return null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var player = get_current_player()
	# It will roll the dice of the current character, print some information, and increment the turn/round
	#if Input.is_action_just_pressed("ui_down"): #sets current player in jail (for testing)
		#player.goToJail()
	#if Input.is_action_just_pressed("mortgage"): # Press M to mortgage current space (if property)
		#if player.currentSpace.type == Space.SpaceType.PROPERTY:
			#player.currentSpace.toggle_mortgage()
	#if Input.is_action_just_pressed("buy_house"): # Press M to mortgage current space (if property)
		#if player.currentSpace.type == Space.SpaceType.PROPERTY:
			#player.currentSpace.buy_house()
	#if Input.is_action_just_pressed("ui_up"): # Sends the current player to jail
		#player.goToJail()
		#player.takeTurn()
		#end_turn()
	#if Input.is_action_pressed("fast_turn"): # Makes the current player take their turn quickly
		#take_current_turn();

# Tells the current player to take their turn (roll dice) and checks if they are capable of taking more turns
func take_current_turn():
	print("\n" + self.get_current_player().name + "'s turn:")
	print("----------------")
	self.get_current_player().takeTurn()
	if get_current_player().doubleCount == 0:
		if !get_current_player().inDebt:
			get_current_player().turn_over = true # TODO: clean this up

# Returns the player currently taking their turn
func get_current_player():
	return players[turnCounter]

# Ends the current turn (if possible) and passes control to the next player.
func end_turn():
	# turn_over is determined by a number of factors, such as rolling doubles and being in jail
	if get_current_player().turn_over:
		print("Ending " + get_current_player().name + "'s turn.")
		get_current_player().turn_over = false
		get_current_player().z_index = 0 
		turnCounter += 1
		print("----------------")
	else:
		print(get_current_player().name + " still has rolls left!")
	
	# Starts a new round (has player 0 take their turn next) if every player has taken a turn
	if turnCounter == player_count:
		start_new_round()
	
	
	get_current_player().z_index = 1 # Makes the current player render on top of others
	
	# Skips the current player's turn if they are out of the game
	if get_current_player().bankrupt:
		print(get_current_player().name + " is bankrupt.")
		get_current_player().turn_over = true
		end_turn()
	else:
		get_current_player().start_turn()
		
# Is called when all players have taken their turns. Checks to see if the game should end, if the abbreviated version is being played
func start_new_round():
	turnCounter = 0
	roundCounter += 1
	print("\n////////////////////////////////////////////////////")
	print("BEGINNING ROUND " + str(roundCounter) + ":")
	print("////////////////////////////////////////////////////")
	check_winner()
		

# Unfinished - ends the game if somebody has won
func check_winner():
	var activePlayers = []
	
	for player in players:
		if !player.bankrupt:
			activePlayers.append(player)
	
	if players.size() == 1:
		var winner = players[0]
		print("Game Over! " + winner.name + " is the winner!")
		
# Moves a player to a specific space on the board
func goTo(player : Player, target: Space):
	while player.currentSpace != target:
		player.currentSpace = player.currentSpace.next
