extends Control
class_name UI_Manager

@export var roll_button:Button
@export var end_turn_button:Button
@export var forfeit_button:Button



@export var player_list_location:Control

@onready var gameManager:GameManager = get_tree().current_scene
@onready var player_tab_prefab = load("res://Scenes/UI/player_tab.tscn")
@onready var space_manager = $context_menu/UI_Space_Manager
@onready var player_manager = $context_menu/UI_Player_Manager


func add_player_tab(player:Player):
	var new_tab = player_tab_prefab.instantiate()
	new_tab.initialize(player)
	player_list_location.add_child(new_tab)

func _process(delta: float) -> void:
	# there is probably a more efficient way to do this. Some sort of listener for changing values?
	update_control_buttons()
	
# dynamically enables/disables buttons depending on current game state
func update_control_buttons():
	if gameManager.get_current_player() == null:
		return
	if gameManager.get_current_player() is AIPlayer:
		roll_button.disabled = true
		end_turn_button.disabled = true
		forfeit_button.disabled = true
		return
		
	var turn_over = gameManager.get_current_player().turn_over
	var inDebt = gameManager.get_current_player().inDebt
	
	forfeit_button.disabled = false
	roll_button.disabled = inDebt or turn_over
	end_turn_button.disabled = inDebt or !turn_over

func select_space(space:Space):
	space_manager.visible = true
	player_manager.visible = false
	space_manager.select_space(space)

func select_player(player:Player):
	if space_manager.buying:
		return
	space_manager.visible = false
	player_manager.visible = true
	player_manager.select_player(player)

func _on_forfeit_pressed() -> void:
	gameManager.get_current_player().forfeit()

func buy_menu_popup():
	space_manager.visible = true
	space_manager.buy_menu_popup()
