extends Node3D

@export var offset: int = 0

func _physics_process(_delta: float) -> void:
	var wind_angle = Globals.wind_direction + offset
	var parent = get_parent()
	if "global_rotation_degrees" in parent:
		parent.global_rotation_degrees = Vector3(0, wind_angle, 0)
	else:
		print("ERROR:", parent, "does not have func global_rotation_degrees")
