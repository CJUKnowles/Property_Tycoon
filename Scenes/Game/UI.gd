extends Control

var selected_space:Space
@export var space_label:Label
@export var space_owner_label:Label
@export var space_mortgaged_label:Label

@export var sell_button:Button
@export var mortgage_button:Button
@export var buy_house_button:Button
@export var buy_hotel_button:Button

@export var roll_button:Button
@export var end_turn_button:Button
@onready var gameManager:GameManager = get_tree().current_scene

func _process(delta: float) -> void:
	# there is probably a more efficient way to do this. Some sort of listener for changing values?
	update_space_buttons()
	update_space_values() 
	update_control_buttons()
	
# updates all the text fields of the selected space UI element
func update_space_values():
	if selected_space == null:
		return
		
	space_label.text = selected_space.name
	space_mortgaged_label.text = "Mortgaged: " + str(selected_space.isMortgaged)
	var landlord = "Bank"
	if selected_space.landlord != null:
		landlord = selected_space.landlord.name
	space_owner_label.text = "Owner: " + landlord

# dynamically enables/disables buttons depending on current game state
func update_control_buttons():
	if gameManager.get_current_player() == null:
		return
	
	if gameManager.get_current_player().turn_over:
		roll_button.disabled = true
		end_turn_button.disabled = false
	else:
		roll_button.disabled = false
		end_turn_button.disabled = true

# dynamically enables/disables buttons depending on the selected space
func update_space_buttons():
	if selected_space == null or selected_space.landlord == null:
		sell_button.disabled = true
		mortgage_button.disabled = true
		buy_house_button.disabled = true
		buy_hotel_button.disabled = true
		return
	elif selected_space is Property_Space:
		sell_button.disabled = false
		mortgage_button.disabled = false
		buy_house_button.disabled = false
		buy_hotel_button.disabled = false
	elif selected_space is Station_Space:
		sell_button.disabled = false
		mortgage_button.disabled = false
		buy_house_button.disabled = true
		buy_hotel_button.disabled = true
	elif selected_space is Utility_Space:
		sell_button.disabled = false
		mortgage_button.disabled = false
		buy_house_button.disabled = true
		buy_hotel_button.disabled = true

func select_space(new_selected_space:Buyable_Space):
	print("Selecting " + new_selected_space.name)
	selected_space = new_selected_space
	update_space_values()
	update_space_buttons()
	
	
