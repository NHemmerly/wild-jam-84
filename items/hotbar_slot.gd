extends Button

@export var item: Item = null
@export var id: int

#func _ready():
#	if item:
#		icon = item.icon
func _process(_delta: float) -> void:
	update()
	

func update():
	if item != null:
		set_button_icon(item.icon)
	else:
		icon = null

func swap_item(swapn_item: Item) -> Item:
	var temp: Item = item
	item = swapn_item
	swapn_item = temp
	return swapn_item

func _on_pressed() -> void:
	# Item in slot 
	if item != null:
		# Item in hand
		if player_state.held_item != null:
			player_state.held_item = swap_item(player_state.held_item)
			player_state.inventory.items[id] = item
		# Item not in hand
		else:
			player_state.held_item = item
			item = null
			player_state.inventory.items[id] = null
	# Item not in slot but player has an item
	elif player_state.held_item != null:
		item = player_state.held_item
		player_state.held_item = null
		player_state.inventory.items[id] = item
		
		
	
