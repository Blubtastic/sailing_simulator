extends RigidBody3D

var wind_strength: float = 150.0  # Strength of the wind
#var wind_direction: Vector3 = Vector3(-1, 0, -1)  # Direction of the wind (global coordinates)

func _physics_process(_delta):
	# Get wind direction vector
	var radians = deg_to_rad(Globals.wind_direction)
	var wind_direction = Vector3(sin(radians), 0, cos(radians)).normalized()
	
	# Apply wind force to the sail
	var force = wind_direction * wind_strength
	apply_force(force, Vector3.ZERO)  # Apply force at the center of mass
	
