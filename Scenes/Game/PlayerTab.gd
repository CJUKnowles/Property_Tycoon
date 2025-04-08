extends Button

var player:Player
var gameManager:GameManager

var is_current_player:bool = false
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

# The PlayerTab should be created by the player or gamemanager on player creation
# The 

func initialize(new_player:Player):
	player = new_player
	gameManager = player.gameManager
	piece_texture.texture = new_player.get_child(0).texture
	# TODO: Assign the piece texture based on the player. Don't do this until pieces are fully implemented.
	initialized = true

func _process(delta: float) -> void:
	if initialized:
		if player.bankrupt:
			frame.modulate = bankrupt_color
		elif currently_pressed:
			frame.modulate = press_color
		elif currently_hovered:
			frame.modulate = hover_color
		else:
			frame.modulate = Color(1,1,1)
				
		money_label.text = "£" + str(player.money)
		
		if gameManager.get_current_player() == player:
			frame.texture = current_frame_tex
		else:
			frame.texture = default_frame_tex

func on_press():
	if player.bankrupt:
		return
	gameManager.UI.select_player(player)

func _on_mouse_entered() -> void:
	currently_hovered = true


func _on_mouse_exited() -> void:
	currently_hovered = false


func _on_button_down() -> void:
	currently_pressed = true


func _on_button_up() -> void:
	currently_pressed = false
