extends CritterState

func enter(_previous_state_path: String, _data := {}) -> void:
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
