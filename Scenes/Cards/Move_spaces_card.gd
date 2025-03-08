extends Card
class_name Move_spaces_card

var distance : int 

func on_draw():
	var player = gameManager.get_current_player()
	player.move(distance)
