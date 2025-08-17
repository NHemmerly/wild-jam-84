extends Node2D

var map = load("res://maps/map_1.tscn").instantiate()
var welcome_back_menu = load("res://menus/welcome_back.tscn").instantiate()
@export var Mob: PackedScene
@export var Ui: PackedScene

func _ready():
	var mob = Mob.instantiate()
	add_child(map)
	add_child(mob)
	$CanvasLayer.add_child(Ui.instantiate())
	if player_state.welcome_back_menu:
		$CanvasLayer.add_child(welcome_back_menu)
	
	mob.position = map.spawn.position
	mob.start_y = mob.position.y
