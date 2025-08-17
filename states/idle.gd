extends CritterState


func enter(_previous_state_path: String, _data := {}) -> void:
	critter.velocity = Vector2.ZERO
	critter.wanderCd.start(2)

func physics_update(_delta: float) -> void:
	critter.update()
	critter.move_and_slide()
	
	if critter.timer_done:
		critter.timer_done = false	
		finished.emit(WANDER)
	if player_state.stats.current_state == Enums.ActionState.FEEDING \
		&& critter.is_in_feeding_zone():
		critter.wanderCd.stop()
		finished.emit(FEEDING)
	
	
