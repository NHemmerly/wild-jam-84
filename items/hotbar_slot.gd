extends Button

@export var item: Item = null

#func _ready():
#	if item:
#		icon = item.icon
func _process(delta: float) -> void:
	update()
	

func update():
	if item != null:
		set_button_icon(item.icon)
	else:
		icon = null

func swap_item(swap_item: Item) -> void:
	var temp: Item = swap_item
	swap_item = item
	item = temp
	print(str(item.name) + str(swap_item.name))

func _on_pressed() -> void:
	if item != null:
		if player_state.held_item != null:
			swap_item(player_state.held_item)
		else:
			player_state.held_item = item
			item = null
	elif player_state.held_item != null:
		item = player_state.held_item
		player_state.held_item = null
		
	
