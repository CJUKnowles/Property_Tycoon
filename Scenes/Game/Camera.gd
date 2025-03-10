extends Camera2D

func _process(delta:float):
	if (Input.is_action_just_pressed("ui_text_scroll_up")):
		zoom += Vector2(.1,.1)
	if (Input.is_action_just_pressed("ui_text_scroll_down")):
		zoom -= Vector2(.1,.1)
