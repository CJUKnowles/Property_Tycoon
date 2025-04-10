extends Control
class_name Auction

var Property: Buyable_Space #property being put on auction
var Highest_Bid: int = 0 
var Highest_Bidder: Player
var Bidding_Time: float = 30.0 #used for example, could alter for personal use
var players:Array[Player] = [] #list of players in the game able to bid on the auction
var roundCounter: int = 0
var Player_Bid: int = 0
var Current_Player: Player
var player_iterator = 0
var running = true

func start_auction(property: Buyable_Space, players_list: Array):
	Property = property
	Highest_Bid = 0
	Highest_Bidder = null
	players = players_list
	Current_Player = players[player_iterator]


func end_auction():
	if Highest_Bidder == null:
		print("No valid bids for current property: " + Property.name) #if highest bidder is null, property not sold and is buyable
	else:
		Highest_Bidder.money -= Highest_Bid
		Property.set_landlord(Highest_Bidder)
		print(str(Highest_Bidder.name) + " paid $" + str(Highest_Bid) + " for property " + Property.name)
		#no other higher bidder
	running = false

func next_bid(new_bid:int):
	Player_Bid = new_bid
	
	if Current_Player.bankrupt == true:
		remove_current_player()
		Current_Player = players[player_iterator]
		return
	if Current_Player.money <= Highest_Bid:
		remove_current_player()
		return
	if Player_Bid <= Highest_Bid:
		return
	if Player_Bid > Current_Player.money:
		return
		
	Highest_Bid = Player_Bid
	Highest_Bidder = players[player_iterator]
	
	if player_iterator < players.size() - 1:
		player_iterator = player_iterator + 1
		Current_Player = players[player_iterator]
	elif player_iterator >= players.size() - 1:
		player_iterator = 0
		Current_Player = players[player_iterator]
	
func remove_current_player():
	players.remove_at(player_iterator)
	if players.size() <= 1:
		end_auction()
		return
	if player_iterator >= players.size() - 1:
		player_iterator = 0
	Current_Player = players[player_iterator]
