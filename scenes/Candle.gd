extends Node2D
class_name Candle

# Emitted when a body can use the fix action on a candle
signal fix_possible(candle, body)
# Emitted when a body can no longer use the fix action on a candle
signal fix_impossible(candle, body)

export var FIX_TIME: float = 5

onready var animation: AnimatedSprite = $AnimatedSprite
onready var progressBar: ProgressBar = $Progress
onready var hitbox: Area2D = $Hitbox

var isOn = true

var fixProgress = 0
var isFixing = false

var lifetime = 0
var lifetimeInt = 0
var maxLife = _makeLifetime()

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
	
	if !isOn and isFixing:
		fixProgress += delta/FIX_TIME
		progressBar.value = fixProgress

		if fixProgress >= 1:
			stopFixing()
			isOn = true
			lifetime = 0
			lifetimeInt = 0
			maxLife = _makeLifetime()
			animation.play("on")

func _makeLifetime():
	return randf() * 20 + 10 # [10, 30]

func startFixing():
	if !isOn:
		progressBar.visible = true
		isFixing = true

func stopFixing():
	fixProgress = 0
	progressBar.visible = false
	isFixing = false

func _on_Hitbox_body_entered(body):
	emit_signal("fix_possible", self, body)

func _on_Hitbox_body_exited(body):
	emit_signal("fix_impossible", self, body)
