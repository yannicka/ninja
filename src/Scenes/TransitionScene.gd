extends CanvasLayer

var new_scene

func change_scene(_new_scene: String):
	new_scene = _new_scene
	$AnimationPlayer.play("transparent_to_black")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(new_scene)
	$AnimationPlayer.play("black_to_transparent")
	get_tree().paused = false
