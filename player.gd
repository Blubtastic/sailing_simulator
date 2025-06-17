extends CharacterBody3D

@onready var wind_speed_circle: Node3D = $WindHUD/WindSpeedCircle

const ACCELLERATE_VEC = Vector3(0, 0, -10)
const ROTATE_ANGLE = 3
const ACCELERATION = 0.2
const MAX_SPEED = 10
const MAX_WIND_ANGLE = 35
var current_velocity = 0

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("ui_left"):
		rotation.y += ROTATE_ANGLE * delta
	if Input.is_action_pressed("ui_right"):
		rotation.y -= ROTATE_ANGLE * delta
		
	move_and_slide()
	
	var velocity_direction = global_transform.basis.z
	#var velocity_increase = ACCELLERATE_VEC.rotated(Vector3.UP, rotation.y) * delta * 1
	
	var wind_angle = Globals.wind_direction - rotation_degrees.y
	var is_headwind = abs(wind_angle) < MAX_WIND_ANGLE
	if !is_headwind:
		current_velocity = clamp(0, current_velocity+ACCELERATION, MAX_SPEED)
		velocity = velocity_direction * -current_velocity
	else:
		if current_velocity > 0:
			current_velocity = clamp(0, current_velocity-ACCELERATION*2, MAX_SPEED)
		else:
			current_velocity = 0
		velocity = velocity_direction * -current_velocity
