class_name Cannonball

extends CharacterBody2D

const ROTATE_SPEED = 12 # radians/second
const SHOOTING_SPEED = -360
const GRAVITY = 700

var shooter = null

func _ready() -> void:
	velocity.y = SHOOTING_SPEED

func _physics_process(delta: float) -> void:
	rotation += ROTATE_SPEED * delta
	velocity.y += GRAVITY * delta

	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("kill"):
		body.kill()
		queue_free()
