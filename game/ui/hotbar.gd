extends HBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		child.modulate.a = 0.0
