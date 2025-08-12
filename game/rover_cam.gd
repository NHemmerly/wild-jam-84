extends Camera3D

var laser_exists := false

func shoot_laser(start, color = Color.RED):
	const LASER_LENGTH = 1000
	var mouse_pos = get_viewport().get_mouse_position()
	var from = project_ray_origin(mouse_pos)
	var to = from + project_ray_normal(mouse_pos) * LASER_LENGTH
	var space = get_world_3d().direct_space_state
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.from = from
	ray_query.to = to
	var raycast_result = space.intersect_ray(ray_query)

	if !raycast_result.is_empty() && !laser_exists:
		print(raycast_result)
		var mesh_instance := Laser.new()
		var immediate_mesh := ImmediateMesh.new()
		var material := ORMMaterial3D.new()
		
		mesh_instance.mesh = immediate_mesh
		
		immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
		immediate_mesh.surface_add_vertex(start)
		immediate_mesh.surface_add_vertex(raycast_result["position"])
		immediate_mesh.surface_end()
		
		material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
		material.albedo_color = color
		
		get_tree().get_root().add_child(mesh_instance)
		laser_exists = true
		if(raycast_result["collider"].get_name().contains("RockBody")):
			raycast_result["collider"].apply_impulse(Vector3(0.01, 0.02, 0.01), raycast_result["position"])
		$Timer.start()

func _input(event):
	if event.is_action_pressed("click"):
		shoot_laser(self.get_child(0).global_position)

func _on_timer_timeout() -> void:
	get_tree().get_root().get_child(-1).delete_self()
	laser_exists = false
