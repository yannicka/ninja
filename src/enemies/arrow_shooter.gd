extends StaticBody2D

const Arrow = preload("res://src/bullets/arrow.tscn")

@export var direction = Vector2.RIGHT

func _ready() -> void:
	scale.x = direction.x

func _on_timer_timeout() -> void:
	var arrow = Arrow.instantiate()
	arrow.z_index = -1
	arrow.direction = Vector2(direction)
	arrow.global_position = Vector2(self.global_position.x + (3 * direction.x), self.global_position.y)
	get_tree().current_scene.add_child(arrow)
