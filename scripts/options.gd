extends Panel

signal Back

#sends back signal to PauseMenu
func _on_back_pressed() -> void:
	emit_signal("Back")

#when is checkbox toggled fullscreen mode is activated
func _on_check_box_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
