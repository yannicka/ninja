extends Node2D

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		var viewport_size = get_viewport_rect().size
		var half_viewport_width = viewport_size.x / 2
		var pointer_position = event.position

		if pointer_position.x < half_viewport_width:
			if event.pressed:
				$Level1/Player.move = true
			else:
				$Level1/Player.move = false
		else:
			if event.pressed:
				$Level1/Player.jump()
