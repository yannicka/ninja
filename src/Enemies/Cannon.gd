extends CharacterBody2D

const CannonballScene = preload("res://src/Bullets/Cannonball.tscn")

const SPEED = 18
const GRAVITY = 500

@export var direction = Vector2.RIGHT

var timer_before_prepare_shot = Timer.new()
var timer_before_shot = Timer.new()

func _ready() -> void:
	scale.x = direction.x
	velocity.x = SPEED * direction.x

	timer_before_prepare_shot.wait_time = 2.6
	timer_before_prepare_shot.connect("timeout", on_timer_before_prepare_shot_timeout)
	add_child(timer_before_prepare_shot)
	timer_before_prepare_shot.start()

	timer_before_shot.wait_time = 1
	timer_before_shot.connect("timeout", on_timer_before_shot_timeout)
	add_child(timer_before_shot)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		velocity.y = min(velocity.y, GRAVITY)

	if is_on_wall():
		direction = -direction
		velocity.x = SPEED * direction.x
		scale.x = -1

	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("die_or_bounce"):
		var die_or_bounce = body.die_or_bounce()

		if die_or_bounce == "bounce":
			queue_free()

func on_timer_before_prepare_shot_timeout() -> void:
	$AnimatedSprite2d.play("shot")

	velocity.x = 0

	timer_before_prepare_shot.stop()
	timer_before_shot.start()

func on_timer_before_shot_timeout() -> void:
	var cannonball = CannonballScene.instantiate()
	cannonball.shooter = self
	cannonball.global_position = self.global_position
	cannonball.z_index = -1
	get_tree().current_scene.add_child(cannonball)

	timer_before_shot.stop()

func _on_shooter_area_2d_body_entered(body: Node2D) -> void:
	if body is Cannonball and body.velocity.y >= 0:
		body.queue_free()

		$AnimatedSprite2d.play("walk")

		velocity.x = SPEED * direction.x

		timer_before_prepare_shot.start()
