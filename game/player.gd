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
	mason_candy.item.count = 5

func _process(_delta: float) -> void:
	if held_item != null:
		$layering/held_item.texture = held_item.icon
		set_state(held_item.usage)
	else:
		$layering/held_item.texture = null
		set_state(-1)
	$layering/held_item.position = get_global_mouse_position()
		
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

func update_inv() -> void:
	for item in inventory.items:
		if item != null:
			if item.count <= 0:
				item = null
	if held_item != null:
		if held_item.count <= 0:
			held_item = null

func update():
	pass
