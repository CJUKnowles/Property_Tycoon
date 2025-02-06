extends Sprite2D


@export var moveSpeed : int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var movement_input = Vector2()
	
	if Input.is_action_pressed('ui_right'):
		movement_input.x += 1
	if Input.is_action_pressed('ui_left'):
		movement_input.x -= 1
	if Input.is_action_pressed('ui_down'):
		movement_input.y += 1
	if Input.is_action_pressed('ui_up'):
		movement_input.y -= 1
		
	position += movement_input * moveSpeed
	pass
