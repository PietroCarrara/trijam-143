extends Node2D

onready var player = $Player
onready var sleepinessBar: ProgressBar = $SleepBar
onready var pointsLabel: Label = $PointsLabel
onready var gameOverPopup: Popup = $GameOver
onready var candles = get_tree().get_nodes_in_group("Candles")

var sleepiness = 0
var points = 0

func _ready():
	randomize()
	for candle in candles:
		candle.connect("fix_possible", self, "_on_fix_possible")
		candle.connect("fix_impossible", self, "_on_fix_impossible")

func _process(delta):
	points += delta
	pointsLabel.text = "Score: %.1f" % points
	
	for candle in candles:
		if !candle.isOn:
			sleepiness += delta
	sleepinessBar.value = sleepiness

	if sleepiness >= sleepinessBar.max_value:
		get_tree().paused = true
		gameOverPopup.popup()

func _on_fix_possible(candle, body):
	if body == player:
		player.canFix(candle)

func _on_fix_impossible(candle, body):
	if body == player:
		player.cantFix(candle)

func _on_Button_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
