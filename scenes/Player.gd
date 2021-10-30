extends KinematicBody2D

onready var sprite: Sprite = $Sprite
onready var coll: CollisionShape2D = $CollisionShape2D

onready var SPEED = 2*PI*coll.shape.extents.x
const GRAV = 400
const JUMP_FORCE = GRAV*(0.25*2) # Takes 0.25 seconds to reach jump peak

var movement = Vector2()

func _physics_process(delta):
	if Input.is_action_pressed("left"):
		movement.x -= (SPEED*delta)/0.25 # Takes 0.25 seconds to reach max speed
	elif Input.is_action_pressed("right"):
		movement.x += (SPEED*delta)/0.25 # Takes 0.25 seconds to reach max speed
	else:
		movement.x = 0
	movement.x = clamp(movement.x, -SPEED, SPEED)

	if is_on_floor():
		movement.y = GRAV*delta
		if Input.is_action_pressed("jump"):
			movement.y -= JUMP_FORCE
	else:
		movement.y += GRAV*delta
	
	sprite.rotation += (movement.x/SPEED)*2*PI*delta
	move_and_slide(movement, Vector2.UP)
