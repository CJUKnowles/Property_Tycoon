extends Node2D
class_name Space

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

@export var type: SpaceType
@export var playersOnSpace: Array = []
@export var next: Space = null
@export var previous: Space = null
var gameManager:GameManager

func _ready():
	position = previous.position + Vector2(-450, 0)
	#var random:Vector2 = Vector2(randi_range(-2000,2000), randi_range(-1600,1600))
	#position += random

func on_land():
	print("This is a space! Parent class")
