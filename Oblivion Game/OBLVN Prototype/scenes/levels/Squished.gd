extends Area2D


func _on_Squished_body_entered(body):
	if (body.name == "AlexStates"):
# warning-ignore:return_value_discarded
		get_tree().reload_current_scene()
