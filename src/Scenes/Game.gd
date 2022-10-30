extends Node2D

var seconds_elapsed = 0

func _ready() -> void:
	var timer = Timer.new()
	timer.connect("timeout", func():
		seconds_elapsed += 1
		$CanvasLayer/HBoxContainer/MarginContainer3/Label.set_text(format_time(seconds_elapsed))
	)
	timer.wait_time = 1
	add_child(timer)
	timer.start()

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

func _on_move_button_pressed():
	$Level/Player.move = true

func _on_move_button_released():
	$Level/Player.move = false

func _on_jump_button_pressed():
	$Level/Player.jumping = true

func _on_jump_button_released():
	$Level/Player.jumping = false

func format_time(seconds: float) -> String:
	var minutes = seconds / 60
	var _seconds = fmod(seconds, 60)

	return "%02d:%02d" % [minutes, _seconds]
