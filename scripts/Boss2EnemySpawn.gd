extends Spatial

var wizard = load("res://scenes/Enemies/Wizard.tscn")
var archer = load("res://scenes/Enemies/Archer.tscn")
var witch = load("res://scenes/Enemies/Witch.tscn")


func start():
	$Timer.start()


func _on_Timer_timeout():
	for c in get_children():
		if c is Enemy:
			return
	
	randomize()
	var enemy
	var random = randf()
	if random > .7:
		enemy = wizard.instance()
	elif random > .3:
		enemy = archer.instance()
	else:
		enemy = witch.instance()
	add_child(enemy)


func _on_Boss_dead():
	queue_free()
