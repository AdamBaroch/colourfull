extends Area2D

@onready var anim = $AnimatedSprite2D

@export var value: int = 1 #value of coin


#When player enters area of coin animation will play and signal is sent to change UI
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		GameController.coin_collected(value)
		anim.play("collect")
		
#If animation is collect coin will disappear
func _on_animated_sprite_2d_animation_finished():
	if anim.animation == "collect":
		queue_free()
