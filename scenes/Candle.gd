extends Node2D

export var timeToFix: float = 5

onready var animation: AnimatedSprite = $AnimatedSprite
onready var progressBar: ProgressBar = $Progress
onready var hitbox: Area2D = $Hitbox

var isOn = true
var fixProgress = 0

var lifetime = 0
var lifetimeInt = 0
var maxLife = randf() * 20 + 10 # [10, 30]

func _ready():
	if isOn:
		animation.play("on")
	else:
		animation.play("off")
	progressBar.visible = false

func _process(delta):
	if isOn:
		lifetime += delta
		
		var tmpLifetimeInt = int(lifetime)
		if lifetimeInt < tmpLifetimeInt: # We've just survived another second
			lifetimeInt = tmpLifetimeInt
			if randf() < pow(lifetime/maxLife, 2): # Pow to lower chances in the start
				isOn = false
				animation.play("off")
