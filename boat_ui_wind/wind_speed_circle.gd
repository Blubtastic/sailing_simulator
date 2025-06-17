extends Node3D

@onready var raycast: RayCast3D = $SpeedRayCast
@onready var arrow_head: Node3D = $ArrowHead
@onready var draw_line: MeshInstance3D = $DrawLine

func _physics_process(_delta: float) -> void:

	if raycast.is_colliding():
		var hit_position = raycast.get_collision_point()
		#print(raycast.get_collider())
		var speed = hit_position.distance_to(global_position)
		arrow_head.global_position = hit_position
		var speedSize = speed*0.1
		var speedSizeExp = speedSize*speedSize
		arrow_head.scale = Vector3(speedSizeExp, speedSizeExp, speedSizeExp)
		draw_line.draw_line(hit_position)
		
