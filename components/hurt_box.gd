class_name Hurtbox

extends Area2D

signal received_damage(damage: int)

@export var health: HealthComponent

func _ready() -> void:
	connect ("area_entered", _on_area_entered)
	
func _on_area_entered(hitbox: Hitbox) -> void:
	if hitbox != null:
		received_damage.emit(hitbox.damage)
