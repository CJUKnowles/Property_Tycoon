extends Control
var Property: Property_Space #property being put on auction
var Current_Bid: int = 0 
var Highest_Bidder: Player
var Bidding_Time: float = 30.0 #used for example, could alter for personal use
var players = [] #list of players in the game able to bid on the auction
var roundCounter: int = 0
var Player_Bid: int = 0
var Current_Player: Player
var player_iterator = 0

@onready var Property_Label: Label = $PropertyLabel
@onready var Current_Bid_Label: Label = $CurrentBidLabel
@onready var timer: Timer = $Timer

func start_auction(property: Property_Space, players_list: Array):
	Property = property
	Current_Bid = 0
	Highest_Bidder = null
	players = players_list
<<<<<<< Updated upstream
	Property_Label.text = "Auctioning: " + Property_Name
	Current_Bid_Label.text = "Current Bid: £" + str(Current_Bid)
=======
	Property_Label.text = "Auctioning: " + Property.name
	Current_Bid_Label.text = "Current Bid: $" + str(Current_Bid)
>>>>>>> Stashed changes
	timer.start(Bidding_Time)
	if players.len() > 1:
		next_bidder()
	else:
		print("TOO FEW PLAYERS FOR AUCTION")
		end_auction()
	if Bidding_Time == 0:
		next_bidder()
	if roundCounter >= players.len():
		end_auction()
	show()

func end_auction():
	if Highest_Bidder == null:
		print("No valid bids for current property: " + Property.name) #if highest bidder is null, property not sold and is buyable
	else:
		Highest_Bidder.money -= Current_Bid
		Property.set_landlord(Highest_Bidder)
		print(str(Highest_Bidder.name) + " paid $" + str(Current_Bid) + " for property " + Property.name)
		#no other higher bidder

func next_bidder():
	
	if Current_Player.money <= Current_Bid:
		if player_iterator < players.len() - 1:
			Current_Player = players[player_iterator]
			player_iterator = player_iterator + 1
		elif player_iterator >= players.len() - 1:
			player_iterator = 0
		next_bidder()
	elif Player_Bid <= Current_Bid:
		#reinput value to place higher value
		if player_iterator < players.len() - 1:
			Current_Player = players[player_iterator]
			player_iterator = player_iterator + 1
		elif player_iterator >= players.len() - 1:
			player_iterator = 0
		next_bidder()
	if Current_Player.bankrupt == false:
		players.remove_at(player_iterator)
		next_bidder()
	
	
#go in for loop of players, get new bid, go in for loop again, if no new highest bid
#end auction and give prperty to player

func update_HighestBidderDisplay():
	Current_Bid_Label.text = "Current Bid is now: $" + str(Current_Bid)
	if Highest_Bidder:
		Highest_Bidder.text = "Current Highest Bidder is: " + str(Highest_Bidder)
	
