@tool
extends MeshInstance3D

const SIZE := 256.0

@export_range(4, 256, 4) var resolution := 32:
	set(new_resolution):
		resolution = new_resolution
		update_mesh()
		
@export var noise: FastNoiseLite: 
	set(new_noise):
		noise = new_noise
		update_mesh()
		if noise:
			noise.changed.connect(update_mesh)
			
@export_range(4, 128, 4) var height := 64.0:
	set(new_height):
		height = new_height
		material_override.set_shader_parameter("height", height * 2.0)
		update_mesh()

var spawnpoint_pos: float

func get_height(x: float, y: float) -> float:
	return noise.get_noise_2d(x, y) * height
	
func get_normal(x: float, y:float) -> Vector3:
	var epsilon := SIZE / resolution
	var normal := Vector3(
	get_height(x+epsilon, y) - get_height(x-epsilon, y) / (2 * epsilon),
	 1,
	get_height(x, y+epsilon) - get_height(x, y-epsilon) / (2 * epsilon) 
	)
	return normal.normalized()

func update_mesh():
	var plane := PlaneMesh.new()
	plane.subdivide_depth = resolution
	plane.subdivide_width = resolution
	plane.size = Vector2(SIZE, SIZE)
	
	var plane_arrays = plane.get_mesh_arrays()
	var vertex_array: PackedVector3Array = plane_arrays[ArrayMesh.ARRAY_VERTEX]
	var normal_array: PackedVector3Array = plane_arrays[ArrayMesh.ARRAY_NORMAL]
	var tangent_array: PackedFloat32Array = plane_arrays[ArrayMesh.ARRAY_TANGENT]
	
	for i:int in vertex_array.size():
		var vertex := vertex_array[i]
		var normal := Vector3.UP
		var tangent := Vector3.RIGHT
		if noise:
			vertex.y = get_height(vertex.x, vertex.z)
			normal = get_normal(vertex.x, vertex.z)
			tangent = normal.cross(Vector3.UP)
		vertex_array[i] = vertex
		normal_array[i] = normal
		tangent_array[4 * i] = tangent.x
		tangent_array[4 * i + 1] = tangent.y
		tangent_array[4 * i + 2] = tangent.z
		
	var array_mesh = ArrayMesh.new()
	array_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, plane_arrays)
	mesh = array_mesh
	
	update_collision()

func update_collision():
	for n in get_children():
		remove_child(n)
		n.queue_free()
	create_trimesh_collision()
