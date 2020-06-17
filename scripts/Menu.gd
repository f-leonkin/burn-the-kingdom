extends Spatial

var help_control_tab = true

func _ready():
	$UI.visible = false
	if OS.get_name() == "Android":
		$UI/Help/VBoxContainer/Buttons/Controls.visible = false
		help_control_tab = false


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
	$UI/Label.visible = !$UI/Help.visible
	if $UI/Help.visible:
		for c in $UI/Help/VBoxContainer/Text.get_children():
			c.visible = false
		if help_control_tab:
			$UI/Help/VBoxContainer/Text/Controls.visible = true
			$UI/Help/VBoxContainer/Buttons/Controls.grab_focus()
		else:
			$UI/Help/VBoxContainer/Text/Enemies.visible = true
			$UI/Help/VBoxContainer/Buttons/Enemies.grab_focus()


func _on_AboutButton_pressed():
	$UI/About.visible = !$UI/About.visible
	$UI/Help.visible = false
	$UI/Label.visible = true


func _on_AnimationPlayer_animation_started(anim_name):
	$AudioStreamPlayer.play()


func _on_Controls_pressed():
	$UI/Help/VBoxContainer/Text/Controls.visible = true
	$UI/Help/VBoxContainer/Text/Enemies.visible = false
	$UI/Help/VBoxContainer/Text/Misc.visible = false


func _on_Enemies_pressed():
	$UI/Help/VBoxContainer/Text/Controls.visible = false
	$UI/Help/VBoxContainer/Text/Enemies.visible = true
	$UI/Help/VBoxContainer/Text/Misc.visible = false


func _on_Misc_pressed():
	$UI/Help/VBoxContainer/Text/Controls.visible = false
	$UI/Help/VBoxContainer/Text/Enemies.visible = false
	$UI/Help/VBoxContainer/Text/Misc.visible = true
