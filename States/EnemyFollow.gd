extends State
class_name EnemyFollow

@export var enemy: CharacterBody2D
@export var move_speed := 6000.0
var player: CharacterBody2D
var move_direction = 0


func Enter():
	player = get_tree().get_first_node_in_group("Player")
	enemy.modulate = Color(0, 0, 1, 1)

func Physics_Update(delta:float):
	var direction_x = player.global_position.x - enemy.global_position.x
	if player.global_position.x - enemy.global_position.x > 0:
		move_direction = 1
	else:
		move_direction = -1
	enemy.velocity.x = move_direction * move_speed * delta 
	if abs(player.global_position.x - enemy.global_position.x) < 125 and abs(player.global_position.y - enemy.global_position.y) < 150: 
		
		Transitioned.emit(self, "attack")
		
func _on_follow_area_body_exited(body: CharacterBody2D) -> void:
	if body.name == "Player":
		enemy.modulate = Color(0, 1, 0, 1)
		Transitioned.emit(self,"idle")
		
