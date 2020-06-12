extends Spatial


func _process(delta):
	if Input.is_action_just_pressed("mute"):
		G.toggle_sound()
	if Input.is_action_just_pressed("fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen


func _on_AnimationPlayer_animation_finished(anim_name):
	$UI.visible = true


func _on_StartButton_pressed():
	$AudioStreamPlayer.stop()
	$Loading.visible = true
	yield(get_tree().create_timer(.3), "timeout")
	G.load_scene()


func _on_HelpButton_pressed():
	$UI/Help.visible = !$UI/Help.visible
	$UI/About.visible = false


func _on_AboutButton_pressed():
	$UI/About.visible = !$UI/About.visible
	$UI/Help.visible = false


func _on_AnimationPlayer_animation_started(anim_name):
	$AudioStreamPlayer.play()
