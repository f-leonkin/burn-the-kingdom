extends OmniLight


func _ready():
	light_energy = 0


func light():
	$AnimationPlayer.play("light")
