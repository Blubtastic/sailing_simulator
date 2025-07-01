extends Node3D

func _physics_process(_delta: float) -> void:
	var radians = deg_to_rad(Globals.wind_direction)
	var wind_direction = Vector3(sin(radians), 0, cos(radians)).normalized()
	look_at(global_position + wind_direction)
