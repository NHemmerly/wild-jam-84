extends Node3D

var planet_rover = load("res://game/rover.tscn").instantiate()
var ui = load("res://game/ui/batt_meter.tscn").instantiate()
var chunks = []
var planet_noise = FastNoiseLite.new()

func _ready():
	var temp_chunk := terrain.new()
	planet_noise.seed = temp_chunk.rng.randf_range(0, 69)
	for r in range(0, 3):
		for c in range(0, 3):
			temp_chunk = terrain.new()
			temp_chunk.noise = planet_noise
			#temp_chunk.offset += Vector3(256-(256*c), 0, 256-(256*r))
			extend_terrain(Vector3(256-(256*c), 0, 256-(256*r)))
			chunks.append(temp_chunk)
	load_chunks()
	$planet_ui.add_child(ui)
	add_child(planet_rover)
	
	#print(terrain.get_child(0).get_child(0).spawnpoint_pos)
	#$Spawnpoint.position = Vector3(0, terrain.get_node("../StaticBody3D/Terrain").spawnpoint_pos, 0)
	$Spawnpoint.position = Vector3(0, 5, 0)
	planet_rover.position = $Spawnpoint.position

func extend_terrain(offset: Vector3 ):
	#var new_terrain = load("res://game/terrain.tscn").instantiate()
	var new_terrain = terrain.new()
	new_terrain.noise = planet_noise
	new_terrain.noise.offset += offset
	new_terrain.position = offset
	new_terrain.update_mesh()
	new_terrain.update_collision()
	chunks.append(new_terrain)

func load_chunks():
	for c in chunks:
		add_child(c)
		
func unload_chunks():
	for c in chunks:
		remove_child(c)
