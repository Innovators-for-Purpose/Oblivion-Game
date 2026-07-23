extends Area2D


func _on_Area2D_body_entered(body):
	if (body.name == "AlexStates"):
# warning-ignore:return_value_discarded
			get_tree().reload_current_scene()

