extends CharacterBody2D

const CannonballScene = preload("res://src/bullets/cannonball.tscn")

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

func _on_prepare_shot_timer_timeout() -> void:
	$AnimatedSprite2d.play("shot")

	velocity.x = 0

	$PrepareShotTimer.stop()
	$BeforeShotTimer.start()

func _on_before_shot_timer_timeout() -> void:
	var cannonball = CannonballScene.instantiate()
	cannonball.z_index = -1
	cannonball.shooter = self
	cannonball.global_position = self.global_position
	get_tree().current_scene.add_child(cannonball)
	
	$BeforeShotTimer.stop()

func _on_shooter_area_2d_body_entered(body: Node2D) -> void:
	if body is Cannonball and body.shooter == self and body.velocity.y >= 0:
		body.queue_free()

		$AnimatedSprite2d.play("walk")

		velocity.x = SPEED * direction.x

		$PrepareShotTimer.start()
