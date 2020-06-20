extends Spatial


func _ready():
	$ShootAnimationPlayer.playback_speed = 10
	$ShootAnimationPlayer.play_backwards("roll-left")
	$ShootAnimationPlayer.playback_speed = 5
	$WingsAnimationPlayer.play("wings")


func _on_ShootTimer_timeout():
	$ShootAnimationPlayer.play("shoot")
	$AudioStreamPlayer.play()


func _on_Boss_dead():
	$WingsAnimationPlayer.stop()
