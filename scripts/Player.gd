extends Spatial

var speed = 6.5
var position = Vector2()

onready var camera = $Camera


func _process(delta):
	if $Dragon.power == 3:
		$UI/PowerLabel.bbcode_text = "[color=yellow]"
	else:
		$UI/PowerLabel.bbcode_text = "[color=white]"
	$UI/PowerLabel.bbcode_text += "Power: " + str($Dragon.power) + "[/color]"
	
	$UI/HPBar.value = $Dragon.hp
	$UI/HPBar/HPLabel.text = str($Dragon.hp) + " HP"
	
	var saf = $Dragon.super_attack_fill
	if saf == 0:
		$UI/SuperAttackProgressBar.visible = false
	else:
		$UI/SuperAttackProgressBar.visible = true
	$UI/SuperAttackProgressBar.value = $Dragon.super_attack_fill
	if saf == 100:
		$UI/SuperAttackProgressBar/SuperAttackButton.visible = true
	else:
		$UI/SuperAttackProgressBar/SuperAttackButton.visible = false
	
	translation.z -= speed * delta
	$ViewportContainer/Viewport/Camera.global_transform = camera.global_transform


func _input(event):
	if OS.has_touchscreen_ui_hint():
		var sb = $UI/SoundButton
		var sab = $UI/SuperAttackProgressBar/SuperAttackButton
		if (event is InputEventScreenTouch and event.is_pressed()) or \
				event is InputEventScreenDrag:
			if !(event.position.y > sb.rect_position.y and \
					event.position.y < sb.rect_position.y + sb.rect_size.y and \
					event.position.x > sb.rect_position.x) and \
			   !(event.position.y > sab.get_global_rect().position.y and \
					event.position.y < sab.get_global_rect().position.y + \
					sab.get_global_rect().size.y and \
					event.position.x > sab.get_global_rect().position.x and \
					$Dragon.super_attack_fill == 100):
				position = event.position


func _physics_process(delta):
	if !OS.has_touchscreen_ui_hint():
		position = get_viewport().get_mouse_position()
	if !position:
		return
	var ray_origin = camera.project_ray_origin(position)
	var ray_end = ray_origin + camera.project_ray_normal(position) * 100
	var space_state = get_world().get_direct_space_state()
	var intersection = space_state.intersect_ray(ray_origin, ray_end)
	if not intersection.empty():
		var ip = intersection.position
		$Dragon.move_target = Vector3(ip.x, translation.y, ip.z)
	else:
		$Dragon.move_target = Vector3()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "start":
		$Dragon.playable = true


func loading():
	$Loading.visible = true
	yield(get_tree().create_timer(.3), "timeout")
	G.load_scene()


func _on_SoundButton_pressed():
	G.toggle_sound()


func _on_PauseButton_pressed():
	$Pause.toggle_pause()


func ending():
	G.finished = true
	$UI.visible = false
	$Finale.visible = true
	if OS.get_name() != "Android" and OS.get_name() != "HTML5":
		$Finale/ColorRect/Label.text += "\nPress ESC to exit"
	
