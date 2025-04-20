extends State
class_name EnemyAttack

@export var enemy: CharacterBody2D
var player: CharacterBody2D

var move_direction: float
var attack_time: float
var attack_movement = 40000

var transition_time = 0.5

func attack(delta, move_direction):
	enemy.velocity.x = attack_movement * move_direction * delta 

	if transition_time > 0:
		transition_time -= delta
	else:
		enemy.modulate = Color(0, 0, 1, 1)
		transition_time = 0.5
		Transitioned.emit(self, "Follow")
func Enter():
	player = get_tree().get_first_node_in_group("Player")
	enemy.modulate = Color(0, 0, 0, 1)
	attack_time = 1
	
func Exit():
	pass
	
func Update(_delta: float):
	pass
	
func Physics_Update(_delta: float):
	
	if attack_time > 0:
		enemy.velocity.x = 0
		attack_time -= _delta
		var direction_x = player.global_position.x - enemy.global_position.x
		if player.global_position.x - enemy.global_position.x > 0:
			move_direction = 1
		else:
			move_direction = -1
	else:
		attack(_delta, move_direction)
	
