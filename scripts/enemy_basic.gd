extends CharacterBody2D


var gravitation = 2000    

func _physics_process(delta):
	velocity.y += gravitation*delta
	move_and_slide()
	
func _on_health_component_target_is_dead() -> void:
	queue_free()
