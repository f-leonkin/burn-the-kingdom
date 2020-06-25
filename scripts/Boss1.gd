extends Enemy

var scorpio = 2


func _ready():
	hp = 5


func _physics_process(delta):
	if scorpio == 0:
		vulnerable = true


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "spawn":
		$AnimationPlayer.play("fly")
		for c in $Mesh/Guns.get_children():
			if c is Enemy:
				c.agro = true
				c.force_noagro = false
				c.start_fire()
				c.vulnerable = true
		$EnemySpawn.start()
	elif anim_name == "death":
		dragon.get_parent().get_parent().get_node("AudioStreamPlayer").stop()
		dragon.get_parent().loading()


func _on_AgroArea_body_entered(body):
	if body is StaticBody:
		G.dragon.get_parent().speed = 0
		$AnimationPlayer.play("spawn")


func death():
	dragon.playable = false
	G.power = dragon.power
	G.level = 2
	$Mesh/House/Flames.visible = true
	$AnimationPlayer.play("death")


func _on_Scorpio_dead():
	scorpio -= 1
