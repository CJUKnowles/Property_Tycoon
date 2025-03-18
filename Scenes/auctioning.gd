extends Control
var Property_Name: String = "" #name of property being put on auction
var Current_Bid: int = 0 
var Highest_Bidder: Player
var Bidding_Time: float = 30.0 #used for example, could alter for personal use
var players = [] #list of players in the game able to bid on the auction
var roundCounter: int = 0
var Player_Bid: int = 0
var Current_Player: Player

@onready var Property_Label: Label = $PropertyLabel
@onready var Current_Bid_Label: Label = $CurrentBidLabel
@onready var timer: Timer = $Timer

func start_auction(property: String, players_list: Array):
	Property_Name = property
	Current_Bid = 0
	Highest_Bidder = null
	players = players_list
	Property_Label.text = "Auctioning: " + Property_Name
	Current_Bid_Label.text = "Current Bid: $" + str(Current_Bid)
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
		pass #if highest bidder is null, property not sold and is buyable

func next_bidder():
	var i = 0
	while i < players.len():
		Current_Player = players[i]
		i = i + 1
	if Player_Bid <= Current_Bid:
		pass #reinput value to place higher value
	if Current_Player.money <= Current_Bid:
		next_bidder()
	if Current_Player.bankrupt == false:
		next_bidder()
	pass
	
#go in for loop of players, get new bid, go in for loop again, if no new highest bid
#end auction and give prperty to player
