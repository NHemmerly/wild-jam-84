extends CritterState

var favor_scale: float = 1.0

func enter(_previous_state_path: String, _data := {}) -> void:
	favor_scale = 1.0
	critter.wanderCd.start()
	if critter.likes_item():
		favor_scale = 2.0
	elif critter.hates_item():
		favor_scale = 0.25

func physics_update(_delta: float) -> void:
	critter.velocity = critter.stats.speed * critter.mouse_direction() * favor_scale
	critter.update()
	critter.move_and_slide()
	
	if critter.timer_done:
		critter.timer_done = false
		finished.emit(IDLE)
	if !critter.is_in_feeding_zone():
		finished.emit(WANDER)
