extends Node

var level = 1
var dragon
var power = 1
var powerup_spawned = false
var mute = false
var finished = false


func toggle_sound():
	mute = !mute
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), mute)


func load_scene():
	match level:
		1:
			get_tree().change_scene("res://scenes/LevelOne.tscn")
		2:
			get_tree().change_scene("res://scenes/LevelTwo.tscn")
		3:
			get_tree().change_scene("res://scenes/LevelThree.tscn")
