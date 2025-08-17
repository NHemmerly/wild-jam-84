class_name Critter extends CharacterBody2D

# Movement and scaling
@export var stats: CritterRes
@export var start_y = 846
@export var timer_done = false
@export var tick_update = false
@export var hold_position := Vector2.ZERO
@export var feeding_distance := 400.0
@export var mouse_inside: bool

# Variables for state
@onready var wanderCd = $Timer
@onready var statusTime = $status_tickdown

var rng = RandomNumberGenerator.new()

# make scaler lower to make scaling more dramatic, higher for less
const SCALER := 1.0
const TICK_RATE := 1.0

func _ready() -> void:
	$Sprite2D.texture = stats.sprite	
	
func update():
	scale_size()
	is_in_feeding_zone()
	feed()
	#tick_status()
	
func feed():
	if mouse_inside && \
	player_state.stats.current_state == Enums.ActionState.FEEDING && \
	Input.is_action_just_pressed("click") && \
	!is_equal_approx(stats.hunger, stats.status_max):
		calculate_status_restore()
		stats.happiness = cull_greater_than_max(stats.happiness)
		stats.hunger = cull_greater_than_max(stats.hunger)
		player_state.held_item.count -= 1
		player_state.update_inv()
	
func calculate_status_restore() -> void:
	var fed_item = player_state.held_item
	if fed_item.type == stats.type: # critter likes food
		stats.hunger += fed_item.base_restore 
		stats.happiness += fed_item.base_restore * fed_item.likes_restore_scale
	elif distance_wrap(fed_item.type, stats.type) == 1: # Neutral
		stats.hunger += fed_item.base_restore 
		stats.happiness += fed_item.base_restore 
	else: # HATES food type
		stats.hunger += fed_item.base_restore 
		stats.happiness -= fed_item.base_restore + fed_item.hates_restore_scale

func distance_wrap(a: int, b: int) -> int:
	# something about this isn't working, doesn't really matter tho 
	var distance = abs(a - b) % (stats.Type.COUNT - 1)
	return distance
	
func likes_item() -> bool:
	return player_state.held_item.type == stats.type
	
func hates_item() -> bool:
	return distance_wrap(player_state.held_item.type, stats.type) == 2
	
func neutral_item() -> bool:
	return distance_wrap(player_state.held_item.type, stats.type) == 1

func cull_greater_than_max(stat: float) -> float:
	if stat > stats.status_max:
		return stats.status_max
	return stat

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
	var direction := (get_global_mouse_position() - global_position)
	return direction.normalized() * stats.speed_scale
	
func tick_stats(stat: float, rate: float) -> float:
	stat -= rate
	return snapped(stat, 0.01)
	
func go_wander():
	return rng.randf_range(-1.0, 1.0)
	
func _on_timer_timeout() -> void:
	timer_done = true

func _on_status_tickdown_timeout() -> void:
	stats.hunger = tick_stats(stats.hunger, stats.hunger_rate)
	stats.happiness = tick_stats(stats.happiness, stats.happiness_rate)

func _on_feed_box_mouse_entered() -> void:
	mouse_inside = true

func _on_feed_box_mouse_exited() -> void:
	mouse_inside = false
