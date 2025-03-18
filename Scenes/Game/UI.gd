extends Control

var selected_space:Space
@export var selected_space_label:Label

func select_space(new_selected_space:Space):
	print("Selecting " + new_selected_space.name)
	selected_space = new_selected_space
	selected_space_label.text = selected_space.name
