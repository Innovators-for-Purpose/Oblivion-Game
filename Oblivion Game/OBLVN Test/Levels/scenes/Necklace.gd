extends Area2D




func _on_Necklace_body_entered(body):
	if body.name == "AlexStates":
		get_tree().change_scene("res://Levels/scenes/scenes/AssemblyPlantOld.tscn")
		print("changing scenes")
