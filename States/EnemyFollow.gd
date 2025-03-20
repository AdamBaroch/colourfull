extends State
class_name EnemyFollow

@export var enemy: CharacterBody2D
@export var move_speed := 50.0
var player: CharacterBody2D

func Enter():
	player = get_tree().get_first_node_in_group("Player")

func Physics_Update(delta:float):
	var direction_x = player.global_position.x - enemy.global_position.x
	var direction_y = player.global_position.y - enemy.global_position.y
	enemy.velocity.x = (player.global_position.x - enemy.global_position.x) * move_speed * delta 

	if direction_x > 300 or direction_x < -300:
		Transitioned.emit(self,"idle")
