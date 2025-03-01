extends Card
var houseVal: int
var hotelVal: int 
var bank : Bank


# Called when the node enters the scene tree for the first time.
func on_draw():
	var player = gameManager.get_current_player()
	var toPay = (player.numOfHouse * houseVal ) + (player.NumofHotel * hotelVal)
	bank.receive_payment(player,toPay)
