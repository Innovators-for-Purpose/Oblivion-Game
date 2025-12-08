extends Area2D

func _on_Finish_body_entered(body):
	if body.name == "AlexStates":
		get_tree().change_scene("res://Levels/scenes/Main.tscn")
		print("Finish")
