extends Control

@export var hotbar: Inventory
var slot = load("res://items/hotbar_slot.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hotbar = player_state.inventory
	print(hotbar.items)
	fill_hotbar()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func fill_hotbar():
	for item in hotbar.items:
		var new_item = slot.instantiate()
		new_item.item = item
		new_item.item.icon = item.icon
		$MarginContainer/Hotbar.add_child(new_item)
	var hotbar_size = $MarginContainer/Hotbar.get_children().size()
	if hotbar_size < player_state.inventory.max_size:
		for i in range(player_state.inventory.max_size - hotbar_size):
			var blank_slot = slot.instantiate()
			$MarginContainer/Hotbar.add_child(blank_slot)



func _on_h_box_container_mouse_entered() -> void:
	print("in")
	for child in $MarginContainer/Hotbar.get_children():
		child.modulate.a = 1.0


func _on_h_box_container_mouse_exited() -> void:
	print("out")
	
	for child in $MarginContainer/Hotbar.get_children():
		child.modulate.a = 0.0
		
