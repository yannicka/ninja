extends CanvasLayer

signal transitioned(new_scene: String)

var new_scene: String

func transition(_new_scene: String):
	new_scene = _new_scene
	$AnimationPlayer.play("transparent_to_black")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "transparent_to_black":
		emit_signal("transitioned", new_scene)
		$AnimationPlayer.play("black_to_transparent")
