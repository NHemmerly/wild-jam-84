extends GridContainer

func _ready() -> void:
	for found_item in player_state.explore_inv.items:
		var slot = load("res://items/hotbar_slot.tscn").instantiate()
		slot.item = found_item
		add_child(slot)
