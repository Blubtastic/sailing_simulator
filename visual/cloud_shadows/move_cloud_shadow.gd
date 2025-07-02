extends MeshInstance3D

@export var noise: FastNoiseLite


func _process(delta: float) -> void:
	var radians = deg_to_rad(Globals.wind_direction)
	
	noise.offset.x += delta*cos(radians)*5
	noise.offset.y -= delta*cos(radians)*5
