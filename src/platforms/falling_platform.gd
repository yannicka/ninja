extends CharacterBody2D

func fall(delta: float) -> void:
	position.y += 26 * delta
