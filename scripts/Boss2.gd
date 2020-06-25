extends Enemy

const SPEED = 15

var state = "attack" # or "swim" or "dead"
var swim_dir = 0

var fireball = load("res://scenes/SnakeFireball.tscn")


func _process(delta):
	if state == "swim":
		$Snake.translation.x += swim_dir * SPEED * delta
		if $Snake.translation.x > 80 or $Snake.translation.x < -80:
			state = "attack"
			attack()
	elif state == "dead":
		$Snake.translation.y -= delta * 1.1


func _on_AgroArea_body_entered(body):
	if body is StaticBody:
		G.dragon.get_parent().speed = 0
		attack(true)


func attack(first = false):
	var coords = Vector3()
	if first:
		coords = Vector3(0, -1.8, 20)
	else:
		randomize()
		coords = Vector3(5*((randi() % 5)-2), -1.8, 20)
	$Snake.translation = coords
	$Snake.rotation_degrees.y = 0
	$Snake/AnimationPlayer.play("attack")
	$AtkTimer.start()


func _on_AtkTimer_timeout():
	$AudioStreamPlayer.play()
	var fi = fireball.instance()
	$Snake/MissileSpawn.look_at(G.dragon.global_transform.origin \
			* Vector3(1, 0, 1) \
			+ Vector3(0, $Snake/MissileSpawn.global_transform.origin.y, 0), \
			Vector3.UP)
	add_child(fi)
	fi.global_transform = $Snake/MissileSpawn.global_transform


func swim():
	$EnemySpawn.activate()
	state = "swim"
	randomize()
	var coord_x = 30 - 60 * round(randf())
	var coord_z = 10 + randi() % 15
	print(coord_z)
	swim_dir = sign(-coord_x)
	$Snake.translation = Vector3(coord_x, 0, coord_z)
	$Snake.rotation_degrees.y = (90 * swim_dir)
	$Snake/AnimationPlayer.play("swim")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "attack" and hp > 0:
		swim()


func death():
	state = "dead"
	dragon.playable = false
	G.power = dragon.power
	G.level = 3
	$Snake/BossFlames.visible = true
	$Snake/AnimationPlayer.stop()
	$DeathTimer.start()


func _on_DeathTimer_timeout():
	dragon.get_parent().get_parent().get_node("AudioStreamPlayer").stop()
	dragon.get_parent().loading()
