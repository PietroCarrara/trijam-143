extends Node2D

onready var player = $Player
onready var candles = get_tree().get_nodes_in_group("Candles")

func _ready():
	for candle in candles:
		candle.connect("fix_possible", self, "_on_fix_possible")
		candle.connect("fix_impossible", self, "_on_fix_impossible")

func _on_fix_possible(candle, body):
	if body == player:
		player.canFix(candle)
		
func _on_fix_impossible(candle, body):
	if body == player:
		player.cantFix(candle)
