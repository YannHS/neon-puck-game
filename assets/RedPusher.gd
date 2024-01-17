extends RigidBody3D

@export var Camera: Camera3D
@export var Marker1: Marker3D
@export var Marker2: Marker3D
@export var StartMarker: Marker3D
@export var ResponseTime: int
@export var IsAuto: bool
@export var AutoRestPos: Marker3D
@export var AutoReactionDistance: float
@export var AutoEnemy: Node3D

var TargetPos = Vector3.ZERO
var AutoIsEngaged = false
var LerpTimer = Timer.new()
var EnemyLocation = Vector3.ZERO

func _ready():
	TargetPos = StartMarker.global_position
	pass

# Keeps the player controlled pusher within a set boundary
func ClampPusher(Marker1, Marker2, PusherPos):
	var output = Vector3.ZERO
	for x in range(3):
		output[x] = clamp(PusherPos[x], Marker1.global_position[x], Marker2.global_position[x])
	return output

func _physics_process(delta):
	if IsAuto == false:
		TargetPos = $"..".ScreenPointToRay(Camera, 2)
	else:
		if AutoIsEngaged == true:
			# Push the puck away
			TargetPos = 0
		else:
			# if the autopilot is not engaged and puck is in distance, engage
			var distance = ($"../TableAsset/Puck".position - position).lenth
			if AutoIsEngaged == false and distance <= AutoReactionDistance:
				# engage the autopilot
				AutoIsEngaged = true
				EnemyLocation = AutoEnemy.position
				LerpTimer.start()
			# Stay in place since the puck is not around
			TargetPos = AutoRestPos
		
	linear_velocity = ClampPusher(Marker1, Marker2, TargetPos) - global_position
	linear_velocity *= ResponseTime
	rotation = Vector3.UP
	global_position.y = Marker1.global_position.y
