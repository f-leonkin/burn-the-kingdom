extends Spatial

var archer = load("res://scenes/Enemies/Archer.tscn")
var wizard = load("res://scenes/Enemies/Wizard.tscn")
var enemy


func start():
	$Timer.start()


func _on_Timer_timeout():
	for c in get_children():
		if c is Spatial:
			spawn(c)


func spawn(s):
	for c in s.get_children():
		if c is Enemy:
			return
	
	if randf() > .5:
		enemy = archer.instance()
	else:
		enemy = wizard.instance()
	s.add_child(enemy)
	var anim_player = s.get_node("AnimationPlayer")
	anim_player.play("move")
