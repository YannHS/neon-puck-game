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
	if body == $"../../RedPusher" or body == $"../../BluePusher":
		# plays if touching a pusher since we want a higher pitch
		sound.pitch_scale = 0.75
		sound.volume_db = log(Vector3(linear_velocity - body.linear_velocity).length_squared()) * 5
		sound.play()
	else:
		# plays if touching anything else since we want a lower pitch
		sound.pitch_scale = 0.5
		sound.volume_db = log(Vector3(linear_velocity).length_squared()) * 5
		sound.play()
	
