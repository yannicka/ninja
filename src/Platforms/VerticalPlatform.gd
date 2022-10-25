extends AnimatableBody2D

var velocity = Vector2(0, 20)

func _process(delta: float) -> void:
	move_and_collide(velocity * delta)
