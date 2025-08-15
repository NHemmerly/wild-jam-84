extends VBoxContainer

func _ready() -> void:
	for child in get_children():
		child.modulate.a = 0.0
