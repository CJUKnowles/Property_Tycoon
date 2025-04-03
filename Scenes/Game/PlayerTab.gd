extends Control

var player:Player
var gameManager:GameManager

var is_current_player:bool = false
var initialized:bool = false # true if the player is properly assigned and ready to go

@export var money_label:Label
@export var frame:TextureRect
@export var piece_texture:TextureRect
@onready var default_frame_tex:CompressedTexture2D = load("res://Assets/UI/Interface/Player.png")
@onready var current_frame_tex:CompressedTexture2D = load("res://Assets/UI/Interface/Player_Now.png")

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
			frame.modulate = Color(.5,.5,.5)
		
		money_label.text = "$" + str(player.money)
		
		if gameManager.get_current_player() == player:
			frame.texture = current_frame_tex
		else:
			frame.texture = default_frame_tex
