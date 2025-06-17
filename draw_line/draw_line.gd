extends MeshInstance3D

var point1: Vector3 = Vector3(0,0,0)
var point2: Vector3 = Vector3(0,0,0)

func draw_line(pos: Vector3) -> void:
	point2 = to_local(pos)
	mesh.reset_state()
	var surface_array = []
	# Set array size
	surface_array.resize(Mesh.ARRAY_MAX)
	
	# Create an array to hold the vertices and indices
	var verts = PackedVector3Array()
	verts.append(point1)
	verts.append(point2)
	var indices = PackedInt32Array()
	indices.append(0)
	indices.append(1)
	
	surface_array[Mesh.ARRAY_VERTEX] = verts
	surface_array[Mesh.ARRAY_INDEX] = indices
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_LINES, surface_array)
