extends Enemy

var out_coords = Vector3(0, 0, -35)


func _ready():
	hp = 15


func _on_AgroArea_body_entered(body):
	if body is StaticBody:
		G.dragon.get_parent().speed = 0
		attack(true)


func attack(init = false):
	var coords = Vector3()
	if init:
		coords = Vector3(0, -1.8, 20)
	else:
		randomize()
		coords = Vector3(5*((randi() % 5)-2), -1.8, 20)
	$Snake.translation = coords
	$Snake/AnimationPlayer.play("attack")
	$AtkTimer.start()


func _on_AtkTimer_timeout():
	print("ATK")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "attack" and hp > 0:
		pass
