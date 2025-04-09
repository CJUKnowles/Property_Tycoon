#extends CanvasLayer
#
#@export var dice_faces: Array[Texture2D] = []  # Assign your 6 dice face textures in inspector
#
#@onready var die1_texture: TextureRect = $Panel/Die1
#@onready var die2_texture: TextureRect = $Panel/Die2
#@onready var roll_timer: Timer = $RollTimer
#
#var rolling := false
#var final_values := [1, 1]
#
#func _ready():
	#hide()
#
#func roll_dice():
	#show()
	#rolling = true
	#roll_timer.start()
	## Randomize initial faces
	#die1_texture.texture = dice_faces[randi() % 6]
	#die2_texture.texture = dice_faces[randi() % 6]
#
#func _on_roll_timer_timeout():
	#if rolling:
		## Animate rolling by changing faces rapidly
		#die1_texture.texture = dice_faces[randi() % 6]
		#die2_texture.texture = dice_faces[randi() % 6]
	#else:
		#roll_timer.stop()
		## After a delay, hide the popup
		#await get_tree().create_timer(1.0).timeout
		#hide()
#
#func show_final_values(values: Array):
	#rolling = false
	#final_values = values
	#die1_texture.texture = dice_faces[values[0] - 1]
	#die2_texture.texture = dice_faces[values[1] - 1]
