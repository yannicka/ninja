extends CharacterBody2D

const SPEED = 70

@export var direction = Vector2.RIGHT

var age = 0

func _ready():
	velocity.x = SPEED * direction.x

func _physics_process(delta):
	move_and_slide()

	if not is_on_floor():
		velocity.y += 120 * delta

	if is_on_wall():
		direction = -direction
		velocity.x = SPEED * direction.x

		scale.x = -1

	age += delta

func _on_area_2d_body_entered(body):
	if age > 0.05 and body.has_method("die_or_bounce"):
		body.die_or_bounce()
		queue_free()
