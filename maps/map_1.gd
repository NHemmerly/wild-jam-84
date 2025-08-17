extends Node2D

@onready var spawn = $spawn


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	pass
	#if Input.is_action_just_pressed("click") && \
	#player_state.stats.current_state == player_state.stats.ActionState.DECORATING:
		#var current_scene := get_tree().get_root()
		#print(current_scene)
		#var new_critter = load("res://mobs/mob_temp.tscn").instantiate()
		#current_scene.add_child(new_critter)
		#new_critter.position = get_global_mouse_position()
		#new_critter.stats = player_state.held_item.critter_item.duplicate()
		#new_critter.get_child(1).texture = player_state.held_item.critter_item.sprite
		#print(new_critter)
