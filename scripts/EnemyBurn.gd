extends Spatial


func _ready():
	$Flame/AnimationPlayer.playback_speed = 4


func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
