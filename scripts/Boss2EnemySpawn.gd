extends Spatial

var archer = load("res://scenes/Enemies/Archer.tscn")
var wizard = load("res://scenes/Enemies/Wizard.tscn")
var witch = load("res://scenes/Enemies/Witch.tscn")
var enemy

var spawned_l = false
var spawned_r = false


func activate():
	randomize()
	if randf() > .5:
		if !spawned_l:
			spawned_l = true
			spawn($SpawnL)
	else:
		if !spawned_r:
			spawned_r = true
			spawn($SpawnR)


func spawn(s):
	var random = randf()
	if random > .3:
		enemy = archer.instance()
	elif random > .65:
		enemy = wizard.instace()
	else:
		enemy = witch.instance()
	s.add_child(enemy)
	enemy.translation.y = 1.8
	enemy.connect("dead", self, "sink", [s])
	s.get_node("Boat").translation.y = 0
	for c in s.get_node("Boat").get_children():
		c._ready()
	s.get_node("AnimationPlayer").play("move")


func sink(s):
	s.get_node("AnimationPlayer").play("sink")


func _on_AnimationPlayer_L_animation_finished(anim_name):
	if anim_name == "sink":
		spawned_l = false
		$SpawnL.translation.x = -40
		$SpawnL/Boat.translation.y = 0


func _on_AnimationPlayer_R_animation_finished(anim_name):
	if anim_name == "sink":
		spawned_r = false
