extends Node2D


#sends player to next level
func _on_transfer_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		get_tree().change_scene_to_file("res://scenes/lvl_2.tscn")
