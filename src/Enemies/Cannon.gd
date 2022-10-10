extends CharacterBody2D

const Cannonball = preload("res://src/Bullets/Cannonball.tscn")
const SPEED = 20

var timer_before_prepare_shot: Timer
var timer_before_shot: Timer
var timer_after_rewalk: Timer

var direction = Vector2.RIGHT

func _ready():
	velocity.x = SPEED * direction.x

	timer_before_prepare_shot = Timer.new()
	timer_before_prepare_shot.wait_time = 4
	timer_before_prepare_shot.connect("timeout", on_timer_before_prepare_shot_timeout)
	add_child(timer_before_prepare_shot)
	timer_before_prepare_shot.start()

	timer_before_shot = Timer.new()
	timer_before_shot.wait_time = 1
	timer_before_shot.connect("timeout", on_timer_before_shot_timeout)
	add_child(timer_before_shot)

	timer_after_rewalk = Timer.new()
	timer_after_rewalk.wait_time = 0.5
	timer_after_rewalk.connect("timeout", on_timer_after_rewalk_timeout)
	add_child(timer_after_rewalk)

func _physics_process(delta):
	move_and_slide()

	if not is_on_floor():
		velocity.y += 120 * delta

	if is_on_wall():
		direction = -direction
		velocity.x = SPEED * direction.x

		scale.x = -1

func _on_area_2d_body_entered(body):
	if body.has_method("die_or_bounce"):
		body.die_or_bounce()
		queue_free()

func on_timer_before_prepare_shot_timeout():
	$AnimatedSprite2d.play("shot")

	velocity.x = 0

	timer_before_prepare_shot.stop()
	timer_before_shot.start()

func on_timer_before_shot_timeout():
	var cannonball = Cannonball.instantiate()
	cannonball.global_position = self.global_position
	get_tree().current_scene.add_child(cannonball)

	timer_before_shot.stop()
	timer_after_rewalk.start()

func on_timer_after_rewalk_timeout():
	$AnimatedSprite2d.play("walk")

	velocity.x = SPEED * direction.x

	timer_after_rewalk.stop()
	timer_before_prepare_shot.start()

func _on_top_checker_body_entered(body):
	if body.has_method("bounce"):
		queue_free()

		body.bounce()

func _on_sides_checker_body_entered(body):
	if body.has_method("die"):
		body.die()
