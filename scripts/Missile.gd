extends Area

var speed = 15


func _ready():
	if "Arrow" in name:
		if get_parent().name == "Guns":
			speed = 32
		else:
			speed = 15
	elif "WitchMissile" in name:
		speed = 40
	elif "WizardMissile" in name:
		speed = 25


func _process(delta):
	translate_object_local(Vector3(0, 0, -speed * delta))


func _on_Timer_timeout():
	queue_free()
