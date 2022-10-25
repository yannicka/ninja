extends CharacterBody2D

const JUMP_FORCE = Vector2(32, -220)
const GRAVITY = 500

@onready var player = get_parent().get_node("Player")

var direction = Vector2.LEFT

func _ready() -> void:
	scale.x = direction.x

	var timer = Timer.new()
	timer.connect("timeout", on_timer_timeout)
	timer.wait_time = 2.4
	add_child(timer)
	timer.start()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		velocity.y = min(velocity.y, GRAVITY)

	move_and_slide()

	if is_on_floor():
		$AnimatedSprite2d.play("wait")
		velocity.x = 0

func on_timer_timeout() -> void:
	var direction_before = Vector2(direction)

	if player.global_position.x < global_position.x:
		direction = Vector2.LEFT
		velocity = Vector2(-JUMP_FORCE.x, JUMP_FORCE.y)
	else:
		direction = Vector2.RIGHT
		velocity = Vector2(JUMP_FORCE.x, JUMP_FORCE.y)

	if direction != direction_before:
		scale.x = -1

	$AnimatedSprite2d.play("jump")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("die_or_bounce"):
		var die_or_bounce = body.die_or_bounce()

		if die_or_bounce == "bounce":
			queue_free()
