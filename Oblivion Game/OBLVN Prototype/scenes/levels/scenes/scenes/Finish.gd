extends Area2D

func _on_Finish_body_entered(body):
	if body.is_in_group("player"):
		print("Finish reached. Loading next level. index: " + str(Levelmanager.current_level_index))
		Levelmanager.load_next_level()
		
