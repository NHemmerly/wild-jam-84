extends Control

func _on_splash_timer_timeout() -> void:
	Global.goto_scene("res://SecondSplash.tscn")
