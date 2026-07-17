extends Area2D


func _on_Finish1_body_entered(body):
	if body.name == "AlexStates":
		get_tree().change_scene("res://Levels/scenes/scenes/scenes/level0_house.tscn")
		

