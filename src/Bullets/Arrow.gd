extends CharacterBody2D

const INITIAL_SPEED = 8
const SPEED = 50

@export var direction = Vector2.RIGHT

func _ready() -> void:
	scale.x = direction.x
	velocity.x = INITIAL_SPEED * direction.x

	$Area2D/CollisionShape2d.disabled = true

	var timer = Timer.new()
	timer.connect("timeout", on_start)
	timer.wait_time = 1
	add_child(timer)
	timer.start()

func on_start() -> void:
	velocity.x = SPEED * direction.x

	$Area2D/CollisionShape2d.disabled = false
	$AnimatedSprite2d.play("launched")

	var timer = Timer.new()
	timer.connect("timeout", on_remove)
	timer.wait_time = 6
	add_child(timer)
	timer.start()

func on_remove() -> void:
	queue_free()

func _physics_process(delta: float) -> void:
	if is_on_wall():
		$AnimatedSprite2d.play("stop")

	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("die_or_bounce"):
		var die_or_bounce = body.die_or_bounce()

		if die_or_bounce == "bounce":
			queue_free()
