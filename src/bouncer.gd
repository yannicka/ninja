extends StaticBody2D

@export var direction = Vector2.LEFT

func _ready():
	if direction == Vector2.RIGHT:
		scale.x = -1

func _on_area_2d_body_entered(body):
	if body.has_method("set_direction"):
		$AnimatedSprite2d.frame = 0
		$AnimatedSprite2d.play("bounce")

		body.set_direction(direction)
