extends Node2D

func _on_area_2d_body_entered(body):
	if body.has_method("die_or_bounce"):
		body.die_or_bounce()
		queue_free()
