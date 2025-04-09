extends Button
########################################################################
# This class controls the player info tabs at the top of the screen
# Being a UI class, it should only be directly managed by the main UI class
########################################################################

var player:Player
var gameManager:GameManager

var is_current_player:bool = false # True if this tab represents the player currently taking a turn
var initialized:bool = false # true if the player is properly assigned and ready to go

@export var money_label:Label
@export var frame:TextureRect
@export var piece_texture:TextureRect
@export var hover_color:Color
@export var press_color:Color
@export var bankrupt_color:Color
@onready var default_frame_tex:CompressedTexture2D = load("res://Assets/UI/Interface/Player.png")
@onready var current_frame_tex:CompressedTexture2D = load("res://Assets/UI/Interface/Player_Now.png")
var currently_pressed = false
var currently_hovered = false

## The PlayerTab should be created by the player or gamemanager on player creation
## initialize connects this tab up with a given player; it will not display anything until initialized
func initialize(new_player:Player):
	player = new_player
	gameManager = player.gameManager
	piece_texture.texture = new_player.get_child(0).texture
	# TODO: Assign the piece texture based on the player. Don't do this until pieces are fully implemented.
	initialized = true

## Updates the tab's information every frame
func _process(delta: float) -> void:
	if initialized:
		# puts a color filter on the tab depending on the situation
		if player.bankrupt:
			frame.modulate = bankrupt_color
		elif currently_pressed:
			frame.modulate = press_color
		elif currently_hovered:
			frame.modulate = hover_color
		else:
			frame.modulate = Color(1,1,1)
				
		money_label.text = "£" + str(player.money)
		
		# uses the highlighted tab frame if this tab represents the current player
		if gameManager.get_current_player() == player:
			frame.texture = current_frame_tex
		else:
			frame.texture = default_frame_tex

# selects the player on click, but only if they are still in the game
func on_press():
	if player.bankrupt:
		return
	gameManager.UI.select_player(player)

## The following methods keep track of where the mouse is, for animation purposes

func _on_mouse_entered() -> void:
	currently_hovered = true

func _on_mouse_exited() -> void:
	currently_hovered = false

func _on_button_down() -> void:
	currently_pressed = true

func _on_button_up() -> void:
	currently_pressed = false
