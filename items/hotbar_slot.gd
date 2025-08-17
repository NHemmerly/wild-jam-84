extends Button

@export var item: Item = null
@export var id: int
@export var attached_inv: Inventory = player_state.inventory

var mouse_in: bool = false	

#func _ready():
#	if item:
#		icon = item.icon
func _process(_delta: float) -> void:
	update()

func update() -> void:
	if item != null:
		set_button_icon(item.icon)
		if item.usage != item.ItemUse.DECOR:
			$count.text = str(item.count)
		show_item_name()
	else:
		icon = null
		$count.text = ""
		$item_info.text = ""
		
func show_item_name() -> void:
	if mouse_in:
		if item.usage == item.ItemUse.DECOR:
			$item_info.text = item.critter_item.name
		else:
			$item_info.text = item.name
			$item_info.global_position = get_global_mouse_position()
	else:
		$item_info.text = ""
		

func swap_item(swapn_item: Item) -> Item:
	var temp: Item = item
	item = swapn_item
	swapn_item = temp
	return swapn_item
	
func stack_item(stackn_item: Item) -> void:
	item.count += stackn_item.count
	player_state.held_item = null

func _on_pressed() -> void:
	# Item in slot 
	if item != null:
		# Item in hand
		if player_state.held_item != null:
			if player_state.held_item.name == item.name:
				stack_item(player_state.held_item)
			else:
				player_state.held_item = swap_item(player_state.held_item)
				attached_inv.items[id] = item
		# Item not in hand
		else:
			player_state.held_item = item.duplicate()
			item = null
			attached_inv.items[id] = null
	# Item not in slot but player has an item
	elif player_state.held_item != null:
		item = player_state.held_item
		player_state.held_item = null
		if len(attached_inv.items) > id:
			attached_inv.items[id] = item
		else:
			attached_inv.items.append(item)
			
	print(attached_inv.items)
		
		
func _on_mouse_entered() -> void:
	mouse_in = true


func _on_mouse_exited() -> void:
	mouse_in = false
