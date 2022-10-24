extends StaticBody2D

const ROTATE_SPEED = -3 # radians/second
const TURN_SPEED = 1
const RADIUS = 26

var center_position = Vector2.ZERO
var angle = 0

func _ready():
	center_position = Vector2(position)

func _physics_process(delta):
	rotation += ROTATE_SPEED * delta

	angle += TURN_SPEED * delta;

	var offset = Vector2(sin(angle), cos(angle)) * RADIUS

	position = center_position + offset

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("die"):
		body.die()
