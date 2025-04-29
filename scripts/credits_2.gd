extends Panel

signal Back
#It sends signal to main scene when button is pressed
func _on_back_pressed() -> void:
	emit_signal("Back")
