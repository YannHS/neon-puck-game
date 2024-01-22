extends Node3D



@onready var Outline_Cam = $SubViewportContainer/SubViewport/outline_camera
@onready var container = $SubViewportContainer

func _process(_delta):
	Outline_Cam.transform = $"../Main_cam".transform
	Outline_Cam.fov = $"../Main_cam".fov
	pass

func _mouse_on_table_entered():
	$SubViewportContainer.visible = true

func _mouse_not_entered():
	$SubViewportContainer.visible = false



