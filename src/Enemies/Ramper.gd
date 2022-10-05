extends CharacterBody2D


func _ready():
	velocity.x = 10


func _physics_process(delta):
	move_and_slide()


func _on_area_2d_body_entered(body):
	if body.has_method("die_or_bounce"):
		body.die_or_bounce()
		queue_free()
