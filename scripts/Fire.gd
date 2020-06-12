extends Area

const SPEED = 20

var speed_mult = 1.0


func _ready():
	if name != "SuperAttack":
		if G.dragon.power == 1:
			$Timer.wait_time = 1
		$Timer.start()
	else:
		$AnimationPlayer.play("spawn")


func _process(delta):
	if name != "SuperAttack":
		translate_object_local(Vector3(0, 0, SPEED * speed_mult * delta))
		if G.dragon.get_parent().global_transform.origin.z \
				- global_transform.origin.z > 45:
					queue_free() # remove fireball if it's out of screen


func _on_Timer_timeout():
	queue_free()


func _on_Fire_area_entered(area):
	do_damage(area)


func _on_SATimer_timeout():
	for a in get_overlapping_areas():
		do_damage(a)


func do_damage(area):
	if area.is_in_group("Enemies"):
		area.get_damage()
		if name != "SuperAttack":
			queue_free()
	elif area.is_in_group("Flame"):
		area.burn()
