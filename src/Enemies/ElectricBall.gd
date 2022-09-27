extends CharacterBody2D


var turn_speed = 2.4 # in radians/sec
var move_speed = 40 # pixels/sec


func _physics_process(delta):
	rotation += turn_speed * delta
	move_and_collide(transform.x * move_speed * delta)


func _on_area_2d_body_entered(body):
	if body.has_method("die"):
		body.die()
