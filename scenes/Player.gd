extends KinematicBody2D

onready var sprite: Sprite = $Sprite
onready var coll: CollisionShape2D = $CollisionShape2D

onready var SPEED = 2*PI*coll.shape.radius

func _physics_process(delta):
	var movement = Vector2()
	if Input.is_action_pressed("left"):
		movement.x -= SPEED
	if Input.is_action_pressed("right"):
		movement.x += SPEED
	movement *= delta
	move_and_collide(movement)
	
	sprite.rotation += sign(movement.x)*2*PI*delta
