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

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_up"):
		jump()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_direction = Input.get_axis("ui_left", "ui_right")

	if move:
		input_direction = 1

	if input_direction == 1:
		set_direction(Vector2.RIGHT)
	elif input_direction == -1:
		set_direction(Vector2.LEFT)

	if input_direction:
		velocity.x = input_direction * SPEED
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

	$AnimatedSprite.play("die")
	$CollisionShape2d.disabled = true

func die_or_bounce():
	if state == "fall":
		bounce()
	else:
		die()

func _on_animated_sprite_animation_finished():
	if $AnimatedSprite.animation == "die":
		get_tree().change_scene_to_file("res://src/Game.tscn")
