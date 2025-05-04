extends Node

var total_coins: int = 0

#this connects coin_ui with coins
func coin_collected(value:int):
	print(value)
	print(total_coins)
	total_coins += value
	print(value)
	print(total_coins)
	EventController.emit_signal("coin_collected", total_coins)

func _on_dead():
	total_coins = 0
	EventController.emit_signal("coin_collected", total_coins)
