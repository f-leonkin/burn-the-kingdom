extends Area

const MAX_HP = 10
const SPEED = 70

var hp = MAX_HP
var power = 1
var power_dec_counter = 0
var change_power = false
var super_attack = false
var super_attack_fill = 0
var slope = 0 # -1 - left, 1 - right
var cur_slope = 0
var damaged = false
var move_target = Vector3()
var speed_mult = 1.0
var playable = false
var threshold = .8
var fireball_deg = 20

onready var fireball = load("res://scenes/Fireball.tscn")
onready var super_attack_area = load("res://scenes/SuperAttack.tscn")
onready var slope_ap = $SlopeAnimationPlayer
onready var wings_ap = $WingsAnimationPlayer
onready var shoot_ap = $ShootAnimationPlayer
onready var dmg_ap = $DamagedAnimationPlayer


func _ready():
	G.dragon = self
	power = G.power
	apply_power()
	shoot_ap.playback_speed = 3
	slope_ap.playback_speed = 2


func _process(delta):
	slope()
	
	if Input.is_action_just_pressed("super_attack"):
		if super_attack_fill == 100:
			do_super_attack()


func slope():
	if slope != cur_slope:
		match slope:
			-1:
				if slope_ap.current_animation != "slope-left" or \
						slope_ap.get_playing_speed() < 0:
					slope_ap.play("slope-left", .3)
					cur_slope = slope
			1:
				if slope_ap.current_animation != "slope-right" or \
						slope_ap.get_playing_speed() < 0:
					slope_ap.play("slope-right", .3)
					cur_slope = slope
			0:
				slope_ap.play_backwards(slope_ap.current_animation)


func _physics_process(delta):
	if !playable:
		return
	var move_dir = Vector3()
	var go = global_transform.origin
	slope = 0
	if go.distance_to(move_target) > threshold and move_target:
		move_dir = Vector3(move_target - go)
		global_transform.origin += \
				move_dir.normalized() * SPEED * speed_mult * delta
		if abs(move_dir.x) > 1: # don't start slope if we move just a little
			slope = int(sign(move_dir.x))


func _on_SlopeAnimationPlayer_animation_finished(anim_name):
	if slope == 0:
		cur_slope = 0


func _on_ShootTimer_timeout():
	shoot()


func shoot():
	if !playable or super_attack:
		return
	if change_power:
		apply_power()
	$FireSound.play()
	shoot_ap.play("shoot")
	match power:
		1:
			var fi = fireball.instance()
			fi.translation = translation - Vector3(0, 0, 4.5)
			get_parent().add_child(fi)
		2, 3:
			for i in range(3):
				var fi = fireball.instance()
				match i:
					1:
						fi.rotate_y(deg2rad(-fireball_deg))
					2:
						fi.rotate_y(deg2rad(fireball_deg))
				fi.translation = translation - Vector3(0, 0, 4.5)
				fi.speed_mult = (power + 1) / 2
				get_parent().add_child(fi)


func apply_power():
	if power > 3:
		power = 3
	$ShootTimer.stop()
	if power == 3:
		speed_mult = 1.2
		$ShootTimer.wait_time = 1
	else:
		speed_mult = 1.0
		$ShootTimer.wait_time = 1.5
	power_dec_counter = 6 / power
	change_power = false
	$ShootTimer.start()


func get_damage():
	if damaged or super_attack or !playable:
		return
	damaged = true
	hp -= 1
	if hp <= 0:
		wings_ap.stop()
		dmg_ap.play("death")
		return
	dmg_ap.play("damaged")
	if power > 1:
		power_dec_counter -= 1
		if power_dec_counter <= 0:
			power -= 1
			change_power = true


func _on_Dragon_area_entered(area):
	if area.is_in_group("Missile"):
		get_damage()
		area.queue_free()


func _on_DamagedAnimationPlayer_animation_finished(anim_name):
	match anim_name:
		"damaged":
			damaged = false
		"death":
			get_parent().loading()


func _on_SuperAttackButton_pressed():
	do_super_attack()


func do_super_attack():
	$SuperAttackSound.play()
	super_attack = true
	super_attack_fill = 0
	var saai = super_attack_area.instance()
	add_child(saai)
	shoot_ap.playback_speed = 1
	$ShootAnimationPlayer.play("super_attack")


func _on_ShootAnimationPlayer_animation_finished(anim_name):
	if anim_name == "super_attack":
		super_attack = false
		shoot_ap.playback_speed = 3
		for c in get_children():
			if c.name == "SuperAttack":
				c.queue_free()
