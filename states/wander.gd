extends CritterState

func enter(previous_state_path: String, data := {}) -> void:
	critter.velocity.y = 1 * critter.speed
	critter.velocity.x = 1 * critter.speed
	critter.wanderCd.start()

func physics_update(_delta: float) -> void:
	critter.scale_size()
	critter.move_and_slide()
	
	if critter.timer_done:
		critter.timer_done = false
		finished.emit(IDLE)
