extends Enemy

const SPEED = 8

var running = false


func _process(delta):
	if running:
		translation.z += SPEED * delta


func _on_AgroArea_area_entered(area):
	if area == dragon:
		running = true
		$AnimationPlayer.play("run")


func _on_AtkArea_area_entered(area):
	if area == dragon:
		running = false
		$AnimationPlayer.play("attack")
		$AtkTimer.start()


func _on_AtkTimer_timeout():
	for a in $AtkArea.get_overlapping_areas():
		if a == dragon:
			dragon.get_damage()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "attack":
		$AnimationPlayer.play("idle")
