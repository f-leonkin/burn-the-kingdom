extends Area
class_name PowerUp

onready var dragon = G.dragon


func _ready():
	G.powerup_spawned = true
	rotation_degrees.y = -get_parent().rotation_degrees.y


func _on_PowerUp_area_entered(area):
	if area == dragon:
		if dragon.power < 3:
			dragon.power += 1
			dragon.apply_power()
		G.powerup_spawned = false
		queue_free()


func _on_Timer_timeout():
	$AnimationPlayer.play("disappear")


func _on_AnimationPlayer_animation_finished(anim_name):
	G.powerup_spawned = false
	queue_free()
