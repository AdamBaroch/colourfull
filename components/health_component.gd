class_name HealthComponent extends Node

signal target_is_dead

@export var max_health: float
@onready var health: float = max_health 

func apply_damage(damage:float) -> void:
	health = clamp(health - damage, 0, max_health)
	print(health)
	if health <= 0:
		target_is_dead.emit()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		apply_damage(2.5)
