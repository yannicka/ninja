extends CharacterBody2D

const SPEED = 50

func _ready():
	var timer = Timer.new()
	timer.connect("timeout", on_start)
	timer.wait_time = 1
	add_child(timer)
	timer.start()

func on_start():
	velocity.x = SPEED
	$AnimatedSprite2d.play("default")

	var timer = Timer.new()
	timer.connect("timeout", on_remove)
	timer.wait_time = 6
	add_child(timer)
	timer.start()


func on_remove():
	queue_free()


func _physics_process(delta):
	move_and_slide()

	if velocity.x == 0:
		velocity = Vector2.ZERO
		$CollisionShape2d.set_deferred("disabled", true)
		# $top_checker/CollisionShape2d.set_deferred("disabled", true)
		# $sides_checker/CollisionShape2d.set_deferred("disabled", true)

		$AnimatedSprite2d.play("stop")

# @todo
func _on_top_checker_body_entered(body):
	if body.has_method("bounce"):
		queue_free()

		body.bounce()


# @todo
func _on_sides_checker_body_entered(body):
	if body.has_method("die"):
		body.die()


func _on_area_2d_body_entered(body):
	if velocity.x > 0 and body.has_method("die"):
		body.die()
