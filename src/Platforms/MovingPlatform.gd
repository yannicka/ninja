extends Node2D

var velocity = Vector2(80, 0)

func _process(delta: float):
	var collision = $AnimatableBody2D.move_and_collide(velocity * delta)

	if collision:
		velocity.x *= -1
