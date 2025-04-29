extends Control
@onready var menu: Panel = $menu
@onready var options: Panel = $Options

signal Pause
signal Unpause

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	menu.visible = false
	options.visible = false

func _process(delta):
	test_Esc()

func resume():
	get_tree().paused = false
	menu.visible = false
	options.visible = false
	$AnimationPlayer.play_backwards("blur")
	
func pause():
	get_tree().paused = true
	menu.visible = true
	$AnimationPlayer.play("blur")
	
func test_Esc():
	if Input.is_action_just_pressed("esc") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("esc") and get_tree().paused:
		resume()
		
func _on_resume_game_pressed() -> void:
	resume()


func _on_options_pressed() -> void:
	menu.visible = false
	options.visible = true


func _on_exit_game_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/UI/main_menu.tscn")
	

func _on_options_back() -> void:
	menu.visible = true
	options.visible = false
