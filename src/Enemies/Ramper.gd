extends CharacterBody2D

const SPEED = 20

var direction = Vector2.RIGHT

func _ready():
	velocity.x = SPEED

func _physics_process(delta):
	move_and_slide()

	if not is_on_floor():
		velocity.y += 120 * delta

	if is_on_wall():
		direction = -direction
		velocity.x = SPEED * direction.x

		scale.x = -1

func _on_area_2d_body_entered(body):
	if body.has_method("die_or_bounce"):
		var die_or_bounce = body.die_or_bounce()

		if die_or_bounce == "bounce":
			queue_free()
