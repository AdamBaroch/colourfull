extends State
class_name EnemyIdle

@export var enemy: CharacterBody2D
@export var move_speed := 4000.0

var player: CharacterBody2D
var move_direction: int
var wander_time: float

func randomize_wander():
	move_direction = randi_range(0,1)
	if move_direction == 0:
		move_direction = -1
	wander_time = randf_range(1,3)
	
func Enter():
	player = get_tree().get_first_node_in_group("Player")
	enemy.modulate = Color(0, 1, 0, 1)
	randomize_wander()

func Update(delta: float):
	if wander_time > 0:
		wander_time -= delta
	else:
		randomize_wander()
	
func Physics_Update(delta: float):
	if enemy:
		enemy.velocity.x = move_direction * move_speed * delta 
#	var direction_x = player.global_position.x - enemy.global_position.x
#	var direction_y = player.global_position.y - enemy.global_position.y
#	if direction_x < 300 and direction_x > -300 and direction_y < 20:
		
		
func _on_follow_area_body_entered(body: CharacterBody2D) -> void:
	if body.name == "Player":
		Transitioned.emit(self,"Follow")
