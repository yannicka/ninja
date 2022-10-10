extends CharacterBody2D


func _ready():
	velocity.y = -200


func _physics_process(delta):
	velocity.y += 140 * delta
	move_and_slide()


func _on_area_2d_body_entered(body):
	if body.has_method("die"):
		body.die()
		queue_free()
