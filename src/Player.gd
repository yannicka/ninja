extends CharacterBody2D


const SPEED = 160.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var direction = Vector2.RIGHT

var is_dead = false

@export var move = false

func _physics_process(delta):
	if is_dead:
		return

	print(move)

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")

	if move:
		direction = 1

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	# Animation
	if velocity.y != 0:
		$AnimatedSprite.play("jump")
	else:
		if velocity.x != 0:
			$AnimatedSprite.play("walk")
		else:
			$AnimatedSprite.play("idle")


func set_direction(direction: Vector2) -> void:
	if direction != self.direction:
		self.direction = direction

		scale.x = -1

func die():
	is_dead = true
	velocity = Vector2(0, 0)

	$AnimatedSprite.play("die")
	$CollisionShape2d.disabled = true


func _on_animated_sprite_animation_finished():
	if $AnimatedSprite.animation == "die":
		get_tree().change_scene_to_file("res://src/Game.tscn")
