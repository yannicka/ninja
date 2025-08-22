extends CharacterBody2D

const INITIAL_SPEED = 8
const SPEED = 50

@export var direction = Vector2.RIGHT

var deadly = false

func _ready() -> void:
	scale.x = direction.x
	velocity.x = INITIAL_SPEED * direction.x

	var timer = Timer.new()
	timer.connect("timeout", on_start)
	timer.wait_time = 1
	add_child(timer)
	timer.start()

func on_start() -> void:
	velocity.x = SPEED * direction.x

	deadly = true

	$AnimatedSprite2d.play("launched")

	var timer = Timer.new()
	timer.connect("timeout", on_remove)
	timer.wait_time = 6
	add_child(timer)
	timer.start()

func on_remove() -> void:
	queue_free()

func _physics_process(_delta: float) -> void:
	if is_on_wall():
		remove_from_group("stompable")

		$AnimatedSprite2d.play("stop")

	move_and_slide()
