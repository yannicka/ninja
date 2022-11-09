extends Node2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	queue_free()

	if body.has_method("add_collected_coin"):
		body.add_collected_coin()
