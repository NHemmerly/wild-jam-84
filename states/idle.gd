extends CritterState


func enter(previous_state_path: String, data := {}) -> void:
	critter.velocity.x = 0.0
	critter.wanderCd.start(2)

func physics_update(_delta: float) -> void:
	critter.update()
	critter.move_and_slide()
	
	if critter.timer_done:
		critter.timer_done = false	
		finished.emit(WANDER)
	
	
