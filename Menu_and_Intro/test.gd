extends Node3D

func animation_create():
	var animation_player = AnimationPlayer.new()
	var library = AnimationLibrary.new()
	$".".add_child(animation_player)
	animation_player.add_animation_library("offset", library)
	var camera_shift = Animation.new()
	library.add_animation("camera_shift", camera_shift)
	camera_shift.add_track(Animation.TYPE_VALUE)
	camera_shift.length = 2
	camera_shift.track_set_path(0.5, "Camera3D:rotation:y")
	print($Camera3D.rotation)
	camera_shift.track_insert_key(0.5, 0.0, $Camera3D.rotation.y)
	camera_shift.track_insert_key(0.5, 2, $Camera3D.rotation.y + 0.5)
	animation_player.play("offset/camera_shift")
	print(animation_player.is_playing())
	await animation_player.animation_finished
	animation_player.queue_free()



func _input(event):
	if event.is_action_pressed("left_click"):
		animation_create()
		#$AnimationPlayer.play("new_animation")
		pass
