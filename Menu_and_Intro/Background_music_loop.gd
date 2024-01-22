extends AudioStreamPlayer




func _on_music_toggled(toggled_on):
	if toggled_on:
		stream_paused = true
	else:
		stream_paused = false
