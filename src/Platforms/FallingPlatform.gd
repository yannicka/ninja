extends CharacterBody2D

func _process(delta):
	move_and_slide()
	var a = is_on_floor()
	print(a)
