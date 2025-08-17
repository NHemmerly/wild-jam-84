class_name Player extends Node2D

@export var score := 0
@export var inventory: Inventory
@export var explore_inv: Inventory
@export var terrarium_inv: Inventory
@export var stats: PlayerStats
@export var held_item: Item
@export var welcome_back_menu: bool = false

const TICK_RATE: float = 1.0
const DRAIN_MOD: float = 10.0


func _ready() -> void:
	for i in range(inventory.max_size):
		inventory.items.append(null)


func _process(_delta: float) -> void:
	var current_scene := get_tree().root.get_child(-1)
	if stats.in_terrarium():
		update_terrarium_state()
	elif !stats.in_terrarium():
		update_planet_state()
	if Input.is_action_just_pressed("click") && \
		stats.current_state == stats.ActionState.DECORATING:
			spawn_critter(get_global_mouse_position())

func spawn_critter(pos: Vector2) -> void:
	var current_scene := get_tree().current_scene
	var new_critter = load("res://mobs/mob_temp.tscn").instantiate()
	current_scene.add_child(new_critter)
	new_critter.position = pos
	new_critter.stats = player_state.held_item.critter_item
	player_state.held_item = null
	stats.current_state == stats.ActionState.NAV

func enter_terrarium_state() -> void:
	stats.current_state = stats.ActionState.NAV
	if stats.batt_level <= 0.0:
		stats.batt_level = 0.0
	welcome_back_menu = true
	
func update_terrarium_state() -> void:
	if held_item != null:
		$layering/held_item.texture = held_item.icon
		set_state(held_item.usage)
	else:
		$layering/held_item.texture = null
		set_state(-1)
	$layering/held_item.position = get_global_mouse_position()
	
func enter_planet_state() -> void:
	stats.current_state = stats.ActionState.EXPLORE
	
func update_planet_state() -> void:
	if battery_dead():
		Global.goto_scene("res://menus/welcome_back.tscn")
		enter_terrarium_state()

func battery_dead() -> bool:
	return stats.batt_level <= 0.0

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
				item.free()
	if held_item != null:
		if held_item.count <= 0:
			held_item = null

func drain_battery() -> void:
	stats.batt_level -= TICK_RATE * DRAIN_MOD
	snapped(stats.batt_level, 0.01)
	
func recharge_battery() -> void:
	stats.batt_level += TICK_RATE
	snapped(stats.batt_level, 0.01)
	
func update():
	pass

func _on_batt_tick_timeout() -> void:
	if !is_equal_approx(stats.batt_level, stats.batt_max + 1.0) && stats.in_terrarium():
		recharge_battery()
	elif stats.batt_level >= 0 && !stats.in_terrarium():
		drain_battery()
		

	
