extends Control


func _on_great_pressed() -> void:
	for item in player_state.explore_inv.items:
		player_state.terrarium_inv.items.append(item.duplicate())
	print(player_state.terrarium_inv.items)
	player_state.explore_inv.items.clear()
	player_state.welcome_back_menu = false	
	Global.goto_scene("res://game/terrarium.tscn")
