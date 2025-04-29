extends State
class_name EnemyIdle

@export var enemy: CharacterBody2D
@export var move_speed := 2000.0

var player: CharacterBody2D
var move_direction: int
var wander_time: float

func randomize_wander(): #this choses random direction and time for which enemy will wander
	move_direction = randi_range(0,1)
	if move_direction == 0:
		move_direction = -1
	wander_time = randf_range(1,3)
	
func Enter(): #it makes sure that enemy exist and enemy starts wander right after entering
	if not is_inside_tree():
		push_warning("EnemyIdle: Uzel není ve stromu, přeskočeno Enter()")
		return
	player = get_tree().get_first_node_in_group("player")
	randomize_wander()

func Update(delta: float): #it resets wander everytime enemy stops wandering
	if wander_time > 0:
		wander_time -= delta
	else:
		randomize_wander()
	
func Physics_Update(delta: float): #moves player
	if enemy:
		enemy.velocity.x = move_direction * move_speed * delta 
		
		
func _on_follow_area_body_entered(body: CharacterBody2D) -> void: # if enemy enters follow area enemy changes to follow state
	if body.name == "Player":
		Transitioned.emit(self,"Follow")
