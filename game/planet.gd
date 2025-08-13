extends Node3D

var planet_rover = load("res://game/rover.tscn").instantiate()
var rock = load("res://game/rock.tscn").instantiate()
var terrain = load("res://game/terrain.tscn").instantiate()

func _ready():
	
	add_child(planet_rover)
	add_child(rock)
	add_child(terrain)
	#print(terrain.get_child(0).get_child(0).spawnpoint_pos)
	#$Spawnpoint.position = Vector3(0, terrain.get_node("../StaticBody3D/Terrain").spawnpoint_pos, 0)
	var spawn_point = $Spawnpoint.get_collision_point()
	spawn_point.y += 5
	planet_rover.position = spawn_point
	rock.position = Vector3(0.1, 1, 0.2)
