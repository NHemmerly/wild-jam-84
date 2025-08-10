class_name Critter extends CharacterBody2D

@export var speed = 100
@export var start_y = 0
@export var timer_done = false
@export var hold_position := Vector2.ZERO

@onready var wanderCd = $Timer
@onready var fsm = $StateMachine
@onready var label = $Label

const SCALER := 0.9

func _process(delta: float) -> void:
	label.text = fsm.state.name
	
func scale_size():
	hold_position = position
	var scale_factor := 0.0
	scale_factor = 1 / ((start_y) / (hold_position.y)) 
	if int(start_y) > int(hold_position.y):
		scale_factor *= SCALER
	scale = Vector2(scale_factor, scale_factor)
	position = hold_position
	
	
func _on_timer_timeout() -> void:
	timer_done = true
