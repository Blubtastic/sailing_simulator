extends HingeJoint3D

func _physics_process(_delta: float) -> void:
	var wind_direction = deg_to_rad(Globals.wind_direction)
	#print(rotation.y, wind_direction)
	# TODO: restrain upper and lower angular limits based on wind direction onto boat
