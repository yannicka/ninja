extends Control

func _on_play_button_pressed():
	TransitionScene.change_scene("res://src/Scenes/Game.tscn")

func _on_credits_button_pressed():
	TransitionScene.change_scene("res://src/Scenes/Credits.tscn")
