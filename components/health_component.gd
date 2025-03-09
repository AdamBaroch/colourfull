class_name HealthComponent extends Node

signal target_is_dead

@export var max_health: float
@onready var health: float = max_health 

func apply_damage(damage:float) -> void:
	health = clamp(health - damage, 0, max_health)
	print(health)
	if health <= 0:
		target_is_dead.emit()


func _on_hurtbox_received_damage(damage: int) -> void:
	health = clamp(health - damage, 0, max_health)
	print(health)
	if health <= 0:
		target_is_dead.emit()
