extends Control


func _on_great_pressed() -> void:
	queue_free()
	player_state.welcome_back_menu = false	
