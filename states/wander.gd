extends CritterState

func enter(previous_state_path: String, data := {}) -> void:
	critter.velocity.y = -1 * critter.stats.speed
	critter.velocity.x = 1 * critter.stats.speed
	critter.wanderCd.start()

func physics_update(_delta: float) -> void:
	critter.update()
	critter.move_and_slide()
	
	if critter.timer_done:
		critter.timer_done = false
		finished.emit(IDLE)
	if player_state.stats.current_state == Enums.ActionState.FEEDING \
		&& critter.is_in_feeding_zone():
		critter.wanderCd.stop()
		finished.emit(FEEDING)
