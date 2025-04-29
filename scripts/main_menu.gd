extends Control

@onready var main_buttons: VBoxContainer = $Main_Buttons
@onready var options: Panel = $Options
@onready var credits: Button = $Credits
@onready var credits_menu: Panel = $CREDITS_MENU

# it makes sure every part of main menu is visible at right moment
func _ready() -> void:
	main_buttons.visible = true
	options.visible = false
	credits.visible = true
	credits_menu.visible = false
#if someone presses start button lvl1 starts
func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/lvl1.tscn")

#if someone presses options button options will popup
func _on_options_pressed() -> void:
	main_buttons.visible = false
	options.visible = true
	credits.visible = false
	credits_menu.visible = false
	
#if someone presses exit button game ends itself
func _on_exit_game_pressed() -> void:
	get_tree().quit()

#if someone presses back button we will see main menu again
func _on_options_back() -> void:
	main_buttons.visible = true
	options.visible = false
	credits.visible = true
	credits_menu.visible = false
#if someone presses back button we will see main menu again
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
