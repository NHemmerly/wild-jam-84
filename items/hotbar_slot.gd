extends Button

@export var item: Item

#func _ready():
#	if item:
#		icon = item.icon

func update():
	if item != null:
		set_button_icon(item.icon)


func _on_pressed() -> void:
	if item != null:
		print(item.name)
		match item.usage:
			Enums.ItemUse.FOOD:
				player_state.stats.current_state = Enums.ActionState.FEEDING
			Enums.ItemUse.PLAYTHING:
				player_state.stats.current_state = Enums.ActionState.PLAYING
			Enums.ItemUse.DECOR:
				player_state.stats.current_state = Enums.ActionState.DECORATING
			_:
				player_state.stats.current_state = Enums.ActionState.NAV
		print(player_state.stats.current_state)
