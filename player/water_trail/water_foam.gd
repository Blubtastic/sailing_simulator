extends Node3D

@export var player: Player
@onready var gpu_particles_3d: GPUParticles3D = $GPUParticles3D

func _process(_delta: float) -> void:
	global_rotation_degrees.z = 0
	
	# Fade out particles when slow / standstill
	var ratio = (player.velocity.length() / 10) / 1
	gpu_particles_3d.amount_ratio = ratio
