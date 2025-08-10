extends VehicleBody3D

const ENGINE_POWER := 10
const MAX_STEER := 0.8

func shoot_laster(endpoint: Vector3):
	
	pass

func _physics_process(delta: float):
	
	steering = move_toward(steering, Input.get_axis("right", "left") * MAX_STEER, delta * 10)
	engine_force = Input.get_axis("backward", "forward") * ENGINE_POWER
	
	#shoot_laser
	if Input.is_action_just_pressed("click"):
		shoot_laster(Vector3.ZERO)
