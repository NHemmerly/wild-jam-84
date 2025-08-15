extends HBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		child.modulate.a = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
