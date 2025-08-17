extends ProgressBar

func _process(delta: float) -> void:
	value = player_state.stats.batt_level
