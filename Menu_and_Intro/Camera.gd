extends Node3D




func _input(event):
	if event.is_action_pressed("ui_select"):
		if $Camera1.current:
			$Camera2.make_current()
		else:
			$Camera1.make_current()
