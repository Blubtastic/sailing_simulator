extends Node3D

@export var ParticleEffect : PackedScene
@export var SpawnSpread : float = 0.0
@export var PlayerCharacter: Player

func _input(_event):
	if (Input.is_action_just_pressed("Click")):
		var newParticle = ParticleEffect.instantiate() as Node3D
		add_child(newParticle)
		
		var rng : RandomNumberGenerator = RandomNumberGenerator.new()
		rng.randomize()
		
		var player_position = PlayerCharacter.global_position
		newParticle.global_position = player_position
		# TODO: Tweak spawn
		# TODO: Create scene from Explosion and fix stuff
