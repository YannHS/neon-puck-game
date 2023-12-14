extends RigidBody3D

@export var Camera: Camera3D
@export var Marker1: Marker3D
@export var Marker2: Marker3D

func _physics_process(delta):
	linear_velocity = $"..".ClampPusher(Marker1, Marker2, $"..".ScreenPointToRay(Camera, 2)) - global_position
	linear_velocity *= 100
	rotation = Vector3.UP
	global_position.y = Marker1.global_position.y
