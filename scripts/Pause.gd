extends ColorRect


func _process(delta):
	if Input.is_action_just_pressed("pause"):
		if G.finished:
			get_tree().quit()
		else:
			toggle_pause()
	if Input.is_action_just_pressed("mute"):
		G.toggle_sound()
	if Input.is_action_just_pressed("fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen


func toggle_pause():
	get_tree().paused = !get_tree().paused
	visible = !visible
