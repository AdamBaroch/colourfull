extends Control

@onready var main_buttons: VBoxContainer = $Main_Buttons
@onready var options: Panel = $Options
@onready var credits: Button = $Credits
@onready var credits_menu: Panel = $CREDITS_MENU

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main_buttons.visible = true
	options.visible = false
	credits.visible = true
	credits_menu.visible = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/lvl1.tscn")


func _on_options_pressed() -> void:
	main_buttons.visible = false
	options.visible = true
	credits.visible = false
	credits_menu.visible = false
func _on_exit_game_pressed() -> void:
	get_tree().quit()


func _on_options_back() -> void:
	main_buttons.visible = true
	options.visible = false
	credits.visible = true
	credits_menu.visible = false

func _on_credits_menu_back() -> void:
	main_buttons.visible = true
	options.visible = false
	credits.visible = true
	credits_menu.visible = false


func _on_credits_pressed() -> void:
	main_buttons.visible = false
	options.visible = false
	credits.visible = false
	credits_menu.visible = true
