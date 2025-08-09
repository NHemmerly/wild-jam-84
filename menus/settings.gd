extends Node2D


func _on_back_pressed() -> void:
	Global.goto_scene("res://menus/main_menu.tscn")


func _on_back_mouse_entered() -> void:
	print("mouse in")
