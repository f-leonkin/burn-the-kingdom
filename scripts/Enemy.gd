extends Area
class_name Enemy

var powerup = load("res://scenes/PowerUp.tscn")
var burn = load("res://scenes/Enemies/EnemyBurn.tscn")

onready var dragon = G.dragon

export var hp = 1
export var vulnerable = true

signal dead


func _process(delta):
	if global_transform.origin.z - dragon.global_transform.origin.z > 150 \
			or abs(global_transform.origin.x) > 50:
		queue_free()


func get_damage():
	if !vulnerable:
		return
	hp -= 1
	if hp > 0:
		if has_node("DamageLight"):
			$DamageLight.light()
	else:
		if !dragon.super_attack:
			dragon.super_attack_fill += 10
			if dragon.super_attack_fill > 100:
				dragon.super_attack_fill = 100
		if !("Boss" in name):
			match dragon.power:
				1:
					randomize()
					if randf() > .6: # 40%
						spawn_power_up()
				2:
					randomize()
					if randf() > .9: # 10%
						spawn_power_up()
		if "Catapult" in name or "Scorpio" in name:
			if dragon.hp < 10:
				dragon.hp += 1
		emit_signal("dead")
		death()


func death():
	if !("Boss" in name):
		var bi = burn.instance()
		dragon.get_parent().get_parent().add_child(bi)
		bi.global_transform.origin = global_transform.origin
	queue_free()


func spawn_power_up():
	if G.powerup_spawned or ("Guns" in get_parent().name):
		return
	var pi = powerup.instance()
	dragon.get_parent().get_parent().add_child(pi)
	pi.global_transform.origin = global_transform.origin
