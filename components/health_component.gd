class_name HealthComponent extends Node

signal target_is_dead #signal that enemy dies so enemy can disappear

@export var max_health: float 
@onready var health: float = max_health 




func _on_hurtbox_received_damage(damage: int) -> void: #if hurtbox collide with hitbox enemy receives dmg
	health = clamp(health - damage, 0, max_health)
	print(health)
	if health <= 0: #if health is 0/below 0 emits death signal
		target_is_dead.emit()
