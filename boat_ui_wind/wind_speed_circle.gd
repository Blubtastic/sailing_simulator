extends Node3D

@onready var raycast: RayCast3D = $SpeedRayCast
@onready var arrow_head: Node3D = $ArrowHead
@onready var draw_line: MeshInstance3D = $DrawLine

var speed = 0.0

func _physics_process(_delta: float) -> void:
	if raycast.is_colliding():
		var hit_position = raycast.get_collision_point()
		var distance = hit_position.distance_to(global_position)
		speed = distance if distance > 7.0 else 0.0
		
		# Display visuals
		var arrow_scale = (speed*0.1)*(speed*0.1)
		arrow_head.scale = Vector3(arrow_scale, arrow_scale, arrow_scale)
		var visual_position = hit_position if speed > 0 else global_position
		arrow_head.global_position = visual_position
		draw_line.draw_line(visual_position)
	else:
		draw_line.draw_line(global_position)
		arrow_head.global_position = global_position
		arrow_head.scale = Vector3(0, 0, 0)
		speed = 0

func get_speed():
	return speed
