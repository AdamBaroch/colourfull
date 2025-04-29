class_name Hurtbox

extends Area2D

signal received_damage(damage: int)

@export var health: HealthComponent

func _ready() -> void: #connects area entered with hitbox so it can be reused in other enemies
	connect ("area_entered", _on_area_entered)
	
func _on_area_entered(hitbox: Hitbox) -> void: #if hitbox enters area hurtbox takes dmg
	if hitbox != null:
		received_damage.emit(hitbox.damage) #sents signal to health node to take dmg
