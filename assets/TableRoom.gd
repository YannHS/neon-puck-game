extends Node3D

var RedScore = 0
var BlueScore = 0
var Fullscreen = false
var GameState = 0
# game state 0 is main menu
#game state 1 is gameplay
#game state 2 is paused menu

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
	$Score.text = str(RedScore) + " - " + str(BlueScore)
	if GameState == 0:
		# We should display some home menu
		pass
	if GameState == 1:
		# There should be gameplay
		$PauseMenu.set_visible(false)
		$PauseMenu/Continue.set_visible(false)
		$PauseMenu/Exit.set_visible(false)
		$Score.set_visible(true)
		Engine.time_scale = 1
	if GameState == 2:
		# pause menu
		$PauseMenu.set_visible(true)
		$PauseMenu/Continue.set_visible(true)
		$PauseMenu/Exit.set_visible(true)
		$Score.set_visible(true)
		Engine.time_scale = 0
		
	
func _physics_process(delta):
	var puck = $TableAsset/Puck
	puck.global_rotation = Vector3(0, puck.global_rotation.y, 0)
	puck.global_position = Vector3(puck.global_position.x, 
	0.524, 
	puck.global_position.z)

func _input(event):
	if event is InputEventKey:
		if event.is_action_released("fullscreen"):
			if Fullscreen == false:
				get_window().set_mode(Window.Mode.MODE_EXCLUSIVE_FULLSCREEN)
				Fullscreen = true
			else:
				get_window().set_mode(Window.Mode.MODE_WINDOWED)
				Fullscreen = false
		if event.is_action_released("ui_cancel"):
			if GameState == 1:
				GameState = 2
			



func _on_close_goal_entered(body):
	if body == $TableAsset/Puck:
		# Call our goal logic
		GoalScored(0)


func _on_far_goal_entered(body):
	if body == $TableAsset/Puck:
		# Call our goal logic
		GoalScored(1)


func GoalScored(Victor):
	# Victor is 0 for close (Red Scored) or 1 for far (Blue Scored)
		var VictorName = ""
		if Victor == 0:
			RedScore += 1
			VictorName = "Red"
		elif Victor == 1:
			BlueScore += 1
			VictorName = "Blue"
		$CentreText.text = VictorName + " Wins!"
		$CentreText.visible = true
		# wait 2 seconds
		await get_tree().create_timer(2).timeout
		$CentreText.visible = false 

func _paused_continue_pressed():
	GameState = 1


func _paused_exit_pressed():
	GameState = 0
