extends CharacterBody3D
class_name Player

@onready var wind_speed_circle: Node3D = $WindHUD/WindSpeedCircle
const HEEL_CURVE = preload("res://player/heel_curve.tres")

const ROTATE_FORCE = 1.5
const ROTATE_MAX_SPEED = 0.4
var rotate_speed = 0.0

var acceleration = 10
const SPEED_FORCE = 1.0
var speed = 0.0

func _physics_process(delta: float) -> void:
	# ROTATION
	if Input.is_action_pressed("ui_left"):
		rotate_speed = lerpf(rotate_speed, ROTATE_MAX_SPEED, ROTATE_FORCE*delta)
	if Input.is_action_pressed("ui_right"):
		rotate_speed = lerpf(rotate_speed, -ROTATE_MAX_SPEED, ROTATE_FORCE*delta)
	if not Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
		# Grind rotation to a halt
		rotate_speed = lerpf(rotate_speed, 0.0, ROTATE_FORCE*2*delta)
	rotation.y = lerp_angle(rotation.y, rotation.y+rotate_speed, 4.0*delta)
	
	# SPEED
	var velocity_direction := -global_transform.basis.z
	var wind_speed = wind_speed_circle.get_speed()
	speed = lerpf(velocity.length(), wind_speed, SPEED_FORCE*delta)
	velocity = velocity_direction * speed
	move_and_slide()
	apply_heel(delta)

# Rotate player along local x-axis based on direction towards wind
func apply_heel(delta: float):
	# Get movement vectors
	var boat_direction = -global_basis.z
	var radians = deg_to_rad(Globals.wind_direction)
	var wind_direction = Vector3(sin(radians), 0, cos(radians)).normalized()
	
	# Get which side wind is coming from by using cross product.
	var cross_boat_wind = boat_direction.cross(wind_direction)
	var direction = cross_boat_wind.y
	
	# Get angle by using dot product.
	var direction_dot_product = boat_direction.dot(wind_direction)	
	var sample_ratio = (direction_dot_product + 1) / 2 # 0-1
	var heel_ratio = clamp(HEEL_CURVE.sample(sample_ratio), 0, 1)
	var rads = 0.5*PI*heel_ratio
	
	# Set heel amount
	rotation.z = lerpf(rotation.z, rads*direction, 1*delta)
