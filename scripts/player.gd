extends CharacterBody2D

# Parametry pro ovládání postavy
var acceleration: float = 1300.0   # Rychlost akcelerace při stisknutí vstupu
var friction: float = 2500.0       # Brzdící síla (frikce) při absenci vstupu
var max_speed: float = 650.0      # Maximální rychlost po stranách

# Parametry pohybu a skoku
var gravitation = 2000                         # základní gravitace
var jump_height = -800                        # počáteční impuls skoku (směr nahoru má zápornou hodnotu)
var max_falling_speed = 1000               # maximální rychlost při pádu
var double_jump_height = -600
var double_jump = 0
# Apex modifier – modifikátor gravitace v okolí vrcholu skoku
var apex_gravitation_multiplikator = 0.4
var fall_gravitation_multiplikator = 2    # při pádu chceme vyšší gravitaci

# Parametry pro jump buffering a coyote time (v sekundách)
var jump_buffer_time = 0.2                   # doba, po kterou se uchovává požadavek na skok
var coyote_time = 0.15                        # doba po opuštění země, kdy se dovolí skok
var jump_buffer_counter = 0.0                # čítač pro jump buffering
var coyote_counter = 0.0                     # čítač pro coyote time

# Variabilní výška skoku – pokud hráč uvolní tlačítko, skok se "ořízne"
var jump_cut_multiplier = 0.4

@export var attacking = false

# Poduzel pro ledge detection (např. umístěný na straně postavy, směřující dolů)
#@onready var ledge_detector = $LedgeDetector
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		attack()
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
# Aplikace gravitace s využitím apex modifieru a omezení rychlosti pádu
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

# Aktualizace časovačů pro coyote time a jump buffering
func update_timers(delta):
	if is_on_floor():
		coyote_counter = coyote_time
	else:
		coyote_counter -= delta

	if Input.is_action_just_pressed("ui_accept"):
		jump_buffer_counter = jump_buffer_time
	else:
		jump_buffer_counter -= delta

# Zpracování skoku – využití jump buffering a coyote time
func process_jump():
	if jump_buffer_counter > 0 and coyote_counter > 0:
		velocity.y = jump_height
		jump_buffer_counter = 0
		coyote_counter = 0
	elif double_jump == 0 and Input.is_action_just_pressed("ui_accept") and !is_on_floor():
		velocity.y = double_jump_height
		double_jump = 1
# Zajištění variabilní výšky skoku – pokud hráč tlačítko uvolní, rychlost se sníží
func process_variable_jump():
	if Input.is_action_just_released("ui_accept") and velocity.y < 0:
		velocity.y *= jump_cut_multiplier

# Detekce okraje (ledge detection) pomocí RayCast2D
#	if not ledge_detector.is_colliding() and not is_on_floor():
#		print("Detekován okraj!")
		# Zde lze implementovat logiku pro chytání se okraje
		
# Zpracování vstupu – aktualizujeme horizontální složku rychlosti podle stisknutých tlačítek
func process_input(delta: float) -> void:
	var input_dir: int = 0
	if Input.is_action_pressed("ui_right"):
		input_dir += 1
	if Input.is_action_pressed("ui_left"):
		input_dir -= 1

	# Přičítáme akceleraci podle směru vstupu
	velocity.x += input_dir * acceleration * delta

# Aplikace frikce – pokud žádný vstup není aktivní, zpomalíme postavu směrem k nule
func apply_friction(delta: float) -> void:
	if not (Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left")):
		if velocity.x > 0:
			velocity.x = max(velocity.x - friction * delta, 0)
		elif velocity.x < 0:
			velocity.x = min(velocity.x + friction * delta, 0)

# Omezení rychlosti – zajistíme, že absolutní hodnota rychlosti nepřekročí max_speed
func clamp_speed() -> void:
	if abs(velocity.x) > max_speed:
		velocity.x = sign(velocity.x) * max_speed
# Vykonání pohybu postavy
func move_character():
	# V Godot 4, CharacterBody2D používá vestavěnou proměnnou velocity,
	# a move_and_slide() očekává jako argument směr "up".
	move_and_slide()

func attack():
	pass
