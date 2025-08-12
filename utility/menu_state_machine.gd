extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	pass
## Called by the state machine on the engine's main loop tick.
func update(_delta: float) -> void:
	var current_scene = get_tree().root.get_child(-1)
	if current_scene.name.contains("terrarium"):
		finished.emit("terrarium")
	
	
