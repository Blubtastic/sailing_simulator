extends SoftBody3D

func _process(delta: float) -> void:
	pass
	# Change simulation precision from 5 to 15 based on wind angle (5 is downwind, 15 is close hauled)
	# property: simulation_precision
	# reuse code from restrain_hinge.gd
