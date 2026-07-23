extends Area2D




func _on_deathtrap3_body_entered(body):
	if (body.name == "AlexStates"):
		get_tree().reload_current_scene()
