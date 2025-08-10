extends MenuState

func update(_delta: float) -> void:
	var current_scene = get_tree().root.get_child(-1)
	if current_scene.name.contains("settings"):
		finished.emit("settings")
