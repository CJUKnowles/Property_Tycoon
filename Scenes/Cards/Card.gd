extends Node
class_name Card

var description:String
var gameManager : GameManager


func on_draw():
	print("This is the parent class! Override this function in the children")
