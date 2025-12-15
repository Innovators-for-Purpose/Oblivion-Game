extends Area2D

func _on_Finish_body_entered(body):
	if body.is_in_group("player"):
		print("Finish reached. Loading next level.")
		LevelManager.load_next_level()
		
