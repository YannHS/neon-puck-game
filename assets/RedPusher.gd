extends RigidBody3D

@export var Camera: Camera3D
@export var Marker1: Marker3D
@export var Marker2: Marker3D
@export var StartMarker: Marker3D
@export var ResponseTime: int

var TargetPos = Vector3.ZERO

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
	TargetPos = $"..".ScreenPointToRay(Camera, 2)
	linear_velocity = ClampPusher(Marker1, Marker2, TargetPos) - global_position
	linear_velocity *= ResponseTime
	rotation = Vector3.UP
	global_position.y = Marker1.global_position.y
