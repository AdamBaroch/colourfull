extends CharacterBody2D

@onready var animation = $AnimationPlayer


var gravitation = 2000    

func _physics_process(delta):
	velocity.y += gravitation*delta
	move_and_slide()
	if velocity.x < 0:
			$Sprite2D.flip_h = false
	elif velocity.x > 0:
			$Sprite2D.flip_h = true
	
func _on_health_component_target_is_dead() -> void:
	queue_free()

func animation_player():
	if abs(velocity.x) > 150:
		print("yes")
		animation.play("attack")
