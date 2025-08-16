class_name Player extends Node2D

@export var score := 0
@export var inventory: Inventory
@export var stats: PlayerStats
@export var held_item: Item

const TICK_RATE: float = 1.0

var mason_candy = load("res://items/mason_candy.tres")
var test_item = load("res://items/trash_item.tres")

func _ready() -> void:
	for i in range(inventory.max_size):
		inventory.items.append(null)
	# When adding items to inventory make sure they are duplicated
	# allows them to be freed when updating inventory to clear
	# empties
	inventory.items[0] = mason_candy.duplicate()
	inventory.items[1] = mason_candy.duplicate()
	inventory.items[2] = mason_candy.duplicate()
	inventory.items[3] = test_item.duplicate()

func _process(_delta: float) -> void:
	var current_scene := get_tree().root.get_child(-1)
	if stats.in_terrarium():
		update_terrarium_state()
	elif !stats.in_terrarium():
		update_planet_state()

func enter_terrarium_state() -> void:
	stats.current_state = stats.ActionState.NAV
	
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
		Global.goto_scene("res://game/terrarium.tscn")
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
	var debug_array: Array[int]
	for item in inventory.items:
		if item != null:
			debug_array.append(item.count)
			if item.count <= 0:
				item.free()
	if held_item != null:
		if held_item.count <= 0:
			held_item = null

func drain_battery() -> void:
	stats.batt_level -= TICK_RATE
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
		

	
