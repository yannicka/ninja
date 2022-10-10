extends CharacterBody2D

const GRAVITY = 460
const ACCELERATION = 5120
const MAX_GRAVITY = 200

@onready var player = get_parent().get_node("Player")

func _ready() -> void:
	var timer = Timer.new()
	timer.connect("timeout", on_timer_timeout)
	timer.wait_time = 3
	add_child(timer)
	timer.start()

func _physics_process(delta):
	velocity.y += GRAVITY * delta
	velocity.y = min(velocity.y, MAX_GRAVITY)

	move_and_slide()

	if is_on_floor():
		$AnimatedSprite2d.play("wait")
		velocity.x = 0

func _on_area_2d_body_entered(body):
	if body.has_method("die_or_bounce"):
		body.die_or_bounce()
		queue_free()

func on_timer_timeout() -> void:
	if player.global_position.x < global_position.x:
		scale.x = -1
		velocity = Vector2(-30, -200)
	else:
		velocity = Vector2(30, -200)

	$AnimatedSprite2d.play("jump")
