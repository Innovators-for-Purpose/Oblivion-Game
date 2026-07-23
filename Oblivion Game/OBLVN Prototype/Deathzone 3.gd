extends Area2D



func _on_Deathzone_3_body_entered(body):
	if (body.name == "AlexStates"):
		get_tree().reload_current_scene()

