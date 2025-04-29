extends Control

@onready var label: Label = $Label

# it connects on entering scene signal with method
func _ready() -> void:
	EventController.connect("coin_collected", on_event_coin_collected)

func on_event_coin_collected(value: int):
	label.text = str(value)#It updates number of coins
