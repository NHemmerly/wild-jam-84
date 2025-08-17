#@tool
extends MeshInstance3D

const SIZE := 256.0
const MIN_COORD := -128.0
const MAX_COORD := 128.0

const MOBS_FOLDER := "res://mobs/resources/"
const ITEMS_FOLDER := "res://items/resources/"

var rand_items: Array = []

@export var resolution := 32:
	set(new_resolution):
		resolution = new_resolution
		update_mesh()
		
@export var noise: FastNoiseLite: 
	set(new_noise):
		noise = new_noise
		update_mesh()
		if noise:
			noise.changed.connect(update_mesh)
			
@export var height := 64.0:
	set(new_height):
		height = new_height
		material_override.set_shader_parameter("height", height * 2.0)
		update_mesh()

var spawnpoint_pos: float
var rng = RandomNumberGenerator.new()

func _ready():
	rockify()

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
		if n.name.contains("col"):
			remove_child(n)
			n.queue_free()
	create_trimesh_collision()
	
func make_rand_floats() -> float:
	return rng.randf_range(MIN_COORD, MAX_COORD)
	
func access_dir(path: String) -> String:
	var dir = DirAccess.open(path)
	var file_names := dir.get_files()
	var rand_item = file_names[rng.randi_range(0, len(file_names) - 1)]
	print(path + rand_item)
	return (path + rand_item)
			
	
func load_rand_items() -> void:
	for i in range(10):
		if rng.randi_range(1, 100) > 75:
			var critter_path = access_dir(MOBS_FOLDER)
			var temp_item: Item = Item.new()
			temp_item.critter_item = load(critter_path).duplicate()
			temp_item.icon = temp_item.critter_item.sprite
			rand_items.append(temp_item.duplicate())
		else:
			var rand_item = load(access_dir(ITEMS_FOLDER)).duplicate()
			rand_items.append(rand_item)
	
func rockify():
	load_rand_items()
	for i in range(10):
		var rock1 = load("res://game/rock.tscn").instantiate()
		add_child(rock1)
		rock1.hidden_item = rand_items[i]
		rock1.global_position = Vector3(make_rand_floats(), 1, make_rand_floats())
