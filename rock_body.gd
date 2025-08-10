extends RigidBody3D

var hiding_critter
	
func _init(new_hiding_critter) -> void:
	hiding_critter = new_hiding_critter
	$CritterMesh.material_override.texture = hiding_critter

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

func _on_rockbody_input_event(camera: Node, event: InputEvent, event_position: Vector3):
	if(event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT):
		locked(false)
