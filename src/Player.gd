extends CharacterBody2D

const RUN_SPEED = 160.0
const BOOST_SPEED = 260.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var direction = Vector2.RIGHT

var is_dead = false

var state = "idle"

@export var move = false

var speed = RUN_SPEED

func _physics_process(delta):
	if is_dead:
		return

	if position.y > 300:
		die()
		return

	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().has_method("fall"):
			collision.get_collider().fall(delta)

		if collision.get_collider().has_method("advance"):
			collision.get_collider().advance(delta)

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
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

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

		return "bounce"
	else:
		die()

		return "die"

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "die":
		TransitionScene.change_scene("res://src/Scenes/Game.tscn")

func boost():
	speed = BOOST_SPEED

	$GPUParticles2D.visible = true

	var timer = Timer.new()
	timer.connect("timeout", unboost)
	timer.wait_time = 7
	add_child(timer)
	timer.start()

func unboost():
	speed = RUN_SPEED

	$GPUParticles2D.visible = false
