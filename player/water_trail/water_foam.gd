extends Node3D

@export var player: Player
@onready var gpu_particles_3d: GPUParticles3D = $GPUParticles3D

func _process(_delta: float) -> void:
	global_rotation_degrees.z = 0
	
	#var ratio = (1 - (player.velocity.length() / 14)) / 1
	#gpu_particles_3d.interp_to_end = ratio
	#print(ratio)
