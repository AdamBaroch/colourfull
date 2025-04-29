extends State
class_name EnemyAttack

@export var enemy: CharacterBody2D
var player: CharacterBody2D

var move_direction: float
var attack_time: float
var attack_movement = 10000

var transition_time = 0.5

func attack(delta, move_direction): #this function attacks player and at the end of it switches to Follow state
	enemy.velocity.x = attack_movement * move_direction * delta 
	if transition_time > 0:
		transition_time -= delta
	else: #this makes sure attack doesnt end early
		transition_time = 0.5
		Transitioned.emit(self, "Follow")
func Enter(): #starts attack timer and finds player
	player = get_tree().get_first_node_in_group("player")
	attack_time = 1
	
func Exit():
	pass
	
func Update(_delta: float):
	pass
	
func Physics_Update(_delta: float):
	
	if attack_time > 0: #countdown till attack starts
		enemy.velocity.x = 0
		attack_time -= _delta
		if player.global_position.x - enemy.global_position.x > 0: #gets direction.x to player
			move_direction = 1
		else:
			move_direction = -1
	else:
		attack(_delta, move_direction) #attack starts
	
