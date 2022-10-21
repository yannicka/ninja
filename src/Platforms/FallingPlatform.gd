extends CharacterBody2D

func _process(delta):
	pass

func fall(delta: float):
	position.y += 26 * delta
