extends StaticBody2D

const Arrow = preload("res://src/Bullets/Arrow.tscn")

@export var direction = Vector2.RIGHT

func _ready() -> void:
	scale.x = direction.x

	var timer = Timer.new()
	timer.connect("timeout", on_timer_timeout)
	timer.wait_time = 3
	add_child(timer)
	timer.start()

func on_timer_timeout() -> void:
	var arrow = Arrow.instantiate()
	arrow.direction = Vector2(direction)
	arrow.global_position = Vector2(self.global_position.x + (3 * direction.x), self.global_position.y)
	arrow.z_index = -1
	get_tree().current_scene.add_child(arrow)
