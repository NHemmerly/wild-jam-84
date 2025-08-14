extends CharacterBody3D

const SPEED := 18.0
const STEER := 2.0
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
#const MAX_STEER := 0.8
	
func get_input():
	var move = Input.get_axis("backward", "forward")
	var turn = Input.get_axis("right", "left")
	velocity = move * global_transform.basis.z * SPEED
	if move != 0 && turn  != 0:
		rotation_degrees.y += STEER * turn
	
func _physics_process(delta: float):
	velocity.y += -gravity * delta
	get_input()
	move_and_slide()
	#steering = move_toward(steering, Input.get_axis("right", "left") * MAX_STEER, delta * 10)
	#velocity = Input.get_axis("backward", "forward") * SPEED
