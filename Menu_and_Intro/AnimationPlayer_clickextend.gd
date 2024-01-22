extends AnimationPlayer



func _on_setting_toggled(toggled_on):
	if toggled_on:
		play("Extend_settingbox", -1, 2)
	if not toggled_on:
		play("Extend_settingbox", -1, -2, true)
