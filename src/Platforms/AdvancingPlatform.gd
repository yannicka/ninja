extends AnimatableBody2D

var speed = 20
var nextDirection = Vector2.RIGHT
var direction = Vector2.ZERO

func _process(delta: float):
	var velocity = Vector2(speed * direction.x * delta, 0)
	var collision = move_and_collide(velocity)

	if collision:
		nextDirection.x = -nextDirection.x

func advance(delta: float):
	direction.x = nextDirection.x
