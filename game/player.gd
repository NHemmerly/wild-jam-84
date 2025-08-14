class_name Player extends Node2D

@export var score := 0

@export var inventory: Inventory
@export var stats: PlayerStats
@export var held_item: Item
var test_item = load("res://items/item.tscn").instantiate()
var mason_candy = load("res://items/item.tscn").instantiate()

func _ready() -> void:
	for i in range(inventory.max_size - 2):
		inventory.items.append(null)
	inventory.items.append(test_item.item)
	mason_candy.item = load("res://items/mason_candy.tres")
	inventory.items.append(mason_candy.item)

func _process(delta: float) -> void:
	if held_item != null:
		$held_item.texture = held_item.icon
		set_state(held_item.usage)
	else:
		$held_item.texture = null
		set_state(-1)
	$held_item.position = get_global_mouse_position()
	print(inventory.items)
	
func set_state(usage: int):
	match usage:
		Enums.ItemUse.FOOD:
			player_state.stats.current_state = Enums.ActionState.FEEDING
		Enums.ItemUse.PLAYTHING:
			player_state.stats.current_state = Enums.ActionState.PLAYING
		Enums.ItemUse.DECOR:
			player_state.stats.current_state = Enums.ActionState.DECORATING
		_:
			player_state.stats.current_state = Enums.ActionState.NAV	

func update():
	pass
