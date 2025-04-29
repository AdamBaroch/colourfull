extends CharacterBody2D

# Parametry pro ovládání postavy
var acceleration: float = 1300.0   # Rychlost akcelerace při stisknutí vstupu
var friction: float = 2500.0       # Brzdící síla (frikce) při absenci vstupu
var max_speed: float = 300.0      # Maximální rychlost po stranách

# Parametry pohybu a skoku
var gravitation = 2000                         # základní gravitace
var jump_height = -600                        # počáteční impuls skoku (směr nahoru má zápornou hodnotu)
var max_falling_speed = 800               # maximální rychlost při pádu
var double_jump_height = -450
var double_jump = 0
# Apex modifier – modifikátor gravitace v okolí vrcholu skoku
var apex_gravitation_multiplikator = 0.4
var fall_gravitation_multiplikator = 2    # při pádu chceme vyšší gravitaci

# Parametry pro jump buffering a coyote time (v sekundách)
var jump_buffer_time = 0.1                  # doba, po kterou se uchovává požadavek na skok
var coyote_time = 0.15                        # doba po opuštění země, kdy se dovolí skok
var jump_buffer_counter = 0.0                # čítač pro jump buffering
var coyote_counter = 0.0                     # čítač pro coyote time

# Variabilní výška skoku – pokud hráč uvolní tlačítko, skok se "ořízne"
var jump_cut_multiplier = 0.4

#variables pro health
var current_health:  int = 3
var max_health: int = 3

@export var attacking = false

@onready var animation = $AnimationPlayer
@onready var weapon = $WeaponFX

# Poduzel pro ledge detection (např. umístěný na straně postavy, směřující dolů)
#@onready var ledge_detector = $LedgeDetector
func _process(delta: float) -> void:
	pass
func _physics_process(delta):
	process_input(delta)
	apply_friction(delta)
	clamp_speed()
	apply_gravity(delta)
	update_timers(delta)
	process_jump()
	process_variable_jump()
# 	detect_ledge()
	move_character()
	animations()
# aplication of gravity with restriction of max fall and jump buffer
func apply_gravity(delta):
	if abs(velocity.y) < 20:
		# Jsme blízko vrcholu skoku
		velocity.y += gravitation * apex_gravitation_multiplikator * delta
	else:
		if velocity.y < 0:
			# Stoupáme, použijeme základní gravitaci
			velocity.y += gravitation * delta
		else:
			# Pád – aplikujeme zvýšenou gravitaci
			velocity.y += gravitation * fall_gravitation_multiplikator * delta
	if is_on_floor():
		double_jump = 0
	# Omezení maximální rychlosti při pádu
	if velocity.y > max_falling_speed:
		velocity.y = max_falling_speed

# Actualization for jump buffering and coyotee timer
func update_timers(delta):
	if is_on_floor():
		coyote_counter = coyote_time
	else:
		coyote_counter -= delta

	if Input.is_action_just_pressed("ui_accept"):
		jump_buffer_counter = jump_buffer_time
	else:
		jump_buffer_counter -= delta

# Processing jump (using coyotee timer and jump buffering timer)
func process_jump():
	if jump_buffer_counter > 0 and coyote_counter > 0:
		velocity.y = jump_height
		jump_buffer_counter = 0
		coyote_counter = 0
	elif double_jump == 0 and Input.is_action_just_pressed("ui_accept") and !is_on_floor():
		velocity.y = double_jump_height
		double_jump = 1
# If player releases jump button sooner jump is made shorter 
func process_variable_jump():
	if Input.is_action_just_released("ui_accept") and velocity.y < 0:
		velocity.y *= jump_cut_multiplier

# Detekce okraje (ledge detection) pomocí RayCast2D
#	if not ledge_detector.is_colliding() and not is_on_floor():
#		print("Detekován okraj!")
		# Zde lze implementovat logiku pro chytání se okraje
		
# We are controlling velocity.x based on inputs
func process_input(delta: float) -> void:
	var input_dir: int = 0
	if Input.is_action_pressed("ui_right"):
		input_dir += 1
	if Input.is_action_pressed("ui_left"):
		input_dir -= 1

	# Přičítáme akceleraci podle směru vstupu
	velocity.x += input_dir * acceleration * delta

# Aplication of friction (if you dont press anything player will slow to 0) 
func apply_friction(delta: float) -> void:
	if not (Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left")):
		if velocity.x > 0:
			velocity.x = max(velocity.x - friction * delta, 0)
		elif velocity.x < 0:
			velocity.x = min(velocity.x + friction * delta, 0)

# Speed control - it makes sure player dont exceed max speed
func clamp_speed() -> void:
	if abs(velocity.x) > max_speed:
		velocity.x = sign(velocity.x) * max_speed
#Moving the player
func move_character():
	# V Godot 4, CharacterBody2D používá vestavěnou proměnnou velocity,
	# a move_and_slide() očekává jako argument směr "up".
	move_and_slide()

#it plays attack animation which activates hitbox to kill enemies
func attack():
	animation.play("attack")
	weapon.play("attack_sword")

#it makes sure enemies who is physical body give player damage
func _on_hurtbox_player_body_entered(body: Node2D) -> void:
	if body.is_in_group("damage"):
		take_damage()
#it makes sure enemies who is area give player damage
func _on_hurtbox_player_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area.is_in_group("damage"):
		take_damage()
#preparation for adding health of player and death to the game
func take_damage():
	current_health -= 1
	if current_health == 0:
		current_health = max_health
	print(current_health)

#takes care of animations
func animations():
#flipping the sprite 
	if velocity.x < 0:
			$Sprite2D.flip_h = true
			$Weapon.flip_h = true
			$Weapon.offset.x = -9
			$Hitbox.scale = Vector2(-1, 1)
	elif velocity.x > 0:
			$Sprite2D.flip_h = false
			$Weapon.flip_h = false
			$Weapon.offset.x = 13
			$Hitbox.scale = Vector2(1, 1)
#plays animation based on parameters
	if Input.is_action_just_pressed("attack"):
		attack()
	if animation.is_playing() and animation.current_animation == "attack":
		pass
	elif velocity.y < -1: 
		animation.play("jump_up")
	elif velocity.y > 1:
		animation.play("fall")
	elif velocity.x == 0:
		animation.play("idle")
	elif abs(velocity.x) > 0:
		animation.play("run")
