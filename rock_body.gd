extends RigidBody3D

@export var hidden_item: Item
var active: bool = true

var hiding_critter
	
func _init() -> void:
	#hiding_critter = new_hiding_critter
	#$CritterMesh.material_override.texture = hiding_critter
	pass

func get_hiding_critter(new_hiding_critter):
	return hiding_critter
	
func set_hiding_critter(new_hiding_critter):
	hiding_critter = new_hiding_critter

func locked(locked):
	if locked:
		axis_lock_linear_x = true
		axis_lock_linear_y = true
		axis_lock_linear_z = true
	elif !locked:
		axis_lock_linear_x = false
		axis_lock_linear_y = false
		axis_lock_linear_z = false

#func _on_rockbody_input_event(camera: Node, event: InputEvent, event_position: Vector3):
	#if(event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT):
		#print("rock my body")
		#locked(false)
#
#func _on_body_entered(body: Node) -> void:
	#apply_impulse(Vector3(100, 100 ,100))
	

func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	#if InputEventMouseButton && event.pressed() && event.button_index == MOUSE_BUTTON_LEFT:
	if Input.is_action_just_pressed("click") && active:
		active = false
		locked(false)
		apply_impulse(Vector3(2, 2, 2)) # Replace with function body.
		player_state.explore_inv.items.append(hidden_item)
