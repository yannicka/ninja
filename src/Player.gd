extends CharacterBody2D

const SPEED = 160.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var direction = Vector2.RIGHT

var is_dead = false

var state = "idle"

@export var move = false

func _physics_process(delta):
	if is_dead:
		return

	if position.y > 300:
		die()
		return

	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_up"):
		jump()

	if move or Input.is_action_pressed("space"):
		move = true
	else:
		move = false

	if OS.is_debug_build():
		if Input.is_action_pressed("ui_left"):
			direction = Vector2.LEFT
			move = true
		elif Input.is_action_pressed("ui_right"):
			direction = Vector2.RIGHT
			move = true
		else:
			move = false

	if move:
		velocity.x = direction.x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if velocity.y > 0:
		state = "fall"

	if is_on_floor():
		state = "idle"

	move_and_slide()

	if is_on_floor():
		if velocity.x != 0:
			$AnimatedSprite.play("walk")
		else:
			$AnimatedSprite.play("idle")
	else:
		$AnimatedSprite.play("jump")

func jump():
	if is_on_floor():
		velocity.y = JUMP_VELOCITY
		state = "jump"

func set_direction(direction: Vector2) -> void:
	if direction != self.direction:
		self.direction = direction

		scale.x = -1

func bounce():
	velocity.y = -300

func die():
	is_dead = true
	velocity = Vector2(0, 0)

	$AnimationPlayer.play("die")
	$CollisionShape2d.disabled = true

func die_or_bounce():
	if state == "fall":
		bounce()
	else:
		die()

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "die":
		TransitionScene.change_scene("res://src/Scenes/Game.tscn")
