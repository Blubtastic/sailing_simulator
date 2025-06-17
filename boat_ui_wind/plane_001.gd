extends MeshInstance3D

func _physics_process(_delta: float) -> void:
	var wind_angle = Globals.wind_direction
	global_rotation_degrees = Vector3(0, wind_angle, 0)
