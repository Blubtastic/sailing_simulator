extends Node3D
@onready var raycast: RayCast3D = $SpeedRayCast
@onready var wind_pointer: Node3D = $WindPointer

func _physics_process(delta: float) -> void:
	var wind_angle = Globals.wind_direction - rotation_degrees.y
	if raycast.is_colliding():
		var hit_position = raycast.get_collision_point()
		wind_pointer.global_position = hit_position
		print("Hit Position: ", hit_position)
