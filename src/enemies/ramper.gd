extends CharacterBody2D

const SPEED = 18
const GRAVITY = 500

@export var direction = Vector2.RIGHT

func _ready() -> void:
	scale.x = direction.x
	velocity.x = SPEED * direction.x

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		velocity.y = min(velocity.y, GRAVITY)

	if is_on_wall():
		direction = -direction
		velocity.x = SPEED * direction.x

		scale.x = -1

	move_and_slide()

func kill() -> void:
	queue_free()
