extends Node2D


func _on_move_area_input_event(viewport, event, shape_idx):
	if event.is_pressed():
		$Player.move = true
	else:
		$Player.move = false


func _on_jump_area_input_event(viewport, event, shape_idx):
	if event is InputEventScreenTouch:
		if event.is_pressed():
			$Player.jump_pressed = true
			$Player.jump_released = false
		else:
			$Player.jump_pressed = false
			$Player.jump_released = true
