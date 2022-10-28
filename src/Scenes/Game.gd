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

func _on_move_area_input_event(_viewport: Node, event: InputEvent, _shape_idx: int):
	if event.is_pressed():
		$Level1/Player.move = true
	else:
		$Level1/Player.move = false

func _on_jump_area_input_event(_viewport: Node, event: InputEvent, _shape_idx: int):
	if event.is_pressed():
		$Level1/Player.jump()
