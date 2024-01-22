extends CanvasLayer

@onready var animation: AnimationPlayer = $AnimationPlayer

func _ready():
	print(animation)
	self.hide()
	

func change_scene(path):
	self.show()
	self.set_layer(999)
	animation.play("scene_change")
	await animation.animation_finished
	get_tree().change_scene_to_file(path)
	animation.play_backwards("scene_change")
	await animation.animation_finished
	self.set_layer(-1)
	self.hide()
