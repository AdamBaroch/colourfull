extends Node

var total_coins: int = 0

#this connects coin_ui with coins
func coin_collected(value:int):
	total_coins += value
	EventController.emit_signal("coin_collected", total_coins)
