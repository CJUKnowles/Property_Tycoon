extends Panel

##############################################################################
# This class is responsible for displaying information about the currently selected space
# it is managed by the main UI class, like all other UI elements
# This class is the most complicated UI element as it needs to dynamically enable/disable
# 4 UI buttons based on a variety of factors, such as the property selected,
# the selected property's owner, and whose current turn it is.
##############################################################################
var selected_space:Space
@export var space_icon:TextureRect
@export var space_label:Label
@export var space_owner_label:Label
@export var space_mortgaged_label:Label

@export var sell_button:Button
@export var mortgage_button:Button
@export var buy_house_button:Button
@export var buy_hotel_button:Button

@export var space_visual:Panel
@export var space_buttons:HBoxContainer
@export var buy_menu:Panel

@export var auction_info:Panel
@export var auction_buttons:Panel
@export var highest_bidder_label:Label
@export var highest_bid_label:Label
@export var current_bidder_label:Label
@export var player_icon:TextureRect

@export var bid_button:Button
@export var exit_auction_button:Button
@export var bid_input:LineEdit

var current_auction:Auction

var buying = false

@onready var gameManager:GameManager = get_tree().current_scene

# Updates the UI visuals every frame
func _process(delta: float) -> void:
	# there is probably a more efficient way to do this. Some sort of listener for changing values?
	update_space_visuals() 
	update_space_buttons()
	update_auction_visuals()
	
	
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

# dynamically enables/disables text and icons depending on the current auction
func update_auction_visuals():
	if current_auction != null:
		if current_auction.running:
			auction_info.visible = true
			auction_buttons.visible = true
			if current_auction.Highest_Bidder == null:
				highest_bidder_label.text = "None"
			else:
				highest_bidder_label.text = current_auction.Highest_Bidder.name
			highest_bid_label.text = str(current_auction.Highest_Bid)
			player_icon.texture = current_auction.Current_Player.get_piece_texture()
			current_bidder_label.text = current_auction.Current_Player.name
		else:
			auction_info.visible = false
			auction_buttons.visible = false

# Selects the given space, displaying its information
func select_space(new_selected_space:Buyable_Space):
	if buying:
		return
	print("Selecting " + new_selected_space.name)
	selected_space = new_selected_space
	
	space_visual.visible = true
	space_buttons.visible = true
	
	update_space_visuals()
	update_space_buttons()

# Attempts to buy the selected space, if possible.
# When buying is available, the selected_space will always be the one just landed
# on by the player
func buy_pressed():
	print("Player selected buy!")
	update_space_visuals()
	if selected_space is Buyable_Space:
		var purchased = selected_space.purchase()
		print("Purchase attempted")
		if purchased:
			print("purchase successful")
			space_buttons.visible = false
			buy_menu.visible = false
			space_visual.visible = false
			buying = false
		else:
			print("Purchase failed")
			_on_mortgage_pressed()

# Denies an optional purchase and starts an auction (enabling the auction menu)
func auction_pressed():
	if selected_space is Buyable_Space:
		print("Auction triggered! Demetri connect your code up to here thanks love u ")
		space_buttons.visible = false
		buy_menu.visible = false
		space_visual.visible = false
		buying = false
		
		current_auction = Auction.new()
		current_auction.start_auction(selected_space, gameManager.players.duplicate())
		


# Sells the currently selected space, rewarding money to the current player
# can only be pressed if selling is available (correct player, property, and ownership status)
func _on_sell_pressed():
	if selected_space == null:
		return
	selected_space.sell()

# Toggles the mortgage status of the selected space (only possible if mortgaging is available)
func _on_mortgage_pressed() -> void:
	if selected_space == null:
		return
	selected_space.toggle_mortgage()

# Makes the buy menu visible, called when a player lands on an unowned buyable space
func buy_menu_popup():
	print("popping up buy menu")
	select_space(gameManager.get_current_player().currentSpace)
	buying = true # locks this method into the buying state - player is now unable to select other spaces until buy menu is closed
	space_buttons.visible = false
	buy_menu.visible = true
	space_visual.visible = true

func _submit_bid_pressed():
	print("current player iterator:", current_auction.player_iterator)
	var bid_amount = int(bid_input.text)
	current_auction.next_bid(bid_amount)
	print("new player iterator:", current_auction.player_iterator)
	
func _exit_auction_pressed():
	current_auction.remove_current_player()
	
