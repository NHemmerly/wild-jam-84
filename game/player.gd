class_name Player extends Node2D

@export var score := 0
@onready var fsm = $PlayerStateMachine

@export var inventory: Inventory
var test_item = load("res://items/item.tscn").instantiate()

func _ready() -> void:
	inventory.items.append(test_item.props)

func _process(delta: float) -> void:
	$Label.text = fsm.state.name + ": " + fsm.state.state.name

func update():
	pass
