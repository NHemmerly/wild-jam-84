class_name Player extends Node2D

@export var score := 0
@onready var fsm = $PlayerStateMachine

@export var inventory: Inventory
var test_item = load("res://items/item.tscn").instantiate()

func _ready() -> void:
	for i in range(inventory.max_size - 1):
		inventory.items.append(null)
	inventory.items.append(test_item.item)
	print(inventory.items[-1])
	print(inventory.items.size())
	

func _process(delta: float) -> void:
	$Label.text = fsm.state.name + ": " + fsm.state.state.name

func update():
	pass
