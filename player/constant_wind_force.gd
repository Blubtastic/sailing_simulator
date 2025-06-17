extends RigidBody3D

# Wind properties
var wind_strength: float = 100.0  # Strength of the wind
var wind_direction: Vector3 = Vector3(-1, 0, -1)  # Direction of the wind (global coordinates)

func _physics_process(_delta):
	# Apply wind force to the sail
	var force = wind_direction.normalized() * wind_strength
	apply_force(force, Vector3.ZERO)  # Apply force at the center of mass

# TODO: Read SoftBody3D documentation. It has built-in support for wind-force!
