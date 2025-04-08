extends Card
class_name move_player_card

## move_player_card class
##
## This class inherits from the Card class. It contains the functionality for a specific
## kind of card where the player is moved to a specific space on the board.

var target : String =  "The Old Creek" # space the player is moving to
var passGo : bool = false # whether the player should collect £200 when passing Go

func on_draw():
	var player = gameManager.get_current_player()
	var target_space = gameManager.board.findSpace(target)
	player.collectFromGO = passGo
	player.moveTo(target_space)
	player.collectFromGO = true # set it so player collects £200 when passing go again
	
