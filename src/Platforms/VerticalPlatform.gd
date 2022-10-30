extends AnimatableBody2D

const VELOCITY = Vector2(0, 20)

func _physics_process(delta: float) -> void:
	move_and_collide(VELOCITY * delta)

	var viewport_height = get_viewport_rect().size.y

	if global_position.y > viewport_height + 20:
		queue_free()

# Bouge la plateforme à la position à laquelle elle serait si elle s'était
# déplacée pendant `seconds` secondes.
func move(seconds: float) -> void:
	position += VELOCITY * seconds
