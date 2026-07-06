extends Area2D



func _on_Finish_body_entered(body):
	if (body.name == "AlexStates"):
		LevelTransition.change_scene_to_file("res://scenes/levels/scenes/level0_house.tscn")
