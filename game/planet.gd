extends Node3D

var rover = load("res://game/rover.tscn").instantiate()

func _physics_process(delta: float) -> void:
	add_child(rover)
	rover.position = $Spawnpoint.position
