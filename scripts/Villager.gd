extends Enemy

const SPEED = 5

var dir = 1


func _ready():
	randomize()
	yield(get_tree().create_timer(randf() * 2), "timeout")
	$Timer.start()


func _process(delta):
	translate_object_local(Vector3(0, 0, SPEED * dir * delta))


func _on_Timer_timeout():
	dir = -dir
	if $Spatial.rotation_degrees.y == 0:
		$Spatial.rotation_degrees.y = 180
	else:
		$Spatial.rotation_degrees.y = 0
