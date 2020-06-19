extends MeshInstance


func _ready():
	if OS.get_name() == "Android":
		var water_shader = load("res://assets/water-static.tres")
		mesh.material.shader = water_shader
