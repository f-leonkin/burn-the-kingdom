extends Enemy

var missile 
var agro = false
var distance = 70

onready var rotate_object = self

export var force_noagro = false


func _ready():
	if "Archer" in name:
		missile = load("res://scenes/Missiles/Arrow.tscn")
	elif "Wizard" in name:
		missile = load("res://scenes/Missiles/WizardMissile.tscn")
	elif "Witch" in name:
		missile = load("res://scenes/Missiles/WitchMissile.tscn")
	elif "Scorpio" in name:
		missile = load("res://scenes/Missiles/Arrow.tscn")
		rotate_object = $Gun


func _on_AgroArea_area_entered(area):
	if !agro and !force_noagro and area == dragon:
		agro = true
		start_fire()


func start_fire():
	if $AtkTimer.is_stopped():
		shoot()
		$AtkTimer.start()


func shoot():
	if agro:
		rotate_object.look_at((dragon.global_transform.origin * Vector3(1, 0, 1)) \
				+ Vector3(0, rotate_object.global_transform.origin.y, 0), \
				Vector3.UP)
		if has_node("AnimationPlayer"):
			$AnimationPlayer.play("attack")
		if has_node("AudioStreamPlayer"):
			$AudioStreamPlayer.play()
		var mi = missile.instance()
		get_parent().add_child(mi)
		mi.global_transform = rotate_object.global_transform
	else:
		$AtkTimer.stop()


func _on_AtkTimer_timeout():
	shoot()


func _on_AgroArea_area_exited(area):
	if area == dragon and get_parent().name != "Guns":
		agro = false
		if has_node("AnimationPlayer"):
			$AnimationPlayer.play("idle")
