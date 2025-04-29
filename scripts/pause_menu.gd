extends Control
@onready var menu: Panel = $menu
@onready var options: Panel = $Options

signal Pause
signal Unpause

#makes sure menu is hidden when lvl starts
func _ready() -> void:
	menu.visible = false
	options.visible = false

#it controls if someone pressed Escape
func _process(delta):
	test_Esc()

#starts game again
func resume():
	get_tree().paused = false
	menu.visible = false
	options.visible = false
	$AnimationPlayer.play_backwards("blur")
#pauses game and shows menu
func pause():
	get_tree().paused = true
	menu.visible = true
	$AnimationPlayer.play("blur")

#based on if game is paused pauses the game or resumes the game
func test_Esc():
	if Input.is_action_just_pressed("esc") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("esc") and get_tree().paused:
		resume()
		
#if resume button is pressed resumes game
func _on_resume_game_pressed() -> void:
	resume()

#if options button is pressed shows option menu
func _on_options_pressed() -> void:
	menu.visible = false
	options.visible = true

#if exit game button is pressed player is returned to main menu
func _on_exit_game_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/UI/main_menu.tscn")
	
#signal from options backs to main menu
func _on_options_back() -> void:
	menu.visible = true
	options.visible = false
