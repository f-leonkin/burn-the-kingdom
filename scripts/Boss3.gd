extends Enemy

const SPEED = 25

onready var ed = $Dragon
var dead = false
var threshold = .35
var dir = 0

onready var fireball = load("res://scenes/EvilFireball.tscn")
onready var super_attack_area = load("res://scenes/SuperAttack.tscn")


func _process(delta):
	if dead:
		translation.y -= 5 * delta
		if translation.y < -25:
			dragon.get_parent().ending()
			queue_free()
		return
	if !vulnerable:
		return
	var dgox = dragon.global_transform.origin.x
	var gox = global_transform.origin.x
	if gox > dgox + threshold:
		dir = -1
	elif gox < dgox - threshold:
		dir = 1
	else:
		dir = 0
	translation.x += dir * SPEED * delta


func _on_AgroArea_body_entered(body):
	if body is StaticBody:
		G.dragon.get_parent().speed = 0
		$AnimationPlayer.play("spawn")


func _on_AnimationPlayer_animation_finished(anim_name):
	vulnerable = true
	collision_layer = 1
	collision_mask = 1
	$ShootTimer.start()
	var es = get_node("../BossEnemySpawns")
	for c in es.get_children():
		c.start()


func _on_ShootTimer_timeout():
	var fi = fireball.instance()
	get_parent().add_child(fi)
	fi.global_transform.origin = ed.global_transform.origin + Vector3(0, 0, 4.5)
	fi.rotate_y(PI)


func death():
	$ShootTimer.stop()
	dragon.playable = false
	dead = true
	vulnerable = false
	ed.get_node("BossFlames").visible = true
