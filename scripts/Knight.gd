extends Enemy

const SPEED = 8

var running = false
var force_stop = false


func _process(delta):
	if running:
		translation += transform.basis.z * delta * SPEED


func _on_AgroArea_area_entered(area):
	if area == dragon and !force_stop:
		running = true
		$AnimationPlayer.play("run")


func _on_AtkArea_area_entered(area):
	if area == dragon:
		running = false
		$AnimationPlayer.play("attack")
		$AtkTimer.start()
	elif "Buildings" in area.get_parent().get_parent().name:
		running = false
		force_stop = true
		$AnimationPlayer.play("idle")


func _on_AtkTimer_timeout():
	for a in $AtkArea.get_overlapping_areas():
		if a == dragon:
			$AudioStreamPlayer.play()
			dragon.get_damage()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "attack":
		$AnimationPlayer.play("idle")
