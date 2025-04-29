extends Area2D

@onready var anim = $AnimatedSprite2D

@export var value: int = 1



func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		GameController.coin_collected(value)
		anim.play("collect")
		
		
func _on_animated_sprite_2d_animation_finished():
	if anim.animation == "collect":
		queue_free()
