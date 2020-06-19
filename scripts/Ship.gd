extends Spatial

onready var spawn = $Spatial/EnemySpawn

export(String, "Catapult", "Scorpio", "None") var weapon_type = "Catapult"


func _ready():
	if OS.get_name() == "Android":
		var sail_material = $Spatial/Mesh.mesh.surface_get_material(2)
		sail_material.flags_unshaded = true
		$Spatial/Mesh.mesh.surface_set_material(2, sail_material)
	
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
