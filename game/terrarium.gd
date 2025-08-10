extends Node2D

var map = load("res://maps/map_1.tscn").instantiate()
var mob = load("res://mobs/mob_temp.tscn").instantiate()

func _ready():
	add_child(map)
	add_child(mob)
	mob.position = map.spawn.position
	mob.start_y = mob.position.y
