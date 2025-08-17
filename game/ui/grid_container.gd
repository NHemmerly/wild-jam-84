extends GridContainer

var current_size: int = 0
var slot = load("res://items/hotbar_slot.tscn")
var sorted: bool = false	

func _ready() -> void:
	sort_inv()
	fill_hotbar()
	current_size = len(player_state.terrarium_inv.items)

func _process(delta: float) -> void:
	if len(get_children()) == current_size:
		var new_slot = slot.instantiate()
		add_child(new_slot)
		new_slot.id = len(player_state.terrarium_inv.items)
		new_slot.attached_inv = player_state.terrarium_inv
	current_size = len(player_state.terrarium_inv.items)

func fill_hotbar() -> void:
	var id: int = 0
	for item in player_state.terrarium_inv.items:
		var new_slot = slot.instantiate()
		add_child(new_slot)
		new_slot.item = item
		new_slot.attached_inv = player_state.terrarium_inv
		new_slot.id = id
		id += 1
		
func sort_inv() -> void:
	var sort_item: Item = null
	var temp_inv: Array[Item] = []
	var i: int = 0
	for item in player_state.terrarium_inv.items:
		if item != null:
			sort_item = item
		i += 1
		for next_item in player_state.terrarium_inv.items.slice(i, -1):
			if sort_item != null:
				if next_item != null:
					if next_item.name == sort_item.name:
						sort_item.count += next_item.count
						next_item = null
		temp_inv.append(sort_item)
	player_state.terrarium_inv.items = temp_inv
			
		
		
