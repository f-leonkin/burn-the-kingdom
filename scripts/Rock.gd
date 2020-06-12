extends Area

const SPEED = 20


func _process(delta):
	translate_object_local(Vector3(0, 0, SPEED * delta))


func _on_Timer_timeout():
	queue_free()
