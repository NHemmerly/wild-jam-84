extends Node3D

var planet_rover = load("res://game/rover.tscn").instantiate()
var terrain = load("res://game/terrain.tscn").instantiate()
var ui = load("res://game/ui/batt_meter.tscn").instantiate()

func _ready():
	$planet_ui.add_child(ui)
	add_child(planet_rover)
	add_child(terrain)
	#print(terrain.get_child(0).get_child(0).spawnpoint_pos)
	#$Spawnpoint.position = Vector3(0, terrain.get_node("../StaticBody3D/Terrain").spawnpoint_pos, 0)
	$Spawnpoint.position = Vector3(0, 5, 0)
	planet_rover.position = $Spawnpoint.position
