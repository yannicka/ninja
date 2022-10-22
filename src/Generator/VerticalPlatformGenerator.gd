extends Node2D

const VerticalPlatform = preload("res://src/Platforms/VerticalPlatform.tscn")

var timer = Timer.new()

func _ready():
	timer.connect("timeout", generate)
	timer.wait_time = 2
	add_child(timer)
	timer.start()

func generate():
	var vertical_platform = VerticalPlatform.instantiate()
	vertical_platform.position = global_position
	get_tree().current_scene.add_child(vertical_platform)

	timer.start()
