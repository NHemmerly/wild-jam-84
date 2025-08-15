extends Control

@export var hotbar: Inventory

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hotbar = player_state.inventory
	fill_hotbar()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func fill_hotbar():
	var i: int = 0
	var slots = $MarginContainer/Hotbar.get_children()
	for slot in slots:
		if player_state.inventory.items[i] != null:
			slot.item = player_state.inventory.items[i]
		slot.id = i
		i += 1
		
func update_inv(slots: Array, inv: Array) -> void:
	var i: int = 0
	for slot in slots:
		if slot != null:
			slot.item = inv[i]
		i += 1


func _on_h_box_container_mouse_entered() -> void:
	for child in $MarginContainer/Hotbar.get_children():
		child.modulate.a = 1.0


func _on_h_box_container_mouse_exited() -> void:
	for child in $MarginContainer/Hotbar.get_children():
		child.modulate.a = 0.0
