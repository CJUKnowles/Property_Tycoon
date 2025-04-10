extends Control
class_name Auction

var Property: Buyable_Space #property being put on auction
var Highest_Bid: int = 0 #the highest bid of the auction so far
var Highest_Bidder: Player #the player who bid the highest
var players:Array[Player] = [] #list of players in the game able to bid on the auction
var Player_Bid: int = 0 #the current player's bid
var Current_Player: Player #the player who's turn it is to bid
var player_iterator = 0 
var running = true

#starts a new auction with the given property and list of players
func start_auction(property: Buyable_Space, players_list: Array):
	Property = property
	Highest_Bid = 0
	Highest_Bidder = null
	players = players_list
	Current_Player = players[player_iterator]

#ends the auction, assigning the property to the highest bidder or to the bank if there were no bids
func end_auction():
	if Highest_Bidder == null:
		print("No valid bids for current property: " + Property.name) #if highest bidder is null, property not sold and is buyable
	else:
		Highest_Bidder.money -= Highest_Bid
		Property.set_landlord(Highest_Bidder)
		print(str(Highest_Bidder.name) + " paid $" + str(Highest_Bid) + " for property " + Property.name)
		#no other higher bidder
	running = false

#accepts a player's bid and compares it to the current highest
func next_bid(new_bid:int):
	Player_Bid = new_bid
	
	#if the player does not have enough money to bid, remove them from the auction
	if Current_Player.bankrupt == true:
		remove_current_player()
		Current_Player = players[player_iterator]
		return
	if Current_Player.money <= Highest_Bid:
		remove_current_player()
		return
		
	# if the player's bid is too low to beat the highest, or too high for them to afford, repeat their turn
	if Player_Bid <= Highest_Bid:
		return
	if Player_Bid > Current_Player.money:
		return
		
	Highest_Bid = Player_Bid
	Highest_Bidder = players[player_iterator]
	
	#iterate to the next player in the auction
	if player_iterator < players.size() - 1:
		player_iterator = player_iterator + 1
		Current_Player = players[player_iterator]
	elif player_iterator >= players.size() - 1:
		player_iterator = 0
		Current_Player = players[player_iterator]
	
#removes the current player from the list of players in the auction
func remove_current_player():
	players.remove_at(player_iterator)
	if players.size() <= 1:
		end_auction()
		return
	if player_iterator >= players.size() - 1:
		player_iterator = 0
	Current_Player = players[player_iterator]
