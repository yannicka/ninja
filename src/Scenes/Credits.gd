extends Control

func _on_back_button_pressed() -> void:
	TransitionScene.change_scene("res://src/Scenes/MainMenu.tscn")
