extends Node3D
@onready var raycast: RayCast3D = $"."
@onready var arrow_head: Node3D = $"../ArrowHead"
@export var speed = 0
signal position_hit(pos)

func _physics_process(_delta: float) -> void:
	if raycast.is_colliding():
		var hit_position = raycast.get_collision_point()
		var hit_position_local = to_local(raycast.get_collision_point())
		speed = hit_position.distance_to(global_position)
		arrow_head.global_position = hit_position
		var speedSize = speed*0.1
		var speedSizeExp = speedSize*speedSize
		arrow_head.scale = Vector3(speedSizeExp, speedSizeExp, speedSizeExp)
		emit_signal("position_hit", hit_position_local)
