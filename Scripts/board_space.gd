@tool
extends ColorRect

var space_name: String = "Go"
var price: int = 0
var rent: int = 0

@export var dark : bool = false:
	set(v):
		dark = v
		color = Color.AQUA if dark else Color.WEB_GREEN

func on_land(player):
	print(player.name, " just landed on: ", space_name)
	# thing that happens when player lands
