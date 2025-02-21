extends Node2D
class_name Space

enum SpaceType {
	PROPERTY,
	POT_LUCK,
	OPPORTUNITY_KNOCK,
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
@export var bought: bool = false
var gameManager:GameManager

func _ready():
	var random:Vector2 = Vector2(randi_range(100,800), randi_range(100,500))
	position += random

func on_land():
	print("This is a space! Parent class")
