extends CritterState

func enter(previous_state_path: String, data := {}) -> void:
	critter.velocity.x = 1 * critter.speed
	critter.Timer.start()

func physics_update(_delta: float) -> void:
	critter.move_and_slide()
	
	if critter.Timer.time_left <= 0:
		finished.emit(IDLE)
