extends Node3D

@export var player: Player

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# lock rotation
	var radians = deg_to_rad(Globals.wind_direction)
	global_rotation.y = radians
	
	# set "initial_velocity" to the same as player, but negative.
	
	# player.velocity
	set("initial_velocity", 50)
	# TODO: set the property correctly
