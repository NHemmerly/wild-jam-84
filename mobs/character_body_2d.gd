extends CharacterBody2D

const SPEED = 100

func _physics_process(_delta: float) -> void:
	velocity = Vector2.ZERO
	velocity.x = SPEED
	velocity.y = SPEED
	
	move_and_slide()
