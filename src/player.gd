extends CharacterBody2D

class_name Player

const RUN_SPEED = 200
const BOOST_SPEED = 320
const JUMP_VELOCITY = -470
const GRAVITY = 2000
const STOMP_IMPULSE = 400

var direction = Vector2.RIGHT
var is_dead = false
var state = "idle"
var speed = RUN_SPEED

var move = false
var jumping = false

var collected_coins = 0

func _physics_process(delta: float) -> void:
	if is_dead:
		return

	var viewport_height = get_viewport_rect().size.y

	if global_position.y > viewport_height + 24:
		kill()

		return

	# for i in get_slide_collision_count():
	# 	var collision = get_slide_collision(i)
	# 
	# 	if collision.get_collider().has_method("fall"):
	# 		collision.get_collider().fall(delta)
	# 
	# 	if collision.get_collider().has_method("advance"):
	# 		collision.get_collider().advance(delta)

	if not OS.has_feature("mobile"):
		if OS.is_debug_build():
			if Input.is_action_pressed("ui_left"):
				direction = Vector2.LEFT
				move = true
			elif Input.is_action_pressed("ui_right"):
				direction = Vector2.RIGHT
				move = true

			if Input.is_action_just_released("ui_left") or Input.is_action_just_released("ui_right"):
				move = false

	if Input.is_action_pressed("space"):
		move = true

	if Input.is_action_just_released("space"):
		move = false

	if Input.is_action_just_pressed("ui_up"):
		jumping = true

	if Input.is_action_just_released("ui_up"):
		jumping = false

	if not is_on_floor():
		velocity.y += GRAVITY * delta

	if is_on_floor() and jumping:
		velocity.y = JUMP_VELOCITY

		state = "jump"

	if move:
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	if velocity.y > 0:
		state = "fall"

	if is_on_floor():
		state = "idle"

	move_and_slide()
	
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()

		if collider == null:
			continue

		if collider.is_in_group("stompable"):
			if Vector2.UP.dot(collision.get_normal()) > 0.1:
				collider.kill()

				bounce()

				break
			else:
				kill()

	if is_on_floor():
		if velocity.x != 0:
			$AnimatedSprite.play("walk")
		else:
			$AnimatedSprite.play("idle")
	else:
		$AnimatedSprite.play("jump")

func set_direction(direction: Vector2) -> void:
	if direction != self.direction:
		self.direction = direction

		scale.x = -1

func bounce():
	velocity.y = -400

func kill():
	is_dead = true
	velocity = Vector2(0, 0)

	$AnimationPlayer.play("die")

	get_tree().paused = true

func die_or_bounce(deadly: bool = true):
	if state == "fall":
		bounce()

		return "bounce"
	else:
		if deadly:
			kill()

			return "die"

	return "nothing"

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "die":
		TransitionScene.change_scene("res://src/scenes/game.tscn")

func boost():
	speed = BOOST_SPEED

	if not OS.has_feature("mobile"):
		$GPUParticles2D.visible = true

	var timer = Timer.new()
	timer.connect("timeout", unboost)
	timer.wait_time = 7
	add_child(timer)
	timer.start()

func unboost():
	speed = RUN_SPEED

	if not OS.has_feature("mobile"):
		$GPUParticles2D.visible = false

func add_collected_coin():
	get_tree().current_scene.add_collected_coin()
