extends Node2D
class_name Space

###############################################################################
# This is the parent class of EVERY space on the board - all spaces inherit from this class
# this class contains common values between every type of space, as well as
# a handful of utility functions that will be useful for every space.
# the on_land() funciton is intended to be overridden by every space class, filling
# in the method body with its own behaviour.
###############################################################################

# list of space types - may be removed in favor of checking the class name of a space
enum SpaceType {
	PROPERTY,
	POT_LUCK,
	OPPORTUNITY_KNOCKS,
	JAIL,
	FREE_PARKING,
	GO_TO_JAIL,
	TAX,
	GO,
	STATION,
	UTILITY
}


@export var landing_positions:Node2D
var landing_positions_list: Array = []
@export var type: SpaceType
@export var playersOnSpace: Array = []
@export var next: Space = self
@export var previous: Space = self
var gameManager:GameManager
@onready var icon:Sprite2D = $icon

func _ready():
	#position = previous.position + Vector2(-450, 0)
	#var random:Vector2 = Vector2(randi_range(-2000,2000), randi_range(-1600,1600))
	#position += random
	if($name != null):
		print("i have a name")
		$name.text = name
	for pos in landing_positions.get_children():
		#pos.reparent(gameManager.board)
		landing_positions_list.append(pos)
		print(pos)
	pass

# Intended to be overridden by all children. Is called when the player lands on this space
func on_land():
	print("This is a space! Parent class")

# Called when this space is clicked - attempts to select the current space
func on_click():
	gameManager.UI.select_space(self)

# Returns the coordinate position that the player should move to when landing on this space.
# This is used to provide an offset to each player position, preventing them from
# covering each other up entirely.
func get_landing_position(player_num):
	#return position + landing_positions.get_child(player_num).position
	return landing_positions_list[player_num].global_position
