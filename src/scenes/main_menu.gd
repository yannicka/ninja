extends Control

func _on_play_button_pressed() -> void:
	TransitionScene.change_scene("res://src/scenes/game.tscn")

func _on_credits_button_pressed() -> void:
	TransitionScene.change_scene("res://src/scenes/credits.tscn")
