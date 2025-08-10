extends MenuState

func update(_delta: float) -> void:
	var current_scene = get_tree().root.get_child(-1)
	if current_scene.name.contains("main_menu"):
		finished.emit("main_menu")
	if current_scene.name.contains("terrarium"):
		finished.emit("terrarium")
