extends Camera3D

var laser_exists := false
const LASER_LENGTH = 1000

func aim_laser():
	var mouse_pos = get_viewport().get_mouse_position()
	$LaserBarrelStart.look_at(project_ray_normal(mouse_pos) * LASER_LENGTH)

func shoot_laser(color = Color.GREEN):
	const LASER_LENGTH = 1000
	var mouse_pos = get_viewport().get_mouse_position()
	var from = $LaserBarrelStart.find_child("LaserBarrel").global_position
	var to = from + project_ray_normal(mouse_pos) * LASER_LENGTH
	var space = get_world_3d().direct_space_state
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.from = from
	ray_query.to = to
	var raycast_result = space.intersect_ray(ray_query)

	if !raycast_result.is_empty() && !laser_exists:
		#print(raycast_result)
		var mesh_instance := Laser.new()
		#var immediate_mesh := ImmediateMesh.new()
		var laser_mesh := CapsuleMesh.new()
		var material := ORMMaterial3D.new()

		laser_mesh.radius = 0.0006
		laser_mesh.height = LASER_LENGTH
		
		mesh_instance.mesh = laser_mesh
		
		#immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
		#immediate_mesh.surface_add_vertex($LaserBarrelStart.find_child("LaserBarrel").position)
		#immediate_mesh.surface_add_vertex(raycast_result["position"])
		#immediate_mesh.surface_end()
		#print(raycast_result)
		
		material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
		material.albedo_color = color
		
		#mesh_instance.mesh = immediate_mesh
		laser_mesh.material = material
		
		mesh_instance.mesh = laser_mesh
		mesh_instance.mesh.material = material 
		#mesh_instance.global_rotation = $LaserBarrelStart.find_child("LaserGun").global_rotation
		#mesh_instance.position.x = $LaserBarrelStart.find_child("LaserGun").global_position.x
		#mesh_instance.position.z = $LaserBarrelStart.find_child("LaserGun").global_position.z

		#get_tree().get_root().add_child(mesh_instance)
		$LaserBarrelStart.find_child("LaserGun").add_child(mesh_instance)
		
		mesh_instance.position.y += 500
		
		laser_exists = true
		print(raycast_result["collider"].get_name())
		if(raycast_result["collider"].get_name().contains("Rock") || raycast_result["collider"].get_name().contains("Rigid")):
			var away = find_parent("Rover").basis.z
			away.y += 2
			raycast_result["collider"].apply_impulse(away, raycast_result["position"])
		$Timer.start()

func _input(event):
	if event.is_action_pressed("click"):
		shoot_laser()

func _on_timer_timeout() -> void:
	#$LaserBarrel.get_child(-1).delete_self()
	for n in $LaserBarrelStart.find_child("LaserGun").get_children():
		if n.get_name().contains("Mesh"):
			n.delete_self()
			pass
	laser_exists = false
	
func _physics_process(delta: float) -> void:
	aim_laser()
