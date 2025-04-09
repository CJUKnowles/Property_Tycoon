extends Panel

##############################################################################
# This class is responsible for displaying player information of the selected player
# Like other UI classes, it is managed by the main UI class
##############################################################################

var selected_player:Player
@export var player_icon:TextureRect
@export var player_name_label:Label
@export var player_money_label:Label

@onready var gameManager:GameManager = get_tree().current_scene

# Updates the player's information visuals every frame
func _process(delta: float) -> void:
	# there is probably a more efficient way to do this. Some sort of listener for changing values?
	update_player_visuals() 
	
# updates all the text fields of the selected space UI element
func update_player_visuals():
	if selected_player == null:
		return
	
	player_icon.texture = selected_player.get_piece_texture()
	player_name_label.text = selected_player.name
	player_money_label.text = str(selected_player.money)

# Selects the given player, displaying their information
func select_player(player:Player):
	print("Selecting " + player.name)
	selected_player = player
	update_player_visuals()
