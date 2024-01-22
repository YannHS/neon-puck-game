extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$ColorRect2.hide()
	$ColorRect.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_exit_pressed():
	SceneChange.change_scene("res://Main.tscn")



func _on_start_mouse_entered():
	$ColorRect2.show()


func _on_start_mouse_exited():
	$ColorRect2.hide()


func _on_exit_mouse_entered():
	$ColorRect.show()


func _on_exit_mouse_exited():
	$ColorRect.hide()
