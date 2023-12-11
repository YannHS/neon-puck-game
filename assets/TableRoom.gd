extends Node3D

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

func ClampPusher(Marker1, Marker2, PusherPos):
	var output = Vector3.ZERO
	for x in range(3):
		output[x] = clamp(PusherPos[x], Marker1.global_position[x], Marker2.global_position[x])
	return output

var Input_Pos = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#Vector3(deg_to_rad(fov) * Input_Pos.y, deg_to_rad(fov) * Input_Pos.x, 0)
	pass
	
func _physics_process(delta):
	$RedPusher.global_position = ClampPusher($RedBound/MarkerNegative, $RedBound/MarkerPositive, ScreenPointToRay($"3DCamera", 2))
	$BluePusher.global_position = ClampPusher($BlueBound/MarkerNegative, $BlueBound/MarkerPositive, ScreenPointToRay($"3DCamera", 2))
	var puck = $TableAsset/Puck
	puck.global_rotation = Vector3(0, puck.global_rotation.y, 0)
	puck.global_position = Vector3(puck.global_position.x, 
	0.524, 
	puck.global_position.z)



func _on_close_goal_entered(body):
	if body == $TableAsset/Puck:
		print("red win")


func _on_far_goal_entered(body):
	if body == $TableAsset/Puck:
		print("blue win")
