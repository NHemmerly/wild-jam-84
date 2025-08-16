extends ColorRect

const MAX_SIZE: float = 1580

func _process(_delta) -> void:
	var decrease_by = MAX_SIZE * (1 - (player_state.stats.batt_level/100))
	offset_right -= decrease_by
