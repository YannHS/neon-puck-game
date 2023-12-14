extends RigidBody3D


# Called when the node enters the scene tree for the first time.
func _ready():
	contact_monitor = true
	max_contacts_reported = 10


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	var sound = $AudioStreamPlayer
	sound.pitch_scale = randf_range(0.4, 0.7)
	sound.play()
