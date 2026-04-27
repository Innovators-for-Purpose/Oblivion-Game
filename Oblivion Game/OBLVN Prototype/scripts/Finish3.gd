extends Area2D




func _on_Finish_3_body_entered(body):
	if (body.name == "AlexStates"):
		get_tree().change_scene_to_file("res://scenes/levels/Main.tscn")
