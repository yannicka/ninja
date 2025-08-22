extends CharacterBody2D

const SPEED = 70
const GRAVITY = 500

var direction = Vector2.RIGHT
var age = 0

func _ready():
	scale.x = direction.x
	velocity.x = SPEED * direction.x

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		velocity.y = min(velocity.y, GRAVITY)

	if is_on_wall():
		direction = -direction
		velocity.x = SPEED * direction.x

		scale.x = -1

	age += delta

	move_and_slide()
