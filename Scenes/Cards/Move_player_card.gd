extends Card
class_name move_player_card

var target : String =  "The Old Creek"# space the player is moving to
var passGo : bool = false # whether the player should collect £200 when passing Go

func on_draw():
	var player = gameManager.get_current_player()
	var target_space = gameManager.board.findSpace(target)
	player.collectFromGO = passGo
	player.moveTo(target_space)
	player.collectFromGO = true
	
