extends Node2D

func _on_area_2d_body_entered(body):
	if body.has_method("die"):
		body.die()
		queue_free()
