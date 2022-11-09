extends Node2D

const VerticalPlatform = preload("res://src/platforms/vertical_platform.tscn")

const WAIT_TIMER = 2

var timer = Timer.new()

var has_done_initial_generation = false

func _ready() -> void:
	timer.connect("timeout", generate)
	timer.wait_time = WAIT_TIMER
	add_child(timer)
	timer.start()

func _physics_process(_delta: float) -> void:
	if !has_done_initial_generation:
		var nb_to_generate = 20

		for i in range(0, nb_to_generate):
			generate(i * WAIT_TIMER)

		has_done_initial_generation = true

func generate(seconds: float = 0.0) -> void:
	var vertical_platform = VerticalPlatform.instantiate()
	vertical_platform.position = global_position
	vertical_platform.move(seconds)
	get_tree().current_scene.add_child(vertical_platform)

	timer.start()
