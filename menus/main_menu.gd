extends Node2D



func _on_settings_pressed() -> void:
	Global.goto_scene("res://menus/settings.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_play_pressed() -> void:
	Global.goto_scene("res://game/terrarium.tscn")
