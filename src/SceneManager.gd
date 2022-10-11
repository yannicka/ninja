extends Node2D

func change_scene2(new_scene: String):
	$TransitionScreen.transition(new_scene)

func _on_transition_screen_transitioned(new_scene):
	var scene = load(new_scene).instantiate()

	$CurrentScene.get_child(0).queue_free()
	$CurrentScene.add_child(scene)
