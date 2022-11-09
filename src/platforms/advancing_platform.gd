extends AnimatableBody2D

const speed = 20

var direction = Vector2.ZERO
var nextDirection = Vector2.RIGHT

func _physics_process(delta):
	var velocity = Vector2(speed * direction.x * delta, 0)
	var collision = move_and_collide(velocity)

	if collision:
		nextDirection.x = -nextDirection.x

func advance(_delta: float) -> void:
	direction.x = nextDirection.x
