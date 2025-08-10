class_name Player extends Node2D

@export var score := 0
@onready var fsm = $PlayerStateMachine

func _process(delta: float) -> void:
	$Label.text = fsm.state.name + ": " + fsm.state.state.name

func update():
	pass
