extends Node
class_name Card

## Card class
##
## This is a parent class for a card object. Types of cards inherit from this class.

var description:String
var gameManager : GameManager


func on_draw():
	print("This is the parent class! Override this function in the children")
