extends CharacterBody2D

const TurtleSpinningTop = preload("res://src/Enemies/TurtleSpinningTop.tscn")

const SPEED = 18
const GRAVITY = 500

@export var direction = Vector2.RIGHT

func _ready() -> void:
	scale.x = direction.x
	velocity.x = SPEED * direction.x

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		velocity.y = min(velocity.y, GRAVITY)

	if is_on_wall():
		direction = -direction
		velocity.x = SPEED * direction.x

		scale.x = -1

	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("die_or_bounce"):
		var die_or_bounce = body.die_or_bounce()

		if die_or_bounce == "bounce":
			var turtleSpinningTop = TurtleSpinningTop.instantiate()
			turtleSpinningTop.direction = Vector2(-direction.x, direction.y)
			turtleSpinningTop.global_position = Vector2(self.global_position.x, self.global_position.y)
			get_tree().current_scene.add_child(turtleSpinningTop)

			queue_free()
