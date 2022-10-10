extends StaticBody2D

const Arrow = preload("res://src/Bullets/Arrow.tscn")

@export var direction = Vector2.RIGHT

func _ready():
	var timer = Timer.new()
	timer.connect("timeout", on_timer_timeout)
	timer.wait_time = 2.5
	add_child(timer)
	timer.start()

func on_timer_timeout():
	var arrow = Arrow.instantiate()
	arrow.global_position = Vector2(self.global_position.x - 5, self.global_position.y)
	arrow.global_position.x += 14
	arrow.z_index = -1
	get_tree().current_scene.add_child(arrow)
