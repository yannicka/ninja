extends Control

func _on_play_button_pressed():
	get_tree().root.get_child(0).change_scene2("res://src/Scenes/Game.tscn")
