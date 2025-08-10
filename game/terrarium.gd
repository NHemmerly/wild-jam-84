extends Node2D

var map = load("res://maps/map_1.tscn").instantiate()
@export var Mob: PackedScene = load("res://mobs/mob_temp.tscn")
@export var Ui: PackedScene = load("res://game/terrarium_ui.tscn")

func _ready():
	var mob = Mob.instantiate()
	add_child(map)
	add_child(mob)
	$CanvasLayer.add_child(Ui.instantiate())
	mob.position = map.spawn.position
	mob.start_y = mob.position.y
