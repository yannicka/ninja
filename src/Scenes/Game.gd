extends Node2D

# var i = 0
#
# func _physics_process(delta: float) -> void:
# 	i += delta / 20
#
# 	if i > 1:
# 		i = 0
#
# 	$CanvasLayer2/Polygon2D.get_texture().gradient.set_color(0, Color(i, i, 0.5, 1))
# 	$CanvasLayer2/Polygon2D.get_texture().gradient.set_color(1, Color(i, 0.5, i, 1))

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
