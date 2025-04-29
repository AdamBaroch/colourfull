extends CharacterBody2D

@onready var animation = $AnimationPlayer


var gravitation = 2000    

func _physics_process(delta):
	velocity.y += gravitation*delta
	move_and_slide()
	if velocity.x < 0:#this flips sprite of enemy based on velocity
			$Sprite2D.flip_h = false
	elif velocity.x > 0:
			$Sprite2D.flip_h = true
	
func _on_health_component_target_is_dead() -> void: #this makes enemy dissapear when he has 0 hp
	queue_free()

#testing of animations (didnt work yet)
#func animation_player():
	#if abs(velocity.x) > 150:
		#print("yes")
		#animation.play("attack")
