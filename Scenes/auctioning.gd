extends Control
var Property_Name: String = "" #name of property being put on auction
var Current_Bid: int = 0 
var Highest_Bidder: String = ""
var Bidding_Time: float = 30.0 #used for example, could alter for personal use
var players = [] #list of players in the game able to bid on the auction

@onready var Property_Label: Label = $PropertyLabel
@onready var Current_Bid_Label: Label = $CurrentBidLabel
@onready var timer: Timer = $Timer

func start_auction(property: String, players_list: Array):
	Property_Name = property
	Current_Bid = 0
	Highest_Bidder = ""
	players = players_list
	Property_Label.text = "Auctioning: " + Property_Name
	Current_Bid_Label.text = "Current Bid: $" + str(Current_Bid)
	timer.start(Bidding_Time)
	show()

func end_auction():
	pass

func next_bidder():
	pass
