class_name Critter extends CharacterBody2D

# Movement and scaling
@export var speed = 100
@export var start_y = 0
@export var timer_done = false
@export var tick_update = false
@export var hold_position := Vector2.ZERO
@export var feeding_distance := 400.0
@export var mouse_inside: bool

# Variables for state
@onready var wanderCd = $Timer
@onready var statusTime = $status_tickdown
@onready var fsm = $StateMachine
@onready var label = $Label # Debug

# Creature status
var status = {
	"happiness" = 100.0,
	"hunger" = 100.0,
}
# make scaler lower to make scaling more dramatic, higher for less
const SCALER := 0.85
const TICK_RATE := 1.0

func _process(_delta: float) -> void:
	label.text = str(status["happiness"]) # Debug
	$state_label.text = fsm.state.name
	
func update():
	scale_size()
	is_in_feeding_zone()
	feed()
	#tick_status()
	
func feed():
	if mouse_inside && \
	player_state.stats.current_state == Enums.ActionState.FEEDING && \
	Input.is_action_just_pressed("click"):
		print("Character_Body_2D:40 MMMMM TASTYYY")
	
func scale_size():
	hold_position = position
	var scale_factor := 0.0
	scale_factor = 1 / ((start_y) / (hold_position.y)) 
	if int(start_y) > int(hold_position.y):
		scale_factor *= SCALER
	scale = Vector2(scale_factor, scale_factor)
	position = hold_position

func is_in_feeding_zone():
	# really long line haha
	return position.distance_to(get_global_mouse_position()) < feeding_distance

func mouse_direction():
	return get_global_mouse_position() - global_position
	
func _on_timer_timeout() -> void:
	timer_done = true

func _on_status_tickdown_timeout() -> void:
	for stat in status:
		status[stat] -= TICK_RATE
		status[stat] = snapped(status[stat], 0.01)

func _on_mouse_entered() -> void:
	mouse_inside = true
	
func _on_mouse_exited() -> void:
	mouse_inside = false
