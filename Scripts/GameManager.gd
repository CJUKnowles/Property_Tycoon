extends Node
class_name GameManager

var player_count
@export var human_count:int = 1 # Number of players in the game
@export var AI_count:int = 3
var players:Array[Player] = [];
var roundCounter = 0 # increments once all players have had a turn
var turnCounter = 0 # increments after each player's turn. Resets to 0 on a new round.
var board:Board # board reference
@onready var UI:UI_Manager = %UI
@export var board_spawn_location:Node2D
@export var player_piece_textures:Array
@onready var space_UI = %UI.get_node("UI_Space_Manager")

func _ready():
	player_count = human_count + AI_count
	# Generate board from file ---------------
	board = Board.new()
	board.gameManager = self
	board.name = "Board"
	board.initialize()
	
	# Makes board scale to screen (work in progress)
	board_spawn_location.add_child(board)
	board.scale = Vector2(.105,.105)
	
	# Generate example players via playerCount ---------------
	for i in human_count:
		createAndGetPlayer(i, true)
	for i in AI_count:
		createAndGetPlayer(i + human_count, false)
	
	print("List of players:")
	for player in players:
		print(player.name)
	# ------------------------------------------------------------------------
	
	start_new_round()
	if get_current_player() is AIPlayer:
		get_current_player().start_turn()

func createAndGetPlayer(i:int, is_human:bool):
	var path
	if is_human:
		path = "res://Scenes/Game/human_player.tscn"
	else:
		path = "res://Scenes/Game/AI_player.tscn"
		
	if FileAccess.file_exists(path):
		var newPlayer:Player = load(path).instantiate()
	
		newPlayer.name = "Player_" + str(i)
		newPlayer.id_number = i
		newPlayer.currentSpace = board.head
		newPlayer.currentVisualSpace = board.head
		newPlayer.gameManager = self
		newPlayer.get_child(0).texture = player_piece_textures[i]
		board.add_child(newPlayer)
		players.append(newPlayer) # add the generated player to the players array
		UI.add_player_tab(newPlayer)
		return newPlayer
	else:
		return null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var player = get_current_player()
	# It will roll the dice of the current character, print some information, and increment the turn/round
	if Input.is_action_just_pressed("ui_down"): #sets current player in jail (for testing)
		player.goToJail()
	if Input.is_action_just_pressed("mortgage"): # Press M to mortgage current space (if property)
		if player.currentSpace.type == Space.SpaceType.PROPERTY:
			player.currentSpace.toggle_mortgage()
	if Input.is_action_just_pressed("buy_house"): # Press M to mortgage current space (if property)
		if player.currentSpace.type == Space.SpaceType.PROPERTY:
			player.currentSpace.buy_house()
	if Input.is_action_just_pressed("ui_up"): # Sends the current player to jail
		player.goToJail()
		player.takeTurn()
		end_turn()
	if Input.is_action_pressed("fast_turn"): # Makes the current player take their turn quickly
		take_current_turn();


func take_current_turn():
	print("\n" + self.get_current_player().name + "'s turn:")
	print("----------------")
	self.get_current_player().takeTurn()
	if get_current_player().doubleCount == 0:
		if !get_current_player().inDebt:
			get_current_player().turn_over = true # TODO: clean this up
		
func get_current_player():
	return players[turnCounter]

func end_turn():
	if get_current_player().turn_over:
		print("Ending " + get_current_player().name + "'s turn.")
		get_current_player().turn_over = false
		get_current_player().z_index = 0 
		turnCounter += 1
		print("----------------")
	else:
		print(get_current_player().name + " still has rolls left!")
	
	if turnCounter == player_count:
		start_new_round()
	
	get_current_player().z_index = 1 # Makes the current player render on top of others
	
	if get_current_player().bankrupt:
		print(get_current_player().name + " is bankrupt.")
		get_current_player().turn_over = true
		end_turn()
	else:
		get_current_player().start_turn()
		
func start_new_round():
	turnCounter = 0
	roundCounter += 1
	print("\n////////////////////////////////////////////////////")
	print("BEGINNING ROUND " + str(roundCounter) + ":")
	print("////////////////////////////////////////////////////")
	check_winner()
		
	
func check_winner():
	var activePlayers = []
	
	for player in players:
		if !player.bankrupt:
			activePlayers.append(player)
	
	if players.size() == 1:
		var winner = players[0]
		print("Game Over! " + winner.name + " is the winner!")
		
		
func goTo(player : Player, target: Space):
	while player.currentSpace != target:
		player.currentSpace = player.currentSpace.next


func _on_roll_dice_button_pressed() -> void:
	pass # Replace with function body.

func _on_sell_pressed():
	if space_UI.selected_space == null:
		return
	space_UI.selected_space.sell()

func _on_mortgage_pressed() -> void:
	if space_UI.selected_space == null:
		return
	space_UI.selected_space.toggle_mortgage()
	
func _on_forfeit_pressed() -> void:
	get_current_player().forfeit()
