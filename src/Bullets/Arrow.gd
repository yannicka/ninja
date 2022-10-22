extends CharacterBody2D

const SPEED = 50

func _ready():
	var timer = Timer.new()
	timer.connect("timeout", on_start)
	timer.wait_time = 1
	add_child(timer)
	timer.start()
	$top_checker/CollisionShape2d.disabled = true

func on_start():
	velocity.x = SPEED
	$top_checker/CollisionShape2d.disabled = false
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
		$AnimatedSprite2d.play("stop")

func _on_top_checker_body_entered(body):
	if body.has_method("die_or_bounce"):
		body.die_or_bounce()
		queue_free()
