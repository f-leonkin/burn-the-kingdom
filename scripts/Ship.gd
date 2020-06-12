extends Spatial

onready var spawn = $Spatial/EnemySpawn

export(String, "Catapult", "Scorpio", "None") var weapon_type = "Catapult"

func _ready():
	if weapon_type == "None":
		return
	var weapon
	match weapon_type:
		"Catapult":
			weapon = load("res://scenes/Enemies/Catapult.tscn")
		"Scorpio":
			weapon = load("res://scenes/Enemies/Scorpio.tscn")
			spawn.rotation_degrees.y = 180
	var wi = weapon.instance()
	spawn.add_child(wi)
