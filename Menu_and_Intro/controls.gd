extends Node

@export var pop_up_poped: bool

@onready var pop_up = $Control/Panel
@onready var popup_ani = $Control/AnimationPlayer

func _ready():
	pop_up.hide()
	$Control/Panel/Cancel_back.hide()
	$Control/Panel/Exit_back.hide()
	

func _on_exit_game_pressed():
	pop_up_poped = true
	pop_up.show()
	popup_ani.play("popup_ani")
	



func _on_cancel_but_pressed():
	pop_up_poped = false
	pop_up.hide()




func _on_exit_but_pressed():
	get_tree().quit()


func _on_cancel_back_mouse_entered():
	$Control/Panel/Cancel_back.show()
	

func _on_cancel_back_mouse_exited():
	$Control/Panel/Cancel_back.hide()
	

func _on_exit_but_mouse_entered():
	$Control/Panel/Exit_back.show()
	

func _on_exit_but_mouse_exited():
	$Control/Panel/Exit_back.hide()
	
func _music_disappear():
	var animation_player = AnimationPlayer.new()
	var library = AnimationLibrary.new()
	$".".add_child(animation_player)
	animation_player.add_animation_library("music", library)
	var disappear = Animation.new()
	library.add_animation("disappear", disappear)
	disappear.add_track(Animation.TYPE_VALUE)
	disappear.length = 0.5
	disappear.track_set_path(0, "Background_music_loop:volume_db")
	disappear.track_insert_key(0, 0.0, 0)
	disappear.track_insert_key(0, 0.5, -80)
	animation_player.play("music/disappear")
	print(animation_player.is_playing())
	await animation_player.animation_finished
	print($Background_music_loop.volume_db)
	animation_player.queue_free()

