extends CharacterBody2D

const SPEED = 22
const GRAVITY = 500

@export var direction = Vector2.RIGHT

func _ready():
	velocity.x = SPEED * direction.x

	if direction.x == -1:
		scale.x = -1

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		velocity.y = min(velocity.y, GRAVITY)

	if is_on_wall():
		direction = -direction
		velocity.x = SPEED * direction.x

		scale.x = -1

	move_and_slide()

func _on_area_2d_body_entered(body):
	if body.has_method("die_or_bounce"):
		var die_or_bounce = body.die_or_bounce()

		if die_or_bounce == "bounce":
			queue_free()
