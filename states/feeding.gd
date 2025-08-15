extends CritterState

func enter(previous_state_path: String, data := {}) -> void:
	critter.wanderCd.start()

func physics_update(_delta: float) -> void:
	critter.velocity = critter.stats.speed * critter.mouse_direction()
	critter.update()
	critter.move_and_slide()
	
	if critter.timer_done:
		critter.timer_done = false
		finished.emit(IDLE)
	if !critter.is_in_feeding_zone():
		finished.emit(WANDER)
