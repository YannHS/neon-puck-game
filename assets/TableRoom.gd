extends Node3D

var RedScore = 0
var BlueScore = 0

func ScreenPointToRay(camera, mask):
	var spaceState = get_world_3d().direct_space_state
	var mousePos = get_viewport().get_mouse_position()
	var rayOrigin = camera.project_ray_origin(mousePos)
	var rayEnd = rayOrigin + camera.project_ray_normal(mousePos) * 2000
	var params = PhysicsRayQueryParameters3D.new()
	params.from = rayOrigin
	params.to = rayEnd
	params.exclude = [] 
	params.collision_mask = mask
	var rayArray = spaceState.intersect_ray(params)
	if rayArray.has("position"):
		return rayArray["position"]
	else:
		return Vector3(0, 0, 0)

var Input_Pos = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Label.text = str(RedScore) + " - " + str(BlueScore)
	
func _physics_process(delta):
	var puck = $TableAsset/Puck
	puck.global_rotation = Vector3(0, puck.global_rotation.y, 0)
	puck.global_position = Vector3(puck.global_position.x, 
	0.524, 
	puck.global_position.z)

func _input(event):
	if event is InputEventKey:
		if event.is_action("fullscreen"):
			if get_window().get_mode() != Window.Mode.MODE_FULLSCREEN:
				get_window().set_mode(Window.Mode.MODE_EXCLUSIVE_FULLSCREEN)
			else:
				get_window().set_mode(Window.Mode.MODE_MAXIMIZED)



func _on_close_goal_entered(body):
	if body == $TableAsset/Puck:
		RedScore += 1


func _on_far_goal_entered(body):
	if body == $TableAsset/Puck:
		BlueScore += 1
