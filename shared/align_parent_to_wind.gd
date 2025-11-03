extends Node3D

@export var offset: int = 0

func _physics_process(_delta: float) -> void:
	var parent = get_parent()
	if "look_at" in parent and "global_position" in parent:
		var radians = deg_to_rad(Globals.wind_direction)
		var wind_direction = Vector3(sin(radians), 0, cos(radians)).normalized()
		parent.look_at(parent.global_position - wind_direction)
		
	else:
		print("ERROR:", parent, "does not have funcs")
