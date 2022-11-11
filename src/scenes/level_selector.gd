extends Control

const level_selector_button = preload("res://src/scenes/level_selector_button.tscn")

func _ready():
	for i in range(1, 20):
		var button = level_selector_button.instantiate()
		button.level_number = i
		$GridContainer.add_child(button)
