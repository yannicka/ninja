extends AnimatableBody2D

const VELOCITY = Vector2(0, 20)

func _physics_process(delta: float) -> void:
	move_and_collide(VELOCITY * delta)

# Bouge la plateforme à la position à laquelle elle serait si elle s'était
# déplacée pendant `seconds` secondes.
func move(seconds: float) -> void:
	position += VELOCITY * seconds
