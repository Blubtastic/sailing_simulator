extends SoftBody3D
const SAIL_ANGLE_CURVE = preload("res://player/sail_angle_curve.tres")
@export var MIN: int = 5
@export var MAX: int = 15
@onready var main_sail_anchor: Node3D = $"../../../MainSailAnchor"

func _process(_delta: float) -> void:
	pass
	# Change simulation precision from 5 to 15 based on wind angle (5 is downwind, 15 is close hauled)
	# property: simulation_precision
	# reuse code from restrain_hinge.gd
	
	# Direction of boat
	# TODO: get boat direction without referencing parent
	var boat_direction = -main_sail_anchor.global_basis.z
	
	# Direction of wind
	var radians = deg_to_rad(Globals.wind_direction)
	var wind_direction = Vector3(sin(radians), 0, cos(radians)).normalized()
	
	# Angle between boat and wind
	# Dot product is number where -1 is against wind and 1 is with wind.
	var direction_dot_product = boat_direction.dot(wind_direction)
	var sample_ratio = (direction_dot_product + 1) / 2 # 0-1
	# Tweak ratio - should go from 0-1 in the range 35-180 instead of 0-180
	var sail_ratio = clamp(SAIL_ANGLE_CURVE.sample(sample_ratio), 0, 1)
	
	simulation_precision = MAX - ((MAX - MIN) * sail_ratio)
