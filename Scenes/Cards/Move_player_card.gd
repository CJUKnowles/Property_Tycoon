extends Card

var target : String # space the player is moving to
var passGo : bool # whether the player should collect £200 when passing Go

func on_draw():
	var player = gameManager.get_current_player()
	var target_space = gameManager.board.findSpace(target)
	player.collectFromGO = passGo
	player.moveTo(target_space)
	player.collectFromGO = true
	
