extends Area2D




func _on_Boss_Arena_detection_body_entered(body):
	if "AlexStates" in body.name:
		get_parent().get_node("BOSS1").emit_signal("on_begin")
