extends Camera3D

signal mouse_entered
signal mouse_not_entered
signal music_disappear

var mouse_position
var sensitive = 0.003
var mouse_is_entered: bool

func _ready():
	self.connect("mouse_entered", Callable($"../Table", "_mouse_on_table_entered"))
	self.connect("mouse_not_entered", Callable($"../Table", "_mouse_not_entered"))
	self.connect("music_disappear", Callable($"../CanvasLayer/Controls", "_music_disappear"))
	
func _input(event):
	var mouse_pos: Vector2
	var collide_result
	if event is InputEventMouseMotion:
		mouse_position = event.relative
	
	
	if event is InputEventMouseButton:
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				collide_result = shoot_ray()
				if mouse_is_entered:
					emit_signal("music_disappear")
					SceneChange.change_scene("res://menubackground.tscn")
			MOUSE_BUTTON_MIDDLE:
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED if event.is_pressed() else Input.MOUSE_MODE_VISIBLE)

func _update_rotate():
	var offsetx
	var offsety
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		print(rotation.y)
		mouse_position *= sensitive
		offsetx = mouse_position.x
		offsety = mouse_position.y
		rotate_y(deg_to_rad(-offsetx))
		rotate_object_local(Vector3(1,0,0), -deg_to_rad(offsety))
		rotation.y = clamp(rotation.y, -0.975, -0.748)
		rotation.x = clamp(rotation.x, -0.134, -0.068)
	else:
		rotation.x = -0.105
		rotation.y = -0.856
		pass
		
		
func shoot_ray():
	var mouse_pos = get_viewport().get_mouse_position()
	var raylength = 1000
	var from = project_ray_origin(mouse_pos)
	var to = from + project_ray_normal(mouse_pos) * raylength
	var space = get_world_3d().direct_space_state
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.from = from
	ray_query.to = to
	var raycast_result = space.intersect_ray(ray_query)
	return raycast_result
	

func _process(delta):
	_update_rotate()
	var result = shoot_ray()
	if !(result == { }) and !$"../CanvasLayer/Controls".pop_up_poped:
		if result["collider"] == $"../Table_body":
			emit_signal("mouse_entered")
			mouse_is_entered = true
	else:
		emit_signal("mouse_not_entered")
		mouse_is_entered = false
	
	


	
	

