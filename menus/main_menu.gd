extends Node2D



func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://menus/settings.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()
