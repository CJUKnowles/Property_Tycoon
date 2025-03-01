extends Node2D
class_name Bank

var money: int = 50000

func pay_player(player, amount: int):
	print("Bank pays " + player.name + " £" + str(amount))
	player.money += amount
	money -= amount

func receive_payment(player, amount: int):
	print(player.name + " pays the bank £" + str(amount))
	player.money -= amount
	money += amount

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
