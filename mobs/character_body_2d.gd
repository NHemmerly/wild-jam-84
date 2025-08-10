class_name Critter extends CharacterBody2D

@export var speed = 100

func _physics_process(_delta: float) -> void:
	
	move_and_slide()


func _on_wander_cooldown_timeout() -> void:
	pass # Replace with function body.
