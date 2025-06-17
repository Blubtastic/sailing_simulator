extends MeshInstance3D

# Define the two points for the line
var point1: Vector3 = Vector3(0, 0, 0)
var point2: Vector3 = Vector3(0,0,0)

func draw_line(pos: Vector3) -> void:
	point2 = to_local(pos)
	mesh.reset_state()
	var surface_array = []
	surface_array.resize(Mesh.ARRAY_MAX)
	
	# Create an array to hold the vertices
	var verts = PackedVector3Array()
	verts.append(point1)
	verts.append(point2)
	# Create an array for the indices
	var indices = PackedInt32Array()
	indices.append(0)
	indices.append(1)
	
	surface_array[Mesh.ARRAY_VERTEX] = verts
	surface_array[Mesh.ARRAY_INDEX] = indices
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_LINES, surface_array)
	print(point1, point2)
	# Optionally, set a material to the line
	#var material = StandardMaterial3D.new()
	#material.albedo_color = Color(1, 0, 0)  # Red color
	#material.emission_enabled = true
	#material.emission_energy_multiplier = 50
	#material.emission = Color(0.803, 0.596, 0.048)
	#self.material_override = material
