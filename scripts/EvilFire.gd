extends Area

const SPEED = 20

var dragon = G.dragon
var speed_mult = 1.0


func _ready():
	if name == "SuperAttack":
		$AnimationPlayer.play("spawn")


func _process(delta):
	if name != "SuperAttack":
		translate_object_local(Vector3(0, 0, SPEED * speed_mult * delta))


func _on_Timer_timeout():
	queue_free()


func _on_Fire_area_entered(area):
	do_damage(area)


func _on_SATimer_timeout():
	for a in get_overlapping_areas():
		do_damage(a)


func do_damage(area):
	if area == dragon:
		area.get_damage()
		if name != "SuperAttack":
			queue_free()
