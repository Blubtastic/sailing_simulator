extends CharacterBody3D

@onready var wind_speed_circle: Node3D = $WindHUD/WindSpeedCircle

const ROTATE_FORCE = 3.0
const ROTATE_MAX_SPEED = 0.6
var rotate_speed = 0.0

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
	var velocity_direction = global_transform.basis.z
	var wind_speed = wind_speed_circle.get_speed()
	speed = lerpf(speed, wind_speed, SPEED_FORCE*delta)
	velocity = velocity_direction * -speed
	move_and_slide()
