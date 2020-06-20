extends Enemy

var agro = false
var fired = false
var sound_played = false
var rock = load("res://scenes/Missiles/Rock.tscn")

onready var rock_spawn = $RockSpawn


func _process(delta):
	if $AnimationPlayer.is_playing():
		if $AnimationPlayer.current_animation_position > .4 and !sound_played:
			$AudioStreamPlayer.play()
			sound_played = true
		if $AnimationPlayer.current_animation_position > .5 and !fired:
			spawn_rock()
			fired = true


func spawn_rock():
	var ri = rock.instance()
	get_parent().add_child(ri)
	ri.global_transform = rock_spawn.global_transform


func _on_AgroArea_area_entered(area):
	if area == dragon:
		agro = true
		$AnimationPlayer.play("fire")


func _on_AnimationPlayer_animation_finished(anim_name):
	fired = false
	sound_played = false
	if agro:
		$AnimationPlayer.play("fire")
