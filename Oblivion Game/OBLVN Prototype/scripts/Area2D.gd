extends Area2D



func _on_Fall_body_entered(body):
	if (body.name == "AlexStates"):
# warning-ignore:return_value_discarded
		get_tree().reload_current_scene()



func _on_DeathPits_body_entered(body):
	if (body.name == "AlexStates"):
# warning-ignore:return_value_discarded
		get_tree().reload_current_scene()

