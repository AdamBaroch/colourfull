extends State
class_name EnemyFollow

@export var enemy: CharacterBody2D
@export var move_speed := 3000.0
var player: CharacterBody2D
var move_direction = 0



func Enter():
	player = get_tree().get_first_node_in_group("player")
func Physics_Update(delta:float): #This finds direction to player and follows player around
	var direction_x = player.global_position.x - enemy.global_position.x
	if player.global_position.x - enemy.global_position.x > 0:
		move_direction = 1
	else:
		move_direction = -1
	enemy.velocity.x = move_direction * move_speed * delta 
	if abs(player.global_position.x - enemy.global_position.x) < 50 and abs(player.global_position.y - enemy.global_position.y) < 40: #if player is too close enemy goes in attack state 
		Transitioned.emit(self, "attack")
		
func _on_follow_area_body_exited(body: CharacterBody2D) -> void: #if player leaves follow area enemy will enter idle state 
	if body.name == "Player":
		Transitioned.emit(self,"idle")
		
