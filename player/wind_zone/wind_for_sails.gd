extends Area3D

func _physics_process(_delta: float) -> void:
	wind_force_magnitude = wind_force_magnitude
	look_at(global_position - Vector3(0,0,1))
