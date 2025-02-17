extends Space
class_name Station_Space

@export var rent: int
@export var colorGroup: String
@export var houses: int = 0
@export var hotel: bool = false
@export var isMortgaged: bool = false


func on_land():
	print("This is a Station space! Child class")
