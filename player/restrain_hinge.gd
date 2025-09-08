extends Node3D

const SAIL_ANGLE_CURVE = preload("res://player/sail_angle_curve.tres")

@export var motor_strength = 0.3
@export var hinge_joint: HingeJoint3D
@export var boom: RigidBody3D
@export var MIN: int = 0
@export var MAX: int = 80

var motor_active: bool = false

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

	flip_sails(wind_direction)

func calulate_is_clockwise():
	var boom_rotation = boom.rotation.y
	return true if boom_rotation < 0 else false
	

func flip_sails(wind_direction: Vector3):
	var boom_dot = wind_direction.dot(boom.global_basis.z)
	if (boom_dot < -0.6):
		if (!motor_active):
			enable_flip_motor(calulate_is_clockwise())
			motor_active = true
	else:
		disable_flip_motor()
		motor_active = false

func enable_flip_motor(clockwise: bool):
	var motor_velocity = 10
	var target_velocity = -motor_velocity if clockwise else motor_velocity
	# enable motor. Default: false
	hinge_joint.set_flag(HingeJoint3D.FLAG_ENABLE_MOTOR, true)
	# set target_velocity. Default: 57.3
	hinge_joint.set_param(HingeJoint3D.PARAM_MOTOR_TARGET_VELOCITY, target_velocity)
	# set max impulse. Default: 1
	hinge_joint.set_param(HingeJoint3D.PARAM_MOTOR_MAX_IMPULSE, motor_strength)

func disable_flip_motor():
	hinge_joint.set_flag(HingeJoint3D.FLAG_ENABLE_MOTOR, false)
