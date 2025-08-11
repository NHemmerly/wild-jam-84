extends CharacterBody2D

@export var stats: Resource

func _ready():
	if stats:
		stats.hunger = 100.0
		print(stats.hunger)
