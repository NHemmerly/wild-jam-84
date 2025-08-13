extends VehicleBody3D

const ENGINE_POWER := 2
const MAX_STEER := 0.2


	
func _physics_process(delta: float):
	
	steering = move_toward(steering, Input.get_axis("right", "left") * MAX_STEER, delta * 10)
	engine_force = Input.get_axis("backward", "forward") * ENGINE_POWER
