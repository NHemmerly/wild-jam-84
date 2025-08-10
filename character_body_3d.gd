extends VehicleBody3D

var SPEED = 10

func _physics_process(delta: float) -> void:
	#Movement
	if Input.is_action_just_pressed("Up") && is_on_floor():
		velocity.y = -1 * SPEED
	if Input.is_action_pressed("Left"):
		velocity.x = -1 * SPEED
	if Input.is_action_pressed("Right"):
		velocity.x = 1 * SPEED
	if Input.is_action_pressed("Down") && is_on_floor():
		velocity.y = 1 * SPEED
	if !(Input.is_action_pressed("Right") || Input.is_action_pressed("Left")):
		velocity.x = 0
