extends AnimatableBody2D

var velocity = Vector2(20, 0)

func _process(delta: float):
	var collision = move_and_collide(velocity * delta)

	if collision:
		velocity.x *= -1
