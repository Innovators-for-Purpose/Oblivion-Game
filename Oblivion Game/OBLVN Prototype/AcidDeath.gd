extends Area2D



func _on_AcidDeath_body_entered(body):
	if (body.name == "AlexStates"):
		get_tree().reload_current_scene()

