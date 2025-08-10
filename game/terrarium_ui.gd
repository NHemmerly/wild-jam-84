extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_h_box_container_mouse_entered() -> void:
	print("in")
	for child in $MarginContainer/Hotbar.get_children():
		child.modulate.a = 1.0


func _on_h_box_container_mouse_exited() -> void:
	print("out")
	
	for child in $MarginContainer/Hotbar.get_children():
		child.modulate.a = 0.0
		
