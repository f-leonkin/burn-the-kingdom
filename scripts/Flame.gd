extends Area

onready var dragon = G.dragon


func _ready():
	if get_parent().name != "BossFlames":
		rotation_degrees.y = -get_parent().rotation_degrees.y
		$Mesh.visible = false
	$AnimationPlayer.playback_speed = 4
	randomize()
	var s = .8 + randi() % 5 / 100
	scale = Vector3(s, s, s)


func burn():
	if $Mesh.visible == false:
		$Mesh.visible = true
		if !dragon.super_attack:
			dragon.super_attack_fill += 1
			if dragon.super_attack_fill > 100:
				dragon.super_attack_fill = 100
