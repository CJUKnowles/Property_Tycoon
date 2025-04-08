extends Panel

var selected_space:Space
@export var space_icon:TextureRect
@export var space_label:Label
@export var space_owner_label:Label
@export var space_mortgaged_label:Label

@export var sell_button:Button
@export var mortgage_button:Button
@export var buy_house_button:Button
@export var buy_hotel_button:Button

@onready var gameManager:GameManager = get_tree().current_scene

func _process(delta: float) -> void:
	# there is probably a more efficient way to do this. Some sort of listener for changing values?
	update_space_visuals() 
	update_space_buttons()
	
# updates all the text fields of the selected space UI element
func update_space_visuals():
	if selected_space == null:
		return
	
	if selected_space is Property_Space:
		space_icon.self_modulate = selected_space.get_color()
		space_icon.get_child(0).visible = true
	else:
		space_icon.self_modulate = Color(1, 1, 1, 1)
		space_icon.get_child(0).visible = false
	space_icon.texture = selected_space.icon.texture
	space_label.text = selected_space.name
	space_mortgaged_label.text = "Mortgaged: " + str(selected_space.isMortgaged)
	var landlord = "Bank"
	if selected_space.landlord != null:
		landlord = selected_space.landlord.name
	space_owner_label.text = "Owner: " + landlord
	
# dynamically enables/disables buttons depending on the selected space
func update_space_buttons():
	if gameManager.get_current_player() == null:
		return
	
	var canManage = gameManager.get_current_player().turn_over or gameManager.get_current_player().inDebt
	
	if selected_space == null or selected_space.landlord == null or gameManager.get_current_player() is AIPlayer:
		sell_button.disabled = true
		mortgage_button.disabled = true
		buy_house_button.disabled = true
		buy_hotel_button.disabled = true
		return
	elif selected_space is Property_Space and selected_space.landlord == gameManager.get_current_player():
		sell_button.disabled = !canManage
		mortgage_button.disabled = !canManage
		buy_house_button.disabled = !canManage
		buy_hotel_button.disabled = !canManage
	elif selected_space is Property_Space and selected_space.landlord != gameManager.get_current_player():
		sell_button.disabled = true
		mortgage_button.disabled = true
		buy_house_button.disabled = true
		buy_hotel_button.disabled = true
	elif selected_space is Station_Space and selected_space.landlord == gameManager.get_current_player():
		sell_button.disabled = !canManage
		mortgage_button.disabled = !canManage
		buy_house_button.disabled = true
		buy_hotel_button.disabled = true
	elif selected_space is Station_Space and selected_space.landlord != gameManager.get_current_player():
		sell_button.disabled = true
		mortgage_button.disabled = true
		buy_house_button.disabled = true
		buy_hotel_button.disabled = true
	elif selected_space is Utility_Space and selected_space.landlord == gameManager.get_current_player():
		sell_button.disabled = !canManage
		mortgage_button.disabled = !canManage
		buy_house_button.disabled = true
		buy_hotel_button.disabled = true
	elif selected_space is Utility_Space and selected_space.landlord != gameManager.get_current_player():
		sell_button.disabled = true
		mortgage_button.disabled = true
		buy_house_button.disabled = true
		buy_hotel_button.disabled = true

func select_space(new_selected_space:Buyable_Space):
	print("Selecting " + new_selected_space.name)
	selected_space = new_selected_space
	update_space_visuals()
	update_space_buttons()
