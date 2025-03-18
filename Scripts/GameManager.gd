extends Node
class_name GameManager

@export var playerCount:int = 4 # Number of players in the game
@export var playerPrefab:Node2D
var players:Array[Player] = [];
var roundCounter = 0 # increments once all players have had a turn
var turnCounter = 0 # increments after each player's turn. Resets to 0 on a new round.
var board:Board # board reference
var selectedSpace:Space





func _ready():
	# Generate board from file ---------------
	board = Board.new()
	board.gameManager = self
	board.name = "Board"
	board.initialize()
	
	# Makes board scale to screen (work in progress)
	%CanvasLayer.add_child(board)
	board.position = Vector2(60.71, 627.325)
	board.scale = Vector2(.105,.105)
	
	# Generate example players via playerCount ---------------
	for i in playerCount:
		var newPlayer = createAndGetPlayer("Player_" + str(i))
		
	print("List of players:")
	for player in players:
		print(player.name)
	# ------------------------------------------------------------------------
	
	start_new_round()

func createAndGetPlayer(name:String):
	var path = "res://Scenes/Game/player.tscn"
	if FileAccess.file_exists(path):
		var newPlayer:Player = load(path).instantiate()
		newPlayer.name = (name)
		newPlayer.currentSpace = board.head
		newPlayer.gameManager = self
		board.add_child(newPlayer)
		players.append(newPlayer) # add the generated player to the players array
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


func _on_roll_dice_button_pressed() -> void:
	pass # Replace with function body.


func _on_sell_pressed():
	selectedSpace.sell()


func _on_mortgage_pressed() -> void:
	selectedSpace.toggle_mortgage()
