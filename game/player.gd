class_name Player extends Node2D

@export var score := 0

@export var inventory: Inventory
@export var stats: PlayerStats
var test_item = load("res://items/item.tscn").instantiate()

func _ready() -> void:
	for i in range(inventory.max_size - 1):
		inventory.items.append(null)
	inventory.items.append(test_item.item)

func _process(delta: float) -> void:
	if stats.held_item_icon != null:
		$held_item.texture = stats.held_item_icon
	$held_item.position = get_global_mouse_position()
	
func update():
	pass
