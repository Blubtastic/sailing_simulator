extends Node3D

const SAIL_ANGLE_CURVE = preload("res://player/sail_angle_curve.tres")

@export var hinge_joint: HingeJoint3D
@export var isFlipped: bool
@export var boom: RigidBody3D
@export var MIN: int = 0
@export var MAX: int = 80

func _physics_process(_delta: float) -> void:
	# Direction of boat
	var boat_direction = -global_basis.z
	
	# Direction of wind
	var radians = deg_to_rad(Globals.wind_direction)
	var wind_direction = Vector3(sin(radians), 0, cos(radians)).normalized()
	
	# Angle between boat and wind
	# Dot product is number where -1 is against wind and 1 is with wind.
	var direction_dot_product = boat_direction.dot(wind_direction)
	var sample_ratio = (direction_dot_product + 1) / 2 # 0-1
	# Tweak ratio - should go from 0-1 in the range 35-180 instead of 0-180
	var sail_ratio = clamp(SAIL_ANGLE_CURVE.sample(sample_ratio), 0, 1)
	
	# Ratio to angle, degs to rads
	var joint_angle = ((MAX - MIN) * sail_ratio)
	var joint_radians = deg_to_rad(joint_angle)
	
	# Set joint limits
	hinge_joint.set_param(HingeJoint3D.PARAM_LIMIT_UPPER, joint_radians)
	hinge_joint.set_param(HingeJoint3D.PARAM_LIMIT_LOWER, -joint_radians)
	
	# TODO: find out whether to rotate clockwise or anticlockwise (is sail left or right)?
	
	# Dot product between wind and boom
	var wind_boom_dot_product = wind_direction.dot(boom.global_basis.z)
	if (wind_boom_dot_product < -0.6):
		flip_sail_begin(isFlipped)
	else:
		flip_sail_end()
	print(wind_boom_dot_product)

func flip_sail_begin(clockwise: bool):
	var motor_velocity = 10
	var target_velocity = -motor_velocity if clockwise else motor_velocity
	# enable motor. Default: false
	hinge_joint.set_flag(HingeJoint3D.FLAG_ENABLE_MOTOR, true)
	# set target_velocity. Default: 57.3
	hinge_joint.set_param(HingeJoint3D.PARAM_MOTOR_TARGET_VELOCITY, target_velocity)
	# set max impulse. Default: 1
	hinge_joint.set_param(HingeJoint3D.PARAM_MOTOR_MAX_IMPULSE, 1)

func flip_sail_end():
	hinge_joint.set_flag(HingeJoint3D.FLAG_ENABLE_MOTOR, false)
